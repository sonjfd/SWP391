/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;


import java.sql.Timestamp;

/**
 *
 * @author Admin
 */
public class ProductVariantFlavor {
   private int flavorId;
    private String flavor;
    private boolean status;

    public ProductVariantFlavor() {
    }

    public ProductVariantFlavor(int flavorId, String flavor, boolean status) {
        this.flavorId = flavorId;
        this.flavor = flavor;
        this.status = status;
    }

    public int getFlavorId() {
        return flavorId;
    }

    public void setFlavorId(int flavorId) {
        this.flavorId = flavorId;
    }

    public String getFlavor() {
        return flavor;
    }

    public void setFlavor(String flavor) {
        this.flavor = flavor;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "ProductVariantFlavor{" + "flavorId=" + flavorId + ", flavor=" + flavor + ", status=" + status + '}';
    }

    
    
}
