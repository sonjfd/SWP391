/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package UserController;

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
import java.util.UUID;

/**
 *
 * @author Admin
 */
@WebServlet(name = "UploadImageServlet", urlPatterns = {"/upload-image"})
@MultipartConfig

public class UploadImageServlet extends HttpServlet {

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
            out.println("<title>Servlet UploadImageServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UploadImageServlet at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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

        // Thư mục lưu trữ cố định ngoài project
        String uploadDirPath = "C:/MyUploads/avatars";
        File uploadDir = new File(uploadDirPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // Lấy part ảnh
        Part part = request.getPart("image");
        String oldImagePath = request.getParameter("oldImagePath"); // option: xóa ảnh cũ nếu cần

        String avatarPath = null;
        String randomFileName = null;

        if (part != null && part.getSize() > 0) {

            // Xóa ảnh cũ nếu có
            if (oldImagePath != null && oldImagePath.contains("/image-loader/")) {
                String oldFileName = oldImagePath.substring(oldImagePath.lastIndexOf("/") + 1);
                File oldFile = new File(uploadDirPath, oldFileName);
                if (oldFile.exists()) {
                    oldFile.delete();
                }
            }

            // Tạo tên mới ngẫu nhiên
            String fileExtension = part.getSubmittedFileName()
                    .substring(part.getSubmittedFileName().lastIndexOf("."));
            randomFileName = UUID.randomUUID().toString() + fileExtension;

            // Ghi file vào ổ đĩa
            File newFile = new File(uploadDirPath, randomFileName);
            part.write(newFile.getAbsolutePath());

            // Tạo đường dẫn URL để lưu vào DB hoặc phản hồi về client
            avatarPath = request.getContextPath() + "/image-loader/" + randomFileName;
        }

        // Trả về đường dẫn ảnh nếu thành công
        if (avatarPath != null) {
            response.setContentType("text/plain");
            response.getWriter().write(avatarPath);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Không nhận được ảnh");
        }
    }

    @Override
    public String getServletInfo() {
        return "Upload image to external folder and return path";
    }

}
