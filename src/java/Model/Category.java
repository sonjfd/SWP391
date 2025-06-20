/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author Admin
 */
public class Category {
    private int CategoryId;
    private String CategoryName;
    private String description;
    private boolean status;

    public Category() {
    }

    public Category(int CategoryId, String CategoryName, String description,boolean status) {
        this.CategoryId = CategoryId;
        this.CategoryName = CategoryName;
        this.description = description;
        this.status = status;
    }

    public int getCategoryId() {
        return CategoryId;
    }

    public void setCategoryId(int CategoryId) {
        this.CategoryId = CategoryId;
    }

    public String getCategoryName() {
        return CategoryName;
    }

    public void setCategoryName(String CategoryName) {
        this.CategoryName = CategoryName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Category{" + "CategoryId=" + CategoryId + ", CategoryName=" + CategoryName + ", description=" + description + ", status=" + status + '}';
    }

   
    
    
}
