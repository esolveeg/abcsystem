package adapter

type PrinterAdapterInterface interface {
	PrintKitchenOrderGrpcFromErp() (string, error)
}

type PrinterAdapter struct {
}

func NewPrintingAdapter() PrinterAdapterInterface {
	return &PrinterAdapter{}
}
