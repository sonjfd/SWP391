/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Role;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.sql.SQLException;

/**
 *
 * @author ASUS
 */
public class RoleDAO {
    
    public Role getRoleByName(String name) {
        String sql = "select  * from roles where name = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement stm = conn.prepareStatement(sql)) {

            stm.setString(1, name);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return new Role(rs.getInt("id"), rs.getString("name"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;

    }

    public Role getRoleById(int id) {
        Role Admin = getRoleByName("admin");
        Role Customer = getRoleByName("customer");
        Role Staff = getRoleByName("staff");
        Role Doctor = getRoleByName("doctor");  
        if(id==Admin.getId()){
            return Admin;
        }else if(id==Customer.getId()){
            return Customer;
        }else if(id==Staff.getId()){
            return Staff;
        }else if(id==Doctor.getId()){
            return Doctor;
        }
        return null;
    }
    
    public Role getRoleByIdAll(int id) throws SQLException {
    String sql = "SELECT id, name FROM roles WHERE id = ?";
    try (Connection conn = DBContext.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, id);
        try (ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return new Role(
                    rs.getInt("id"),
                    rs.getString("name")
                );
            }
        }
    }
    return null;
}
    
    public List<Role> getAllRoles() {
        List<Role> roles = new ArrayList<>();
        String sql = "SELECT id, name FROM roles";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Role role = new Role();
                role.setId(rs.getInt("id"));
                role.setName(rs.getString("name"));
                roles.add(role);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return roles;
    }
    
    // Kiểm tra tên vai trò đã tồn tại
    public boolean isNameExists(String name, int excludeId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM roles WHERE name = ? AND id != ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, name.trim());
            stmt.setInt(2, excludeId);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    // Thêm vai trò mới
    public void addRole(String name) throws SQLException {
        String sql = "INSERT INTO roles (name) VALUES (?)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, name.trim());
            stmt.executeUpdate();
        }
    }

    // Cập nhật vai trò
    public void updateRole(int id, String name) throws SQLException {
        String sql = "UPDATE roles SET name = ? WHERE id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, name.trim());
            stmt.setInt(2, id);
            stmt.executeUpdate();
        }
    }

    // Kiểm tra khóa ngoại trong users
    public boolean hasForeignKeyConstraints(int id) throws SQLException {
        String sql = "SELECT COUNT(*) FROM users WHERE role_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    
}
