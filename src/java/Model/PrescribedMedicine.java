/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author Dell
 */
public class PrescribedMedicine {
    private MedicalRecords medicalRecords;
    private Medicine medicine;
    private int quantity;
    private String dosage;
    private String duration;
    private String usageIntructions;

    public PrescribedMedicine() {
    }

    public PrescribedMedicine(MedicalRecords medicalRecords, Medicine medicine, int quantity, String dosage, String duration, String usageIntructions) {
        this.medicalRecords = medicalRecords;
        this.medicine = medicine;
        this.quantity = quantity;
        this.dosage = dosage;
        this.duration = duration;
        this.usageIntructions = usageIntructions;
    }

    public MedicalRecords getMedicalRecords() {
        return medicalRecords;
    }

    public void setMedicalRecords(MedicalRecords medicalRecords) {
        this.medicalRecords = medicalRecords;
    }

    public Medicine getMedicine() {
        return medicine;
    }

    public void setMedicine(Medicine medicine) {
        this.medicine = medicine;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getDosage() {
        return dosage;
    }

    public void setDosage(String dosage) {
        this.dosage = dosage;
    }

    public String getDuration() {
        return duration;
    }

    public void setDuration(String duration) {
        this.duration = duration;
    }

    public String getUsageIntructions() {
        return usageIntructions;
    }

    public void setUsageIntructions(String usageIntructions) {
        this.usageIntructions = usageIntructions;
    }

    @Override
    public String toString() {
        return "PrescribedMedicine{" + "medicalRecords=" + medicalRecords + ", medicine=" + medicine + ", quantity=" + quantity + ", dosage=" + dosage + ", duration=" + duration + ", usageIntructions=" + usageIntructions + '}';
    }
    
    
}
