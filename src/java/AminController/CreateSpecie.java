package AminController;

import DAO.SpecieDAO;
import Model.Specie;
import java.io.File;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet(name = "CreateSpecie", urlPatterns = {"/admin-create-specie"})
@MultipartConfig
public class CreateSpecie extends HttpServlet {

    private SpecieDAO specieDAO = new SpecieDAO();
    private static final String UPLOAD_DIR = "C:/MyUploads/avatars";
    private static final long MAX_FILE_SIZE = 5 * 1024 * 1024; // 5MB

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.getRequestDispatcher("view/admin/content/CreateSpecie.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            List<Specie> specieList = specieDAO.getAllSpecies();
            request.setAttribute("specieList", specieList);
            request.setAttribute("message", "Failed to load create specie form.");
            request.getRequestDispatcher("view/admin/content/ListSpecie.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        Part filePart = request.getPart("image");

        String imageUrl = null;

        try {
            // Kiểm tra và tạo thư mục nếu chưa có
            File uploadDir = new File(UPLOAD_DIR);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            if (filePart != null && filePart.getSize() > 0) {
                String fileName = filePart.getSubmittedFileName().toLowerCase();

                // Kiểm tra định dạng ảnh
                if (!fileName.endsWith(".png") && !fileName.endsWith(".jpg") && !fileName.endsWith(".jpeg")) {
                    throw new ServletException("Only PNG, JPG, JPEG files are allowed!");
                }

                // Kiểm tra dung lượng
                if (filePart.getSize() > MAX_FILE_SIZE) {
                    throw new ServletException("File size must be less than 5MB!");
                }

                // Tạo tên file ngẫu nhiên
                String extension = fileName.substring(fileName.lastIndexOf("."));
                String uniqueFileName = java.util.UUID.randomUUID().toString() + extension;
                File savedFile = new File(uploadDir, uniqueFileName);
                filePart.write(savedFile.getAbsolutePath());

                // Đường dẫn lưu trong DB (hiển thị thông qua ImageLoaderServlet)
                imageUrl = request.getContextPath() + "/image-loader/" + uniqueFileName;
            }

            Specie specie = new Specie(0, name, imageUrl);
            boolean success = specieDAO.addSpecie(specie);

            List<Specie> specieList = specieDAO.getAllSpecies();
            request.setAttribute("specieList", specieList);
            request.setAttribute("message", success ? "Tạo loài mới thành công" : "Tạo loài thất bại");
            request.getRequestDispatcher("view/admin/content/ListSpecie.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            List<Specie> specieList = specieDAO.getAllSpecies();
            request.setAttribute("specieList", specieList);
            request.setAttribute("message", "Create failed due to an error: " + e.getMessage());
            request.getRequestDispatcher("view/admin/content/ListSpecie.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet for creating new Specie with image upload.";
    }
}
