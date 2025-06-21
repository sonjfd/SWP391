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
    // CỦA ĐẠI
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

    // HẾT CỦA ĐẠI

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
