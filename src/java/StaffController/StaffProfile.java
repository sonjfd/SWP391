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
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        Part part = request.getPart("avatar");

        String filePath = null;

        // Lấy đường dẫn thư mục lưu ảnh
        String realPath = request.getServletContext().getRealPath("/assets/images");
        File uploads = new File(realPath);
        if (!uploads.exists()) {
            uploads.mkdirs();
        }

        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("user");

        // Nếu người dùng chọn ảnh mới
        if (part != null && part.getSize() > 0) {
            String originalFilename = Path.of(part.getSubmittedFileName()).getFileName().toString();
            String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
            String randomFilename = System.currentTimeMillis() + "_" + (int) (Math.random() * 10000) + fileExtension;
            filePath = "/assets/images/" + randomFilename;

            File file = new File(uploads, randomFilename);
            part.write(file.getAbsolutePath());
        } else {
            // Nếu không có ảnh mới, giữ ảnh cũ
            try {
                UserDAO userDao = new UserDAO();
                User existingUser = userDao.getUserById(u.getId());
                filePath = existingUser.getAvatar(); // Giữ lại đường dẫn ảnh cũ
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // Cập nhật thông tin người dùng
        UserDAO userDAO = new UserDAO();
        boolean isUserUpdated = userDAO.updateUser(u.getId(), fullName, address, email, phone, filePath);

        if (isUserUpdated) {
            User updatedUser = userDAO.getUserById(u.getId());
            session.setAttribute("user", updatedUser);
            session.setAttribute("alertMessage", "Cập nhật thông tin thành công!");
            session.setAttribute("alertType", "success");
        } else {
            session.setAttribute("alertMessage", "Cập nhật thông tin không thành công!");
            session.setAttribute("alertType", "error");
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
