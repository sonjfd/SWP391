package DAO;

import Model.Product;
import java.sql.*;
import java.util.*;

public class ProductDAO extends DBContext {

    // Lấy tất cả sản phẩm
    public List<Product> getAll() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Product p = new Product(
                    rs.getInt("product_id"),
                    rs.getInt("category_id"),
                    rs.getInt("supplier_id"),
                    rs.getString("product_name"),
                    rs.getString("description"),
                    rs.getString("image"),
                    rs.getTimestamp("created_at"),
                    rs.getTimestamp("updated_at")
                );
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Thêm sản phẩm mới
    public boolean insertProduct(Product p) {
        String sql = "INSERT INTO products (category_id, supplier_id, product_name, description, image, created_at, updated_at) " +
                     "VALUES (?, ?, ?, ?, ?, GETDATE(), GETDATE())";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, p.getCategoryId());
            ps.setInt(2, p.getSupplierId());
            ps.setString(3, p.getProductName());
            ps.setString(4, p.getDescription());
            ps.setString(5, p.getImage());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật sản phẩm
    public boolean updateProduct(Product p) {
        String sql = "UPDATE products SET category_id = ?, supplier_id = ?, product_name = ?, description = ?, image = ?, updated_at = GETDATE() WHERE product_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, p.getCategoryId());
            ps.setInt(2, p.getSupplierId());
            ps.setString(3, p.getProductName());
            ps.setString(4, p.getDescription());
            ps.setString(5, p.getImage());
            ps.setInt(6, p.getProductId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xoá sản phẩm
    public boolean deleteProduct(int id) {
        String sql = "DELETE FROM products WHERE product_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Lấy sản phẩm theo ID
    public Product getProductById(int id) {
        String sql = "SELECT * FROM products WHERE product_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Product(
                        rs.getInt("product_id"),
                        rs.getInt("category_id"),
                        rs.getInt("supplier_id"),
                        rs.getString("product_name"),
                        rs.getString("description"),
                        rs.getString("image"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
