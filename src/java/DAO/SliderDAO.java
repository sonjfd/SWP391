package DAO;

import Model.Slider;
import java.sql.*;
import java.util.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SliderDAO {
    private Connection getConnection() throws SQLException {
        return DBContext.getConnection();
    }
    public List<Slider> getActiveSliders() {
        List<Slider> sliders = new ArrayList<>();
        String sql = "SELECT * FROM sliders WHERE is_active = 1 ORDER BY created_at DESC";
        try (
            Connection conn = DBContext.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {
            while (rs.next()) {
                Slider s = new Slider();
                s.setId(rs.getString("id"));
                s.setTitle(rs.getString("title"));
                s.setDescription(rs.getString("description"));
                s.setImageUrl(rs.getString("image_url"));
                s.setLink(rs.getString("link"));
                s.setIsActive(rs.getInt("is_active"));
                s.setCreatedAt(rs.getTimestamp("created_at"));
                s.setUpdatedAt(rs.getTimestamp("updated_at"));
                sliders.add(s);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return sliders;
    }
    
    public List<Slider> getAllSlider() {
        List<Slider> slides = new ArrayList<>();
            String sql = "SELECT id, title, description, image_url, link, is_active, created_at, updated_at FROM sliders";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Slider slide = new Slider();
                slide.setId(rs.getString("id"));
                slide.setTitle(rs.getString("title"));
                slide.setDescription(rs.getString("description"));
                slide.setImageUrl(rs.getString("image_url"));
                slide.setLink(rs.getString("link"));
                slide.setIsActive(rs.getInt("is_active"));
                slide.setCreatedAt(rs.getTimestamp("created_at"));
                slide.setUpdatedAt(rs.getTimestamp("updated_at"));
                slides.add(slide);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return slides;
    }
    
    public List<Slider> searchSlider(String search) {
        List<Slider> slides = new ArrayList<>();
        String sql = "SELECT id, title, description, image_url, link, is_active FROM sliders WHERE title LIKE ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + search + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Slider slide = new Slider();
                slide.setId(rs.getString("id"));
                slide.setTitle(rs.getString("title"));
                slide.setDescription(rs.getString("description"));
                slide.setImageUrl(rs.getString("image_url"));
                slide.setLink(rs.getString("link"));
                slide.setIsActive(rs.getInt("is_active"));
                slides.add(slide);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return slides;
    }

    
    

    public boolean updateSlider(Slider slide) {
        String sql = "UPDATE sliders SET title = ?, description = ?, image_url = ?, link = ?, is_active = ? WHERE id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, slide.getTitle());
            ps.setString(2, slide.getDescription());
            ps.setString(3, slide.getImageUrl());
            ps.setString(4, slide.getLink());
            ps.setInt(5, slide.getIsActive());
            ps.setString(6, slide.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void deleteSlider(String id) {
        String sql = "DELETE FROM sliders WHERE id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
    }

    public void updateStatus(String id, int isActive) {
        String sql = "UPDATE sliders SET is_active = ? WHERE id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, isActive);
            ps.setString(2, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Slider getSlideById(String id) {
        String sql = "SELECT id, title, description, image_url, link, is_active FROM sliders WHERE id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Slider slide = new Slider();
                slide.setId(rs.getString("id"));
                slide.setTitle(rs.getString("title"));
                slide.setDescription(rs.getString("description"));
                slide.setImageUrl(rs.getString("image_url"));
                slide.setLink(rs.getString("link"));
                slide.setIsActive(rs.getInt("is_active"));
                return slide;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public boolean addSlider(Slider slide) {
        String sql = "INSERT INTO sliders (id, title, description, image_url, link, is_active) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, slide.getId()); // id là chuỗi UUID
            ps.setString(2, slide.getTitle());
            ps.setString(3, slide.getDescription());
            ps.setString(4, slide.getImageUrl());
            ps.setString(5, slide.getLink());
            ps.setInt(6, slide.getIsActive());
            System.out.println("addSlider: Adding slider ID = " + slide.getId());
            int rowsAffected = ps.executeUpdate();
            System.out.println("addSlider: Rows affected = " + rowsAffected);
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("addSlider: Error = " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean updateSliderStatus(String id, int isActive) {
    String sql = "UPDATE sliders SET is_active = ?, updated_at = GETDATE() WHERE id = ?";
    try (Connection conn = getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, isActive);
        ps.setString(2, id);
        int rowsAffected = ps.executeUpdate();
        return rowsAffected > 0;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}

    // Test addSlider
    public static void main(String[] args) {
        SliderDAO dao = new SliderDAO();
        Slider slide = new Slider();
        slide.setId(UUID.randomUUID().toString()); // Tạo UUID
        slide.setTitle("Test Slider");
        slide.setDescription("This is a test slider");
        slide.setImageUrl("/assets/images/slider/test.jpg");
        slide.setLink("/test-page");
        slide.setIsActive(1);

        System.out.println("Testing addSlider...");
        boolean success = dao.addSlider(slide);
        System.out.println("Result: " + (success ? "Slider added successfully!" : "Failed to add slider."));
    }
    
            
        
    
    
}
