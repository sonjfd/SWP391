/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author FPT
 */
public class DashboardData {
    private int totalPets;
    private double totalRevenue;
    private int totalAppointments;
    private int totalUsers;
    private int totalDoctors;
    private int totalNurses;

    public DashboardData() {
    }

    public DashboardData(int totalPets, double totalRevenue, int totalAppointments, int totalUsers, int totalDoctors, int totalNurses) {
        this.totalPets = totalPets;
        this.totalRevenue = totalRevenue;
        this.totalAppointments = totalAppointments;
        this.totalUsers = totalUsers;
        this.totalDoctors = totalDoctors;
        this.totalNurses = totalNurses;
    }

    public int getTotalPets() {
        return totalPets;
    }

    public void setTotalPets(int totalPets) {
        this.totalPets = totalPets;
    }

    public double getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(double totalRevenue) {
        this.totalRevenue = totalRevenue;
    }

    public int getTotalAppointments() {
        return totalAppointments;
    }

    public void setTotalAppointments(int totalAppointments) {
        this.totalAppointments = totalAppointments;
    }

    public int getTotalUsers() {
        return totalUsers;
    }

    public void setTotalUsers(int totalUsers) {
        this.totalUsers = totalUsers;
    }

    public int getTotalDoctors() {
        return totalDoctors;
    }

    public void setTotalDoctors(int totalDoctors) {
        this.totalDoctors = totalDoctors;
    }

    public int getTotalNurses() {
        return totalNurses;
    }

    public void setTotalNurses(int totalNurses) {
        this.totalNurses = totalNurses;
    }

    @Override
    public String toString() {
        return "DashboardData{" + "totalPets=" + totalPets + ", totalRevenue=" + totalRevenue + ", totalAppointments=" + totalAppointments + ", totalUsers=" + totalUsers + ", totalDoctors=" + totalDoctors + ", totalNurses=" + totalNurses + '}';
    }
    
}
