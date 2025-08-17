package api // or your actual package name

import (
	"context"
	"fmt"

	"github.com/kenshaw/escpos"

	_ "image/png"
	"net"
	"strings"
	"time"

	"connectrpc.com/connect"
	"github.com/esolveeg/abcsystem/pkg/printservice"
	abcsystemv1 "github.com/esolveeg/abcsystem/proto_gen/abcsystem/v1"
)

func (api *Api) DiscoverPrinters(
	ctx context.Context,
	req *connect.Request[abcsystemv1.DiscoverPrintersRequest],
) (*connect.Response[abcsystemv1.DiscoverPrintersResponse], error) {
	invoice := printservice.Invoice{
		Name:          "ACC-PSINV-2025-00024",
		TableName:     "T1",
		CashierName:   "Alice",
		RoomNumber:    "101",
		CustomerName:  "John Doe",
		Note:          "No onions in salad",
		PaymentMethod: "Cash",
		Items: []printservice.InvoiceItem{
			{ItemName: "Onion Rings", Rate: 250.0, Qty: 1},
			{ItemName: "Onion Rings", Rate: 250.0, Qty: 1},
			{ItemName: "Onion Rings", Rate: 250.0, Qty: 1},
			{ItemName: "Onion Rings", Rate: 250.0, Qty: 1},
			{ItemName: "Onion Rings", Rate: 250.0, Qty: 1},
			{ItemName: "Onion Rings", Rate: 250.0, Qty: 1},
			{ItemName: "Onion Rings", Rate: 250.0, Qty: 1},
			{ItemName: "Onion Rings", Rate: 250.0, Qty: 1},
		},
	}
	ip := "192.168.100.190"
	_ = api.printerService.Connect(ip)
	_ = api.printerService.PrintInvoiceItems(ip, invoice)
	_ = api.printerService.PrintInvoiceReceipt(ip, invoice)
	originalTime := time.Date(2025, 8, 15, 18, 30, 0, 0, time.Local)

	_ = api.printerService.PrintInvoiceVoidItems(ip, invoice, originalTime)
	res, err := api.printerService.Discover()
	return connect.NewResponse(&abcsystemv1.DiscoverPrintersResponse{
		Printers: res,
	}), err
}

// TestPrint sends a simple test page to the given printer IP
func TestPrint(ip string) error {
	port := 9100
	conn, err := net.DialTimeout("tcp", fmt.Sprintf("%s:%d", ip, port), 2*time.Second)
	if err != nil {
		return fmt.Errorf("failed to connect to printer: %w", err)
	}
	defer conn.Close()

	// Simple text print (works on many raw TCP printers)
	msg := "Hello from GoHello from GoHello from GoHello from GoHello from GoHello from GoHello from GoHello from GoHello from GoHello from GoHello from GoHello from GoHello from GoHello from Go!\n\n\n\n"
	_, err = conn.Write([]byte(msg))
	if err != nil {
		return fmt.Errorf("failed to send print data: %w", err)
	}

	return nil
}

// Invoice item struct (mock)
type Item struct {
	Name     string
	ItemName string
	Qty      float64
	Rate     float64
	UOM      string
}

type Invoice struct {
	Name          string
	TableName     string
	RoomNumber    string
	CustomerName  string
	Note          string
	PaymentMethod string
	CashierName   string
	DateTime      time.Time

	Items []InvoiceItem
}

type InvoiceItem struct {
	ItemName string
	Qty      float64
	Rate     float64
}

