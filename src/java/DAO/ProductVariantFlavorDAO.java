/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.ProductVariantFlavor;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;

/**
 *
 * @author Admin
 */
public class ProductVariantFlavorDAO {
     public List<ProductVariantFlavor> getAll() {
        List<ProductVariantFlavor> list = new ArrayList<>();
        String sql = "SELECT * FROM product_variant_flavors";

        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ProductVariantFlavor f = new ProductVariantFlavor();
                f.setFlavorId(rs.getInt("flavor_id"));
                f.setProductVariantId(rs.getInt("product_variant_id"));
                f.setFlavor(rs.getString("flavor"));
                f.setCreatedAt(rs.getTimestamp("created_at"));
                f.setUpdatedAt(rs.getTimestamp("updated_at"));
                list.add(f);
            }

        } catch (SQLException e) {
            System.err.println("Lỗi getAll(): " + e.getMessage());
        }

        return list;
    }

    public ProductVariantFlavor getById(int flavorId) {
        String sql = "SELECT * FROM product_variant_flavors WHERE flavor_id = ?";
        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, flavorId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                ProductVariantFlavor f = new ProductVariantFlavor();
                f.setFlavorId(rs.getInt("flavor_id"));
                f.setProductVariantId(rs.getInt("product_variant_id"));
                f.setFlavor(rs.getString("flavor"));
                f.setCreatedAt(rs.getTimestamp("created_at"));
                f.setUpdatedAt(rs.getTimestamp("updated_at"));
                return f;
            }

        } catch (SQLException e) {
            System.err.println("Lỗi getById(): " + e.getMessage());
        }

        return null;
    }

    public boolean insert(ProductVariantFlavor f) {
        String sql = "INSERT INTO product_variant_flavors (product_variant_id, flavor) VALUES (?, ?)";

        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, f.getProductVariantId());
            ps.setString(2, f.getFlavor());
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Lỗi insert(): " + e.getMessage());
        }

        return false;
    }

    public boolean update(ProductVariantFlavor f) {
        String sql = "UPDATE product_variant_flavors SET flavor = ?, updated_at = GETDATE() WHERE flavor_id = ?";

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
