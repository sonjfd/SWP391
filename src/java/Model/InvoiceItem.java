/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.math.BigDecimal;

public class InvoiceItem {

    private int id;
    private String invoiceId;
    private int productVariantId;
    private int quantity;
    private double price;
    private String productName;
    private String variantName;

    public InvoiceItem() {
    }

    public InvoiceItem(int id, String invoiceId, int productVariantId, int quantity, double price) {
        this.id = id;
        this.invoiceId = invoiceId;
        this.productVariantId = productVariantId;
        this.quantity = quantity;
        this.price = price;
    }

    public InvoiceItem(int id, String invoiceId, int productVariantId, int quantity, double price, String productName, String variantName) {
        this.id = id;
        this.invoiceId = invoiceId;
        this.productVariantId = productVariantId;
        this.quantity = quantity;
        this.price = price;
        this.productName = productName;
        this.variantName = variantName;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getVariantName() {
        return variantName;
    }

    public void setVariantName(String variantName) {
        this.variantName = variantName;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getInvoiceId() {
        return invoiceId;
    }

    public void setInvoiceId(String invoiceId) {
        this.invoiceId = invoiceId;
    }

    public int getProductVariantId() {
        return productVariantId;
    }

    public void setProductVariantId(int productVariantId) {
        this.productVariantId = productVariantId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    @Override
    public String toString() {
        return "InvoiceItem{" + "id=" + id + ", invoiceId=" + invoiceId + ", productVariantId=" + productVariantId + ", quantity=" + quantity + ", price=" + price + '}';
    }

}
