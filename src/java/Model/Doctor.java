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
    private String qualifications;
    private int yearsOfExperience;
    private int biography;
    private int status ;

    public Doctor() {
    }

    public Doctor(User user, String specialty, String qualifications, int yearsOfExperience, int biography, int status) {
        this.user = user;
        this.specialty = specialty;
        this.qualifications = qualifications;
        this.yearsOfExperience = yearsOfExperience;
        this.biography = biography;
        this.status = status;
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

    public int getBiography() {
        return biography;
    }

    public void setBiography(int biography) {
        this.biography = biography;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Doctors{" + "user=" + user + ", specialty=" + specialty + ", qualifications=" + qualifications + ", yearsOfExperience=" + yearsOfExperience + ", biography=" + biography + ", status=" + status + '}';
    }

   
    
}
