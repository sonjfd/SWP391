/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.time.LocalTime;
import java.util.Date;

/**
 *
 * @author ASUS
 */
public class Appointment {

    private String id;
    private User user;
    private Pet pet;
    private Doctor doctor;
    private Date appointmentDate;
    private LocalTime startTime;
    private LocalTime endTime;
    private String status;
    private String paymentStatus;
    private String paymentMethod;
    private String note;
    private Date createdAt;
    private Date updatedAt;

    public Appointment() {
    }

    public Appointment(String id, User user, Pet pet, Doctor doctor, Date appointmentDate, LocalTime startTime, LocalTime endTime, String status, String paymentStatus, String paymentMethod, String note, Date createdAt, Date updatedAt) {
        this.id = id;
        this.user = user;
        this.pet = pet;
        this.doctor = doctor;
        this.appointmentDate = appointmentDate;
        this.startTime = startTime;
        this.endTime = endTime;
        this.status = status;
        this.paymentStatus = paymentStatus;
        this.paymentMethod = paymentMethod;
        this.note = note;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public String getId() {
        return id;
    }

    public User getUser() {
        return user;
    }

    public Pet getPet() {
        return pet;
    }

    public Doctor getDoctor() {
        return doctor;
    }

    public Date getAppointmentDate() {
        return appointmentDate;
    }

    public LocalTime getStartTime() {
        return startTime;
    }

    public LocalTime getEndTime() {
        return endTime;
    }

    public String getStatus() {
        return status;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public String getNote() {
        return note;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public void setPet(Pet pet) {
        this.pet = pet;
    }

    public void setDoctor(Doctor doctor) {
        this.doctor = doctor;
    }

    public void setAppointmentDate(Date appointmentDate) {
        this.appointmentDate = appointmentDate;
    }

    public void setStartTime(LocalTime startTime) {
        this.startTime = startTime;
    }

    public void setEndTime(LocalTime endTime) {
        this.endTime = endTime;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

   
    
}
