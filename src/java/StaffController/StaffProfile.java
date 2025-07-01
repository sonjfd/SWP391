/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package StaffController;

import DAO.StaffDAO;
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

/**
 *
 * @author Dell
 */
@MultipartConfig

@WebServlet(name = "StaffProfile", urlPatterns = {"/staff-profile-setting"})
public class StaffProfile extends HttpServlet {

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
            out.println("<title>Servlet StaffProfile</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet StaffProfile at " + request.getContextPath() + "</h1>");
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
        StaffDAO sdao = new StaffDAO();
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("user");
        String uuid = u.getId();
        User newuser = sdao.getUserById(uuid);
        session.setAttribute("staff", newuser);

        request.getRequestDispatcher("/view/staff/content/StaffProfile.jsp").forward(request, response);
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
        String name = request.getParameter("fullName");
        String address = request.getParameter("address");
        String email = request.getParameter("email");
        String number = request.getParameter("phone");

        Part part = request.getPart("avatar");

        String uploadDirPath = "C:/MyUploads/avatars";
        File uploadDir = new File(uploadDirPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        String avatarPath = null;
        String randomFileName = null;

        UserDAO userDAO = new UserDAO();
        User currentUser = userDAO.getUserById(id);

        if (part != null && part.getSize() > 0) {
            String oldAvatarPath = currentUser.getAvatar();
            if (oldAvatarPath != null && oldAvatarPath.contains("/image-loader/")) {
                String oldFileName = oldAvatarPath.substring((request.getContextPath() + "/image-loader/").length());
                File oldFile = new File(uploadDir, oldFileName);
                if (oldFile.exists()) {
                    oldFile.delete();
                }
            }

            String submittedFileName = part.getSubmittedFileName();
            String fileExtension = submittedFileName.substring(submittedFileName.lastIndexOf("."));
            randomFileName = java.util.UUID.randomUUID().toString() + fileExtension;

            File newFile = new File(uploadDir, randomFileName);
            part.write(newFile.getAbsolutePath());

            avatarPath = request.getContextPath() + "/image-loader/" + randomFileName;
        } else {
            avatarPath = currentUser.getAvatar();
        }

        User u = userDAO.getUserByEmail(email);
        HttpSession session = request.getSession();
        User loggedInStaff = (User) session.getAttribute("staff");

        if (u != null && !u.getId().equals(loggedInStaff.getId())) {
            request.setAttribute("wrongemail", "Cập nhật thông tin không thành công do email đã được sử dụng");
            request.setAttribute("staff", currentUser);
            request.getRequestDispatcher("view/staff/content/StaffProfile.jsp").forward(request, response);
            return;
        }

        if (userDAO.updateUser(id, name, address, email, number, avatarPath)) {
            User updatedUser = userDAO.getUserById(id);
            session.setAttribute("user", updatedUser);
            session.setAttribute("SuccessMessage", "Cập nhật thông tin thành công!");
        } else {
            session.setAttribute("FailMessage", "Cập nhật thông tin không thành công!");
        }

        response.sendRedirect("staff-profile-setting");
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
