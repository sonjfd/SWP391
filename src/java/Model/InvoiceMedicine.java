package Model;


import Model.InvoiceService;


public class InvoiceMedicine {
    private InvoiceService invoice;
    private Medicine medicine;
    private int quantity;
    private double price;

    // Nếu bạn muốn ánh xạ mối quan hệ với đối tượng, bạn có thể thêm:
    // private Invoice invoice;
    // private Medicine medicine;

    public InvoiceMedicine() {
    }

    public InvoiceMedicine(InvoiceService invoice, Medicine medicine, int quantity, double price) {
        this.invoice = invoice;
        this.medicine = medicine;
        this.quantity = quantity;
        this.price = price;
    }

    public InvoiceService getInvoice() {
        return invoice;
    }

    public void setInvoice(InvoiceService invoice) {
        this.invoice = invoice;
    }

    public Medicine getMedicine() {
        return medicine;
    }

    public void setMedicine(Medicine medicine) {
        this.medicine = medicine;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    

    
}
