/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

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
    private Date startTime;
    private Date endTime;
    private String status;
    private String note;
    private Date createdAt;
    private Date updatedAt;

    public Appointment() {
    }

    public Appointment(String id, User user, Pet pet, Doctor doctor, Date startTime, Date endTime, String status, String note, Date createdAt, Date updatedAt) {
        this.id = id;
        this.user = user;
        this.pet = pet;
        this.doctor = doctor;
        this.startTime = startTime;
        this.endTime = endTime;
        this.status = status;
        this.note = note;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
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

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

    @Override
    public String toString() {
        return "Appointment{" + "id=" + id + ", user=" + user + ", pet=" + pet + ", doctor=" + doctor + ", startTime=" + startTime + ", endTime=" + endTime + ", status=" + status + ", note=" + note + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + '}';
    }
    
    
}
