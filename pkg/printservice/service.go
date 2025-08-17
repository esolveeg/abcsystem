package printservice

import (
	"errors"
	"fmt"
	"net"
	"os/exec"
	"strings"
	"sync"
	"time"

	abcsystemv1 "github.com/esolveeg/abcsystem/proto_gen/abcsystem/v1"
	"github.com/kenshaw/escpos"
)

const (
	ColsFontB88mm = 62 // For 88mm, Font B
	DefaultPort   = 9100
)

// Invoice & Cheque placeholders — replace with your real types
type Invoice struct {
	Name          string
	TableName     string
	RoomNumber    string
	CustomerName  string
	CashierName   string
	Items         []InvoiceItem
	Total         float64
	Note          string
	PaymentMethod string
}
type InvoiceItem struct {
	ItemName string
	Qty      float64
	Rate     float64
}

type Cheque struct {
	Number string
	Amount float64
}
type ItemPrintOptions struct {
	ShowPrice   bool
	DashedStyle bool
	Center      bool
}

// NetworkPrinterInterface defines the contract for all printer services
type NetworkPrinterInterface interface {
	Discover() ([]*abcsystemv1.DiscoveredPrinter, error)
	PrintInvoiceVoidItems(ip string, invoice Invoice, originalTime time.Time) error
	DiscoverSingle(ip string, port int) (bool, error)
	Connect(ip string) error
	TestPrint(ip string) error
	PrintInvoiceReceipt(ip string, invoice Invoice) error
	PrintInvoiceItems(ip string, invoice Invoice) error
	PrintInvoiceVoid(ip string, invoice Invoice) error
	ListConnected() []string
}

// NetworkPrinterService implements NetworkPrinterInterface
type NetworkPrinterService struct {
	mu          sync.RWMutex
	baseNetwork string
	conns       map[string]net.Conn
	connected   map[string]time.Time
	timeout     time.Duration
}

// NewNetworkPrinterService creates a new service with connection cache
func NewNetworkPrinterService(baseNetwork string) *NetworkPrinterService {
	return &NetworkPrinterService{
		conns:       make(map[string]net.Conn),
		connected:   make(map[string]time.Time),
		baseNetwork: baseNetwork,
		timeout:     2 * time.Second,
	}
}

// withPrinter handles connection, init, and cleanup
func (s *NetworkPrinterService) withPrinter(ip string, fn func(p *escpos.Escpos) error) error {
	if err := s.Connect(ip); err != nil {
		return err
	}
	p, err := s.getPrinter(ip)
	if err != nil {
		return err
	}

	p.Init()
	_, _ = p.WriteRaw([]byte{0x1B, 0x50, 0x00}) // Disable proportional
	err = fn(p)
	p.FormfeedN(2)
	p.Cut()
	p.End()
	return err
}

// printItems prints items with optional price/dashes/centered
func printItems(p *escpos.Escpos, items []InvoiceItem, cols int, opts ItemPrintOptions) {
	centerDashed := func(name string, qty int) string {
		mid := fmt.Sprintf(" %s x%d ", name, qty)
		dashCount := cols - len(mid)
		if dashCount < 2 {
			return mid
		}
		leftDash := dashCount / 2
		rightDash := dashCount - leftDash
		return strings.Repeat("-", leftDash) + mid + strings.Repeat("-", rightDash)
	}

	for _, item := range items {
		if opts.DashedStyle {
			line := centerDashed(item.ItemName, int(item.Qty))
			if opts.Center {
				p.SetAlign("center")
			}
			_, _ = p.Write(line + "\n")
		} else {
			name := item.ItemName
			var right string
			if opts.ShowPrice {
				right = fmt.Sprintf("%d x %.2f", int(item.Qty), item.Rate)
			} else {
				right = fmt.Sprintf("%d", int(item.Qty))
			}

			spaces := max(cols-len(name)-len(right), 1)
			if opts.Center {
				// Center the whole line
				line := name + " " + right
				p.SetAlign("center")
				_, _ = p.Write(line + "\n")
			} else {
				p.SetAlign("left")
				_, _ = p.Write(name + strings.Repeat(" ", spaces) + right + "\n")
			}
		}
	}
}
func (s *NetworkPrinterService) Discover() ([]*abcsystemv1.DiscoveredPrinter, error) {
	subnet := s.baseNetwork
	port := 9100
	concurrency := 50

	var (
		printers []*abcsystemv1.DiscoveredPrinter
		mu       sync.Mutex
		wg       sync.WaitGroup
	)

	// channel of IPs to scan
	ipChan := make(chan string, concurrency)

	// worker function
	worker := func() {
		defer wg.Done()
		for ip := range ipChan {
			// Use a short timeout to speed up scan
			cmd := exec.Command(
				"gtimeout", "0.2",
				"bash", "-c",
				fmt.Sprintf("nc -z %s %d", ip, port),
			)
			if err := cmd.Run(); err == nil {
				mu.Lock()
				printers = append(printers, &abcsystemv1.DiscoveredPrinter{Ip: ip, Port: int32(port)})
				mu.Unlock()
			}
		}
	}

	// start workers
	for range concurrency {
		wg.Add(1)
		go worker()
	}

	// feed IPs
	for i := 1; i <= 254; i++ {
		ipChan <- fmt.Sprintf("%s.%d", subnet, i)
	}
	close(ipChan)

	// wait for all scans to finish
	wg.Wait()

	return printers, nil
}

