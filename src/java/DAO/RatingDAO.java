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
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
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
        String sql = "INSERT INTO ratings (id, appointment_id, customer_id, doctor_id, satisfaction_level, comment) " +
                     "VALUES (NEWID(), ?, ?, ?, ?, ?)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, rating.getAppointment().getId());
            ps.setString(2, rating.getUser().getId());
            ps.setString(3, rating.getDoctor().getUser().getId());
            ps.setInt(4, rating.getSatisfaction_level());
            ps.setString(5, rating.getComment());
          
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
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
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
    try (Connection conn = DBContext.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
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
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
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
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
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
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, ratingId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error in deleteRating: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }


    public List<Rating> getAllRatings() {
        List<Rating> ratings = new ArrayList<>();
        String sql = "SELECT * FROM ratings";
        UserDAO udao = new UserDAO();
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()){
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
}


