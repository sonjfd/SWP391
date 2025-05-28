/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author Dell
 */
public class ScheduleTemplate {
    private int id;
    private Doctor doctor;
    private User user;
    private int weekday;
    private Shift shift;

    public ScheduleTemplate() {
    }

    public ScheduleTemplate(int id, Doctor doctor, User user, int weekday, Shift shift) {
        this.id = id;
        this.doctor = doctor;
        this.user = user;
        this.weekday = weekday;
        this.shift = shift;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Doctor getDoctor() {
        return doctor;
    }

    public void setDoctor(Doctor doctor) {
        this.doctor = doctor;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public int getWeekday() {
        return weekday;
    }

    public void setWeekday(int weekday) {
        this.weekday = weekday;
    }

    public Shift getShift() {
        return shift;
    }

    public void setShift(Shift shift) {
        this.shift = shift;
    }

    @Override
    public String toString() {
        return "ScheduleTemplate{" + "id=" + id + ", doctor=" + doctor + ", user=" + user + ", weekday=" + weekday + ", shift=" + shift + '}';
    }
    
}
