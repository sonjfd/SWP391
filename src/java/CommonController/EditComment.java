package CommonController;

import DAO.BlogDAO;
import Model.BlogComment;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;

@WebServlet("/edit-comment")
public class EditComment extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String commentId = request.getParameter("commentId");
        String content = request.getParameter("content");

        User user = (User) request.getSession().getAttribute("user");

        if (user == null || commentId == null || content == null || content.trim().isEmpty()) {
            response.sendRedirect("blog-detail?id=" + request.getParameter("blogId"));
            return;
        }

        // Tạo đối tượng BlogComment
        BlogComment comment = new BlogComment();
        comment.setId(commentId);
        comment.setContent(content);
        comment.setUpdatedAt(new Date());
        comment.setIsEdited(1); // Đánh dấu đã chỉnh sửa

        // Cập nhật bình luận vào DB
        BlogDAO blogDAO = new BlogDAO();
        blogDAO.updateComment(comment);

        response.sendRedirect("blog-detail?id=" + request.getParameter("blogId")+"#reactions");
    }
}
