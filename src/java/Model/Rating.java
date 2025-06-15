/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.Date;

/**
 *
 * @author Admin
 */
public class Rating {
    private String id;
    private Appointment appointment;
    private User user;
    private Doctor doctor;
    private int satisfaction_level;
    private String comment;
    private String status;
    private Date createdAt;

    public Rating() {
    }

    public Rating(String id, Appointment appointment, User user, Doctor doctor, int satisfaction_level, String comment, String status, Date createdAt) {
        this.id = id;
        this.appointment = appointment;
        this.user = user;
        this.doctor = doctor;
        this.satisfaction_level = satisfaction_level;
        this.comment = comment;
        this.status = status;
        this.createdAt = createdAt;
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

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Doctor getDoctor() {
        return doctor;
    }

    public void setDoctor(Doctor doctor) {
        this.doctor = doctor;
    }

    public int getSatisfaction_level() {
        return satisfaction_level;
    }

    public void setSatisfaction_level(int satisfaction_level) {
        this.satisfaction_level = satisfaction_level;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "Rating{" + "id=" + id + ", appointment=" + appointment + ", user=" + user + ", doctor=" + doctor + ", satisfaction_level=" + satisfaction_level + ", comment=" + comment + ", status=" + status + ", createdAt=" + createdAt + '}';
    }

}
