package StaffController;

import DAO.BlogDAO;
import Model.Blog;
import Model.Tag;
import Model.User;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 10 * 1024 * 1024
)
@WebServlet("/staff-add-blog")
public class AddBlog extends HttpServlet {

    private final String UPLOAD_DIR = "assets/images/blogs";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Tag> tagList = new BlogDAO().getAllTags();
        request.setAttribute("tagList", tagList);
        request.getRequestDispatcher("/view/staff/content/AddBlog.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String status = request.getParameter("status");
        String[] tagIds = request.getParameterValues("tags");
        Part filePart = request.getPart("image");

        // Giả lập User
        HttpSession ss = request.getSession();
        User u = (User) ss.getAttribute("user");
        if (u == null) {
            response.sendRedirect("login");
            return;
        }
        // Thư mục lưu ảnh ngoài project
        String uploadDirPath = "C:/MyUploads/avatars";
        File uploadDir = new File(uploadDirPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        String avatarPath = null;
        String randomFileName = null;
        // Tạo tên ngẫu nhiên cho file
        String fileExtension = filePart.getSubmittedFileName().substring(filePart.getSubmittedFileName().lastIndexOf("."));
        randomFileName = java.util.UUID.randomUUID().toString() + fileExtension;

        // Ghi file
        File newFile = new File(uploadDir, randomFileName);
        filePart.write(newFile.getAbsolutePath());

        // Gán đường dẫn lưu DB
        avatarPath = request.getContextPath() + "/image-loader/" + randomFileName;
        Blog blog = new Blog();
        blog.setId(UUID.randomUUID().toString());
        blog.setTitle(title);
        blog.setContent(content);
        blog.setImage(avatarPath);
        blog.setAuthor(u);
        blog.setStatus(status);
        blog.setCreatedAt(new Date());
        blog.setUpdatedAt(new Date());
        blog.setPublishedAt("published".equals(status) ? new Date() : null);

        BlogDAO dao = new BlogDAO();
        dao.createBlog(blog, tagIds); // Truyền mảng tagIds

        response.sendRedirect("staff-list-blog");
    }
}
