package DAO;

import Model.Blog;
import Model.Tag;
import Model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import java.sql.Timestamp;

public class BlogDAO {

    /// START TAG DAO
    public List<Tag> getAllTags() {
        List<Tag> tags = new ArrayList<>();
        String sql = "SELECT id, name FROM tags";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Tag tag = new Tag();
                tag.setId(rs.getString("id"));
                tag.setName(rs.getString("name"));
                tags.add(tag);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return tags;
    }

    public List<Tag> getTagsByBlogId(String blogId) {
        List<Tag> tags = new ArrayList<>();
        String sql = "SELECT t.id, t.name FROM tags t "
                + "JOIN blog_tags bt ON t.id = bt.tag_id "
                + "WHERE bt.blog_id = ?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, blogId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Tag tag = new Tag();
                    tag.setId(rs.getString("id"));
                    tag.setName(rs.getString("name"));
                    tags.add(tag);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return tags;
    }

    /// END TAG DAO
    public List<Blog> getAllBlogs() {
        List<Blog> blogs = new ArrayList<>();
        String sql = "SELECT "
                + "b.id AS blog_id, b.title, b.content, b.image, b.status, "
                + "b.published_at, b.created_at, b.updated_at, b.reactions_count, b.comments_count, "
                + "u.id AS user_id, u.full_name, u.email, u.avatar "
                + "FROM blogs b "
                + "JOIN users u ON b.author_id = u.id "
                + "ORDER BY b.created_at DESC";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Blog b = new Blog();
                b.setId(rs.getString("blog_id"));
                b.setTitle(rs.getString("title"));
                b.setContent(rs.getString("content"));
                b.setImage(rs.getString("image"));
                b.setStatus(rs.getString("status"));
                b.setPublishedAt(rs.getTimestamp("published_at"));
                b.setCreatedAt(rs.getTimestamp("created_at"));
                b.setUpdatedAt(rs.getTimestamp("updated_at"));
                b.setReactionCount(rs.getInt("reactions_count"));
                b.setCommentCount(rs.getInt("comments_count"));

                User author = new User();
                author.setId(rs.getString("user_id"));
                author.setFullName(rs.getString("full_name"));
                author.setEmail(rs.getString("email"));
                author.setAvatar(rs.getString("avatar"));

                b.setAuthor(author);
                b.setTags(getTagsByBlogId(rs.getString("blog_id")));
                blogs.add(b);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return blogs;
    }

    // Lấy danh sách blog theo tag và phân trang
    public List<Blog> getBlogsByTagWithPagination(String tagId, int pageIndex, int pageSize) {
        List<Blog> blogs = new ArrayList<>();
        String sql = "SELECT b.* FROM blogs b "
                + "JOIN blog_tags bt ON b.id = bt.blog_id "
                + "WHERE bt.tag_id = ? "
                + "ORDER BY b.published_at DESC "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, tagId);
            ps.setInt(2, (pageIndex - 1) * pageSize);
            ps.setInt(3, pageSize);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Blog b = new Blog();
                    b.setId(rs.getString("id"));
                    b.setTitle(rs.getString("title"));
                    b.setContent(rs.getString("content"));
                    b.setImage(rs.getString("image"));
                    b.setStatus(rs.getString("status"));
                    b.setPublishedAt(rs.getTimestamp("published_at"));
                    b.setCreatedAt(rs.getTimestamp("created_at"));
                    b.setUpdatedAt(rs.getTimestamp("updated_at"));
                    b.setReactionCount(rs.getInt("reactions_count"));
                    b.setCommentCount(rs.getInt("comments_count"));

                    b.setTags(getTagsByBlogId(rs.getString("id")));
                    blogs.add(b);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return blogs;
    }

