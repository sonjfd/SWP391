package Model;


public class RevenueTrend {
    private String period;
    private double value;
    private double previousValue;

    public RevenueTrend() {
    }

    public RevenueTrend(String period, double value, double previousValue) {
        this.period = period;
        this.value = value;
        this.previousValue = previousValue;
    }

    public String getPeriod() {
        return period;
    }

    public void setPeriod(String period) {
        this.period = period;
    }

    public double getValue() {
        return value;
    }

    public void setValue(double value) {
        this.value = value;
    }

    public double getPreviousValue() {
        return previousValue;
    }

    public void setPreviousValue(double previousValue) {
        this.previousValue = previousValue;
    }

    @Override
    public String toString() {
        return "RevenueTrend{" + "period=" + period + ", value=" + value + ", previousValue=" + previousValue + '}';
    }

    
    
}