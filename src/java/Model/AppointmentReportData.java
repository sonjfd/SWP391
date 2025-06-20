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
    private List<String> dates;
    private List<Integer> counts;
    private List<String> species;
    private List<Integer> speciesCounts;

    public AppointmentReportData() {
    }

    public AppointmentReportData(List<String> dates, List<Integer> counts, List<String> species, List<Integer> speciesCounts) {
        this.dates = dates;
        this.counts = counts;
        this.species = species;
        this.speciesCounts = speciesCounts;
    }

    public List<String> getDates() {
        return dates;
    }

    public void setDates(List<String> dates) {
        this.dates = dates;
    }

    public List<Integer> getCounts() {
        return counts;
    }

    public void setCounts(List<Integer> counts) {
        this.counts = counts;
    }

    public List<String> getSpecies() {
        return species;
    }

    public void setSpecies(List<String> species) {
        this.species = species;
    }

    public List<Integer> getSpeciesCounts() {
        return speciesCounts;
    }

    public void setSpeciesCounts(List<Integer> speciesCounts) {
        this.speciesCounts = speciesCounts;
    }

    @Override
    public String toString() {
        return "AppointmentReportData{" + "dates=" + dates + ", counts=" + counts + ", species=" + species + ", speciesCounts=" + speciesCounts + '}';
    }

    
    
}
