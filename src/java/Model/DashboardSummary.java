package Model;


import java.util.List;

public class DashboardSummary {
    private int bookedCount;
    private int completedCount;
    private int cancelRequestedCount;
    private int canceledCount;
    private double fillRate;
    private int newCustomers;
    private int previousNewCustomers;
    private int newPets;
    private int previousNewPets;
    private double serviceRevenue;
    private double previousServiceRevenue;
    private int doctorCount;
    private int nurseCount;
    private double averageDoctorRating;
    private double positiveRatingRate;
    private int userCount;
    private double totalRevenue;
    private double paidRevenue;
    private double unpaidRevenue;
    private double cashRevenue;
    private double onlineRevenue;
    private List<RevenueTrend> revenueTrends;
    private List<RevenueTrend> customerTrends;
    private List<RevenueTrend> petTrends;
    private List<RevenueTrend> appointmentTrends;

    public DashboardSummary() {
    }

    public DashboardSummary(int bookedCount, int completedCount, int cancelRequestedCount, int canceledCount, double fillRate, int newCustomers, int previousNewCustomers, int newPets, int previousNewPets, double serviceRevenue, double previousServiceRevenue, int doctorCount, int nurseCount, double averageDoctorRating, double positiveRatingRate, int userCount, double totalRevenue, double paidRevenue, double unpaidRevenue, double cashRevenue, double onlineRevenue, List<RevenueTrend> revenueTrends, List<RevenueTrend> customerTrends, List<RevenueTrend> petTrends, List<RevenueTrend> appointmentTrends) {
        this.bookedCount = bookedCount;
        this.completedCount = completedCount;
        this.cancelRequestedCount = cancelRequestedCount;
        this.canceledCount = canceledCount;
        this.fillRate = fillRate;
        this.newCustomers = newCustomers;
        this.previousNewCustomers = previousNewCustomers;
        this.newPets = newPets;
        this.previousNewPets = previousNewPets;
        this.serviceRevenue = serviceRevenue;
        this.previousServiceRevenue = previousServiceRevenue;
        this.doctorCount = doctorCount;
        this.nurseCount = nurseCount;
        this.averageDoctorRating = averageDoctorRating;
        this.positiveRatingRate = positiveRatingRate;
        this.userCount = userCount;
        this.totalRevenue = totalRevenue;
        this.paidRevenue = paidRevenue;
        this.unpaidRevenue = unpaidRevenue;
        this.cashRevenue = cashRevenue;
        this.onlineRevenue = onlineRevenue;
        this.revenueTrends = revenueTrends;
        this.customerTrends = customerTrends;
        this.petTrends = petTrends;
        this.appointmentTrends = appointmentTrends;
    }

    public int getBookedCount() {
        return bookedCount;
    }

    public void setBookedCount(int bookedCount) {
        this.bookedCount = bookedCount;
    }

    public int getCompletedCount() {
        return completedCount;
    }

    public void setCompletedCount(int completedCount) {
        this.completedCount = completedCount;
    }

    public int getCancelRequestedCount() {
        return cancelRequestedCount;
    }

    public void setCancelRequestedCount(int cancelRequestedCount) {
        this.cancelRequestedCount = cancelRequestedCount;
    }

    public int getCanceledCount() {
        return canceledCount;
    }

    public void setCanceledCount(int canceledCount) {
        this.canceledCount = canceledCount;
    }

    public double getFillRate() {
        return fillRate;
    }

    public void setFillRate(double fillRate) {
        this.fillRate = fillRate;
    }

    public int getNewCustomers() {
        return newCustomers;
    }

    public void setNewCustomers(int newCustomers) {
        this.newCustomers = newCustomers;
    }

    public int getPreviousNewCustomers() {
        return previousNewCustomers;
    }

    public void setPreviousNewCustomers(int previousNewCustomers) {
        this.previousNewCustomers = previousNewCustomers;
    }

    public int getNewPets() {
        return newPets;
    }

    public void setNewPets(int newPets) {
        this.newPets = newPets;
    }

    public int getPreviousNewPets() {
        return previousNewPets;
    }

    public void setPreviousNewPets(int previousNewPets) {
        this.previousNewPets = previousNewPets;
    }

