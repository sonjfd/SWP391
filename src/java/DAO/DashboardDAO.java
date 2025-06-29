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
    public DashboardDAO() {
        
    }
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

    // Lấy dữ liệu cho biểu đồ doanh thu và cuộc hẹn
    public AppointmentReportData getAppointmentReportData(int days) throws SQLException {
        List<String> revenueDates = new ArrayList<>();
        List<Double> revenues = new ArrayList<>();
        List<String> appointmentDates = new ArrayList<>();
        List<Integer> appointmentCounts = new ArrayList<>();

        try (Connection conn = DBContext.getConnection()) {
            // Lấy doanh thu theo ngày, dùng paid_at
            String revenueQuery = "SELECT CAST(paid_at AS DATE) AS revenue_date, SUM(total_amount) AS revenue " +
                                 "FROM invoices " +
                                 "WHERE payment_status = 'paid' AND paid_at >= DATEADD(day, ?, GETDATE()) " +
                                 "GROUP BY CAST(paid_at AS DATE) " +
                                 "ORDER BY revenue_date";
            try (PreparedStatement ps = conn.prepareStatement(revenueQuery)) {
                ps.setInt(1, -days);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        revenueDates.add(rs.getString("revenue_date"));
                        revenues.add(rs.getDouble("revenue"));
                    }
                }
            }

            // Lấy số cuộc hẹn theo ngày
            String appointmentQuery = "SELECT CAST(appointment_time AS DATE) AS appointment_date, COUNT(*) AS count " +
                                     "FROM appointments " +
                                     "WHERE appointment_time >= DATEADD(day, ?, GETDATE()) " +
                                     "GROUP BY CAST(appointment_time AS DATE) " +
                                     "ORDER BY appointment_date";
            try (PreparedStatement ps = conn.prepareStatement(appointmentQuery)) {
                ps.setInt(1, -days);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        appointmentDates.add(rs.getString("appointment_date"));
                        appointmentCounts.add(rs.getInt("count"));
                    }
                }
            }
        }

        return new AppointmentReportData(revenueDates, revenues, appointmentDates, appointmentCounts);
    }

    
    
}
