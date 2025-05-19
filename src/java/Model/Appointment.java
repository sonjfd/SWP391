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
public class Appointment {

    private int id;
    private User user;
    private Pet pet;
    private Doctor doctor;
    private Date appointmentTime;
    private String status;
    private String notes;
    private Date createDate;
    private Date updateDate;

    public Appointment() {
    }

    public Appointment(int id, User user, Pet pet, Doctor doctor, Date appointmentTime, String status, String notes, Date createDate, Date updateDate) {
        this.id = id;
        this.user = user;
        this.pet = pet;
        this.doctor = doctor;
        this.appointmentTime = appointmentTime;
        this.status = status;
        this.notes = notes;
        this.createDate = createDate;
        this.updateDate = updateDate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Pet getPet() {
        return pet;
    }

    public void setPet(Pet pet) {
        this.pet = pet;
    }

    public Doctor getDoctor() {
        return doctor;
    }

    public void setDoctor(Doctor doctor) {
        this.doctor = doctor;
    }

    public Date getAppointmentTime() {
        return appointmentTime;
    }

    public void setAppointmentTime(Date appointmentTime) {
        this.appointmentTime = appointmentTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
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
        return "Appointment{" + "id=" + id + ", user=" + user + ", pet=" + pet + ", doctor=" + doctor + ", appointmentTime=" + appointmentTime + ", status=" + status + ", notes=" + notes + ", createDate=" + createDate + ", updateDate=" + updateDate + '}';
    }
    
    

}
