/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.Date;



public class Contact {
    private String id;
    private String name;
    private String email;
    private String phone;
    private String message;
    private String status;
    private Date createdAt;

    public Contact() {
    }

    public Contact(String id, String name, String email, String phone, String message, String status, Date createdAt) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.message = message;
        this.status = status;
        this.createdAt = createdAt;
    }
    
    public Contact( String name, String email, String phone, String message, Date createdAt) {
        
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.message = message;

        this.createdAt = createdAt;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "Contact{" + "id=" + id + ", name=" + name + ", email=" + email + ", phone=" + phone + ", message=" + message + ", status=" + status + ", createdAt=" + createdAt + '}';
    }

   

}
