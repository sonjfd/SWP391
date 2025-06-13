/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.sql.Timestamp;
import java.util.Date;

/**
 *
 * @author Dell
 */
public class MedicalRecord {
    private String id;
    private Pet pet;
    private Doctor doctor;
    private Appointment appointment;
    private String diagnosis;
    private String treatment;
    private Date reExamDate;
    private Date createdAt;
    private Date updatedAt;

    public MedicalRecord() {
    }

    public MedicalRecord(String id, Pet pet, Doctor doctor, Appointment appointment, String diagnosis, String treatment, Date reExamDate, Date createdAt, Date updatedAt) {
        this.id = id;
        this.pet = pet;
        this.doctor = doctor;
        this.appointment = appointment;
        this.diagnosis = diagnosis;
        this.treatment = treatment;
        this.reExamDate = reExamDate;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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

    public Appointment getAppointment() {
        return appointment;
    }

    public void setAppointment(Appointment appointment) {
        this.appointment = appointment;
    }

    public String getDiagnosis() {
        return diagnosis;
    }

    public void setDiagnosis(String diagnosis) {
        this.diagnosis = diagnosis;
    }

    public String getTreatment() {
        return treatment;
    }

    public void setTreatment(String treatment) {
        this.treatment = treatment;
    }

    public Date getReExamDate() {
        return reExamDate;
    }

    public void setReExamDate(Date reExamDate) {
        this.reExamDate = reExamDate;
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
        return "MedicalRecord{" + "id=" + id + ", pet=" + pet + ", doctor=" + doctor + ", appointment=" + appointment + ", diagnosis=" + diagnosis + ", treatment=" + treatment + ", reExamDate=" + reExamDate + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + '}';
    }

    
    

    
    

    
    
    
    
}