func TestPrintInvoice(ip string, invoice Invoice) error {
	port := 9100
	conn, err := net.DialTimeout("tcp", fmt.Sprintf("%s:%d", ip, port), 2*time.Second)
	if err != nil {
		return fmt.Errorf("failed to connect to printer: %w", err)
	}
	defer conn.Close()

	printer := escpos.New(conn)
	printer.Init()

	// Disable proportional mode
	printer.WriteRaw([]byte{0x1B, 0x50, 0x00}) // ESC P 0

	// Font B for max columns
	printer.SetFont("B")
	printer.SetFontSize(1, 1)
	printer.SetAlign("center")

	const cols = 56 // For 88mm paper, Font B

	writeLR := func(left, right string) {
		spaces := max(cols-len(left)-len(right), 1)
		printer.Write(left + strings.Repeat(" ", spaces) + right + "\n")
	}
	printer.Write(invoice.Name + "\n")
	writeLR(fmt.Sprintf("Table: %s", invoice.TableName), fmt.Sprintf("Room: %s", invoice.RoomNumber))
	writeLR(fmt.Sprintf("Customer: %s", invoice.CustomerName), fmt.Sprintf("Cashier: %s", invoice.CashierName))
	writeLR(
		fmt.Sprintf("Date: %s", time.Now().Format("2006-01-02")),
		fmt.Sprintf("Time: %s", time.Now().Format("15:04")),
	)
	printer.Write(strings.Repeat("-", cols) + "\n")

	// Items
	var total float64
	for _, item := range invoice.Items {
		name := item.ItemName
		price := fmt.Sprintf("%d x %.2f", int(item.Qty), item.Rate)

		if len(name)+len(price) > cols {
			printer.Write(name + "\n")
			spaces := cols - len(price)
			printer.Write(strings.Repeat(" ", spaces) + price + "\n")
		} else {
			spaces := cols - len(name) - len(price)
			printer.Write(name + strings.Repeat(" ", spaces) + price + "\n")
		}

		total += item.Qty * item.Rate
	}

	printer.Write(strings.Repeat("-", cols) + "\n")
	printer.SetAlign("center")
	printer.SetEmphasize(1) // 🔹 Bold ON
	printer.SetFontSize(2, 2)
	printer.Write(fmt.Sprintf("TOTAL: %.0f\n\n", total))
	printer.SetEmphasize(0) // 🔹 Bold ON
	printer.SetFontSize(1, 1)
	printer.Write("TAX AND VAT INCLUDED\n")

	if invoice.Note != "" {
		printer.Write("Note: " + invoice.Note + "\n")
	}
	printer.Write("Payment: " + invoice.PaymentMethod + "\n")
	printer.Write("\nThank you!\n")
	printer.Write("\n POWERED BY ABCHOTELS SYSTEMS \n")

	printer.FormfeedN(2)
	printer.Cut()
	printer.End()

	return nil
}
func centerText(text string, width int) string {
	text = strings.TrimSpace(text)
	if len(text) >= width {
		return text + "\n"
	}
	padding := (width - len(text)) / 2
	return strings.Repeat(" ", padding) + text + "\n"
}

func truncate(s string, maxLen int) string {
	if len(s) > maxLen {
		return s[:maxLen-1] + "…"
	}
	return s
}

//
// // PrintLogo connects to a printer and prints a logo image.
// // The image at logoPath should be a simple, high-contrast, black and white PNG.
// func PrintLogo(printerIP string, logoPath string) error {
// 	// Step 1: Open the logo image file
// 	f, err := os.Open(logoPath)
// 	if err != nil {
// 		return fmt.Errorf("failed to open logo file [%s]: %w", logoPath, err)
// 	}
// 	defer f.Close()
//
// 	// Step 2: Decode the image
// 	logo, _, err := image.Decode(f)
// 	if err != nil {
// 		return fmt.Errorf("failed to decode image: %w", err)
// 	}
//
// 	// Step 3: Connect to the printer
// 	// Standard port for raw receipt printing is 9100
// 	// p, err := escpos.NewNetwork("tcp", printerIP+":9100", nil)
// 	// if err != nil {
// 	// 	return fmt.Errorf("failed to connect to printer: %w", err)
// 	// }
// 	// defer p.Close()
//
// 	// Step 4: Use the library to print the image and cut the paper
// 	// The library handles all the complex conversion from a Go image.Image to ESC/POS commands.
// 	printer.WriteRaw([]byte{0x1b, 0x40}) // Initialize printer
//
// 	if err := p.Image(logo, nil); err != nil {
// 		return fmt.Errorf("failed to print image: %w", err)
// 	}
//
// 	// Feed a few lines and cut the paper
// 	p.Feed(3)
// 	p.Cut()
//
// 	log.Info().Str("ip", printerIP).Str("logo", logoPath).Msg("✅ Logo sent to printer")
// 	return nil
// }
