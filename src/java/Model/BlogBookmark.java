package Model;
import Model.Blog;
import Model.User;
import java.util.Date;

public class BlogBookmark {
    private String id; // Thêm ID để dễ dàng quản lý
    private Blog blog;
    private User user;
    private boolean isActive; // Trạng thái bookmark
    private Date createdAt;
    private Date updatedAt;

    public BlogBookmark() {}

    public BlogBookmark(String id, Blog blog, User user, boolean isActive, Date createdAt, Date updatedAt) {
        this.id = id;
        this.blog = blog;
        this.user = user;
        this.isActive = isActive;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getter and Setter methods
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Blog getBlog() {
        return blog;
    }

    public void setBlog(Blog blog) {
        this.blog = blog;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean isActive) {
        this.isActive = isActive;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }
}
