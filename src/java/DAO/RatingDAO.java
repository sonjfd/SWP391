/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Rating;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import Model.Breed;
import Model.Specie;
import java.util.ArrayList;
import java.util.List;

import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import Model.Appointment;
import Model.Breed;
import Model.Doctor;
import Model.ExaminationPrice;
import Model.Pet;
import Model.Specie;
import Model.User;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
public class RatingDAO {

    public List<Rating> getRatingsByDoctorId(String doctorId) {
        List<Rating> ratings = new ArrayList<>();
        String sql = "SELECT * FROM ratings WHERE doctor_id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, doctorId);
            AppointmentDAO app = new AppointmentDAO();
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Rating rating = new Rating();
                    rating.setId(rs.getString("id"));
                    rating.setAppointment(app.getAppointmentById(rs.getString("appointment_id")));
                    rating.setSatisfaction_level(rs.getInt("satisfaction_level"));
                    rating.setComment(rs.getString("comment"));
                    rating.setStatus(rs.getString("status"));
                    rating.setCreatedAt(rs.getTimestamp("created_at"));
                    ratings.add(rating);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error in getRatingsByDoctorId: " + e.getMessage());
            e.printStackTrace();
        }
        return ratings;
    }

    // Thêm mới rating
    public boolean addRating(Rating rating) {
        String sql = "INSERT INTO ratings (id, appointment_id, customer_id, doctor_id, satisfaction_level, comment,status) "
                + "VALUES (NEWID(), ?, ?, ?, ?, ?,?)";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, rating.getAppointment().getId());
            ps.setString(2, rating.getUser().getId());
            ps.setString(3, rating.getDoctor().getUser().getId());
            ps.setInt(4, rating.getSatisfaction_level());
            ps.setString(5, rating.getComment());
            ps.setString(6, "posted");
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error in addRating: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Cập nhật status rating
    public boolean updateRatingStatus(String ratingId, String status) {
        String sql = "UPDATE ratings SET status = ? WHERE id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setString(2, ratingId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error in updateRatingStatus: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateRating(String ratingId, int satisfaction, String comment) {
        String sql = "UPDATE ratings SET satisfaction_level = ?, comment = ? WHERE id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, satisfaction);
            ps.setString(2, comment);
            ps.setString(3, ratingId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error in updateRating: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Lấy rating theo ID
    public Rating getRatingById(String ratingId) {
        String sql = "SELECT * FROM ratings WHERE id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, ratingId);
            AppointmentDAO app = new AppointmentDAO();

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Rating rating = new Rating();
                    rating.setId(rs.getString("id"));
                    rating.setAppointment(app.getAppointmentById(rs.getString("appointment_id")));
                    rating.setSatisfaction_level(rs.getInt("satisfaction_level"));
                    rating.setComment(rs.getString("comment"));
                    rating.setStatus(rs.getString("status"));
                    rating.setCreatedAt(rs.getTimestamp("created_at"));
                    return rating;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error in getRatingById: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public Rating getRatingByAppId(String AppId) {
        String sql = "SELECT * FROM ratings WHERE appointment_id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, AppId);
            AppointmentDAO app = new AppointmentDAO();

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Rating rating = new Rating();
                    rating.setId(rs.getString("id"));
                    rating.setAppointment(app.getAppointmentById(rs.getString("appointment_id")));
                    rating.setSatisfaction_level(rs.getInt("satisfaction_level"));
                    rating.setComment(rs.getString("comment"));
                    rating.setStatus(rs.getString("status"));
                    rating.setCreatedAt(rs.getTimestamp("created_at"));
                    return rating;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error in getRatingById: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    // Xóa rating
    public boolean deleteRating(String ratingId) {
        String sql = "DELETE FROM ratings WHERE id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, ratingId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error in deleteRating: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public List<Rating> getRatings(String customerName, String status, int page, int pageSize) {
        List<Rating> ratings = new ArrayList<>();
        String sql = """
        SELECT r.*
        FROM ratings r
        JOIN users u ON r.customer_id = u.id
        WHERE (? IS NULL OR u.full_name LIKE ?)
          AND (? IS NULL OR r.status = ?)
        ORDER BY r.created_at DESC
        OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
    """;

        UserDAO udao = new UserDAO();

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            // Tìm theo tên khách hàng
            if (customerName != null && !customerName.trim().isEmpty()) {
                ps.setString(1, customerName);
                ps.setString(2, "%" + customerName + "%");
            } else {
                ps.setNull(1, java.sql.Types.VARCHAR);
                ps.setNull(2, java.sql.Types.VARCHAR);
            }

            // Lọc theo trạng thái
            if (status != null && !status.trim().isEmpty()) {
                ps.setString(3, status);
                ps.setString(4, status);
            } else {
                ps.setNull(3, java.sql.Types.VARCHAR);
                ps.setNull(4, java.sql.Types.VARCHAR);
            }

            ps.setInt(5, (page - 1) * pageSize);
            ps.setInt(6, pageSize);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Rating rating = new Rating();
                rating.setId(rs.getString("id"));
                rating.setUser(udao.getUserById(rs.getString("customer_id")));
                rating.setSatisfaction_level(rs.getInt("satisfaction_level"));
                rating.setComment(rs.getString("comment"));
                rating.setStatus(rs.getString("status"));
                rating.setCreatedAt(rs.getTimestamp("created_at"));
                ratings.add(rating);
            }
        } catch (SQLException e) {
            System.err.println("Error in getRatings: " + e.getMessage());
            e.printStackTrace();
        }
        return ratings;
    }

    public int countRatings(String customerName, String status) {
        String sql = """
        SELECT COUNT(*)
        FROM ratings r
        JOIN users u ON r.customer_id = u.id
        WHERE (? IS NULL OR u.full_name LIKE ?)
          AND (? IS NULL OR r.status = ?)
    """;

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            if (customerName != null && !customerName.trim().isEmpty()) {
                ps.setString(1, customerName);
                ps.setString(2, "%" + customerName + "%");
            } else {
                ps.setNull(1, java.sql.Types.VARCHAR);
                ps.setNull(2, java.sql.Types.VARCHAR);
            }

            if (status != null && !status.trim().isEmpty()) {
                ps.setString(3, status);
                ps.setString(4, status);
            } else {
                ps.setNull(3, java.sql.Types.VARCHAR);
                ps.setNull(4, java.sql.Types.VARCHAR);
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error in countRatings: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    public List<Rating> getAllRatingsPosted() {
        List<Rating> ratings = new ArrayList<>();
        String sql = "SELECT * FROM ratings where status = 'posted'";
        UserDAO udao = new UserDAO();

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Rating rating = new Rating();
                rating.setId(rs.getString("id"));
                rating.setUser(udao.getUserById(rs.getString("customer_id")));
                rating.setSatisfaction_level(rs.getInt("satisfaction_level"));
                rating.setComment(rs.getString("comment"));
                rating.setStatus(rs.getString("status"));
                rating.setCreatedAt(rs.getTimestamp("created_at"));
                ratings.add(rating);
            }
        } catch (SQLException e) {
            System.err.println("Error in getAllRatings: " + e.getMessage());
            e.printStackTrace();
        }
        return ratings;
    }

    public List<Rating> getRatingsByStatus(String status) {
        List<Rating> ratings = new ArrayList<>();
        String sql = "SELECT * FROM ratings WHERE status = ?";
        UserDAO udao = new UserDAO();

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            // ✅ Set parameter trước khi thực thi

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Rating rating = new Rating();
                    AppointmentDAO ad = new AppointmentDAO();
                    rating.setId(rs.getString("id"));
                    rating.setAppointment(ad.getAppointmentById(rs.getString("appointment_id")));
                    rating.setUser(udao.getUserById(rs.getString("customer_id")));
                    rating.setSatisfaction_level(rs.getInt("satisfaction_level"));
                    rating.setComment(rs.getString("comment"));
                    rating.setStatus(rs.getString("status"));
                    rating.setCreatedAt(rs.getTimestamp("created_at"));
                    ratings.add(rating);
                }
            }

        } catch (SQLException e) {
            System.err.println("Error in getRatingsByStatus: " + e.getMessage());
            e.printStackTrace();
        }
        return ratings;
    }

    public List<Rating> getRatingsByCusName(String cusName) {
        List<Rating> ratings = new ArrayList<>();
        String sql = "SELECT * FROM ratings r JOIN users s ON r.customer_id = s.id WHERE s.full_name LIKE ?";
        UserDAO udao = new UserDAO();

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, "%" + cusName + "%"); // tìm kiếm chứa tên

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Rating rating = new Rating();
                    AppointmentDAO ad = new AppointmentDAO();
                    rating.setId(rs.getString("id"));
                    rating.setAppointment(ad.getAppointmentById(rs.getString("appointment_id")));
                    rating.setUser(udao.getUserById(rs.getString("customer_id")));
                    rating.setSatisfaction_level(rs.getInt("satisfaction_level"));
                    rating.setComment(rs.getString("comment"));
                    rating.setStatus(rs.getString("status"));
                    rating.setCreatedAt(rs.getTimestamp("created_at"));
                    ratings.add(rating);
                }
            }

        } catch (SQLException e) {
            System.err.println("Error in getRatingsByCusName: " + e.getMessage());
            e.printStackTrace();
        }

        return ratings;
    }

}
