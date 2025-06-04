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
          // Lấy user từ session
    HttpSession session = request.getSession(false);
    User user = (session != null) ? (User) session.getAttribute("user") : null;

    if (user == null) {
        
        response.sendRedirect("login");
        return;
    }

    UserDAO dao = new UserDAO();
    try {
        User refreshedUser = dao.getUserById(user.getId());
        request.setAttribute("user", refreshedUser);
    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("FailMessage", "Không thể lấy thông tin người dùng.");
    }

    // Forward tới JSP để hiển thị form
    request.getRequestDispatcher("view/profile/UserInformation.jsp").forward(request, response);

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

        // Nếu không có ảnh mới, giữ ảnh cũ
        if (filename.isEmpty()) {

            try {
                UserDAO userDao = new UserDAO();
                User user = userDao.getUserById(id);
                filePath = user.getAvatar(); // Giữ lại ảnh cũ
            } catch (Exception e) {
                e.printStackTrace();
            }

        } else {
            // Nếu có ảnh mới, lưu ảnh mới vào thư mục uploads
            File file = new File(uploads, filename);
            part.write(file.getAbsolutePath());
        }
        UserDAO ud = new UserDAO();
        if (ud.updateUser(id, name, address, email, number, filePath)) {
            User updatedUser = ud.getUserById(id);
            request.getSession().setAttribute("user", updatedUser);

            request.getSession().setAttribute("SuccessMessage", "Cập nhật thông tin thành công!");
        } else {
            request.getSession().setAttribute("FailMessage", "Cập nhật thông tin không thành công!");
        }
        response.sendRedirect("viewuserinformation");

        

    }

    if (!email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {
        request.getSession().setAttribute("FailMessage", "Email không đúng định dạng.");
        response.sendRedirect("viewuserinformation");
        return;
    }

    if (!number.matches("^(0|\\+84)[0-9]{9,10}$")) {
        request.getSession().setAttribute("FailMessage", "Số điện thoại không đúng định dạng.");
        response.sendRedirect("viewuserinformation");
        return;
    }

    // Xử lý ảnh đại diện
    String realPath = request.getServletContext().getRealPath("/assets/images");
    File uploads = new File(realPath);
    if (!uploads.exists()) uploads.mkdirs();

    String filename = Path.of(part.getSubmittedFileName()).getFileName().toString();
    String filePath = "/assets/images/" + filename;

    // Nếu không upload ảnh mới, lấy ảnh cũ
    if (filename == null || filename.trim().isEmpty()) {
        try {
            UserDAO dao = new UserDAO();
            User existingUser = dao.getUserById(id);
            filePath = existingUser.getAvatar();
        } catch (Exception e) {
            e.printStackTrace();
        }
    } else {
        // Lưu file mới
        File file = new File(uploads, filename);
        part.write(file.getAbsolutePath());
    }

    // Cập nhật DB
    UserDAO dao = new UserDAO();
    boolean updated = dao.updateUser(id, name, address, email, number, filePath);

    if (updated) {
        // Cập nhật lại user trong session
        try {
            User newUser = dao.getUserById(id);
            request.getSession().setAttribute("user", newUser);
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getSession().setAttribute("SuccessMessage", "Cập nhật thông tin thành công!");
    } else {
        request.getSession().setAttribute("FailMessage", "Cập nhật không thành công!");
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
