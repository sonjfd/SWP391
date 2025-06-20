package CommonController;

import DAO.BlogDAO;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/delete-comment")
public class DeleteComment extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String commentId = request.getParameter("commentId");

        User user = (User) request.getSession().getAttribute("user");

        if (user == null || commentId == null) {
            response.sendRedirect("blog-detail?id=" + request.getParameter("blogId"));
            return;
        }

        // Xóa bình luận khỏi DB
        BlogDAO blogDAO = new BlogDAO();
        

        response.sendRedirect("blog-detail?id=" + request.getParameter("blogId")+"#reactions");
    }
}
