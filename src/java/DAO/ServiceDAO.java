package DAO;

import Model.Department;
import Model.Service;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class ServiceDAO {

    // Lấy tất cả dịch vụ
    public List<Service> getAllServices() {
        List<Service> services = new ArrayList<>();
        String sql = "SELECT s.id, s.name AS service_name, d.name AS dep_name, s.description AS service_des, s.price, s.status "
                + "FROM services s "
                + "JOIN departments d ON s.department_id = d.id";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Department department = new Department();
                department.setName(rs.getString("dep_name"));
                Service s = new Service(
                        rs.getString("id"),
                        department,
                        rs.getString("service_name"),
                        rs.getString("service_des"),
                        rs.getDouble("price"),
                        rs.getInt("status") // Giả sử class Service có field status
                );
                services.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return services;
    }

// Lấy tất cả dịch vụ có status = 1
    public List<Service> getAllActiveServices() {
        return getAllServices()
                .stream()
                .filter(s -> s.getStatus() == 1)
                .collect(Collectors.toList());
    }

    // Lấy dịch vụ theo ID
    public Service getServiceById(String id) {
        String sql = "SELECT id, s.name as service_name,d.name as dep_name, s.description as service_des , price,status FROM services s JOIN departments d ON s.department_id=d.id WHERE id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Department department = new Department();
                department.setName(rs.getString("dep_name"));
                return new Service(
                        rs.getString("id"),
                        department,
                        rs.getString("service_name"),
                        rs.getString("service_des"), rs.getDouble("price"),rs.getInt("status")
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

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

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

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

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

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, id);

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public double getServicePrice(String serviceId) {
        double price = 0.0;
        String sql = "SELECT price FROM services WHERE id = ?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, serviceId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                price = rs.getDouble("price");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return price;
    }

    public static void main(String[] args) {
        List<Service> l = new ServiceDAO().getAllActiveServices();
        for (Service service : l) {
            System.out.println(service);
        }
    }
}
