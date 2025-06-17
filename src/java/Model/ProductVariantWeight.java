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
public class ProductVariantWeight {
    private int weightId;
    private int productVariantId;
    private double weight;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public ProductVariantWeight() {
    }

    public ProductVariantWeight(int weightId, int productVariantId, double weight, Timestamp createdAt, Timestamp updatedAt) {
        this.weightId = weightId;
        this.productVariantId = productVariantId;
        this.weight = weight;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public int getWeightId() {
        return weightId;
    }

    public void setWeightId(int weightId) {
        this.weightId = weightId;
    }

    public int getProductVariantId() {
        return productVariantId;
    }

    public void setProductVariantId(int productVariantId) {
        this.productVariantId = productVariantId;
    }

    public double getWeight() {
        return weight;
    }

    public void setWeight(double weight) {
        this.weight = weight;
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
        return "ProductVariantWeight{" + "weightId=" + weightId + ", productVariantId=" + productVariantId + ", weight=" + weight + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + '}';
    }
    
    
}
