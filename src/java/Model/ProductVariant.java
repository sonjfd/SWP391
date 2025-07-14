package Model;

import java.util.Date;

public class ProductVariant {

    // --- Trường chính từ bảng product_variants ---
    private int productVariantId;
    private int productId;

    private int weightId;
    private int flavorId;
    private double price;
    private int stockQuantity;
    private boolean status; // true = 1 = Đang bán, false = 0 = Ngừng bán
    private String image;
    private Date createdAt;
    private Date updatedAt;

    // --- Trường hiển thị phụ ---
    private String productName;
    private double weight;
    private String flavorName;
    private String categoryName;
  

    public ProductVariant() {
    }

    public ProductVariant(int productVariantId, int productId, int weightId, int flavorId, double price, int stockQuantity, boolean status, String image, Date createdAt, Date updatedAt, String productName, double weight, String flavorName, String categoryName) {
        this.productVariantId = productVariantId;
        this.productId = productId;
        this.weightId = weightId;
        this.flavorId = flavorId;
        this.price = price;
        this.stockQuantity = stockQuantity;
        this.status = status;
        this.image = image;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.productName = productName;
        this.weight = weight;
        this.flavorName = flavorName;
        this.categoryName = categoryName;
    }

    public int getProductVariantId() {
        return productVariantId;
    }

    public void setProductVariantId(int productVariantId) {
        this.productVariantId = productVariantId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

 

    public int getWeightId() {
        return weightId;
    }

    public void setWeightId(int weightId) {
        this.weightId = weightId;
    }

    public int getFlavorId() {
        return flavorId;
    }

    public void setFlavorId(int flavorId) {
        this.flavorId = flavorId;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

    // --- Trường hiển thị bổ sung ---
    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public double getWeight() {
        return weight;
    }

    public void setWeight(double weight) {
        this.weight = weight;
    }

    public String getFlavorName() {
        return flavorName;
    }

    public void setFlavorName(String flavorName) {
        this.flavorName = flavorName;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    // --- Hiển thị tên trạng thái ---
    public String getStatusName() {
        return status ? "Đang bán" : "Ngừng bán";
    }

    @Override
    public String toString() {
        return "ProductVariant{" + "productVariantId=" + productVariantId + ", productId=" + productId + ", weightId=" + weightId + ", flavorId=" + flavorId + ", price=" + price + ", stockQuantity=" + stockQuantity + ", status=" + status + ", image=" + image + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + ", productName=" + productName + ", weight=" + weight + ", flavorName=" + flavorName + ", categoryName=" + categoryName + '}';
    }

}