// DiscoverSingle checks one IP
func (s *NetworkPrinterService) DiscoverSingle(ip string, port int) (bool, error) {
	ip = strings.TrimSpace(ip)
	if net.ParseIP(ip) == nil {
		return false, fmt.Errorf("invalid IP: %s", ip)
	}
	if port == 0 {
		port = 9100
	}
	conn, err := net.DialTimeout("tcp", net.JoinHostPort(ip, fmt.Sprintf("%d", port)), 500*time.Millisecond)
	if err != nil {
		return false, nil // not reachable
	}
	_ = conn.Close()
	return true, nil
}

// Connect connects and caches the connection
func (s *NetworkPrinterService) Connect(ip string) error {
	s.mu.Lock()
	defer s.mu.Unlock()

	if _, exists := s.conns[ip]; exists {
		return nil // already connected
	}

	conn, err := net.DialTimeout("tcp", fmt.Sprintf("%s:%d", ip, 9100), s.timeout)
	if err != nil {
		return err
	}

	s.conns[ip] = conn
	s.connected[ip] = time.Now()
	return nil
}

// getPrinter returns an escpos printer instance for given IP
func (s *NetworkPrinterService) getPrinter(ip string) (*escpos.Escpos, error) {
	s.mu.RLock()
	conn, ok := s.conns[ip]
	s.mu.RUnlock()
	if !ok {
		return nil, errors.New("printer not connected")
	}
	return escpos.New(conn), nil
}

// TestPrint sends a small test message
func (s *NetworkPrinterService) TestPrint(ip string) error {
	if err := s.Connect(ip); err != nil {
		return err
	}

	printer, err := s.getPrinter(ip)
	if err != nil {
		return err
	}

	printer.Init()
	_, _ = printer.Write("=== TEST PRINT ===\n")
	printer.FormfeedN(2)
	printer.Cut()
	return nil
}
func (s *NetworkPrinterService) PrintInvoiceItems(ip string, invoice Invoice) error {
	return s.withPrinter(ip, func(p *escpos.Escpos) error {
		p.SetFont("B")
		p.SetFontSize(1, 1)
		p.SetAlign("center")

		const cols = 56 // for 88mm in Font B

		writeLR := func(left, right string) {
			spaces := max(cols-len(left)-len(right), 1)
			_, _ = p.Write(left + strings.Repeat(" ", spaces) + right + "\n")
		}

		// Header
		_, _ = p.Write(invoice.Name + "\n")
		if invoice.Note != "" {
			_, _ = p.Write("Note: " + invoice.Note + "\n")
		}

		writeLR(fmt.Sprintf("Table: %s", invoice.TableName), fmt.Sprintf("Room: %s", invoice.RoomNumber))
		writeLR(fmt.Sprintf("Customer: %s", invoice.CustomerName), fmt.Sprintf("Cashier: %s", invoice.CashierName))
		writeLR(
			fmt.Sprintf("Date: %s", time.Now().Format("2006-01-02")),
			fmt.Sprintf("Time: %s", time.Now().Format("15:04")),
		)
		_, _ = p.Write(strings.Repeat("-", cols) + "\n")

		// Items - using the helper function
		printItems(p, invoice.Items, cols, ItemPrintOptions{
			ShowPrice:   false,
			DashedStyle: false,
			Center:      false,
		})

		_, _ = p.Write("\n POWERED BY ABCHOTELS SYSTEMS \n")
		return nil
	})
}

// PrintInvoiceVoid prints a voided invoice
func (s *NetworkPrinterService) PrintInvoiceVoid(ip string, invoice Invoice) error {
	if err := s.Connect(ip); err != nil {
		return err
	}

	printer, err := s.getPrinter(ip)
	if err != nil {
		return err
	}

	printer.Init()
	_, _ = printer.Write("*** VOID INVOICE ***\n")
	_, _ = printer.Write(fmt.Sprintf("Invoice: %s\n", invoice.Name))
	printer.FormfeedN(2)
	printer.Cut()
	return nil
}

