package DAO;

import Model.ProductVariant;
import java.sql.*;
import java.util.*;
import java.math.BigDecimal;

public class ProductVariantDAO extends DBContext {

    // Lấy tất cả biến thể sản phẩm
    public List<ProductVariant> getAllVariants() {
        List<ProductVariant> list = new ArrayList<>();
        String sql = """
           SELECT 
                pv.product_variant_id,
                p.product_name,
                pv.variant_name,
                w.weight,
                f.flavor,
                pv.price,
                pv.stock_quantity,
                pv.image,
                pv.status,
                pv.created_at,
                pv.updated_at
            FROM product_variants pv
            JOIN products p ON pv.product_id = p.product_id
            JOIN product_variant_weights w ON pv.weight_id = w.weight_id
            JOIN product_variant_flavors f ON pv.flavor_id = f.flavor_id;
        """;

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                ProductVariant pv = new ProductVariant();
                pv.setProductVariantId(rs.getInt("product_variant_id"));
                pv.setProductName(rs.getString("product_name"));
                pv.setVariantName(rs.getString("variant_name"));
                pv.setWeight(rs.getBigDecimal("weight"));
                pv.setFlavorName(rs.getString("flavor"));
                pv.setPrice(rs.getDouble("price"));
                pv.setStockQuantity(rs.getInt("stock_quantity"));
                pv.setImage(rs.getString("image"));
                pv.setStatus(rs.getBoolean("status"));
                pv.setCreatedAt(rs.getTimestamp("created_at"));
                pv.setUpdatedAt(rs.getTimestamp("updated_at"));

                list.add(pv);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    // Thêm biến thể sản phẩm
    public void add(ProductVariant pv) {
        String sql = """
            INSERT INTO product_variants 
            (product_id, variant_name, weight_id, flavor_id, price, stock_quantity, status, image, created_at, updated_at)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, GETDATE(), GETDATE())
        """;

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, pv.getProductId());
            ps.setString(2, pv.getVariantName());
            ps.setInt(3, pv.getWeightId());
            ps.setInt(4, pv.getFlavorId());
            ps.setDouble(5, pv.getPrice());
            ps.setInt(6, pv.getStockQuantity());
            ps.setBoolean(7, pv.isStatus());
            ps.setString(8, pv.getImage());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Cập nhật biến thể sản phẩm
    public void update(ProductVariant pv) {
        String sql = """
            UPDATE product_variants SET 
            product_id = ?, 
            variant_name = ?, 
            weight_id = ?, 
            flavor_id = ?, 
            price = ?, 
            stock_quantity = ?, 
            status = ?, 
            image = ?, 
            updated_at = GETDATE()
            WHERE product_variant_id = ?
        """;

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, pv.getProductId());
            ps.setString(2, pv.getVariantName());
            ps.setInt(3, pv.getWeightId());
            ps.setInt(4, pv.getFlavorId());
            ps.setDouble(5, pv.getPrice());
            ps.setInt(6, pv.getStockQuantity());
            ps.setBoolean(7, pv.isStatus());
            ps.setString(8, pv.getImage());
            ps.setInt(9, pv.getProductVariantId());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Xoá biến thể sản phẩm theo ID
    public void delete(int id) {
        String sql = "DELETE FROM product_variants WHERE product_variant_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Tìm biến thể theo ID
    public ProductVariant getById(int id) {
        String sql = """
            SELECT pv.*, 
                   p.product_name, 
                   w.weight, 
                   f.flavor
            FROM product_variants pv
            JOIN products p ON pv.product_id = p.product_id
            JOIN product_variant_weights w ON pv.weight_id = w.weight_id
            JOIN product_variant_flavors f ON pv.flavor_id = f.flavor_id
            WHERE pv.product_variant_id = ?
        """;

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                ProductVariant pv = new ProductVariant();
                pv.setProductVariantId(rs.getInt("product_variant_id"));
                pv.setProductId(rs.getInt("product_id"));
                pv.setVariantName(rs.getString("variant_name"));
                pv.setWeightId(rs.getInt("weight_id"));
                pv.setFlavorId(rs.getInt("flavor_id"));
                pv.setPrice(rs.getDouble("price"));
                pv.setStockQuantity(rs.getInt("stock_quantity"));
                pv.setStatus(rs.getBoolean("status"));
                pv.setImage(rs.getString("image"));
                pv.setCreatedAt(rs.getTimestamp("created_at"));
                pv.setUpdatedAt(rs.getTimestamp("updated_at"));
                pv.setProductName(rs.getString("product_name"));
                pv.setWeight(rs.getBigDecimal("weight"));
                pv.setFlavorName(rs.getString("flavor"));
                return pv;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    // Kiểm tra biến thể trùng (thêm mới)
    public boolean isDuplicateVariant(int productId, int weightId, int flavorId) {
        String sql = "SELECT 1 FROM product_variants WHERE product_id = ? AND weight_id = ? AND flavor_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ps.setInt(2, weightId);
            ps.setInt(3, flavorId);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Kiểm tra biến thể trùng khi cập nhật (trừ chính nó)
    public boolean isDuplicateVariantExcludeId(int productId, int weightId, int flavorId, int excludeId) {
        String sql = "SELECT 1 FROM product_variants WHERE product_id = ? AND weight_id = ? AND flavor_id = ? AND product_variant_id != ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ps.setInt(2, weightId);
            ps.setInt(3, flavorId);
            ps.setInt(4, excludeId);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
