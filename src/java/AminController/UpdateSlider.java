/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package AminController;

import DAO.SliderDAO;
import Model.Slider;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.util.List;

/**
 *
 * @author FPT
 */
@MultipartConfig

@WebServlet(name = "UpdateSlider", urlPatterns = {"/admin-update-slider"})
public class UpdateSlider extends HttpServlet {

    private static final String UPLOAD_DIR = "C:/MyUploads/avatars";
    private SliderDAO sliderDAO = new SliderDAO();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpdateSlider</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateSlider at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        String submit = request.getParameter("submit");

        try {
            if (submit == null) {
                // Hiển thị form cập nhật
                if (id != null && !id.trim().isEmpty()) {
                    Slider slide = sliderDAO.getSlideById(id);
                    if (slide != null) {
                        request.setAttribute("slide", slide);
                        request.getRequestDispatcher("view/admin/content/UpdateSlider.jsp").forward(request, response);
                    } else {
                        List<Slider> slides = sliderDAO.getAllSlider();
                        request.setAttribute("slides", slides);
                        request.setAttribute("message", "Slide not found.");
                        request.getRequestDispatcher("view/admin/content/ListSlider.jsp").forward(request, response);
                    }
                } else {
                    List<Slider> slides = sliderDAO.getAllSlider();
                    request.setAttribute("slides", slides);
                    request.setAttribute("message", "Invalid slide ID.");
                    request.getRequestDispatcher("view/admin/content/ListSlider.jsp").forward(request, response);
                }
            } else {
                // Xử lý cập nhật
                Slider slide = new Slider();
                slide.setId(id);
                slide.setTitle(request.getParameter("title"));
                slide.setDescription(request.getParameter("description"));
                slide.setLink(request.getParameter("link"));
                slide.setIsActive(Integer.parseInt(request.getParameter("isActive")));

                // Xử lý ảnh
                Part filePart = request.getPart("image");
                if (filePart != null && filePart.getSize() > 0) {
                    File uploadDir = new File(UPLOAD_DIR);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }

                    String fileExtension = filePart.getSubmittedFileName().substring(filePart.getSubmittedFileName().lastIndexOf("."));
                    String uniqueFileName = java.util.UUID.randomUUID().toString() + fileExtension;

                    File file = new File(uploadDir, uniqueFileName);
                    filePart.write(file.getAbsolutePath());

                    // Sử dụng đường dẫn dùng chung image-loader
                    slide.setImageUrl(request.getContextPath() + "/image-loader/" + uniqueFileName);
                } else {
                    Slider existing = sliderDAO.getSlideById(id);
                    slide.setImageUrl(existing.getImageUrl());
                }

                // Cập nhật slide
                boolean success = sliderDAO.updateSlider(slide);

                // Lấy danh sách slide mới
                List<Slider> slides = sliderDAO.getAllSlider();
                request.setAttribute("slides", slides);

                // Đặt thông báo
                request.setAttribute("message", success ? "Cập nhật trình chiếu thành công" : "Cập nhật thất bại");

                // Forward về ListSlider.jsp
                request.getRequestDispatcher("view/admin/content/ListSlider.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            List<Slider> slides = sliderDAO.getAllSlider();
            request.setAttribute("slides", slides);
            request.setAttribute("message", "Update failed due to an error.");
            request.getRequestDispatcher("view/admin/content/ListSlider.jsp").forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");

        try {
            // Xử lý cập nhật
            Slider slide = new Slider();
            slide.setId(id);
            slide.setTitle(request.getParameter("title"));
            slide.setDescription(request.getParameter("description"));
            slide.setLink(request.getParameter("link"));
            slide.setIsActive(Integer.parseInt(request.getParameter("isActive")));

            // Xử lý ảnh
            Part filePart = request.getPart("image");
            if (filePart != null && filePart.getSize() > 0) {
                File uploadDir = new File(UPLOAD_DIR);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                String fileExtension = filePart.getSubmittedFileName().substring(filePart.getSubmittedFileName().lastIndexOf("."));
                String uniqueFileName = java.util.UUID.randomUUID().toString() + fileExtension;

                File file = new File(uploadDir, uniqueFileName);
                filePart.write(file.getAbsolutePath());

                // Sử dụng đường dẫn dùng chung image-loader
                slide.setImageUrl(request.getContextPath() + "/image-loader/" + uniqueFileName);
            } else {
                Slider existing = sliderDAO.getSlideById(id);
                slide.setImageUrl(existing.getImageUrl());
            }

            // Cập nhật slide
            boolean success = sliderDAO.updateSlider(slide);

            // Lấy danh sách slide mới
            List<Slider> slides = sliderDAO.getAllSlider();
            request.setAttribute("slides", slides);

            // Đặt thông báo
            request.setAttribute("message", success ? "Slide updated successfully!" : "Slide updated successfully");

            // Forward về ListSlider.jsp
            request.getRequestDispatcher("view/admin/content/ListSlider.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            List<Slider> slides = sliderDAO.getAllSlider();
            request.setAttribute("slides", slides);
            request.setAttribute("message", "Update failed due to an error.");
            request.getRequestDispatcher("view/admin/content/ListSlider.jsp").forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
