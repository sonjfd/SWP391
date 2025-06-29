/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.List;

/**
 *
 * @author FPT
 */
public class AppointmentReportData {
    private List<String> revenueDates;
    private List<Double> revenues;
    private List<String> appointmentDates;
    private List<Integer> appointmentCounts;

    public AppointmentReportData() {
    }

    public AppointmentReportData(List<String> revenueDates, List<Double> revenues, List<String> appointmentDates, List<Integer> appointmentCounts) {
        this.revenueDates = revenueDates;
        this.revenues = revenues;
        this.appointmentDates = appointmentDates;
        this.appointmentCounts = appointmentCounts;
    }

    public List<String> getRevenueDates() {
        return revenueDates;
    }

    public void setRevenueDates(List<String> revenueDates) {
        this.revenueDates = revenueDates;
    }

    public List<Double> getRevenues() {
        return revenues;
    }

    public void setRevenues(List<Double> revenues) {
        this.revenues = revenues;
    }

    public List<String> getAppointmentDates() {
        return appointmentDates;
    }

    public void setAppointmentDates(List<String> appointmentDates) {
        this.appointmentDates = appointmentDates;
    }

    public List<Integer> getAppointmentCounts() {
        return appointmentCounts;
    }

    public void setAppointmentCounts(List<Integer> appointmentCounts) {
        this.appointmentCounts = appointmentCounts;
    }

    @Override
    public String toString() {
        return "AppointmentReportData{" + "revenueDates=" + revenueDates + ", revenues=" + revenues + ", appointmentDates=" + appointmentDates + ", appointmentCounts=" + appointmentCounts + '}';
    }

    
    
    
}