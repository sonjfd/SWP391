package DAO;

import Model.Slider;
import java.sql.*;
import java.util.*;

public class SliderDAO {
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
}
