package AminController;

import DAO.SpecieDAO;
import Model.Specie;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

@WebServlet(name = "UpdateSpecie", urlPatterns = {"/admin-update-specie"})
@MultipartConfig
public class UpdateSpecie extends HttpServlet {

    private static final String IMAGE_UPLOAD_DIR = "C:/MyUploads/avatars";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            SpecieDAO dao = new SpecieDAO();
            Specie specie = dao.getSpecieById(id);

            if (specie != null) {
                request.setAttribute("specie", specie);
                request.getRequestDispatcher("view/admin/content/UpdateSpecie.jsp").forward(request, response);
            } else {
                request.setAttribute("message", "Specie not found.");
                request.getRequestDispatcher("view/admin/content/ListSpecie.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("listspecie");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        SpecieDAO dao = new SpecieDAO();
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String currentImage = request.getParameter("currentImage"); // giá trị giữ ảnh cũ nếu không upload mới

            Part imagePart = request.getPart("image");

            String imageUrl = currentImage;

            // Nếu người dùng upload ảnh mới
            if (imagePart != null && imagePart.getSize() > 0) {
                // Tạo thư mục nếu chưa tồn tại
                File uploadDir = new File(IMAGE_UPLOAD_DIR);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                // Tạo tên file mới
                String fileName = UUID.randomUUID().toString()
                        + imagePart.getSubmittedFileName().substring(imagePart.getSubmittedFileName().lastIndexOf("."));

                File newFile = new File(IMAGE_UPLOAD_DIR, fileName);
                imagePart.write(newFile.getAbsolutePath());

                // Cập nhật đường dẫn ảnh mới
                imageUrl = request.getContextPath() + "/image-loader/" + fileName;
            }

            // Gọi DAO để cập nhật
            Specie s = new Specie(id, name, imageUrl);
            boolean updated = dao.updateSpecie(s);

            request.setAttribute("message", updated ? "Cập nhật thành công!" : "Cập nhật thất bại!");
            request.setAttribute("specieList", dao.getAllSpecies());
            request.getRequestDispatcher("view/admin/content/ListSpecie.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Có lỗi xảy ra khi cập nhật!");
            request.setAttribute("specieList", dao.getAllSpecies());
            request.getRequestDispatcher("view/admin/content/ListSpecie.jsp").forward(request, response);
        }
    }
}