package Model;

import java.math.BigDecimal;
import java.util.Date;

public class ProductVariant {

    // --- Trường chính từ bảng product_variants ---
    private int productVariantId;
    private int productId;
    private String variantName;
    private int weightId;
    private int flavorId;
    private BigDecimal price;
    private int stockQuantity;
    private boolean status; // true = 1 = Đang bán, false = 0 = Ngừng bán
    private String image;
    private Date createdAt;
    private Date updatedAt;

    // --- Trường hiển thị phụ ---
    private String productName;
    private BigDecimal weight;
    private String flavorName;

    // --- Constructors ---
    public ProductVariant() {}

    public ProductVariant(int productVariantId, int productId, String variantName,
                          int weightId, int flavorId, BigDecimal price, int stockQuantity,
                          boolean status, String image, Date createdAt, Date updatedAt) {
        this.productVariantId = productVariantId;
        this.productId = productId;
        this.variantName = variantName;
        this.weightId = weightId;
        this.flavorId = flavorId;
        this.price = price;
        this.stockQuantity = stockQuantity;
        this.status = status;
        this.image = image;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // --- Getter & Setter chính ---
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

    public String getVariantName() {
        return variantName;
    }

    public void setVariantName(String variantName) {
        this.variantName = variantName;
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

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
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

    public BigDecimal getWeight() {
        return weight;
    }

    public void setWeight(BigDecimal weight) {
        this.weight = weight;
    }

    public String getFlavorName() {
        return flavorName;
    }

    public void setFlavorName(String flavorName) {
        this.flavorName = flavorName;
    }

    // --- Hiển thị tên trạng thái ---
    public String getStatusName() {
        return status ? "Đang bán" : "Ngừng bán";
    }

    @Override
    public String toString() {
        return "ProductVariant{" + "productVariantId=" + productVariantId + ", productId=" + productId + ", variantName=" + variantName + ", weightId=" + weightId + ", flavorId=" + flavorId + ", price=" + price + ", stockQuantity=" + stockQuantity + ", status=" + status + ", image=" + image + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + ", productName=" + productName + ", weight=" + weight + ", flavorName=" + flavorName + '}';
    }

    
}
