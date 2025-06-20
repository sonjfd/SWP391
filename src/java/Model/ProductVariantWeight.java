package Model;

import java.math.BigDecimal;

public class ProductVariantWeight {
    private int weightId;
    private BigDecimal weight;

    public ProductVariantWeight() {
    }

    public ProductVariantWeight(int weightId, BigDecimal weight) {
        this.weightId = weightId;
        this.weight = weight;
    }

    public int getWeightId() {
        return weightId;
    }

    public void setWeightId(int weightId) {
        this.weightId = weightId;
    }

    public BigDecimal getWeight() {
        return weight;
    }

    public void setWeight(BigDecimal weight) {
        this.weight = weight;
    }

    @Override
    public String toString() {
        return "ProductVariantWeight{" + "weightId=" + weightId + ", weight=" + weight + '}';
    }
}