// Đếm số lượng blog theo tag
    public int countBlogsByTag(String tagId) {
        String sql = "SELECT COUNT(*) FROM blog_tags WHERE tag_id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, tagId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

// Lấy danh sách blog phân trang (không lọc tag)
    public List<Blog> getPaginationBlog(int pageIndex, int pageSize) {
        List<Blog> blogs = new ArrayList<>();
        String sql = "SELECT * FROM blogs ORDER BY published_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, (pageIndex - 1) * pageSize);
            ps.setInt(2, pageSize);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Blog b = new Blog();
                    b.setId(rs.getString("id"));
                    b.setTitle(rs.getString("title"));
                    b.setContent(rs.getString("content"));
                    b.setImage(rs.getString("image"));
                    b.setStatus(rs.getString("status"));
                    b.setPublishedAt(rs.getTimestamp("published_at"));
                    b.setCreatedAt(rs.getTimestamp("created_at"));
                    b.setUpdatedAt(rs.getTimestamp("updated_at"));
                    b.setReactionCount(rs.getInt("reactions_count"));
                    b.setCommentCount(rs.getInt("comments_count"));

                    b.setTags(getTagsByBlogId(rs.getString("id")));
                    blogs.add(b);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return blogs;
    }
// Lấy blog theo tagId với phân trang

    
// Đếm blog theo tag
    

    public Blog getBlogById(String id) {
        Blog blog = null;
        String sql = "SELECT "
                + "b.id AS blog_id, b.title, b.content, b.image, b.status, "
                + "b.published_at, b.created_at, b.updated_at, b.reactions_count, b.comments_count, "
                + "u.id AS user_id, u.full_name, u.email, u.avatar "
                + "FROM blogs b "
                + "JOIN users u ON b.author_id = u.id "
                + "WHERE b.id = ?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    blog = new Blog();
                    blog.setId(rs.getString("blog_id"));
                    blog.setTitle(rs.getString("title"));
                    blog.setContent(rs.getString("content"));
                    blog.setImage(rs.getString("image"));
                    blog.setStatus(rs.getString("status"));
                    blog.setPublishedAt(rs.getTimestamp("published_at"));
                    blog.setCreatedAt(rs.getTimestamp("created_at"));
                    blog.setUpdatedAt(rs.getTimestamp("updated_at"));
                    blog.setReactionCount(rs.getInt("reactions_count"));
                    blog.setCommentCount(rs.getInt("comments_count"));

                    User author = new User();
                    author.setId(rs.getString("user_id"));
                    author.setFullName(rs.getString("full_name"));
                    author.setEmail(rs.getString("email"));
                    author.setAvatar(rs.getString("avatar"));

                    blog.setAuthor(author);
                    blog.setTags(getTagsByBlogId(id));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return blog;
    }

   

    // END BLOG COMMENT
    // ==================== TẠO BLOG ===============================
    public void createBlog(Blog blog, String[] tagIds) {
        String insertBlogSQL = "INSERT INTO blogs (id, title, content, image, author_id, status, created_at, updated_at, published_at) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        String insertTagSQL = "INSERT INTO blog_tags (blog_id, tag_id) VALUES (?, ?)";

        try (Connection conn = DBContext.getConnection()) {
            conn.setAutoCommit(false);

            try (PreparedStatement psBlog = conn.prepareStatement(insertBlogSQL)) {
                psBlog.setString(1, blog.getId());
                psBlog.setString(2, blog.getTitle());
                psBlog.setString(3, blog.getContent());
                psBlog.setString(4, blog.getImage());
                psBlog.setString(5, blog.getAuthor().getId());
                psBlog.setString(6, blog.getStatus());
                psBlog.setTimestamp(7, new java.sql.Timestamp(blog.getCreatedAt().getTime()));
                psBlog.setTimestamp(8, new java.sql.Timestamp(blog.getUpdatedAt().getTime()));
                if (blog.getPublishedAt() != null) {
                    psBlog.setTimestamp(9, new java.sql.Timestamp(blog.getPublishedAt().getTime()));
                } else {
                    psBlog.setNull(9, java.sql.Types.TIMESTAMP);
                }
                psBlog.executeUpdate();
            }

            if (tagIds != null && tagIds.length > 0) {
                try (PreparedStatement psTag = conn.prepareStatement(insertTagSQL)) {
                    for (String tagId : tagIds) {
                        psTag.setString(1, blog.getId());
                        psTag.setString(2, tagId);
                        psTag.addBatch();
                    }
                    psTag.executeBatch();
                }
            }

            conn.commit();
        } catch (Exception e) {
            e.printStackTrace();
            // Log lỗi ra logger nếu có, hoặc throw runtime để controller xử lý
            throw new RuntimeException("Lỗi tạo blog", e);
        }
    }

    //===============================================================
    //===================== XÓA BLOG ===============================
    public void deleteBlog(String blogId) {
        String deleteBlogTag = "DELETE FROM blog_tags WHERE blog_id = ?";
        String deleteBlog = "DELETE FROM blogs WHERE id = ?";

        try (Connection conn = DBContext.getConnection()) {
            conn.setAutoCommit(false);

            try (
                    PreparedStatement psTag = conn.prepareStatement(deleteBlogTag); PreparedStatement psBlog = conn.prepareStatement(deleteBlog)) {
                psTag.setString(1, blogId);
                psTag.executeUpdate();

                psBlog.setString(1, blogId);
                psBlog.executeUpdate();

                conn.commit();
            } catch (SQLException e) {
                conn.rollback();
                throw new RuntimeException("Lỗi khi xóa blog", e);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    //==============================================================
    //======================UPDATE BLOG ================================

    public void updateBlog(Blog blog, String[] tagIds) {
        String updateSQL = "UPDATE blogs SET title = ?, content = ?, image = ?, status = ?, updated_at = ?, published_at = ? WHERE id = ?";
        String deleteTagSQL = "DELETE FROM blog_tags WHERE blog_id = ?";
        String insertTagSQL = "INSERT INTO blog_tags (blog_id, tag_id) VALUES (?, ?)";

        try (Connection conn = DBContext.getConnection()) {
            conn.setAutoCommit(false);

            try (PreparedStatement ps = conn.prepareStatement(updateSQL)) {
                ps.setString(1, blog.getTitle());
                ps.setString(2, blog.getContent());
                ps.setString(3, blog.getImage());
                ps.setString(4, blog.getStatus());
                ps.setTimestamp(5, new java.sql.Timestamp(blog.getUpdatedAt().getTime()));
                if (blog.getPublishedAt() != null) {
                    ps.setTimestamp(6, new java.sql.Timestamp(blog.getPublishedAt().getTime()));
                } else {
                    ps.setNull(6, java.sql.Types.TIMESTAMP);
                }
                ps.setString(7, blog.getId());
                ps.executeUpdate();
            }

            try (PreparedStatement psDelete = conn.prepareStatement(deleteTagSQL)) {
                psDelete.setString(1, blog.getId());
                psDelete.executeUpdate();
            }

            if (tagIds != null) {
                try (PreparedStatement psInsert = conn.prepareStatement(insertTagSQL)) {
                    for (String tagId : tagIds) {
                        psInsert.setString(1, blog.getId());
                        psInsert.setString(2, tagId);
                        psInsert.addBatch();
                    }
                    psInsert.executeBatch();
                }
            }

            conn.commit();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi cập nhật blog", e);
        }
    }

    public List<String> getTagIdsByBlogId(String blogId) {
        List<String> tagIds = new ArrayList<>();
        String sql = "SELECT tag_id FROM blog_tags WHERE blog_id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, blogId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    tagIds.add(rs.getString("tag_id"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return tagIds;
    }

    

    

    // ======================================================================================
    public List<Blog> getBlogsByTagId(String tagId) {
        List<Blog> blogs = new ArrayList<>();
        String sql = "SELECT b.id AS blog_id, b.title, b.content, b.image, b.status, "
                + "b.published_at, b.created_at, b.updated_at, b.reactions_count, b.comments_count, "
                + "u.id AS user_id, u.full_name, u.email, u.avatar "
                + "FROM blogs b "
                + "JOIN blog_tags bt ON b.id = bt.blog_id "
                + "JOIN users u ON b.author_id = u.id "
                + "WHERE bt.tag_id = ? "
                + "ORDER BY b.created_at DESC";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, tagId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Blog b = new Blog();
                    b.setId(rs.getString("blog_id"));
                    b.setTitle(rs.getString("title"));
                    b.setContent(rs.getString("content"));
                    b.setImage(rs.getString("image"));
                    b.setStatus(rs.getString("status"));
                    b.setPublishedAt(rs.getTimestamp("published_at"));
                    b.setCreatedAt(rs.getTimestamp("created_at"));
                    b.setUpdatedAt(rs.getTimestamp("updated_at"));
                    b.setReactionCount(rs.getInt("reactions_count"));
                    b.setCommentCount(rs.getInt("comments_count"));

                    User author = new User();
                    author.setId(rs.getString("user_id"));
                    author.setFullName(rs.getString("full_name"));
                    author.setEmail(rs.getString("email"));
                    author.setAvatar(rs.getString("avatar"));
                    b.setAuthor(author);

                    b.setTags(getTagsByBlogId(rs.getString("blog_id")));
                    blogs.add(b);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return blogs;
    }

}
