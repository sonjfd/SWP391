package DAO;

import Model.Department;
import Model.Service;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.sql.SQLException;

public class ServiceDAO {
    private Connection getConnection() throws SQLException {
        return DBContext.getConnection();
    }

    public boolean addService(Service service) {
        String sql = "INSERT INTO services (id, department_id, name, description, price, status) VALUES (NEWID(), ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, service.getDepartmentId());
            stmt.setString(2, service.getName());
            stmt.setString(3, service.getDescription());
            stmt.setDouble(4, service.getPrice());
            stmt.setInt(5, service.getStatus());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateService(Service service) {
        String sql = "UPDATE services SET department_id = ?, name = ?, description = ?, price = ?, status = ? WHERE id = ?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, service.getDepartmentId());
            stmt.setString(2, service.getName());
            stmt.setString(3, service.getDescription());
            stmt.setDouble(4, service.getPrice());
            stmt.setInt(5, service.getStatus());
            stmt.setString(6, service.getId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteService(String id) {
        String sql = "DELETE FROM services WHERE id = ?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Service getServiceById(String id) {
        String sql = "SELECT * FROM services WHERE id = ?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Service service = new Service();
                service.setId(rs.getString("id"));
                service.setDepartmentId(rs.getInt("department_id"));
                service.setName(rs.getString("name"));
                service.setDescription(rs.getString("description"));
                service.setPrice(rs.getDouble("price"));
                service.setStatus(rs.getInt("status"));
                return service;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Service> getAllServices() {
        List<Service> services = new ArrayList<>();
        String sql = "SELECT * FROM services";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Service service = new Service();
                service.setId(rs.getString("id"));
                service.setDepartmentId(rs.getInt("department_id"));
                service.setName(rs.getString("name"));
                service.setDescription(rs.getString("description"));
                service.setPrice(rs.getDouble("price"));
                service.setStatus(rs.getInt("status"));
                services.add(service);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return services;
    }

    public List<Department> getAllDepartments() {
        List<Department> departments = new ArrayList<>();
        String sql = "SELECT * FROM departments";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Department dept = new Department();
                dept.setId(rs.getInt("id"));
                dept.setName(rs.getString("name"));
                dept.setDescription(rs.getString("description"));
                departments.add(dept);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return departments;
    }
    
    public static void main(String[] args) {
        // Tạo đối tượng Service cần thêm
        Service newService = new Service();
        newService.setDepartmentId(1);           // ID khoa/phòng
        newService.setName("Khám tổng quát");    // Tên dịch vụ
        newService.setDescription("Dịch vụ khám sức khỏe tổng quát");
        newService.setPrice(250000);             // Giá tiền
        newService.setStatus(0);                 // Trạng thái: 1 = hoạt động, 0 = ngưng

        // Tạo đối tượng DAO (hoặc nơi có phương thức addService)
        ServiceDAO serviceDAO = new ServiceDAO();

        // Gọi phương thức addService
        boolean result = serviceDAO.addService(newService);

        // In kết quả
        if (result) {
            System.out.println("Thêm dịch vụ thành công!");
        } else {
            System.out.println("Thêm dịch vụ thất bại.");
        }
    }
    
   
}
