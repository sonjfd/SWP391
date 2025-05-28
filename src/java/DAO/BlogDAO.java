package DAO;

import Model.Blog;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BlogDAO {

    // Phương thức lấy tất cả các blog từ cơ sở dữ liệu
    public List<Blog> getAllBlogs() {
        List<Blog> blogs = new ArrayList<>();
        String query = "SELECT * FROM blogs WHERE status = 'published'"; // Bạn có thể thay đổi điều kiện nếu cần

        try (Connection conn = DBContext.getConnection(); Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                Blog blog = new Blog(
                        rs.getString("id"),
                        rs.getString("title"),
                        rs.getString("content"),
                        rs.getString("author"),
                        rs.getDate("published_at"),
                        rs.getString("status"),
                        rs.getDate("created_at"),
                        rs.getDate("updated_at")
                );
                blogs.add(blog);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return blogs;
    }

    public List<Blog> getPaginationBlog(int index) {
        List<Blog> blogs = new ArrayList<>();
        String sql = "SELECT * FROM blogs WHERE status = 'published' \n"
                + "ORDER BY created_at \n"
                + "OFFSET ? ROWS FETCH NEXT 6 ROWS ONLY";
        try (Connection conn = DBContext.getConnection(); PreparedStatement stm = conn.prepareStatement(sql)) {
            stm.setInt(1, (index - 1) * 6);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Blog blog = new Blog(
                        rs.getString("id"),
                        rs.getString("title"),
                        rs.getString("content"),
                        rs.getString("author"),
                        rs.getDate("published_at"),
                        rs.getString("status"),
                        rs.getDate("created_at"),
                        rs.getDate("updated_at")
                );
                blogs.add(blog);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return blogs;
    }

    // Phương thức lấy blog theo ID
    public Blog getBlogById(String id) {
        Blog blog = null;
        String query = "SELECT * FROM blogs WHERE id = ?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    blog = new Blog(
                            rs.getString("id"),
                            rs.getString("title"),
                            rs.getString("content"),
                            rs.getString("author"),
                            rs.getDate("published_at"),
                            rs.getString("status"),
                            rs.getDate("created_at"),
                            rs.getDate("updated_at")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return blog;
    }

    // Phương thức thêm blog mới vào cơ sở dữ liệu
    public boolean addBlog(Blog blog) {
        String query = "INSERT INTO blogs (id, title, content, author, published_at, status, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, blog.getId());
            ps.setString(2, blog.getTitle());
            ps.setString(3, blog.getContent());
            ps.setString(4, blog.getAuthor());
            ps.setDate(5, new java.sql.Date(blog.getPublishedAt().getTime()));
            ps.setString(6, blog.getStatus());
            ps.setDate(7, new java.sql.Date(blog.getCreatedAt().getTime()));
            ps.setDate(8, new java.sql.Date(blog.getUpdatedAt().getTime()));

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Phương thức sửa thông tin của blog
    public boolean updateBlog(Blog blog) {
        String query = "UPDATE blogs SET title = ?, content = ?, author = ?, published_at = ?, status = ?, updated_at = ? WHERE id = ?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, blog.getTitle());
            ps.setString(2, blog.getContent());
            ps.setString(3, blog.getAuthor());
            ps.setDate(4, new java.sql.Date(blog.getPublishedAt().getTime()));
            ps.setString(5, blog.getStatus());
            ps.setDate(6, new java.sql.Date(blog.getUpdatedAt().getTime()));
            ps.setString(7, blog.getId());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Phương thức xóa blog theo ID
    public boolean deleteBlog(String id) {
        String query = "DELETE FROM blogs WHERE id = ?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, id);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static void main(String[] args) {
        List<Blog> l = new BlogDAO().getPaginationBlog(1);
        for (Blog blog : l) {
            System.out.println(blog);
        }
    }
}
