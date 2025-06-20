package DAO;

import Model.ProductVariantWeight;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductVariantWeightDAO {

    // Lấy toàn bộ danh sách trọng lượng
    public List<ProductVariantWeight> getAllWeights() {
        List<ProductVariantWeight> list = new ArrayList<>();
        String sql = "SELECT * FROM product_variant_weights";

        try (Connection connection = DBContext.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ProductVariantWeight w = new ProductVariantWeight();
                w.setWeightId(rs.getInt("weight_id"));
                w.setWeight(rs.getBigDecimal("weight"));
                list.add(w);
            }

        } catch (SQLException e) {
            System.err.println("Lỗi getAllWeights(): " + e.getMessage());
        }

        return list;
    }

    // Lấy trọng lượng theo weight_id
    public ProductVariantWeight getByWeightId(int weightId) {
        String sql = "SELECT * FROM product_variant_weights WHERE weight_id = ?";

        try (Connection connection = DBContext.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, weightId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    ProductVariantWeight w = new ProductVariantWeight();
                    w.setWeightId(rs.getInt("weight_id"));
                    w.setWeight(rs.getBigDecimal("weight"));
                    return w;
                }
            }

        } catch (SQLException e) {
            System.err.println("Lỗi getByWeightId(): " + e.getMessage());
        }

        return null;
    }

    // Thêm mới 1 trọng lượng
    public boolean insert(ProductVariantWeight w) {
        String sql = "INSERT INTO product_variant_weights (weight) VALUES (?)";

        try (Connection connection = DBContext.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setBigDecimal(1, w.getWeight());
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Lỗi insert(): " + e.getMessage());
        }

        return false;
    }

    // Cập nhật trọng lượng theo weight_id
    public boolean update(ProductVariantWeight w) {
        String sql = "UPDATE product_variant_weights SET weight = ? WHERE weight_id = ?";

        try (Connection connection = DBContext.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setBigDecimal(1, w.getWeight());
            ps.setInt(2, w.getWeightId());
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Lỗi update(): " + e.getMessage());
        }

        return false;
    }

    // Xoá theo weight_id
    public boolean deleteByWeightId(int weightId) {
        String sql = "DELETE FROM product_variant_weights WHERE weight_id = ?";

        try (Connection connection = DBContext.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, weightId);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Lỗi deleteByWeightId(): " + e.getMessage());
        }

        return false;
    }
}
