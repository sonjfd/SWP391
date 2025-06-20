/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.DashboardData;
import Model.AppointmentReportData;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author FPT
 */
public class DashboardDAO {
    public DashboardData getDashboardData() throws SQLException {
        try (Connection conn = DBContext.getConnection()) {
            // Tổng thú cưng
            String sqlPets = "SELECT COUNT(*) AS total_pets FROM pets";
            PreparedStatement stmt = conn.prepareStatement(sqlPets);
            ResultSet rs = stmt.executeQuery();
            int totalPets = 0;
            if (rs.next()) {
                totalPets = rs.getInt("total_pets");
            }

            // Tổng doanh thu
            String sqlRevenue = "SELECT SUM(total_amount) AS total_revenue FROM invoices WHERE payment_status = 'paid'";
            stmt = conn.prepareStatement(sqlRevenue);
            rs = stmt.executeQuery();
            double totalRevenue = 0;
            if (rs.next()) {
                totalRevenue = rs.getDouble("total_revenue");
            }

            // Tổng cuộc hẹn
            String sqlAppointments = "SELECT COUNT(*) AS total_appointments FROM appointments";
            stmt = conn.prepareStatement(sqlAppointments);
            rs = stmt.executeQuery();
            int totalAppointments = 0;
            if (rs.next()) {
                totalAppointments = rs.getInt("total_appointments");
            }

            // Tổng người dùng
            String sqlUsers = "SELECT COUNT(*) AS total_users FROM users";
            stmt = conn.prepareStatement(sqlUsers);
            rs = stmt.executeQuery();
            int totalUsers = 0;
            if (rs.next()) {
                totalUsers = rs.getInt("total_users");
            }

            // Tổng bác sĩ
            String sqlDoctors = "SELECT COUNT(*) AS total_doctors FROM doctors";
            stmt = conn.prepareStatement(sqlDoctors);
            rs = stmt.executeQuery();
            int totalDoctors = 0;
            if (rs.next()) {
                totalDoctors = rs.getInt("total_doctors");
            }

            // Tổng y tá
            String sqlNurses = "SELECT COUNT(*) AS total_nurses FROM nurses";
            stmt = conn.prepareStatement(sqlNurses);
            rs = stmt.executeQuery();
            int totalNurses = 0;
            if (rs.next()) {
                totalNurses = rs.getInt("total_nurses");
            }

            return new DashboardData(totalPets, totalRevenue, totalAppointments, totalUsers, totalDoctors, totalNurses);
        }
    }

    public AppointmentReportData getAppointmentReportData(int days) throws SQLException {
        List<String> dates = new ArrayList<>();
        List<Integer> counts = new ArrayList<>();
        List<String> species = new ArrayList<>();
        List<Integer> speciesCounts = new ArrayList<>();

        try (Connection conn = DBContext.getConnection()) {
            // Thống kê cuộc hẹn theo ngày
            String sqlDates = "SELECT CAST(appointment_time AS DATE) AS appointment_date, COUNT(*) AS count " +
                    "FROM appointments " +
                    "WHERE appointment_time >= DATEADD(day, ?, GETDATE()) " +
                    "GROUP BY CAST(appointment_time AS DATE) " +
                    "ORDER BY appointment_date";
            PreparedStatement stmt = conn.prepareStatement(sqlDates);
            stmt.setInt(1, -days);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                dates.add(rs.getString("appointment_date"));
                counts.add(rs.getInt("count"));
            }

            // Thống kê thú cưng theo loài (dựa trên các cuộc hẹn)
            String sqlSpecies = "SELECT s.name, COUNT(DISTINCT p.id) AS count " +
                    "FROM appointments a " +
                    "JOIN pets p ON a.pet_id = p.id " +
                    "JOIN breeds b ON p.breeds_id = b.id " +
                    "JOIN species s ON b.species_id = s.id " +
                    "WHERE a.appointment_time >= DATEADD(day, ?, GETDATE()) " +
                    "GROUP BY s.name";
            stmt = conn.prepareStatement(sqlSpecies);
            stmt.setInt(1, -days);
            rs = stmt.executeQuery();
            while (rs.next()) {
                species.add(rs.getString("name"));
                speciesCounts.add(rs.getInt("count"));
            }
        }
        return new AppointmentReportData(dates, counts, species, speciesCounts);
    }
    
    public static void main(String[] args) {
        DashboardDAO dao = new DashboardDAO();

        try {
            // Test getDashboardData()
            DashboardData dashboard = dao.getDashboardData();
            System.out.println("== DASHBOARD DATA ==");
            System.out.println("Total Pets: " + dashboard.getTotalPets());
            System.out.println("Total Revenue: " + dashboard.getTotalRevenue());
            System.out.println("Total Appointments: " + dashboard.getTotalAppointments());
            System.out.println("Total Users: " + dashboard.getTotalUsers());
            System.out.println("Total Doctors: " + dashboard.getTotalDoctors());
            System.out.println("Total Nurses: " + dashboard.getTotalNurses());
            System.out.println();

            // Test getAppointmentReportData() for last 7 days
            AppointmentReportData report = dao.getAppointmentReportData(7);
            System.out.println("== APPOINTMENT REPORT (Last 7 Days) ==");

            List<String> dates = report.getDates();
            List<Integer> counts = report.getCounts();
            System.out.println("Date-wise Appointments:");
            for (int i = 0; i < dates.size(); i++) {
                System.out.println(dates.get(i) + ": " + counts.get(i));
            }

            List<String> species = report.getSpecies();
            List<Integer> speciesCounts = report.getSpeciesCounts();
            System.out.println("\nSpecies-wise Appointments:");
            for (int i = 0; i < species.size(); i++) {
                System.out.println(species.get(i) + ": " + speciesCounts.get(i));
            }

        } catch (SQLException e) {
            System.err.println("Database error: " + e.getMessage());
        }
    }
    
}
