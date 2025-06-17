/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

/**
 *
 * @author Admin
 */


import Model.ProductVariant;
import java.sql.*;
import java.util.*;

public class ProductVariantDAO extends DBContext {

     public List<ProductVariant> getAllVariants() {
    List<ProductVariant> list = new ArrayList<>();
    String sql = "SELECT pv.*, p.product_name FROM product_variants pv " +
                 "JOIN products p ON pv.product_id = p.product_id";
    try (Connection conn = getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        while (rs.next()) {
            ProductVariant v = new ProductVariant();
            v.setProductVariantId(rs.getInt("product_variant_id"));
            v.setProductId(rs.getInt("product_id"));
            v.setProductName(rs.getString("product_name")); // ✅ thêm dòng này
            v.setVariantName(rs.getString("variant_name"));
            v.setPrice(rs.getDouble("price"));
            v.setStockQuantity(rs.getInt("stock_quantity"));
            v.setCreatedAt(rs.getTimestamp("created_at"));
            v.setUpdatedAt(rs.getTimestamp("updated_at"));
            list.add(v);
        }
    } catch (Exception e) {
        System.err.println("Error in getAllVariants: " + e.getMessage());
    }
    return list;
}

    public ProductVariant getById(int id) {
    String sql = "SELECT pv.*, p.product_name FROM product_variants pv " +
                 "JOIN products p ON pv.product_id = p.product_id WHERE pv.product_variant_id = ?";
    try (Connection conn = getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            ProductVariant v = new ProductVariant();
            v.setProductVariantId(rs.getInt("product_variant_id"));
            v.setProductId(rs.getInt("product_id"));
            v.setProductName(rs.getString("product_name")); // ✅ thêm dòng này
            v.setVariantName(rs.getString("variant_name"));
            v.setPrice(rs.getDouble("price"));
            v.setStockQuantity(rs.getInt("stock_quantity"));
            v.setCreatedAt(rs.getTimestamp("created_at"));
            v.setUpdatedAt(rs.getTimestamp("updated_at"));
            return v;
        }
    } catch (Exception e) {
        System.err.println("Error in getById: " + e.getMessage());
    }
    return null;
}


    public boolean isProductIdValid(int productId) {
        String sql = "SELECT 1 FROM products WHERE product_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            System.err.println("Error in isProductIdValid: " + e.getMessage());
            return false;
        }
    }

    public void addVariant(ProductVariant v) {
        String sql = "INSERT INTO product_variants(product_id, variant_name, price, stock_quantity) VALUES (?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, v.getProductId());
            ps.setString(2, v.getVariantName());
            ps.setDouble(3, v.getPrice());
            ps.setInt(4, v.getStockQuantity());
            ps.executeUpdate();
        } catch (Exception e) {
            System.err.println("Error in addVariant: " + e.getMessage());
        }
    }

    public boolean updateVariant(ProductVariant v) {
    String sql = "UPDATE product_variants SET product_id=?, variant_name=?, price=?, stock_quantity=?, updated_at=GETDATE() WHERE product_variant_id=?";
    try (Connection conn = getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, v.getProductId());
        ps.setString(2, v.getVariantName());
        ps.setDouble(3, v.getPrice());
        ps.setInt(4, v.getStockQuantity());
        ps.setInt(5, v.getProductVariantId());
        
        int rowsAffected = ps.executeUpdate();
        return rowsAffected > 0; // Cập nhật thành công nếu có ít nhất 1 dòng bị ảnh hưởng
    } catch (Exception e) {
        System.err.println("Error in updateVariant: " + e.getMessage());
        return false;
    }
}

    public void deleteVariant(int id) {
        String sql = "DELETE FROM product_variants WHERE product_variant_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            System.err.println("Error in deleteVariant: " + e.getMessage());
        }
    }
}