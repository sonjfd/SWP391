package StaffController;

import DAO.BlogDAO;
import Model.Blog;
import Model.Tag;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@WebServlet("/edit-blog")
@MultipartConfig
public class EditBlog extends HttpServlet {

    private final String UPLOAD_DIR = "assets/images/blogs";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        String id = request.getParameter("id");
        Blog blog = new BlogDAO().getBlogById(id);
        List<Tag> tagList = new BlogDAO().getAllTags();
        blog.setTagsAsList(new BlogDAO().getTagIdsByBlogId(id)); // lấy danh sách tagId để checked

        request.setAttribute("blog", blog);
        request.setAttribute("tagList", tagList);
        request.getRequestDispatcher("/view/staff/content/EditBlog.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String id = request.getParameter("id");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String status = request.getParameter("status");
        String[] tagIds = request.getParameterValues("tags");
        Part filePart = request.getPart("image");

        BlogDAO dao = new BlogDAO();
        Blog blog = dao.getBlogById(id);

        blog.setTitle(title);
        blog.setContent(content);
        blog.setStatus(status);
        blog.setUpdatedAt(new Date());
        if ("published".equals(status) && blog.getPublishedAt() == null) {
            blog.setPublishedAt(new Date());
        }

        if (filePart != null && filePart.getSize() > 0) {
            String uploadPath = request.getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uniqueFileName = UUID.randomUUID().toString() + "_" + fileName;
            filePart.write(uploadPath + File.separator + uniqueFileName);
            blog.setImage(UPLOAD_DIR + "/" + uniqueFileName);
        }

        dao.updateBlog(blog, tagIds);
        response.sendRedirect("list-blog");
    }
}
