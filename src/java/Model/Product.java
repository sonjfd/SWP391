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
public class Product {
    private int productId;
    private int categoryId;
    private int supplierId;
    private String productName;
    private String description;
    private String image;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public Product() {
    }

    public Product(int productId, int categoryId, int supplierId, String productName, String description, String image, Timestamp createdAt, Timestamp updatedAt) {
        this.productId = productId;
        this.categoryId = categoryId;
        this.supplierId = supplierId;
        this.productName = productName;
        this.description = description;
        this.image = image;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public int getSupplierId() {
        return supplierId;
    }

    public void setSupplierId(int supplierId) {
        this.supplierId = supplierId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
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
        return "Product{" + "productId=" + productId + ", categoryId=" + categoryId + ", supplierId=" + supplierId + ", productName=" + productName + ", description=" + description + ", image=" + image + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + '}';
    }
    
    
}
