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
    private int productVariantId;
    private String flavor;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public ProductVariantFlavor() {
    }

    public ProductVariantFlavor(int flavorId, int productVariantId, String flavor, Timestamp createdAt, Timestamp updatedAt) {
        this.flavorId = flavorId;
        this.productVariantId = productVariantId;
        this.flavor = flavor;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public int getFlavorId() {
        return flavorId;
    }

    public void setFlavorId(int flavorId) {
        this.flavorId = flavorId;
    }

    public int getProductVariantId() {
        return productVariantId;
    }

    public void setProductVariantId(int productVariantId) {
        this.productVariantId = productVariantId;
    }

    public String getFlavor() {
        return flavor;
    }

    public void setFlavor(String flavor) {
        this.flavor = flavor;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    @Override
    public String toString() {
        return "ProductVariantFlavor{" + "flavorId=" + flavorId + ", productVariantId=" + productVariantId + ", flavor=" + flavor + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + '}';
    }

    

    
}
