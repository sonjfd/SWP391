/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Supplier;
import java.sql.*;

/**
 *
 * @author Admin
 */
import java.util.ArrayList;
import java.util.List;

public class SupplierDAO {

    private Connection conn;

    public SupplierDAO(Connection conn) {
        this.conn = conn;
    }

    public List<Supplier> getAllSuppliers() {
        List<Supplier> list = new ArrayList<>();
        String sql = "SELECT * FROM suppliers";
        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Supplier s = new Supplier();
                s.setId(rs.getInt("supplier_id"));
                s.setSupplierName(rs.getString("supplier_name"));
                s.setContactName(rs.getString("contact_name"));
                s.setPhone(rs.getString("phone"));
                s.setEmail(rs.getString("email"));
                s.setAddress(rs.getString("address"));
                list.add(s);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Thêm nhà cung cấp mới
    public void insertSupplier(Supplier s) {
        String sql = "INSERT INTO suppliers (supplier_name, contact_name, phone, email, address) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, s.getSupplierName());
            ps.setString(2, s.getContactName());
            ps.setString(3, s.getPhone());
            ps.setString(4, s.getEmail());
            ps.setString(5, s.getAddress());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

// Cập nhật thông tin nhà cung cấp
    public void updateSupplier(Supplier s) {
        String sql = "UPDATE suppliers SET supplier_name = ?, contact_name = ?, phone = ?, email = ?, address = ? WHERE supplier_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, s.getSupplierName());
            ps.setString(2, s.getContactName());
            ps.setString(3, s.getPhone());
            ps.setString(4, s.getEmail());
            ps.setString(5, s.getAddress());
            ps.setInt(6, s.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

// Xóa nhà cung cấp theo ID
    public void deleteSupplier(int id) {
        String sql = "DELETE FROM suppliers WHERE supplier_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

// Lấy thông tin nhà cung cấp theo ID (cho edit)
    public Supplier getSupplierById(int id) {
        String sql = "SELECT * FROM suppliers WHERE supplier_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Supplier s = new Supplier();
                s.setId(rs.getInt("supplier_id"));
                s.setSupplierName(rs.getString("supplier_name"));
                s.setContactName(rs.getString("contact_name"));
                s.setPhone(rs.getString("phone"));
                s.setEmail(rs.getString("email"));
                s.setAddress(rs.getString("address"));
                return s;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
