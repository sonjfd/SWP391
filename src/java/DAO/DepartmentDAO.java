/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import Model.Department;
import DAO.DBContext;
import java.sql.SQLException;
/**
 *
 * @author FPT
 */
public class DepartmentDAO {
    public List<Department> getAllDepartments() {
        List<Department> list = new ArrayList<>();
        String sql = "SELECT id, name, description FROM departments";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Department dept = new Department();
                dept.setId(rs.getInt("id"));
                dept.setName(rs.getString("name"));
                dept.setDescription(rs.getString("description"));
                list.add(dept);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    // Lấy phòng ban theo ID
    public Department getDepartmentById(int id) throws SQLException {
        String sql = "SELECT id, name, description FROM departments WHERE id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Department(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description")
                    );
                }
            }
        }
        return null;
    }

    // Kiểm tra tên phòng ban đã tồn tại (trừ ID hiện tại khi cập nhật)
    public boolean isNameExists(String name, int excludeId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM departments WHERE name = ? AND id != ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, name.trim());
            stmt.setInt(2, excludeId);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    // Thêm phòng ban mới
    public void addDepartment(String name, String description) throws SQLException {
        String sql = "INSERT INTO departments (name, description) VALUES (?, ?)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, name.trim());
            stmt.setString(2, description != null && !description.trim().isEmpty() ? description.trim() : null);
            stmt.executeUpdate();
        }
    }

    // Cập nhật phòng ban
    public void updateDepartment(int id, String name, String description) throws SQLException {
        String sql = "UPDATE departments SET name = ?, description = ? WHERE id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, name.trim());
            stmt.setString(2, description != null && !description.trim().isEmpty() ? description.trim() : null);
            stmt.setInt(3, id);
            stmt.executeUpdate();
        }
    }

    // Kiểm tra khóa ngoại trong services và nurses
    public boolean hasForeignKeyConstraints(int id) throws SQLException {
        String sql = "SELECT COUNT(*) FROM services WHERE department_id = ? " +
                     "UNION ALL " +
                     "SELECT COUNT(*) FROM nurses WHERE department_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.setInt(2, id);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    if (rs.getInt(1) > 0) {
                        return true;
                    }
                }
            }
        }
        return false;
    }

    // Xóa phòng ban
    public void deleteDepartment(int id) throws SQLException {
    String sql = """
        DECLARE @department_id INT = ?;

        -- Xóa kết quả của y tá liên quan đến dịch vụ trong phòng ban
        DELETE nsr FROM nurse_specialization_results nsr
        JOIN services s ON nsr.service_id = s.id
        WHERE s.department_id = @department_id;

        -- Xóa cuộc hẹn liên quan đến dịch vụ trong phòng ban
        DELETE aps FROM appointment_services aps
        JOIN services s ON aps.service_id = s.id
        WHERE s.department_id = @department_id;

        -- Xóa dịch vụ thuộc phòng ban
        DELETE FROM services WHERE department_id = @department_id;

        -- Xóa y tá thuộc phòng ban
        DELETE FROM nurses WHERE department_id = @department_id;

        -- Cuối cùng xóa phòng ban
        DELETE FROM departments WHERE id = @department_id;
        """;

    try (Connection conn = DBContext.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, id);
        stmt.execute();
    }
}
    
    
    public static void main(String[] args) {
        // Giả sử bạn có một lớp chứa hàm deleteDepartment tên là DepartmentDAO
        DepartmentDAO dao = new DepartmentDAO();
        int departmentIdToDelete = 1; // ID phòng ban bạn muốn xóa để test

        try {
            dao.deleteDepartment(departmentIdToDelete);
            System.out.println("Phòng ban với ID " + departmentIdToDelete + " đã được xóa thành công.");
        } catch (SQLException e) {
            System.err.println("Lỗi khi xóa phòng ban: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
