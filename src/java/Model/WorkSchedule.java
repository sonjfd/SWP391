/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.time.LocalTime;
import java.util.Date;

public class WorkSchedule {

    private String id;
    private Doctor doctor;
    private Date workDate;
    private LocalTime startTime;     
    private LocalTime endTime;
    private Date createdAt;
    private Date updatedAt;

    
    public WorkSchedule() {
    }

    public WorkSchedule(String id, Doctor doctor, Date workDate, LocalTime startTime, LocalTime endTime, Date createdAt, Date updatedAt) {
        this.id = id;
        this.doctor = doctor;
        this.workDate = workDate;
        this.startTime = startTime;
        this.endTime = endTime;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Doctor getDoctor() {
        return doctor;
    }

    public void setDoctor(Doctor doctor) {
        this.doctor = doctor;
    }

    public Date getWorkDate() {
        return workDate;
    }

    public void setWorkDate(Date workDate) {
        this.workDate = workDate;
    }

    public LocalTime getStartTime() {
        return startTime;
    }

    public void setStartTime(LocalTime startTime) {
        this.startTime = startTime;
    }

    public LocalTime getEndTime() {
        return endTime;
    }

    public void setEndTime(LocalTime endTime) {
        this.endTime = endTime;
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
        return "WorkSchedule{" + "id=" + id + ", doctor=" + doctor + ", workDate=" + workDate + ", startTime=" + startTime + ", endTime=" + endTime + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + '}';
    }

   
}
