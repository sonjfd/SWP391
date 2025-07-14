/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.Map;
import java.util.List;

/**
 *
 * @author Admin
 */
public class DashboardProducts {
    // A. Tổng quan doanh thu

    private double revenueToday;
    private double revenueYesterday;
    private double revenueThisMonth;
    private double revenueLastMonth;
    private double revenueThisYear;
    private List<Double> dailyRevenueThisMonth;
    private List<Double> dailyRevenueLastMonth;
    private Map<Integer, Double> dailyRevenueInMonth;
    private Map<String, Double> paymentMethodDistribution;

    // B. Phân tích hóa đơn
    private int totalInvoices;
    private int totalInvoicesPaid;
    private int totalInvoicesUnpaid;
    private double averageOrderValue;

    // C. Doanh thu theo sản phẩm / danh mục
    private List<TopProduct> topSellingProducts;
    private Map<String, Double> revenueByCategory;

    // D. Tình trạng kho
    private int outOfStockProducts;
    private int lowStockProducts;

    // E. Bộ lọc doanh thu theo thời gian
    private double filteredRevenue;
    private Map<String, Double> filteredRevenueByDay;

    public DashboardProducts() {
    }

    public DashboardProducts(double revenueToday, double revenueYesterday, double revenueThisMonth, double revenueLastMonth, double revenueThisYear, Map<Integer, Double> dailyRevenueInMonth, Map<String, Double> paymentMethodDistribution, int totalInvoices, int totalInvoicesPaid, int totalInvoicesUnpaid, double averageOrderValue, List<TopProduct> topSellingProducts, Map<String, Double> revenueByCategory, int outOfStockProducts, int lowStockProducts, double filteredRevenue, Map<String, Double> filteredRevenueByDay) {
        this.revenueToday = revenueToday;
        this.revenueYesterday = revenueYesterday;
        this.revenueThisMonth = revenueThisMonth;
        this.revenueLastMonth = revenueLastMonth;
        this.revenueThisYear = revenueThisYear;
        this.dailyRevenueInMonth = dailyRevenueInMonth;
        this.paymentMethodDistribution = paymentMethodDistribution;
        this.totalInvoices = totalInvoices;
        this.totalInvoicesPaid = totalInvoicesPaid;
        this.totalInvoicesUnpaid = totalInvoicesUnpaid;
        this.averageOrderValue = averageOrderValue;
        this.topSellingProducts = topSellingProducts;
        this.revenueByCategory = revenueByCategory;
        this.outOfStockProducts = outOfStockProducts;
        this.lowStockProducts = lowStockProducts;
        this.filteredRevenue = filteredRevenue;
        this.filteredRevenueByDay = filteredRevenueByDay;
    }

    public List<Double> getDailyRevenueThisMonth() {
        return dailyRevenueThisMonth;
    }

    public void setDailyRevenueThisMonth(List<Double> dailyRevenueThisMonth) {
        this.dailyRevenueThisMonth = dailyRevenueThisMonth;
    }

    public List<Double> getDailyRevenueLastMonth() {
        return dailyRevenueLastMonth;
    }

    public void setDailyRevenueLastMonth(List<Double> dailyRevenueLastMonth) {
        this.dailyRevenueLastMonth = dailyRevenueLastMonth;
    }

    
    public double getRevenueToday() {
        return revenueToday;
    }

    public void setRevenueToday(double revenueToday) {
        this.revenueToday = revenueToday;
    }

    public double getRevenueYesterday() {
        return revenueYesterday;
    }

    public void setRevenueYesterday(double revenueYesterday) {
        this.revenueYesterday = revenueYesterday;
    }

    public double getRevenueThisMonth() {
        return revenueThisMonth;
    }

    public void setRevenueThisMonth(double revenueThisMonth) {
        this.revenueThisMonth = revenueThisMonth;
    }

    public double getRevenueLastMonth() {
        return revenueLastMonth;
    }

    public void setRevenueLastMonth(double revenueLastMonth) {
        this.revenueLastMonth = revenueLastMonth;
    }

    public double getRevenueThisYear() {
        return revenueThisYear;
    }

