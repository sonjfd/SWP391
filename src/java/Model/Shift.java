/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.time.LocalTime;

/**
 *
 * @author Dell
 */
public class Shift {
    private int id;
    private String name;
    private LocalTime start_time;
    private LocalTime end_time;

    public Shift() {
    }

    public Shift(int id, String name, LocalTime start_time, LocalTime end_time) {
        this.id = id;
        this.name = name;
        this.start_time = start_time;
        this.end_time = end_time;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public LocalTime getStart_time() {
        return start_time;
    }

    public void setStart_time(LocalTime start_time) {
        this.start_time = start_time;
    }

    public LocalTime getEnd_time() {
        return end_time;
    }

    public void setEnd_time(LocalTime end_time) {
        this.end_time = end_time;
    }

    @Override
    public String toString() {
        return "Shift{" + "id=" + id + ", name=" + name + ", start_time=" + start_time + ", end_time=" + end_time + '}';
    }
    
    
    
}
