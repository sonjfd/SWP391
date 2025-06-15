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
    private String medicalRecordId;
    private String medicineId;
    private int quantity;
    private String dosage;
    private String duration;
    private String usageInstructions;

    public PrescribedMedicine() {
    }

    public PrescribedMedicine(String medicalRecordId, String medicineId, int quantity, String dosage, String duration, String usageInstructions) {
        this.medicalRecordId = medicalRecordId;
        this.medicineId = medicineId;
        this.quantity = quantity;
        this.dosage = dosage;
        this.duration = duration;
        this.usageInstructions = usageInstructions;
    }

    
    

    public String getMedicalRecordId() {
        return medicalRecordId;
    }

    public void setMedicalRecordId(String medicalRecordId) {
        this.medicalRecordId = medicalRecordId;
    }

    public String getMedicineId() {
        return medicineId;
    }

    public void setMedicineId(String medicineId) {
        this.medicineId = medicineId;
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

    public String getUsageInstructions() {
        return usageInstructions;
    }

    public void setUsageInstructions(String usageInstructions) {
        this.usageInstructions = usageInstructions;
    }

    

    

    

    

    
    
    
}
