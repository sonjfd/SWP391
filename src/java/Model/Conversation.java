/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.Date;

/**
 *
 * @author Admin
 */
public class Conversation {
    private String id;
    private User customer;
    private User staff;
    private Date created_at;
    private Date last_masage_time ;

    public Conversation() {
    }

    public Conversation(String id, User customer, User staff, Date created_at, Date last_masage_time) {
        this.id = id;
        this.customer = customer;
        this.staff = staff;
        this.created_at = created_at;
        this.last_masage_time = last_masage_time;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public User getCustomer() {
        return customer;
    }

    public void setCustomer(User customer) {
        this.customer = customer;
    }

    public User getStaff() {
        return staff;
    }

    public void setStaff(User staff) {
        this.staff = staff;
    }

    public Date getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Date created_at) {
        this.created_at = created_at;
    }

    public Date getLast_masage_time() {
        return last_masage_time;
    }

    public void setLast_masage_time(Date last_masage_time) {
        this.last_masage_time = last_masage_time;
    }

    @Override
    public String toString() {
        return "Conversation{" + "id=" + id + ", customer=" + customer + ", staff=" + staff + ", created_at=" + created_at + ", last_masage_time=" + last_masage_time + '}';
    }
    
}