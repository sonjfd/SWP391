package Model;



public class ProductVariantWeight {
    private int weightId;
    private double weight;
    private boolean status;

    public ProductVariantWeight() {
    }

    public ProductVariantWeight(int weightId, double weight, boolean status) {
        this.weightId = weightId;
        this.weight = weight;
        this.status = status;
    }

    public int getWeightId() {
        return weightId;
    }

    public void setWeightId(int weightId) {
        this.weightId = weightId;
    }

    public double getWeight() {
        return weight;
    }

    public void setWeight(double weight) {
        this.weight = weight;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "ProductVariantWeight{" + "weightId=" + weightId + ", weight=" + weight + ", status=" + status + '}';
    }

    
   
}
