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

@WebServlet("/staff-edit-blog")
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

        // Thư mục lưu ảnh ngoài project
        String uploadDirPath = "C:/MyUploads/avatars";
        File uploadDir = new File(uploadDirPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        
        String avatarPath = null;
        String randomFileName = null;
        
        if (filePart != null && filePart.getSize() > 0) {
            // Xóa ảnh cũ nếu có
            String oldAvatarPath = blog.getImage(); // eg: /image-loader/abc.jpg
            if (oldAvatarPath != null && oldAvatarPath.contains("/image-loader/")) {
                String oldFileName = oldAvatarPath.substring((request.getContextPath() + "/image-loader/").length());
                File oldFile = new File(uploadDir, oldFileName);
                if (oldFile.exists()) {
                    oldFile.delete();
                }
            }

            // Tạo tên ngẫu nhiên cho file
            String fileExtension = filePart.getSubmittedFileName().substring(filePart.getSubmittedFileName().lastIndexOf("."));
            randomFileName = java.util.UUID.randomUUID().toString() + fileExtension;

            // Ghi file
            File newFile = new File(uploadDir, randomFileName);
            filePart.write(newFile.getAbsolutePath());

            // Gán đường dẫn lưu DB
            avatarPath = request.getContextPath() + "/image-loader/" + randomFileName;
            
        } else {
            // Không upload ảnh mới → giữ nguyên ảnh cũ
            avatarPath = blog.getImage();
        }
        blog.setImage(avatarPath);
        
        dao.updateBlog(blog, tagIds);
        response.sendRedirect("staff-list-blog");
    }
}
