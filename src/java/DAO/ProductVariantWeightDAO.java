package DAO;

import Model.ProductVariantWeight;
import java.sql.*;
import java.util.*;

public class ProductVariantWeightDAO {

    private ProductVariantWeight extractFromResultSet(ResultSet rs) throws SQLException {
        return new ProductVariantWeight(
            rs.getInt("weight_id"),
            rs.getDouble("weight"),
            rs.getBoolean("status")
        );
    }

    // ✅ Lấy tất cả
    public List<ProductVariantWeight> getAllWeights() {
        List<ProductVariantWeight> list = new ArrayList<>();
        String sql = "SELECT * FROM product_variant_weights";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(extractFromResultSet(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ✅ Lấy theo ID
    public ProductVariantWeight getById(int id) {
        String sql = "SELECT * FROM product_variant_weights WHERE weight_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return extractFromResultSet(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // ✅ Lọc theo trạng thái
    public List<ProductVariantWeight> getByStatus(boolean status) {
        List<ProductVariantWeight> list = new ArrayList<>();
        String sql = "SELECT * FROM product_variant_weights WHERE status = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setBoolean(1, status);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(extractFromResultSet(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ✅ Phân trang
    public List<ProductVariantWeight> getByPage(int page, int pageSize) {
        List<ProductVariantWeight> list = new ArrayList<>();
        String sql = "SELECT * FROM product_variant_weights ORDER BY weight_id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, (page - 1) * pageSize);
            ps.setInt(2, pageSize);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(extractFromResultSet(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ✅ Phân trang + trạng thái
    public List<ProductVariantWeight> getByStatusAndPage(boolean status, int page, int pageSize) {
        List<ProductVariantWeight> list = new ArrayList<>();
        String sql = "SELECT * FROM product_variant_weights WHERE status = ? ORDER BY weight_id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setBoolean(1, status);
            ps.setInt(2, (page - 1) * pageSize);
            ps.setInt(3, pageSize);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(extractFromResultSet(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ✅ Đếm tổng
    public int countAll() {
        String sql = "SELECT COUNT(*) FROM product_variant_weights";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // ✅ Đếm theo trạng thái
    public int countByStatus(boolean status) {
        String sql = "SELECT COUNT(*) FROM product_variant_weights WHERE status = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setBoolean(1, status);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // ✅ Thêm mới
    public boolean insert(ProductVariantWeight w) {
        String sql = "INSERT INTO product_variant_weights (weight, status) VALUES (?, ?)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDouble(1, w.getWeight());
            ps.setBoolean(2, w.isStatus());
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Cập nhật
    public boolean update(ProductVariantWeight w) {
        String sql = "UPDATE product_variant_weights SET weight = ?, status = ? WHERE weight_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDouble(1, w.getWeight());
            ps.setBoolean(2, w.isStatus());
            ps.setInt(3, w.getWeightId());
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Xoá cứng
    public boolean delete(int id) {
        String sql = "DELETE FROM product_variant_weights WHERE weight_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Xoá mềm
    public boolean softDelete(int id) {
        String sql = "UPDATE product_variant_weights SET status = 0 WHERE weight_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Tìm kiếm theo trọng lượng + trạng thái + phân trang
    public List<ProductVariantWeight> search(Double weight, Boolean status, int page, int pageSize) {
        List<ProductVariantWeight> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM product_variant_weights WHERE 1=1");

        if (weight != null) sql.append(" AND weight = ?");
        if (status != null) sql.append(" AND status = ?");
        sql.append(" ORDER BY weight_id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int index = 1;
            if (weight != null) ps.setDouble(index++, weight);
            if (status != null) ps.setBoolean(index++, status);
            ps.setInt(index++, (page - 1) * pageSize);
            ps.setInt(index, pageSize);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(extractFromResultSet(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ✅ Đếm kết quả tìm kiếm
    public int countSearch(Double weight, Boolean status) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM product_variant_weights WHERE 1=1");

        if (weight != null) sql.append(" AND weight = ?");
        if (status != null) sql.append(" AND status = ?");

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int index = 1;
            if (weight != null) ps.setDouble(index++, weight);
            if (status != null) ps.setBoolean(index, status);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // ✅ KIỂM TRA TRÙNG - Dành cho thêm mới
    public boolean isWeightExists(double weight) {
        String sql = "SELECT 1 FROM product_variant_weights WHERE weight = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDouble(1, weight);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next(); // Có ít nhất 1 bản ghi => đã tồn tại
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ KIỂM TRA TRÙNG - Dành cho cập nhật (ngoại trừ bản ghi hiện tại)
    public boolean isWeightExistsExceptId(double weight, int id) {
        String sql = "SELECT 1 FROM product_variant_weights WHERE weight = ? AND weight_id != ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDouble(1, weight);
            ps.setInt(2, id);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next(); // Có ít nhất 1 bản ghi khác => đã trùng
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