// ListConnected returns list of currently connected printers
func (s *NetworkPrinterService) ListConnected() []string {
	s.mu.RLock()
	defer s.mu.RUnlock()

	keys := make([]string, 0, len(s.conns))
	for ip := range s.conns {
		keys = append(keys, ip)
	}
	return keys
}
func (s *NetworkPrinterService) PrintInvoiceReceipt(ip string, invoice Invoice) error {
	// You should call CalculateTotal() before calling this function
	// to ensure invoice.Total is accurate.
	// For example:
	// invoice.CalculateTotal()

	return s.withPrinter(ip, func(p *escpos.Escpos) error {
		p.SetFont("B")
		p.SetFontSize(1, 1)
		p.SetAlign("center")

		const cols = 56

		writeLR := func(left, right string) {
			spaces := max(cols-len(left)-len(right), 1)
			_, _ = p.Write(left + strings.Repeat(" ", spaces) + right + "\n")
		}

		// Header
		_, _ = p.Write(invoice.Name + "\n")
		writeLR(fmt.Sprintf("Table: %s", invoice.TableName), fmt.Sprintf("Room: %s", invoice.RoomNumber))
		writeLR(fmt.Sprintf("Customer: %s", invoice.CustomerName), fmt.Sprintf("Cashier: %s", invoice.CashierName))
		writeLR(
			fmt.Sprintf("Date: %s", time.Now().Format("2006-01-02")),
			fmt.Sprintf("Time: %s", time.Now().Format("15:04")),
		)
		_, _ = p.Write(strings.Repeat("-", cols) + "\n")

		// Items - using the helper function
		printItems(p, invoice.Items, cols, ItemPrintOptions{
			ShowPrice:   true,
			DashedStyle: false,
			Center:      false,
		})

		_, _ = p.Write(strings.Repeat("-", cols) + "\n")
		p.SetAlign("center")
		p.SetEmphasize(1)
		p.SetFontSize(2, 2)

		// Use the pre-calculated total
		_, _ = p.Write(fmt.Sprintf("TOTAL: %.0f\n\n", invoice.Total))

		p.SetEmphasize(0)
		p.SetFontSize(1, 1)
		_, _ = p.Write("TAX AND VAT INCLUDED\n")

		if invoice.Note != "" {
			_, _ = p.Write("Note: " + invoice.Note + "\n")
		}
		_, _ = p.Write("Payment: " + invoice.PaymentMethod + "\n")
		_, _ = p.Write("\nThank you!\n")
		_, _ = p.Write("\n POWERED BY ABCHOTELS SYSTEMS \n")

		return nil
	})
}

// PrintInvoiceVoidItems — now uses helpers
func (s *NetworkPrinterService) PrintInvoiceVoidItems(ip string, invoice Invoice, originalTime time.Time) error {
	return s.withPrinter(ip, func(p *escpos.Escpos) error {
		p.SetFont("B")
		p.SetFontSize(1, 1)

		writeLR := func(left, right string) {
			spaces := max(ColsFontB88mm-len(left)-len(right), 1)
			_, _ = p.Write(left + strings.Repeat(" ", spaces) + right + "\n")
		}

		p.SetAlign("center")
		p.SetEmphasize(1)
		_, _ = p.Write("*** VOID INVOICE ***\n")
		p.SetEmphasize(0)
		p.SetAlign("left")

		writeLR(fmt.Sprintf("Table: %s", invoice.TableName), fmt.Sprintf("Room: %s", invoice.RoomNumber))
		writeLR(fmt.Sprintf("Customer: %s", invoice.CustomerName), fmt.Sprintf("Cashier: %s", invoice.CashierName))
		writeLR(fmt.Sprintf("Current Time: %s", time.Now().Format("2006-01-02 15:04")),
			fmt.Sprintf("Order Time: %s", originalTime.Format("2006-01-02 15:04")))

		_, _ = p.Write(strings.Repeat("-", ColsFontB88mm) + "\n")

		// Items
		printItems(p, invoice.Items, ColsFontB88mm, ItemPrintOptions{
			ShowPrice:   false,
			DashedStyle: true,
			Center:      true,
		})

		_, _ = p.Write(strings.Repeat("-", ColsFontB88mm) + "\n")
		_, _ = p.Write("\n POWERED BY ABCHOTELS SYSTEMS \n")
		return nil
	})
}
