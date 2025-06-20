package CommonController;

import DAO.BlogDAO;
import Model.Blog;
import Model.BlogComment;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.UUID;

@WebServlet("/add-comment")
public class AddComment extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy thông tin từ form
        String blogId = request.getParameter("blogId");
        String content = request.getParameter("content");

        // Lấy user từ session
        User user = (User) request.getSession().getAttribute("user"); 

        if (user == null || blogId == null || content == null || content.trim().isEmpty()) {
            response.sendRedirect("blog-detail?id=" + blogId);  // Nếu thiếu dữ liệu, quay lại trang blog
            return;
        }

        // Tạo comment mới
        Blog blog = new Blog();
        blog.setId(blogId);

        BlogComment comment = new BlogComment();
        comment.setId(UUID.randomUUID().toString());
        comment.setBlog(blog);
        comment.setUser(user);
        comment.setContent(content);
        comment.setCreatedAt(new Date());
        comment.setIsEdited(0);

        // Thêm comment vào DB
        BlogDAO blogDAO = new BlogDAO();
    

        // Chuyển hướng về trang chi tiết blog
        response.sendRedirect("blog-detail?id=" + blogId+"#reactions");
    }

}
