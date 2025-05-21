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
public class MedicalRecords {
    private String id;
    private Pet pet;
    private Doctor doctor;
    private Appointment appointment;
    private String diagnosis;
    private String treatment;
    private Date reExamDate;
    private String attachments;
    private Date createDate;
    private Date updateDate;

    public MedicalRecords() {
    }

    public MedicalRecords(String id, Pet pet, Doctor doctor, Appointment appointment, String diagnosis, String treatment, Date reExamDate, String attachments, Date createDate, Date updateDate) {
        this.id = id;
        this.pet = pet;
        this.doctor = doctor;
        this.appointment = appointment;
        this.diagnosis = diagnosis;
        this.treatment = treatment;
        this.reExamDate = reExamDate;
        this.attachments = attachments;
        this.createDate = createDate;
        this.updateDate = updateDate;
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

    public String getAttachments() {
        return attachments;
    }

    public void setAttachments(String attachments) {
        this.attachments = attachments;
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
        return "MedicalRecords{" + "id=" + id + ", pet=" + pet + ", doctor=" + doctor + ", appointment=" + appointment + ", diagnosis=" + diagnosis + ", treatment=" + treatment + ", reExamDate=" + reExamDate + ", attachments=" + attachments + ", createDate=" + createDate + ", updateDate=" + updateDate + '}';
    }
    
    
    
}
