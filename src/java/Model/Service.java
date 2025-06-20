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
    private int departmentId;
    private String name;
    private String description;
    private double price;
    private int status;

    public Service() {
    }

    public Service(String id, int departmentId, String name, String description, double price, int status) {
        this.id = id;
        this.departmentId = departmentId;
        this.name = name;
        this.description = description;
        this.price = price;
        this.status = status;
    }
    

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public int getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(int departmentId) {
        this.departmentId = departmentId;
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
        return "Service{" + "id=" + id + ", departmentId=" + departmentId + ", name=" + name + ", description=" + description + ", price=" + price + ", status=" + status + '}';
    }

    
    
}
