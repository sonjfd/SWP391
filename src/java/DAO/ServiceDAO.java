package DAO;

import Model.Service;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ServiceDAO {

    // Lấy tất cả dịch vụ
    public List<Service> getAllServices() {
        List<Service> services = new ArrayList<>();
        String sql = "SELECT id, name, description, price FROM services";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Service s = new Service(
                    rs.getString("id"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getDouble("price")
                );
                services.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return services;
    }

    // Lấy dịch vụ theo ID
    public Service getServiceById(String id) {
        String sql = "SELECT id, name, description, price FROM services WHERE id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new Service(
                    rs.getString("id"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getDouble("price")
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Thêm dịch vụ mới
    public boolean addService(Service s) {
        String sql = "INSERT INTO services (id, name, description, price) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, s.getId());
            ps.setString(2, s.getName());
            ps.setString(3, s.getDescription());
            ps.setDouble(4, s.getPrice());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật dịch vụ
    public boolean updateService(Service s) {
        String sql = "UPDATE services SET name = ?, description = ?, price = ? WHERE id = ?";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, s.getName());
            ps.setString(2, s.getDescription());
            ps.setDouble(3, s.getPrice());
            ps.setString(4, s.getId());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa dịch vụ theo ID
    public boolean deleteService(String id) {
        String sql = "DELETE FROM services WHERE id = ?";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, id);

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public static void main(String[] args) {
        List<Service> l = new ServiceDAO().getAllServices();
        for (Service service : l) {
            System.out.println(service);
        }
    }
}
