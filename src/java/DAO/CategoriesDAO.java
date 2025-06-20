/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Categories;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Connection;
import java.util.ArrayList;

/**
 *
 * @author Dell
 */
public class CategoriesDAO {

    public List<Categories> getAllCategories() {
        String sql = "select * from categories";
        List<Categories> list = new ArrayList<>();
        try (Connection conn = DBContext.getConnection(); PreparedStatement stm = conn.prepareStatement(sql)) {
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Categories c = new Categories();
                c.setName(rs.getString("category_name"));
                c.setDescription(" description");
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Categories> getAllCategoriesById(int id) {
        String sql = "select * from categories where category_id= ?";
        List<Categories> list = new ArrayList<>();
        try (Connection conn = DBContext.getConnection(); PreparedStatement stm = conn.prepareStatement(sql)) {
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Categories c = new Categories();
                c.setName(rs.getString("category_id"));
                c.setDescription("category_name");
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean addCategory(Categories category) {
        String sql = "INSERT INTO categories (category_name, description) VALUES (?, ?)";
        try (Connection conn = DBContext.getConnection(); PreparedStatement stm = conn.prepareStatement(sql)) {

            // Thiết lập các tham số
            stm.setString(1, category.getName());  // Set tên danh mục
            stm.setString(2, category.getDescription());  // Set mô tả danh mục

            // Thực thi câu lệnh
            int rowsAffected = stm.executeUpdate();

            // Kiểm tra xem có dòng nào bị ảnh hưởng không
            if (rowsAffected > 0) {
                return true;  // Thêm thành công
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;  // Thêm không thành công
    }

   public boolean isCategoryExist(String categoryName) {
    String sql = "SELECT * FROM categories WHERE category_name LIKE ?";
    try (Connection conn = DBContext.getConnection(); PreparedStatement stm = conn.prepareStatement(sql)) {

        // Thêm dấu "%" vào trước và sau tên danh mục để sử dụng LIKE
        stm.setString(1, "%" + categoryName.trim().toLowerCase() + "%");  // Tìm kiếm tên danh mục có chứa "categoryName"
        ResultSet rs = stm.executeQuery();

        // Nếu có ít nhất một bản ghi, trả về true
        if (rs.next()) {
            return true;  // Không cần phải kiểm tra lại rs.getInt(1)
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return false;  // Nếu không có bản ghi nào, trả về false
}
   
   
   public boolean hideCategory(int id) {
    String sql = "UPDATE categories SET status = 0 WHERE category_id = ?";
    try (Connection conn = DBContext.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, id);
        return ps.executeUpdate() > 0;
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}

   public boolean deleteCategory(int id) {
    String sql = "DELETE FROM Categories WHERE   category_id = ?";
    try (Connection conn = DBContext.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, id);
        int rows = ps.executeUpdate();
        return rows > 0;
    } catch (Exception e) {
        e.printStackTrace();
        return false;
    }
}



    public static void main(String[] args) {
    CategoriesDAO dao = new CategoriesDAO();
    System.out.println(dao.deleteCategory(1));  // Sử dụng dấu nháy kép cho chuỗi
}

}
