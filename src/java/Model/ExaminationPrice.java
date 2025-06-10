/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.Date;

/**
 *
 * @author Dell
 */
public class ExaminationPrice {
    private String id;
    private double price;
  

    public ExaminationPrice() {
    }

    public ExaminationPrice(String id, double price) {
        this.id = id;
        this.price = price;
        
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    @Override
    public String toString() {
        return "ExaminationPrice{" + "id=" + id + ", price=" + price + '}';
    }

    

   
    
}
