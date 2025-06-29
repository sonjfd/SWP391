/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package CommonController;

import DAO.AIChatboxDAO;
import DAO.UserDAO;
import GoogleLogin.PasswordUtils;
import static GoogleLogin.PasswordUtils.hashPassword;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.apache.tomcat.dbcp.dbcp2.Utils;

/**
 *
 * @author Admin
 */
@WebServlet(name = "Login", urlPatterns = {"/login"})
public class Login extends HttpServlet {

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
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie c : cookies) {
                if (c.getName().equals("identifier")) {
                    request.setAttribute("savedUser", c.getValue());
                }
                if (c.getName().equals("password")) {
                    request.setAttribute("savedPass", c.getValue());
                }
            }
        }

        request.getRequestDispatcher("view/home/content/Login.jsp").forward(request, response);
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

        String identifier = request.getParameter("identifier"); // username hoặc email
        String password = request.getParameter("password");

        // 1. Kiểm tra đầu vào rỗng
        if (identifier == null || identifier.trim().isEmpty()
                || password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ tên tài khoản, email và password");
            request.getRequestDispatcher("/view/home/content/Login.jsp").forward(request, response);
            return;
        }

        // 2. Mã hóa mật khẩu
        String hashedPassword = hashPassword(password);

        // 3. Kiểm tra thông tin đăng nhập
        UserDAO dao = new UserDAO();
        User user = dao.loginCheck(identifier, hashedPassword);

        // 4. Nếu không tìm được hoặc bị khóa
        if (user == null) {
            request.setAttribute("error", "Tên tài khoản, email hoặc mật khẩu không đúng. Vui lòng nhập lại.");
            request.getRequestDispatcher("/view/home/content/Login.jsp")
                    .forward(request, response);
            return;
        }
        if (user.getStatus() == 2) {
            request.setAttribute("error", "Tài khoản của bạn đã bị khóa. Vui lòng liên hiện đến Admin.");
            request.getRequestDispatcher("/view/home/content/Login.jsp")
                    .forward(request, response);
            return;
        }
        if (user.getStatus() == 0) {
            request.getSession().setAttribute("user", user); // để servlet /verify-home có thể dùng
            response.sendRedirect("verifylogin");
            return;
        }

        // 5. Lưu session
        HttpSession session = request.getSession();
        session.setAttribute("user", user);
        String sessionId = session.getId(); // lấy lại sessionId cũ
        AIChatboxDAO chatDao = new AIChatboxDAO();
        chatDao.updateMessagesWithUserId(sessionId, user.getId());
        // 6. Ghi nhớ tài khoản (remember me)
        String remember = request.getParameter("remember");
        if ("true".equals(remember)) {
            Cookie cUser = new Cookie("identifier", identifier);
            Cookie cPass = new Cookie("password", hashedPassword);
            cUser.setMaxAge(7 * 24 * 60 * 60); // 7 ngày
            cPass.setMaxAge(7 * 24 * 60 * 60);
            response.addCookie(cUser);
            response.addCookie(cPass);
        }

        // 7. Phân hướng theo vai trò
        int roleId = user.getRole().getId();

        switch (roleId) {
            case 1: // customer
                response.sendRedirect("homepage"); // hoặc profile
                break;
            case 2: // admin
                response.sendRedirect("admin");
                break;
            case 3: // doctor
                response.sendRedirect("homepage");
                break;
            case 4: // staff
                response.sendRedirect("staff-list-pet-and-owner");
                break;
            case 5: // nurse
                response.sendRedirect("homepage");
                break;
            default:
                response.sendRedirect("homepage");
                break;
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