package DAO;

import Model.ProductVariant;
import java.sql.*;
import java.util.*;

public class ProductVariantDAO extends DBContext {

    private ProductVariant extractFromResultSet(ResultSet rs) throws SQLException {
        ProductVariant pv = new ProductVariant();
        pv.setProductVariantId(rs.getInt("product_variant_id"));
        pv.setProductName(rs.getString("product_name"));
        pv.setCategoryName(rs.getString("category_name"));
        pv.setWeight(rs.getDouble("weight"));
        pv.setFlavorName(rs.getString("flavor"));
        pv.setPrice(rs.getDouble("price"));
        pv.setStockQuantity(rs.getInt("stock_quantity"));
        pv.setImage(rs.getString("image"));
        pv.setStatus(rs.getBoolean("status"));
        pv.setCreatedAt(rs.getTimestamp("created_at"));
        pv.setUpdatedAt(rs.getTimestamp("updated_at"));
        return pv;
    }

    public List<ProductVariant> getAllVariants() {
        List<ProductVariant> list = new ArrayList<>();
        String sql = "SELECT pv.product_variant_id, p.product_name, c.category_name, w.weight, f.flavor, pv.price, pv.stock_quantity, pv.image, pv.status, pv.created_at, pv.updated_at FROM product_variants pv JOIN products p ON pv.product_id = p.product_id JOIN categories c ON p.category_id = c.category_id JOIN product_variant_weights w ON pv.weight_id = w.weight_id JOIN product_variant_flavors f ON pv.flavor_id = f.flavor_id";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(extractFromResultSet(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<ProductVariant> search(String name, Boolean status, int page, int pageSize) {
        List<ProductVariant> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT pv.product_variant_id, p.product_name, c.category_name, w.weight, f.flavor, pv.price, pv.stock_quantity, pv.image, pv.status, pv.created_at, pv.updated_at FROM product_variants pv JOIN products p ON pv.product_id = p.product_id JOIN categories c ON p.category_id = c.category_id JOIN product_variant_weights w ON pv.weight_id = w.weight_id JOIN product_variant_flavors f ON pv.flavor_id = f.flavor_id WHERE 1=1");

        if (name != null && !name.isEmpty()) {
            sql.append(" AND p.product_name LIKE ?");
        }
        if (status != null) {
            sql.append(" AND pv.status = ?");
        }
        sql.append(" ORDER BY pv.product_variant_id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            int index = 1;
            if (name != null && !name.isEmpty()) {
                ps.setString(index++, "%" + name + "%");
            }
            if (status != null) {
                ps.setBoolean(index++, status);
            }
            ps.setInt(index++, (page - 1) * pageSize);
            ps.setInt(index, pageSize);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(extractFromResultSet(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countSearch(String name, Boolean status) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM product_variants pv JOIN products p ON pv.product_id = p.product_id JOIN categories c ON p.category_id = c.category_id JOIN product_variant_weights w ON pv.weight_id = w.weight_id JOIN product_variant_flavors f ON pv.flavor_id = f.flavor_id WHERE 1=1");

        if (name != null && !name.isEmpty()) {
            sql.append(" AND p.product_name LIKE ?");
        }
        if (status != null) {
            sql.append(" AND pv.status = ?");
        }

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            int index = 1;
            if (name != null && !name.isEmpty()) {
                ps.setString(index++, "%" + name + "%");
            }
            if (status != null) {
                ps.setBoolean(index++, status);
            }
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public void add(ProductVariant pv) {
        String sql = "INSERT INTO product_variants (product_id, weight_id, flavor_id, price, stock_quantity, status, image, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, GETDATE(), GETDATE())";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, pv.getProductId());
            ps.setInt(2, pv.getWeightId());
            ps.setInt(3, pv.getFlavorId());
            ps.setDouble(4, pv.getPrice());
            ps.setInt(5, pv.getStockQuantity());
            ps.setBoolean(6, pv.isStatus());
            ps.setString(7, pv.getImage());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void update(ProductVariant pv) {
        String sql = "UPDATE product_variants SET weight_id = ?, flavor_id = ?, price = ?, stock_quantity = ?, status = ?, image = ?, updated_at = GETDATE() WHERE product_variant_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, pv.getWeightId());
            ps.setInt(2, pv.getFlavorId());
            ps.setDouble(3, pv.getPrice());
            ps.setInt(4, pv.getStockQuantity());
            ps.setBoolean(5, pv.isStatus());
            ps.setString(6, pv.getImage());
            ps.setInt(7, pv.getProductVariantId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void delete(int id) {
        String sql = "DELETE FROM product_variants WHERE product_variant_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ProductVariant getById(int id) {
        String sql = "SELECT pv.*, p.product_name, c.category_name, w.weight, f.flavor FROM product_variants pv JOIN products p ON pv.product_id = p.product_id JOIN categories c ON p.category_id = c.category_id JOIN product_variant_weights w ON pv.weight_id = w.weight_id JOIN product_variant_flavors f ON pv.flavor_id = f.flavor_id WHERE pv.product_variant_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                ProductVariant pv = new ProductVariant();
                pv.setProductVariantId(rs.getInt("product_variant_id"));
                pv.setProductId(rs.getInt("product_id"));
                pv.setWeightId(rs.getInt("weight_id"));
                pv.setFlavorId(rs.getInt("flavor_id"));
                pv.setPrice(rs.getDouble("price"));
                pv.setStockQuantity(rs.getInt("stock_quantity"));
                pv.setStatus(rs.getBoolean("status"));
                pv.setImage(rs.getString("image"));
                pv.setCreatedAt(rs.getTimestamp("created_at"));
                pv.setUpdatedAt(rs.getTimestamp("updated_at"));
                pv.setProductName(rs.getString("product_name"));
                pv.setCategoryName(rs.getString("category_name"));
                pv.setWeight(rs.getDouble("weight"));
                pv.setFlavorName(rs.getString("flavor"));
                return pv;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

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

    // ➕ 1. Lấy đường dẫn ảnh cũ (để xoá khi upload mới)
    public String getImagePathById(int variantId) {
        String sql = "SELECT image FROM product_variants WHERE product_variant_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, variantId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("image");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

// ➕ 2. Cập nhật ảnh mới (khi chỉ muốn thay ảnh)
    public boolean updateImageById(int variantId, String imagePath) {
        String sql = "UPDATE product_variants SET image = ?, updated_at = GETDATE() WHERE product_variant_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, imagePath);
            ps.setInt(2, variantId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
