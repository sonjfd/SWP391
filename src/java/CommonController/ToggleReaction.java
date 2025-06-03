package CommonController;

import DAO.BlogDAO;
import Model.Blog;
import Model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/toggle-reaction")
public class ToggleReaction extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String blogId = request.getParameter("blogId");

        // Lấy user từ session
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Nếu chưa đăng nhập thì chuyển hướng đến trang đăng nhập
        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        BlogDAO blogDAO = new BlogDAO();
        Blog blog = blogDAO.getBlogById(blogId);

        // Gọi hàm toggleReaction
        blogDAO.toggleReaction(blog, user);

        // Trở lại trang chi tiết bài viết
        response.sendRedirect("blog-detail?id=" + blogId+"#reactions");
    }

    @Override
    public String getServletInfo() {
        return "Servlet to toggle blog reaction (like/unlike)";
    }
}
