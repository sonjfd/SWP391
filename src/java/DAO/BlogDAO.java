package DAO;

import Model.Blog;
import Model.BlogComment;
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

    // get BLOG COMMENT
    public List<BlogComment> getCommentsByBlogId(String blogId) {
        List<BlogComment> comments = new ArrayList<>();

        String sql = "SELECT c.id, c.content, c.created_at, c.updated_at, c.is_edited, "
                + "u.id AS user_id, u.full_name, u.email, u.avatar "
                + "FROM blog_comments c "
                + "JOIN users u ON c.user_id = u.id "
                + "WHERE c.blog_id = ? "
                + "ORDER BY c.created_at DESC";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, blogId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    BlogComment comment = new BlogComment();
                    comment.setId(rs.getString("id"));
                    comment.setContent(rs.getString("content"));
                    comment.setCreatedAt(rs.getTimestamp("created_at"));
                    comment.setUpdatedAt(rs.getTimestamp("updated_at"));
                    comment.setIsEdited(rs.getInt("is_edited"));

                    User user = new User();
                    user.setId(rs.getString("user_id"));
                    user.setFullName(rs.getString("full_name"));
                    user.setEmail(rs.getString("email"));
                    user.setAvatar(rs.getString("avatar"));

                    comment.setUser(user);

                    comments.add(comment);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi lấy bình luận blog", e);
        }

        return comments;
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

    // ============================== THÊM SỬA XÓA BOOKMARK =====================================
    public void addBookmark(Blog blog, User user) {
        String sql = "INSERT INTO blog_bookmarks (blog_id, user_id, is_active, created_at, updated_at) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, blog.getId());
            ps.setString(2, user.getId());
            ps.setBoolean(3, true); // Khi thêm bookmark là true
            ps.setTimestamp(4, new java.sql.Timestamp(new Date().getTime()));
            ps.setTimestamp(5, new java.sql.Timestamp(new Date().getTime()));

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void removeBookmark(Blog blog, User user) {
        String sql = "UPDATE blog_bookmarks SET is_active = ? WHERE blog_id = ? AND user_id = ?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setBoolean(1, false); // Thay đổi trạng thái bookmark thành false khi bỏ bookmark
            ps.setString(2, blog.getId());
            ps.setString(3, user.getId());

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean isBookmarked(Blog blog, User user) {
        String sql = "SELECT * FROM blog_bookmarks WHERE blog_id = ? AND user_id = ? AND is_active = 1";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, blog.getId());
            ps.setString(2, user.getId());

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next(); // Nếu có dữ liệu thì có bookmark
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // kiểm tra đã từng bookmark chưa 
    public boolean hasBookmarkRecord(Blog blog, User user) {
        String sql = "SELECT 1 FROM blog_bookmarks WHERE blog_id = ? AND user_id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, blog.getId());
            ps.setString(2, user.getId());

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    //khôi phục bookmark
    public void reactivateBookmark(Blog blog, User user) {
        String sql = "UPDATE blog_bookmarks SET is_active = 1, updated_at = GETDATE() WHERE blog_id = ? AND user_id = ?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, blog.getId());
            ps.setString(2, user.getId());

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // toggle bookmark
    public void toggleBookmark(Blog blog, User user) {
        if (isBookmarked(blog, user)) {
            removeBookmark(blog, user);
        } else {
            if (hasBookmarkRecord(blog, user)) {
                reactivateBookmark(blog, user);
            } else {
                addBookmark(blog, user);
            }
        }
    }

    // ==========================================================================================
    // ==================================== THÊM SỬA XÓA REACTION ===============================
    public void toggleReaction(Blog blog, User user) {
        String checkSql = "SELECT is_active FROM blog_reactions WHERE blog_id = ? AND user_id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {

            checkStmt.setString(1, blog.getId());
            checkStmt.setString(2, user.getId());
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                boolean current = rs.getBoolean("is_active");
                String updateSql = "UPDATE blog_reactions SET is_active = ?, updated_at = GETDATE() WHERE blog_id = ? AND user_id = ?";
                try (PreparedStatement ps = conn.prepareStatement(updateSql)) {
                    ps.setBoolean(1, !current);
                    ps.setString(2, blog.getId());
                    ps.setString(3, user.getId());
                    ps.executeUpdate();
                }
            } else {
                String insertSql = "INSERT INTO blog_reactions (blog_id, user_id, is_active, created_at, updated_at) VALUES (?, ?, 1, GETDATE(), GETDATE())";
                try (PreparedStatement ps = conn.prepareStatement(insertSql)) {
                    ps.setString(1, blog.getId());
                    ps.setString(2, user.getId());
                    ps.executeUpdate();
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean hasReacted(Blog blog, User user) {
        String sql = "SELECT * FROM blog_reactions WHERE blog_id = ? AND user_id = ? AND is_active = 1";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, blog.getId());
            ps.setString(2, user.getId());

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next(); // Nếu có dữ liệu thì đã thả tim
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

// ==========================================================================================
    //================================= COMMENT =============================================
    public void addComment(BlogComment comment) {
        String sql = "INSERT INTO blog_comments (id, blog_id, user_id, content, created_at, is_edited) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, comment.getId());
            ps.setString(2, comment.getBlog().getId());
            ps.setString(3, comment.getUser().getId());
            ps.setString(4, comment.getContent());
            ps.setTimestamp(5, new java.sql.Timestamp(comment.getCreatedAt().getTime()));
            ps.setInt(6, comment.getIsEdited());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi thêm comment", e);
        }
    }

    public void updateComment(BlogComment comment) {
        String sql = "UPDATE blog_comments SET content = ?, updated_at = ?, is_edited = ? WHERE id = ?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, comment.getContent());
            ps.setTimestamp(2, new java.sql.Timestamp(comment.getUpdatedAt().getTime()));
            ps.setInt(3, comment.getIsEdited());
            ps.setString(4, comment.getId());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteComment(String commentId) {
        String sql = "DELETE FROM blog_comments WHERE id = ?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, commentId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
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
