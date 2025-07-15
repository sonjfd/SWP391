package DAO;

import Model.RevenueTrend;
import Model.DashboardSummary;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class ReportDAO {

    public DashboardSummary getDashboardSummary(String startDate, String endDate, String periodType) throws SQLException {
        DashboardSummary summary = new DashboardSummary();
        Connection conn = null;
        try {
            conn = DBContext.getConnection();

            // 1. Tổng Quan Hoạt Động
            getAppointmentCounts(conn, startDate, endDate, summary);
            getFillRate(conn, startDate, endDate, summary);
            getNewCustomers(conn, startDate, endDate, periodType, summary);
            getNewPets(conn, startDate, endDate, periodType, summary);
            getServiceRevenue(conn, startDate, endDate, periodType, summary);

            // 2. Hiệu Suất Nhân Sự
            getDoctorCount(conn, summary);
            getNurseCount(conn, summary);
            getAverageDoctorRating(conn, startDate, endDate, summary);
            getPositiveRatingRate(conn, startDate, endDate, summary);

            // 3. Khách Hàng
            getUserCount(conn, summary);

            // 4. Tài Chính Dịch Vụ
            getFinancialMetrics(conn, startDate, endDate, summary);

            // 5. Xu Hướng
            getRevenueTrends(conn, startDate, endDate, periodType, summary);
            getCustomerTrends(conn, startDate, endDate, periodType, summary);
            getPetTrends(conn, startDate, endDate, periodType, summary);
            getAppointmentTrends(conn, startDate, endDate, periodType, summary);

        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return summary;
    }

    private void getAppointmentCounts(Connection conn, String startDate, String endDate, DashboardSummary summary) throws SQLException {
        String sql = "SELECT status, COUNT(*) AS count FROM appointments WHERE created_at BETWEEN ? AND ? GROUP BY status";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, startDate);
            pstmt.setString(2, endDate + " 23:59:59");
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                String status = rs.getString("status");
                int count = rs.getInt("count");
                switch (status) {
                    case "booked":
                        summary.setBookedCount(count);
                        break;
                    case "completed":
                        summary.setCompletedCount(count);
                        break;
                    case "cancel_requested":
                        summary.setCancelRequestedCount(count);
                        break;
                    case "canceled":
                        summary.setCanceledCount(count);
                        break;
                }
            }
        }
    }

    private void getFillRate(Connection conn, String startDate, String endDate, DashboardSummary summary) throws SQLException {
        String sql = "SELECT (COUNT(a.id) * 100.0 / NULLIF(COUNT(ds.schedule_id), 0)) AS fill_rate "
                + "FROM doctor_schedule ds LEFT JOIN appointments a ON ds.doctor_id = a.doctor_id "
                + "AND CAST(a.appointment_time AS DATE) = ds.work_date "
                + "AND a.start_time = (SELECT start_time FROM shift WHERE shift_id = ds.shift_id) "
                + "WHERE ds.work_date BETWEEN ? AND ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, startDate);
            pstmt.setString(2, endDate);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                summary.setFillRate(rs.wasNull() ? 0.0 : rs.getDouble("fill_rate"));
            } else {
                summary.setFillRate(0.0);
            }
        }
    }

    private void getNewCustomers(Connection conn, String startDate, String endDate, String periodType, DashboardSummary summary) throws SQLException {
        String sql = "SELECT COUNT(*) AS count FROM users WHERE created_at BETWEEN ? AND ? AND role_id = 2";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, startDate);
            pstmt.setString(2, endDate + " 23:59:59");
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                summary.setNewCustomers(rs.getInt("count"));
            }
        }

        String[] previousDates = calculatePreviousPeriod(startDate, endDate, periodType);
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, previousDates[0]);
            pstmt.setString(2, previousDates[1] + " 23:59:59");
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                summary.setPreviousNewCustomers(rs.getInt("count"));
            }
        }
    }

    private void getNewPets(Connection conn, String startDate, String endDate, String periodType, DashboardSummary summary) throws SQLException {
        String sql = "SELECT COUNT(*) AS count FROM pets WHERE created_at BETWEEN ? AND ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, startDate);
            pstmt.setString(2, endDate + " 23:59:59");
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                summary.setNewPets(rs.getInt("count"));
            }
        }

        String[] previousDates = calculatePreviousPeriod(startDate, endDate, periodType);
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, previousDates[0]);
            pstmt.setString(2, previousDates[1] + " 23:59:59");
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                summary.setPreviousNewPets(rs.getInt("count"));
            }
        }
    }

   public void getServiceRevenue(Connection conn, String startDate, String endDate, String periodType, DashboardSummary summary) throws SQLException {
    double currentAppointmentRevenue = 0.0;
    double previousAppointmentRevenue = 0.0;
    double currentInvoiceRevenue = 0.0;
    double previousInvoiceRevenue = 0.0;

    // SQL tính tổng appointments.price
    String appointmentSql = """
        SELECT SUM(price) AS revenue
        FROM appointments
        WHERE created_at BETWEEN ? AND ?
    """;

    // SQL tính tổng invoices.total_amount
    String invoiceSql = """
        SELECT SUM(total_amount) AS revenue
        FROM invoices
        WHERE created_at BETWEEN ? AND ?
    """;

    // ==== DOANH THU HIỆN TẠI ====
    try (PreparedStatement pstmt = conn.prepareStatement(appointmentSql)) {
        pstmt.setString(1, startDate);
        pstmt.setString(2, endDate + " 23:59:59");
        try (ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                currentAppointmentRevenue = rs.getDouble("revenue");
            }
        }
    }

    try (PreparedStatement pstmt = conn.prepareStatement(invoiceSql)) {
        pstmt.setString(1, startDate);
        pstmt.setString(2, endDate + " 23:59:59");
        try (ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                currentInvoiceRevenue = rs.getDouble("revenue");
            }
        }
    }

    // ==== DOANH THU KỲ TRƯỚC ====
    String[] previousDates = calculatePreviousPeriod(startDate, endDate, periodType);

    try (PreparedStatement pstmt = conn.prepareStatement(appointmentSql)) {
        pstmt.setString(1, previousDates[0]);
        pstmt.setString(2, previousDates[1] + " 23:59:59");
        try (ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                previousAppointmentRevenue = rs.getDouble("revenue");
            }
        }
    }

    try (PreparedStatement pstmt = conn.prepareStatement(invoiceSql)) {
        pstmt.setString(1, previousDates[0]);
        pstmt.setString(2, previousDates[1] + " 23:59:59");
        try (ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                previousInvoiceRevenue = rs.getDouble("revenue");
            }
        }
    }

    // ==== GÁN VÀO SUMMARY ====
    summary.setServiceRevenue(currentAppointmentRevenue);
    summary.setPreviousServiceRevenue(previousAppointmentRevenue);
    summary.setTotalRevenue(currentInvoiceRevenue);

    // 👉 Nếu muốn theo dõi invoices kỳ trước, thêm dòng này (và field nếu chưa có):
    // summary.setPreviousTotalRevenue(previousInvoiceRevenue);
}



    private void getDoctorCount(Connection conn, DashboardSummary summary) throws SQLException {
        String sql = "SELECT COUNT(*) AS count FROM users WHERE role_id = 3";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                summary.setDoctorCount(rs.getInt("count"));
            }
        }
    }

    private void getNurseCount(Connection conn, DashboardSummary summary) throws SQLException {
        String sql = "SELECT COUNT(*) AS count FROM users WHERE role_id = 4";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                summary.setNurseCount(rs.getInt("count"));
            }
        }
    }

    private void getAverageDoctorRating(Connection conn, String startDate, String endDate, DashboardSummary summary) throws SQLException {
        String sql = "SELECT AVG(CAST(r.satisfaction_level AS FLOAT)) AS avg_rating FROM ratings r JOIN appointments a ON r.appointment_id = a.id "
                + "WHERE a.created_at BETWEEN ? AND ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, startDate);
            pstmt.setString(2, endDate + " 23:59:59");
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                summary.setAverageDoctorRating(rs.wasNull() ? 0.0 : rs.getDouble("avg_rating"));
            }
        }
    }

    private void getPositiveRatingRate(Connection conn, String startDate, String endDate, DashboardSummary summary) throws SQLException {
        String sql = "SELECT (COUNT(CASE WHEN r.satisfaction_level >= 4 THEN 1 END) * 100.0 / NULLIF(COUNT(*), 0)) AS positive_rate "
                + "FROM ratings r JOIN appointments a ON r.appointment_id = a.id WHERE a.created_at BETWEEN ? AND ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, startDate);
            pstmt.setString(2, endDate + " 23:59:59");
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                summary.setPositiveRatingRate(rs.wasNull() ? 0.0 : rs.getDouble("positive_rate"));
            }
        }
    }

    private void getUserCount(Connection conn, DashboardSummary summary) throws SQLException {
        String sql = "SELECT COUNT(*) AS count FROM users WHERE role_id = 2";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                summary.setUserCount(rs.getInt("count"));
            }
        }
    }

    private void getFinancialMetrics(Connection conn, String startDate, String endDate, DashboardSummary summary) throws SQLException {
        String sql = "SELECT SUM(i.total_amount) AS total_revenue, "
                + "SUM(CASE WHEN i.payment_status = 'paid' THEN i.total_amount ELSE 0 END) AS paid_revenue, "
                + "SUM(CASE WHEN i.payment_status = 'pending' THEN i.total_amount ELSE 0 END) AS unpaid_revenue, "
                + "SUM(CASE WHEN i.payment_method = 'cash' AND i.payment_status = 'paid' THEN i.total_amount ELSE 0 END) AS cash_revenue, "
                + "SUM(CASE WHEN i.payment_method = 'online' AND i.payment_status = 'paid' THEN i.total_amount ELSE 0 END) AS online_revenue "
                + "FROM invoices i JOIN appointments a ON i.appointment_id = a.id WHERE a.created_at BETWEEN ? AND ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, startDate);
            pstmt.setString(2, endDate + " 23:59:59");
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                summary.setTotalRevenue(rs.wasNull() ? 0.0 : rs.getDouble("total_revenue"));
                summary.setPaidRevenue(rs.wasNull() ? 0.0 : rs.getDouble("paid_revenue"));
                summary.setUnpaidRevenue(rs.wasNull() ? 0.0 : rs.getDouble("unpaid_revenue"));
                summary.setCashRevenue(rs.wasNull() ? 0.0 : rs.getDouble("cash_revenue"));
                summary.setOnlineRevenue(rs.wasNull() ? 0.0 : rs.getDouble("online_revenue"));
            }
        }
    }

    private void getRevenueTrends(Connection conn, String startDate, String endDate, String periodType, DashboardSummary summary) throws SQLException {
        List<RevenueTrend> revenueTrends = new ArrayList<>();
        String sql;
        if (periodType.equals("day")) {
            sql = "SELECT CAST(a.created_at AS DATE) AS period, SUM(i.total_amount) AS value FROM invoices i JOIN appointments a ON i.appointment_id = a.id "
                    + "WHERE i.payment_status = 'paid' AND a.created_at BETWEEN ? AND ? GROUP BY CAST(a.created_at AS DATE) ORDER BY period";
        } else if (periodType.equals("month")) {
            sql = "SELECT FORMAT(a.created_at, 'yyyy-MM') AS period, SUM(i.total_amount) AS value FROM invoices i JOIN appointments a ON i.appointment_id = a.id "
                    + "WHERE i.payment_status = 'paid' AND a.created_at BETWEEN ? AND ? GROUP BY FORMAT(a.created_at, 'yyyy-MM') ORDER BY period";
        } else {
            sql = "SELECT YEAR(a.created_at) AS period, SUM(i.total_amount) AS value FROM invoices i JOIN appointments a ON i.appointment_id = a.id "
                    + "WHERE i.payment_status = 'paid' AND a.created_at BETWEEN ? AND ? GROUP BY YEAR(a.created_at) ORDER BY period";
        }

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, startDate);
            pstmt.setString(2, endDate + " 23:59:59");
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                RevenueTrend trend = new RevenueTrend();
                trend.setPeriod(rs.getString("period"));
                trend.setValue(rs.wasNull() ? 0.0 : rs.getDouble("value"));
                revenueTrends.add(trend);
            }
        }

        String[] previousDates = calculatePreviousPeriod(startDate, endDate, periodType);
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, previousDates[0]);
            pstmt.setString(2, previousDates[1] + " 23:59:59");
            ResultSet rs = pstmt.executeQuery();
            int index = 0;
            while (rs.next() && index < revenueTrends.size()) {
                revenueTrends.get(index).setPreviousValue(rs.wasNull() ? 0.0 : rs.getDouble("value"));
                index++;
            }
        }
        summary.setRevenueTrends(revenueTrends);
    }

    private void getCustomerTrends(Connection conn, String startDate, String endDate, String periodType, DashboardSummary summary) throws SQLException {
        List<RevenueTrend> customerTrends = new ArrayList<>();
        String sql;
        if (periodType.equals("day")) {
            sql = "SELECT CAST(created_at AS DATE) AS period, COUNT(*) AS value FROM users WHERE role_id = 2 AND created_at BETWEEN ? AND ? GROUP BY CAST(created_at AS DATE) ORDER BY period";
        } else if (periodType.equals("month")) {
            sql = "SELECT FORMAT(created_at, 'yyyy-MM') AS period, COUNT(*) AS value FROM users WHERE role_id = 2 AND created_at BETWEEN ? AND ? GROUP BY FORMAT(created_at, 'yyyy-MM') ORDER BY period";
        } else {
            sql = "SELECT YEAR(created_at) AS period, COUNT(*) AS value FROM users WHERE role_id = 2 AND created_at BETWEEN ? AND ? GROUP BY YEAR(created_at) ORDER BY period";
        }

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, startDate);
            pstmt.setString(2, endDate + " 23:59:59");
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                RevenueTrend trend = new RevenueTrend();
                trend.setPeriod(rs.getString("period"));
                trend.setValue(rs.getDouble("value"));
                customerTrends.add(trend);
            }
        }

        String[] previousDates = calculatePreviousPeriod(startDate, endDate, periodType);
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, previousDates[0]);
            pstmt.setString(2, previousDates[1] + " 23:59:59");
            ResultSet rs = pstmt.executeQuery();
            int index = 0;
            while (rs.next() && index < customerTrends.size()) {
                customerTrends.get(index).setPreviousValue(rs.getDouble("value"));
                index++;
            }
        }
        summary.setCustomerTrends(customerTrends);
    }

    private void getPetTrends(Connection conn, String startDate, String endDate, String periodType, DashboardSummary summary) throws SQLException {
        List<RevenueTrend> petTrends = new ArrayList<>();
        String sql;
        if (periodType.equals("day")) {
            sql = "SELECT CAST(created_at AS DATE) AS period, COUNT(*) AS value FROM pets WHERE created_at BETWEEN ? AND ? GROUP BY CAST(created_at AS DATE) ORDER BY period";
        } else if (periodType.equals("month")) {
            sql = "SELECT FORMAT(created_at, 'yyyy-MM') AS period, COUNT(*) AS value FROM pets WHERE created_at BETWEEN ? AND ? GROUP BY FORMAT(created_at, 'yyyy-MM') ORDER BY period";
        } else {
            sql = "SELECT YEAR(created_at) AS period, COUNT(*) AS value FROM pets WHERE created_at BETWEEN ? AND ? GROUP BY YEAR(created_at) ORDER BY period";
        }

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, startDate);
            pstmt.setString(2, endDate + " 23:59:59");
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                RevenueTrend trend = new RevenueTrend();
                trend.setPeriod(rs.getString("period"));
                trend.setValue(rs.getDouble("value"));
                petTrends.add(trend);
            }
        }

        String[] previousDates = calculatePreviousPeriod(startDate, endDate, periodType);
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, previousDates[0]);
            pstmt.setString(2, previousDates[1] + " 23:59:59");
            ResultSet rs = pstmt.executeQuery();
            int index = 0;
            while (rs.next() && index < petTrends.size()) {
                petTrends.get(index).setPreviousValue(rs.getDouble("value"));
                index++;
            }
        }
        summary.setPetTrends(petTrends);
    }

    private void getAppointmentTrends(Connection conn, String startDate, String endDate, String periodType, DashboardSummary summary) throws SQLException {
        List<RevenueTrend> appointmentTrends = new ArrayList<>();
        String sql;
        if (periodType.equals("day")) {
            sql = "SELECT CAST(created_at AS DATE) AS period, COUNT(*) AS value FROM appointments WHERE created_at BETWEEN ? AND ? GROUP BY CAST(created_at AS DATE) ORDER BY period";
        } else if (periodType.equals("month")) {
            sql = "SELECT FORMAT(created_at, 'yyyy-MM') AS period, COUNT(*) AS value FROM appointments WHERE created_at BETWEEN ? AND ? GROUP BY FORMAT(created_at, 'yyyy-MM') ORDER BY period";
        } else {
            sql = "SELECT YEAR(created_at) AS period, COUNT(*) AS value FROM appointments WHERE created_at BETWEEN ? AND ? GROUP BY YEAR(created_at) ORDER BY period";
        }

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, startDate);
            pstmt.setString(2, endDate + " 23:59:59");
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                RevenueTrend trend = new RevenueTrend();
                trend.setPeriod(rs.getString("period"));
                trend.setValue(rs.getDouble("value"));
                appointmentTrends.add(trend);
            }
        }

        String[] previousDates = calculatePreviousPeriod(startDate, endDate, periodType);
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, previousDates[0]);
            pstmt.setString(2, previousDates[1] + " 23:59:59");
            ResultSet rs = pstmt.executeQuery();
            int index = 0;
            while (rs.next() && index < appointmentTrends.size()) {
                appointmentTrends.get(index).setPreviousValue(rs.getDouble("value"));
                index++;
            }
        }
        summary.setAppointmentTrends(appointmentTrends);
    }

    private String[] calculatePreviousPeriod(String startDate, String endDate, String periodType) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate start = LocalDate.parse(startDate, formatter);
        LocalDate end = LocalDate.parse(endDate, formatter);

        if (periodType.equals("day")) {
            long days = end.toEpochDay() - start.toEpochDay() + 1;
            return new String[]{
                start.minusDays(days).format(formatter),
                start.minusDays(1).format(formatter)
            };
        } else if (periodType.equals("month")) {
            long months = (end.toEpochDay() - start.toEpochDay()) / 30 + 1;
            return new String[]{
                start.minusMonths(months).format(formatter),
                end.minusMonths(1).format(formatter)
            };
        } else {
            return new String[]{
                start.minusYears(1).format(formatter),
                end.minusYears(1).format(formatter)
            };
        }
    }
}