    public void setRevenueThisYear(double revenueThisYear) {
        this.revenueThisYear = revenueThisYear;
    }

    public Map<Integer, Double> getDailyRevenueInMonth() {
        return dailyRevenueInMonth;
    }

    public void setDailyRevenueInMonth(Map<Integer, Double> dailyRevenueInMonth) {
        this.dailyRevenueInMonth = dailyRevenueInMonth;
    }

    public Map<String, Double> getPaymentMethodDistribution() {
        return paymentMethodDistribution;
    }

    public void setPaymentMethodDistribution(Map<String, Double> paymentMethodDistribution) {
        this.paymentMethodDistribution = paymentMethodDistribution;
    }

    public int getTotalInvoices() {
        return totalInvoices;
    }

    public void setTotalInvoices(int totalInvoices) {
        this.totalInvoices = totalInvoices;
    }

    public int getTotalInvoicesPaid() {
        return totalInvoicesPaid;
    }

    public void setTotalInvoicesPaid(int totalInvoicesPaid) {
        this.totalInvoicesPaid = totalInvoicesPaid;
    }

    public int getTotalInvoicesUnpaid() {
        return totalInvoicesUnpaid;
    }

    public void setTotalInvoicesUnpaid(int totalInvoicesUnpaid) {
        this.totalInvoicesUnpaid = totalInvoicesUnpaid;
    }

    public double getAverageOrderValue() {
        return averageOrderValue;
    }

    public void setAverageOrderValue(double averageOrderValue) {
        this.averageOrderValue = averageOrderValue;
    }

    public List<TopProduct> getTopSellingProducts() {
        return topSellingProducts;
    }

    public void setTopSellingProducts(List<TopProduct> topSellingProducts) {
        this.topSellingProducts = topSellingProducts;
    }

    public Map<String, Double> getRevenueByCategory() {
        return revenueByCategory;
    }

    public void setRevenueByCategory(Map<String, Double> revenueByCategory) {
        this.revenueByCategory = revenueByCategory;
    }

    public int getOutOfStockProducts() {
        return outOfStockProducts;
    }

    public void setOutOfStockProducts(int outOfStockProducts) {
        this.outOfStockProducts = outOfStockProducts;
    }

    public int getLowStockProducts() {
        return lowStockProducts;
    }

    public void setLowStockProducts(int lowStockProducts) {
        this.lowStockProducts = lowStockProducts;
    }

    public double getFilteredRevenue() {
        return filteredRevenue;
    }

    public void setFilteredRevenue(double filteredRevenue) {
        this.filteredRevenue = filteredRevenue;
    }

    public Map<String, Double> getFilteredRevenueByDay() {
        return filteredRevenueByDay;
    }

    public void setFilteredRevenueByDay(Map<String, Double> filteredRevenueByDay) {
        this.filteredRevenueByDay = filteredRevenueByDay;
    }

    @Override
    public String toString() {
        return "DashboardProducts{" + "revenueToday=" + revenueToday + ", revenueYesterday=" + revenueYesterday + ", revenueThisMonth=" + revenueThisMonth + ", revenueLastMonth=" + revenueLastMonth + ", revenueThisYear=" + revenueThisYear + ", dailyRevenueThisMonth=" + dailyRevenueThisMonth + ", dailyRevenueLastMonth=" + dailyRevenueLastMonth + ", dailyRevenueInMonth=" + dailyRevenueInMonth + ", paymentMethodDistribution=" + paymentMethodDistribution + ", totalInvoices=" + totalInvoices + ", totalInvoicesPaid=" + totalInvoicesPaid + ", totalInvoicesUnpaid=" + totalInvoicesUnpaid + ", averageOrderValue=" + averageOrderValue + ", topSellingProducts=" + topSellingProducts + ", revenueByCategory=" + revenueByCategory + ", outOfStockProducts=" + outOfStockProducts + ", lowStockProducts=" + lowStockProducts + ", filteredRevenue=" + filteredRevenue + ", filteredRevenueByDay=" + filteredRevenueByDay + '}';
    }

    

}
