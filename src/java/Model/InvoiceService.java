/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.Date;

/**
 *
 * @author Dell
 */
public class InvoiceService {
    private String id;
    private Appointment appointment;
    private double totalAmount;
    private String paymentStatus;
    private String paymentMethod;
    private Date paidAt;
    private Date createDate;
    private Date updateDate;

    public InvoiceService() {
    }

    public InvoiceService(String id, Appointment appointment, double totalAmount, String paymentStatus, String paymentMethod, Date paidAt, Date createDate, Date updateDate) {
        this.id = id;
        this.appointment = appointment;
        this.totalAmount = totalAmount;
        this.paymentStatus = paymentStatus;
        this.paymentMethod = paymentMethod;
        this.paidAt = paidAt;
        this.createDate = createDate;
        this.updateDate = updateDate;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    
    public Appointment getAppointment() {
        return appointment;
    }

    public void setAppointment(Appointment appointment) {
        this.appointment = appointment;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public Date getPaidAt() {
        return paidAt;
    }

    public void setPaidAt(Date paidAt) {
        this.paidAt = paidAt;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    @Override
    public String toString() {
        return "InvoiceService{" + "id=" + id + ", appointment=" + appointment + ", totalAmount=" + totalAmount + ", paymentStatus=" + paymentStatus + ", paymentMethod=" + paymentMethod + ", paidAt=" + paidAt + ", createDate=" + createDate + ", updateDate=" + updateDate + '}';
    }
    
    
}
