/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package UserController;

import DAO.UserDAO;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Path;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
@WebServlet(name = "UpdateUserInformation", urlPatterns = {"/customer-updateuserinformation"})
@MultipartConfig
public class UpdateUserInformation extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
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
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {

            response.sendRedirect("login");
            return;
        }

        User user = (User) session.getAttribute("user");
        request.setAttribute("user", user);
        request.getRequestDispatcher("view/profile/UserProfile.jsp").forward(request, response);
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
        UserDAO userDAO = new UserDAO();
        String id = request.getParameter("id");
        String name = request.getParameter("fullName");
        String address = request.getParameter("address");
        String email = request.getParameter("email");
        String number = request.getParameter("phone");

        Part part = request.getPart("avatar");

        // Thư mục lưu ảnh ngoài project
        String uploadDirPath = "C:/MyUploads/avatars";
        File uploadDir = new File(uploadDirPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        String avatarPath = null;
        String randomFileName = null;

        if (part != null && part.getSize() > 0) {
            // Xóa ảnh cũ nếu có
            String oldAvatarPath = userDAO.getUserById(id).getAvatar(); // eg: /swp391/image-loader/abc.jpg
            if (oldAvatarPath != null && oldAvatarPath.contains("/image-loader/")) {
                String oldFileName = oldAvatarPath.substring((request.getContextPath() + "/image-loader/").length());
                File oldFile = new File(uploadDir, oldFileName);
                if (oldFile.exists()) {
                    oldFile.delete();
                }
            }

            // Tạo tên ngẫu nhiên cho file
            String fileExtension = part.getSubmittedFileName().substring(part.getSubmittedFileName().lastIndexOf("."));
            randomFileName = java.util.UUID.randomUUID().toString() + fileExtension;

            // Ghi file
            File newFile = new File(uploadDir, randomFileName);
            part.write(newFile.getAbsolutePath());

            // Gán đường dẫn lưu DB
            avatarPath = request.getContextPath() + "/image-loader/" + randomFileName;
        } else {
            // Không upload ảnh mới → giữ nguyên ảnh cũ
            avatarPath = userDAO.getUserById(id).getAvatar();
        }

        UserDAO ud = new UserDAO();
        User u = ud.getUserByEmail(email);
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user.getAddress().equalsIgnoreCase(address)
                && user.getAvatar().equalsIgnoreCase(avatarPath)
                && user.getFullName().equalsIgnoreCase(name)
                && user.getEmail().equalsIgnoreCase(email)
                && user.getPhoneNumber().equalsIgnoreCase(number)) {
            User currentUser = ud.getUserById(id);
            request.setAttribute("user", currentUser);
            request.getRequestDispatcher("view/profile/UserProfile.jsp").forward(request, response);
            return;
        }
        if (u != null && !u.getId().equals(user.getId())) {
            request.setAttribute("wrongemail", "Cập nhật thông tin không thành công do email đã được sử dụng");
            User currentUser = ud.getUserById(id);
            request.setAttribute("user", currentUser);
            request.getRequestDispatcher("view/profile/UserProfile.jsp").forward(request, response);
            return;
        }
        if (ud.updateUser(id, name, address, email, number, avatarPath)) {
            User updatedUser = ud.getUserById(id);
            request.getSession().setAttribute("user", updatedUser);

            request.getSession().setAttribute("SuccessMessage", "Cập nhật thông tin thành công!");
        } else {
            request.getSession().setAttribute("FailMessage", "Cập nhật thông tin không thành công!");
        }
        response.sendRedirect("customer-updateuserinformation");

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
