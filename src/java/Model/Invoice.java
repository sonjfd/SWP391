/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;



import java.math.BigDecimal;
import java.sql.Timestamp;

public class Invoice {
    private String invoiceId;
    private String staffId;
    private double totalAmount;
    private String paymentMethod;
    private String paymentStatus;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public Invoice() {
    }

    public Invoice(String invoiceId, String staffId, double totalAmount, String paymentMethod, String paymentStatus, Timestamp createdAt, Timestamp updatedAt) {
        this.invoiceId = invoiceId;
        this.staffId = staffId;
        this.totalAmount = totalAmount;
        this.paymentMethod = paymentMethod;
        this.paymentStatus = paymentStatus;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getters and Setters

    public String getInvoiceId() {
        return invoiceId;
    }

    public void setInvoiceId(String invoiceId) {
        this.invoiceId = invoiceId;
    }

    public String getStaffId() {
        return staffId;
    }

    public void setStaffId(String staffId) {
        this.staffId = staffId;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

  
    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    @Override
    public String toString() {
        return "Invoice{" + "invoiceId=" + invoiceId + ", staffId=" + staffId + ", totalAmount=" + totalAmount + ", paymentMethod=" + paymentMethod + ", paymentStatus=" + paymentStatus + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + '}';
    }
    
}
