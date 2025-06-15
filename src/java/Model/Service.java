/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author Dell
 */
public class Service {
    private String id;
    private Department department;
    private String name;
    
    private String description;
    private double price;
    private int status;
    
    public Service() {
    }

    public Service(String id, Department department, String name, String description, double price, int status) {
        this.id = id;
        this.department = department;
        this.name = name;
        this.description = description;
        this.price = price;
        this.status = status;
    }

    

    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Service{" + "id=" + id + ", department=" + department + ", name=" + name + ", description=" + description + ", price=" + price + ", status=" + status + '}';
    }

    

    
    
}
