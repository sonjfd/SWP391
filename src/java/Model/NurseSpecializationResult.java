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
public class NurseSpecializationResult {
    private String id;
    private Appointment appointment;
    private Service service;
    private Nurse nurse;
    private Date createdAt;

    public NurseSpecializationResult() {
    }

    public NurseSpecializationResult(String id, Appointment appointment, Service service, Nurse nurse, Date createdAt) {
        this.id = id;
        this.appointment = appointment;
        this.service = service;
        this.nurse = nurse;
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

    public Service getService() {
        return service;
    }

    public void setService(Service service) {
        this.service = service;
    }

    public Nurse getNurse() {
        return nurse;
    }

    public void setNurse(Nurse nurse) {
        this.nurse = nurse;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "NurseSpecializationResult{" + "id=" + id + ", appointment=" + appointment + ", service=" + service + ", nurse=" + nurse + ", createdAt=" + createdAt + '}';
    }
    
}