    public double getServiceRevenue() {
        return serviceRevenue;
    }

    public void setServiceRevenue(double serviceRevenue) {
        this.serviceRevenue = serviceRevenue;
    }

    public double getPreviousServiceRevenue() {
        return previousServiceRevenue;
    }

    public void setPreviousServiceRevenue(double previousServiceRevenue) {
        this.previousServiceRevenue = previousServiceRevenue;
    }

    public int getDoctorCount() {
        return doctorCount;
    }

    public void setDoctorCount(int doctorCount) {
        this.doctorCount = doctorCount;
    }

    public int getNurseCount() {
        return nurseCount;
    }

    public void setNurseCount(int nurseCount) {
        this.nurseCount = nurseCount;
    }

    public double getAverageDoctorRating() {
        return averageDoctorRating;
    }

    public void setAverageDoctorRating(double averageDoctorRating) {
        this.averageDoctorRating = averageDoctorRating;
    }

    public double getPositiveRatingRate() {
        return positiveRatingRate;
    }

    public void setPositiveRatingRate(double positiveRatingRate) {
        this.positiveRatingRate = positiveRatingRate;
    }

    public int getUserCount() {
        return userCount;
    }

    public void setUserCount(int userCount) {
        this.userCount = userCount;
    }

    public double getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(double totalRevenue) {
        this.totalRevenue = totalRevenue;
    }

    public double getPaidRevenue() {
        return paidRevenue;
    }

    public void setPaidRevenue(double paidRevenue) {
        this.paidRevenue = paidRevenue;
    }

    public double getUnpaidRevenue() {
        return unpaidRevenue;
    }

    public void setUnpaidRevenue(double unpaidRevenue) {
        this.unpaidRevenue = unpaidRevenue;
    }

    public double getCashRevenue() {
        return cashRevenue;
    }

    public void setCashRevenue(double cashRevenue) {
        this.cashRevenue = cashRevenue;
    }

    public double getOnlineRevenue() {
        return onlineRevenue;
    }

    public void setOnlineRevenue(double onlineRevenue) {
        this.onlineRevenue = onlineRevenue;
    }

    public List<RevenueTrend> getRevenueTrends() {
        return revenueTrends;
    }

    public void setRevenueTrends(List<RevenueTrend> revenueTrends) {
        this.revenueTrends = revenueTrends;
    }

    public List<RevenueTrend> getCustomerTrends() {
        return customerTrends;
    }

    public void setCustomerTrends(List<RevenueTrend> customerTrends) {
        this.customerTrends = customerTrends;
    }

    public List<RevenueTrend> getPetTrends() {
        return petTrends;
    }

    public void setPetTrends(List<RevenueTrend> petTrends) {
        this.petTrends = petTrends;
    }

    public List<RevenueTrend> getAppointmentTrends() {
        return appointmentTrends;
    }

    public void setAppointmentTrends(List<RevenueTrend> appointmentTrends) {
        this.appointmentTrends = appointmentTrends;
    }

    @Override
    public String toString() {
        return "DashboardSummary{" + "bookedCount=" + bookedCount + ", completedCount=" + completedCount + ", cancelRequestedCount=" + cancelRequestedCount + ", canceledCount=" + canceledCount + ", fillRate=" + fillRate + ", newCustomers=" + newCustomers + ", previousNewCustomers=" + previousNewCustomers + ", newPets=" + newPets + ", previousNewPets=" + previousNewPets + ", serviceRevenue=" + serviceRevenue + ", previousServiceRevenue=" + previousServiceRevenue + ", doctorCount=" + doctorCount + ", nurseCount=" + nurseCount + ", averageDoctorRating=" + averageDoctorRating + ", positiveRatingRate=" + positiveRatingRate + ", userCount=" + userCount + ", totalRevenue=" + totalRevenue + ", paidRevenue=" + paidRevenue + ", unpaidRevenue=" + unpaidRevenue + ", cashRevenue=" + cashRevenue + ", onlineRevenue=" + onlineRevenue + ", revenueTrends=" + revenueTrends + ", customerTrends=" + customerTrends + ", petTrends=" + petTrends + ", appointmentTrends=" + appointmentTrends + '}';
    }
    
    

    
}