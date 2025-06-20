package DAO;

import java.sql.*;
import java.util.*;
import Model.Category;

public class CategoryDAO {

    // ✅ Lấy tất cả danh mục
    public List<Category> getAllCategories() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT * FROM Categories";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Category c = extractCategoryFromResultSet(rs);
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ✅ Lấy danh mục theo ID
    public Category getCategoryById(int id) {
        String sql = "SELECT * FROM Categories WHERE category_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractCategoryFromResultSet(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // ✅ Lấy danh mục theo trạng thái
    public List<Category> getCategoriesByStatus(boolean status) {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT * FROM Categories WHERE status = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setBoolean(1, status);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(extractCategoryFromResultSet(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ✅ Phân trang tất cả danh mục
    public List<Category> getCategoriesByPage(int page, int pageSize) {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT * FROM Categories ORDER BY category_id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, (page - 1) * pageSize);
            ps.setInt(2, pageSize);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(extractCategoryFromResultSet(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ✅ Phân trang + lọc theo trạng thái
    public List<Category> getCategoriesByStatusAndPage(boolean status, int page, int pageSize) {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT * FROM Categories WHERE status = ? ORDER BY category_id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setBoolean(1, status);
            ps.setInt(2, (page - 1) * pageSize);
            ps.setInt(3, pageSize);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(extractCategoryFromResultSet(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ✅ Đếm tổng số danh mục
    public int getTotalCategories() {
        String sql = "SELECT COUNT(*) FROM Categories";
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
    public int getTotalCategoriesByStatus(boolean status) {
        String sql = "SELECT COUNT(*) FROM Categories WHERE status = ?";
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

    // ✅ Thêm danh mục
    public void addCategory(Category c) {
        String sql = "INSERT INTO Categories (category_name, description, status) VALUES (?, ?, ?)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, c.getCategoryName());
            ps.setString(2, c.getDescription());
            ps.setBoolean(3, c.isStatus());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ✅ Cập nhật danh mục
    public void updateCategory(Category c) {
        String sql = "UPDATE Categories SET category_name = ?, description = ?, status = ? WHERE category_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, c.getCategoryName());
            ps.setString(2, c.getDescription());
            ps.setBoolean(3, c.isStatus());
            ps.setInt(4, c.getCategoryId());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ✅ Xoá cứng
    public void deleteCategory(int id) {
        String sql = "DELETE FROM Categories WHERE category_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ✅ Xoá mềm (ẩn)
    public void softDeleteCategory(int id) {
        String sql = "UPDATE Categories SET status = 0 WHERE category_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ✅ Hàm chung để tạo Category từ ResultSet
    private Category extractCategoryFromResultSet(ResultSet rs) throws SQLException {
        return new Category(
            rs.getInt("category_id"),
            rs.getString("category_name"),
            rs.getString("description"),
            rs.getBoolean("status")
        );
    }
    // ✅ Tìm kiếm danh mục theo tên có phân trang
public List<Category> searchCategoriesByName(String keyword, int page, int pageSize) {
    List<Category> list = new ArrayList<>();
    String sql = "SELECT * FROM Categories WHERE category_name LIKE ? ORDER BY category_id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
    try (Connection conn = DBContext.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setString(1, "%" + keyword + "%");
        ps.setInt(2, (page - 1) * pageSize);
        ps.setInt(3, pageSize);

        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(extractCategoryFromResultSet(rs));
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}

// ✅ Đếm tổng số danh mục tìm kiếm
public int countCategoriesByName(String keyword) {
    String sql = "SELECT COUNT(*) FROM Categories WHERE category_name LIKE ?";
    try (Connection conn = DBContext.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setString(1, "%" + keyword + "%");
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return 0;
}
}
