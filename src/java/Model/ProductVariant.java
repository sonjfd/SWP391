package Model;

import java.util.Date;

public class ProductVariant {

    private int productVariantId;
    private int productId;
    private String productName; // ✅ thêm thuộc tính này
    private String variantName;
    private double price;
    private int stockQuantity;
    private Date createdAt;
    private Date updatedAt;

    public ProductVariant() {
    }

    public ProductVariant(int productVariantId, int productId, String productName, String variantName, double price, int stockQuantity, Date createdAt, Date updatedAt) {
        this.productVariantId = productVariantId;
        this.productId = productId;
        this.productName = productName;
        this.variantName = variantName;
        this.price = price;
        this.stockQuantity = stockQuantity;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
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

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getVariantName() {
        return variantName;
    }

    public void setVariantName(String variantName) {
        this.variantName = variantName;
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

    @Override
    public String toString() {
        return "ProductVariant{" +
                "productVariantId=" + productVariantId +
                ", productId=" + productId +
                ", productName=" + productName +
                ", variantName=" + variantName +
                ", price=" + price +
                ", stockQuantity=" + stockQuantity +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                '}';
    }
}
