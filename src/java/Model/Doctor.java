/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author Dell
 */
public class Doctor {
    private User user;
    private String specialty;
    private String certificates;
    private String qualifications;
    private int yearsOfExperience;
    private String biography;
    

    public Doctor() {
    }

    public Doctor(User user, String specialty, String certificates, String qualifications, int yearsOfExperience, String biography) {
        this.user = user;
        this.specialty = specialty;
        this.certificates = certificates;
        this.qualifications = qualifications;
        this.yearsOfExperience = yearsOfExperience;
        this.biography = biography;
        
    }

    

    

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getSpecialty() {
        return specialty;
    }

    public void setSpecialty(String specialty) {
        this.specialty = specialty;
    }

    public String getCertificates() {
        return certificates;
    }

    public void setCertificates(String certificates) {
        this.certificates = certificates;
    }

    public String getQualifications() {
        return qualifications;
    }

    public void setQualifications(String qualifications) {
        this.qualifications = qualifications;
    }

    public int getYearsOfExperience() {
        return yearsOfExperience;
    }

    public void setYearsOfExperience(int yearsOfExperience) {
        this.yearsOfExperience = yearsOfExperience;
    }

    public String getBiography() {
        return biography;
    }

    public void setBiography(String biography) {
        this.biography = biography;
    }

    @Override
    public String toString() {
        return "Doctor{" + "user=" + user + ", specialty=" + specialty + ", certificates=" + certificates + ", qualifications=" + qualifications + ", yearsOfExperience=" + yearsOfExperience + ", biography=" + biography + '}';
    }

    



   

    

   
    
}