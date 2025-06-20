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
@WebServlet(name = "UpdateUserInformation", urlPatterns = {"/updateuserinformation"})
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
        String realPath = request.getServletContext().getRealPath("/assets/images");
        File uploads = new File(realPath);
        if (!uploads.exists()) {
            uploads.mkdirs();
        }

        String filename = Path.of(part.getSubmittedFileName()).getFileName().toString();
        String filePath = "/assets/images/" + filename;

        if (filename.isEmpty()) {

            try {
                UserDAO userDao = new UserDAO();
                User user = userDao.getUserById(id);
                filePath = user.getAvatar();
            } catch (Exception e) {
                e.printStackTrace();
            }

        } else {
            String originalFilename = Path.of(part.getSubmittedFileName()).getFileName().toString();
            String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
            String randomFilename = System.currentTimeMillis() + "_" + (int) (Math.random() * 10000) + fileExtension;

            filePath = "/assets/images/" + randomFilename;
            File file = new File(uploads, randomFilename);
            part.write(file.getAbsolutePath());
        }

        UserDAO ud = new UserDAO();
        User u = ud.getUserByEmail(email);
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if(user.getAddress().equalsIgnoreCase(address)&&
                user.getAvatar().equalsIgnoreCase(filePath)&&
                user.getFullName().equalsIgnoreCase(name)&&
                user.getEmail().equalsIgnoreCase(email)&&
                user.getPhoneNumber().equalsIgnoreCase(number)){
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
        if (ud.updateUser(id, name, address, email, number, filePath)) {
            User updatedUser = ud.getUserById(id);
            request.getSession().setAttribute("user", updatedUser);

            request.getSession().setAttribute("SuccessMessage", "Cập nhật thông tin thành công!");
        } else {
            request.getSession().setAttribute("FailMessage", "Cập nhật thông tin không thành công!");
        }
        response.sendRedirect("viewuserinformation");

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