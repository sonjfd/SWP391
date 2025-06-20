package DAO;

import Model.ProductVariantFlavor;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductVariantFlavorDAO {

    // Lấy tất cả hương vị
    public List<ProductVariantFlavor> getAll() {
        List<ProductVariantFlavor> list = new ArrayList<>();
        String sql = "SELECT * FROM product_variant_flavors";

        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ProductVariantFlavor f = new ProductVariantFlavor();
                f.setFlavorId(rs.getInt("flavor_id"));
                f.setFlavor(rs.getString("flavor"));
                list.add(f);
            }

        } catch (SQLException e) {
            System.err.println("Lỗi getAll(): " + e.getMessage());
        }

        return list;
    }

    // Lấy theo ID
    public ProductVariantFlavor getById(int flavorId) {
        String sql = "SELECT * FROM product_variant_flavors WHERE flavor_id = ?";

        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, flavorId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    ProductVariantFlavor f = new ProductVariantFlavor();
                    f.setFlavorId(rs.getInt("flavor_id"));
                    f.setFlavor(rs.getString("flavor"));
                    return f;
                }
            }

        } catch (SQLException e) {
            System.err.println("Lỗi getById(): " + e.getMessage());
        }

        return null;
    }

    // Thêm mới
    public boolean insert(ProductVariantFlavor f) {
        String sql = "INSERT INTO product_variant_flavors (flavor) VALUES (?)";

        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, f.getFlavor());
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Lỗi insert(): " + e.getMessage());
        }

        return false;
    }

    // Cập nhật
    public boolean update(ProductVariantFlavor f) {
        String sql = "UPDATE product_variant_flavors SET flavor = ? WHERE flavor_id = ?";

        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, f.getFlavor());
            ps.setInt(2, f.getFlavorId());
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Lỗi update(): " + e.getMessage());
        }

        return false;
    }

    // Xoá theo ID
    public boolean deleteById(int flavorId) {
        String sql = "DELETE FROM product_variant_flavors WHERE flavor_id = ?";

        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, flavorId);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Lỗi deleteById(): " + e.getMessage());
        }

        return false;
    }
}
