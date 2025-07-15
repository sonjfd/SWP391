package DAO;

import Model.ProductVariantFlavor;
import java.sql.*;
import java.util.*;

public class ProductVariantFlavorDAO {

    private ProductVariantFlavor extract(ResultSet rs) throws SQLException {
        ProductVariantFlavor f = new ProductVariantFlavor();
        f.setFlavorId(rs.getInt("flavor_id"));
        f.setFlavor(rs.getString("flavor"));
        f.setStatus(rs.getBoolean("status"));
        return f;
    }

    // ✅ Lấy tất cả
    public List<ProductVariantFlavor> getAll() {
        List<ProductVariantFlavor> list = new ArrayList<>();
        String sql = "SELECT * FROM product_variant_flavors";
        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(extract(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<ProductVariantFlavor> getAllActive() {
    List<ProductVariantFlavor> list = new ArrayList<>();
    String sql = "SELECT * FROM product_variant_flavors WHERE status = 1";

    try (Connection con = DBContext.getConnection();
         PreparedStatement ps = con.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) list.add(extract(rs));

    } catch (SQLException e) {
        e.printStackTrace();
    }
    return list;
}


    // ✅ Lấy theo ID
    public ProductVariantFlavor getById(int flavorId) {
        String sql = "SELECT * FROM product_variant_flavors WHERE flavor_id = ?";
        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, flavorId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return extract(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ✅ Thêm mới
    public boolean insert(ProductVariantFlavor f) {
        String sql = "INSERT INTO product_variant_flavors (flavor, status) VALUES (?, ?)";
        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, f.getFlavor());
            ps.setBoolean(2, f.isStatus());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Cập nhật
    public boolean update(ProductVariantFlavor f) {
        String sql = "UPDATE product_variant_flavors SET flavor = ?, status = ? WHERE flavor_id = ?";
        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, f.getFlavor());
            ps.setBoolean(2, f.isStatus());
            ps.setInt(3, f.getFlavorId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Xoá cứng
    public boolean delete(int flavorId) {
        String sql = "DELETE FROM product_variant_flavors WHERE flavor_id = ?";
        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, flavorId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Xoá mềm (ẩn)
    public boolean softDelete(int flavorId) {
        String sql = "UPDATE product_variant_flavors SET status = 0 WHERE flavor_id = ?";
        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, flavorId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Lấy theo trạng thái
    public List<ProductVariantFlavor> getByStatus(boolean status) {
        List<ProductVariantFlavor> list = new ArrayList<>();
        String sql = "SELECT * FROM product_variant_flavors WHERE status = ?";
        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setBoolean(1, status);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(extract(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // ✅ Phân trang
    public List<ProductVariantFlavor> getByPage(int page, int pageSize) {
        List<ProductVariantFlavor> list = new ArrayList<>();
        String sql = "SELECT * FROM product_variant_flavors ORDER BY flavor_id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, (page - 1) * pageSize);
            ps.setInt(2, pageSize);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(extract(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // ✅ Phân trang theo trạng thái
    public List<ProductVariantFlavor> getByStatusAndPage(boolean status, int page, int pageSize) {
        List<ProductVariantFlavor> list = new ArrayList<>();
        String sql = "SELECT * FROM product_variant_flavors WHERE status = ? ORDER BY flavor_id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setBoolean(1, status);
            ps.setInt(2, (page - 1) * pageSize);
            ps.setInt(3, pageSize);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(extract(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // ✅ Tìm kiếm + trạng thái + phân trang
    public List<ProductVariantFlavor> search(String flavor, Boolean status, int page, int pageSize) {
        List<ProductVariantFlavor> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM product_variant_flavors WHERE 1=1");

        if (flavor != null && !flavor.isEmpty()) sql.append(" AND flavor LIKE ?");
        if (status != null) sql.append(" AND status = ?");
        sql.append(" ORDER BY flavor_id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {

            int i = 1;
            if (flavor != null && !flavor.isEmpty()) ps.setString(i++, "%" + flavor + "%");
            if (status != null) ps.setBoolean(i++, status);
            ps.setInt(i++, (page - 1) * pageSize);
            ps.setInt(i, pageSize);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(extract(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    // ✅ Đếm kết quả tìm kiếm
    public int countSearch(String flavor, Boolean status) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM product_variant_flavors WHERE 1=1");

        if (flavor != null && !flavor.isEmpty()) sql.append(" AND flavor LIKE ?");
        if (status != null) sql.append(" AND status = ?");

        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {

            int i = 1;
            if (flavor != null && !flavor.isEmpty()) ps.setString(i++, "%" + flavor + "%");
            if (status != null) ps.setBoolean(i, status);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    // ✅ Kiểm tra trùng tên khi thêm
    public boolean isFlavorExists(String flavor) {
        String sql = "SELECT 1 FROM product_variant_flavors WHERE flavor = ?";
        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, flavor);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next(); // tồn tại ít nhất 1 bản ghi
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Kiểm tra trùng tên khi cập nhật
    public boolean isFlavorExistsExceptId(String flavor, int flavorId) {
        String sql = "SELECT 1 FROM product_variant_flavors WHERE flavor = ? AND flavor_id != ?";
        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, flavor);
            ps.setInt(2, flavorId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next(); // tồn tại ít nhất 1 bản ghi trùng tên nhưng khác ID
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public static void main(String[] args) {
        ProductVariantFlavorDAO dao= new ProductVariantFlavorDAO();
        System.out.println(dao.getAllActive());
    }
}
