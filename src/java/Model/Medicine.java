/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author Dell
 */
public class Medicine {
    private String id;
    private String name;
    private String descripton;
    private double price;

    public Medicine() {
    }

    public Medicine(String id, String name, String descripton, double price) {
        this.id = id;
        this.name = name;
        this.descripton = descripton;
        this.price = price;
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

    public String getDescripton() {
        return descripton;
    }

    public void setDescripton(String descripton) {
        this.descripton = descripton;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    @Override
    public String toString() {
        return "Medicine{" + "id=" + id + ", name=" + name + ", descripton=" + descripton + ", price=" + price + '}';
    }
    

}
