/*
 * Servlet to create a new slider and forward to ListSlider.jsp
 */
package AminController;

import DAO.SliderDAO;
import Model.Slider;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.util.List;
import java.util.UUID;

/**
 * @author FPT
 */
@MultipartConfig
@WebServlet(name="CreateSlider", urlPatterns={"/createslider"})
public class CreateSlider extends HttpServlet {
    private static final String UPLOAD_DIR = "assets/images/slider";
    private SliderDAO sliderDAO = new SliderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        try {
            request.getRequestDispatcher("view/admin/content/CreateSlider.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            List<Slider> slides = sliderDAO.getAllSlider();
            request.setAttribute("slides", slides);
            request.setAttribute("message", "Failed to load create slider form.");
            request.getRequestDispatcher("view/admin/content/ListSlider.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        try {
            // Tạo slider
            Slider slide = new Slider();
            slide.setId(UUID.randomUUID().toString()); // UUID cho UNIQUEIDENTIFIER
            slide.setTitle(request.getParameter("title"));
            slide.setDescription(request.getParameter("description"));
            slide.setLink(request.getParameter("link"));
            slide.setIsActive(Integer.parseInt(request.getParameter("isActive")));

            // Xử lý ảnh
            Part filePart = request.getPart("image");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = filePart.getSubmittedFileName();
                String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
                File file = new File(uploadPath, uniqueFileName);
                filePart.write(file.getAbsolutePath());
                slide.setImageUrl("/" + UPLOAD_DIR + "/" + uniqueFileName);
            } else {
                List<Slider> slides = sliderDAO.getAllSlider();
                request.setAttribute("slides", slides);
                request.setAttribute("message", "Image is required.");
                request.getRequestDispatcher("view/admin/content/ListSlider.jsp").forward(request, response);
                return;
            }

            // Thêm slider
            boolean success = sliderDAO.addSlider(slide);

            // Lấy danh sách slide
            List<Slider> slides = sliderDAO.getAllSlider();
            request.setAttribute("slides", slides);

            // Đặt thông báo
            request.setAttribute("message", success ? "Slider created successfully!" : "Failed to create slider.");

            // Forward
            request.getRequestDispatcher("view/admin/content/ListSlider.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            List<Slider> slides = sliderDAO.getAllSlider();
            request.setAttribute("slides", slides);
            request.setAttribute("message", "Create failed due to an error.");
            request.getRequestDispatcher("view/admin/content/ListSlider.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet to create a new slider and forward to ListSlider.jsp";
    }
}