/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package CommonController;

import Mail.ResetService;
import DAO.TokenForgetDAO;
import DAO.UserDAO;
import GoogleLogin.PasswordUtils;
import GoogleLogin.TokenForgetPassword;
import Model.User;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDateTime;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ResetPassword", urlPatterns = {"/resetPassword"})
public class ResetPassword extends HttpServlet {

      TokenForgetDAO tokenDAO = new TokenForgetDAO();
    UserDAO userDAO = new UserDAO();

   @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String token = request.getParameter("token");
        HttpSession session = request.getSession();
        if(token != null) {
            TokenForgetPassword tokenForgetPassword = tokenDAO.getTokenPassword(token);
            ResetService service = new ResetService();
            if(tokenForgetPassword == null) {
                request.setAttribute("mess", "token invalid");
                request.getRequestDispatcher("view/home/content/RequestPassword.jsp").forward(request, response);
                return;
            }
            if(tokenForgetPassword.isIsUsed()) {
                request.setAttribute("mess", "token is used");
                request.getRequestDispatcher("view/home/content/RequestPassword.jsp").forward(request, response);
                return;
            }
            if(service.isExpireTime(tokenForgetPassword.getExpiryTime())) {
                request.setAttribute("mess", "token is expiry time");
                request.getRequestDispatcher("view/home/content/RequestPassword.jsp").forward(request, response);
                return;
            }
            User user = userDAO.getUserById(tokenForgetPassword.getUserId());
            request.setAttribute("email", user.getEmail());
            session.setAttribute("token", tokenForgetPassword.getToken());
            request.getRequestDispatcher("view/home/content/ResetPassword.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("view/home/content/RequestPassword.jsp").forward(request, response);
        }
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
   @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    HttpSession session = request.getSession();

    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String repassword = request.getParameter("repassword");
    String tokenStr = (String) session.getAttribute("token");

    // ⚠️ Validate dữ liệu đầu vào
    if (email == null || password == null || repassword == null || tokenStr == null) {
        request.setAttribute("mess", "Thiếu thông tin cần thiết để đặt lại mật khẩu.");
        request.getRequestDispatcher("view/home/content/ResetPassword.jsp").forward(request, response);
        return;
    }

    if (!password.equals(repassword)) {
        request.setAttribute("mess", "Mật khẩu xác nhận không khớp.");
        request.setAttribute("email", email);
        request.getRequestDispatcher("view/home/content/ResetPassword.jsp").forward(request, response);
        return;
    }

    // ✅ Lấy token từ DB để kiểm tra tính hợp lệ
    TokenForgetDAO tokenDAO = new TokenForgetDAO();
    TokenForgetPassword tokenData = tokenDAO.getTokenPassword(tokenStr);

    if (tokenData == null || tokenData.isIsUsed() || tokenData.getExpiryTime().isBefore(LocalDateTime.now())) {
        request.setAttribute("mess", "Liên kết đặt lại mật khẩu không hợp lệ hoặc đã hết hạn.");
        request.setAttribute("email", email);
        request.getRequestDispatcher("view/home/content/ResetPassword.jsp").forward(request, response);
        return;
    }

    // ✅ Mã hóa mật khẩu mới (nếu có dùng hashing)
    String hashedPassword = PasswordUtils.hashPassword(password);

    // ✅ Cập nhật mật khẩu người dùng
    UserDAO userDAO = new UserDAO();
    User user = new User();
    user.setEmail(email);
    user.setPassword(hashedPassword);

    boolean updated = userDAO.updatePassword(user);
    if (!updated) {
        request.setAttribute("mess", "Không tìm thấy người dùng với email này.");
        request.setAttribute("email", email);
        request.getRequestDispatcher("view/home/content/ResetPassword.jsp").forward(request, response);
        return;
    }

    // ✅ Đánh dấu token đã sử dụng
    tokenData.setIsUsed(true);
    tokenDAO.updateStatus(tokenData);

    // ✅ Xoá token khỏi session
    session.removeAttribute("token");

    // ✅ Thành công → chuyển hướng login
    request.setAttribute("success", "Đặt lại mật khẩu thành công. Hãy đăng nhập.");
    request.getRequestDispatcher("view/home/content/Login.jsp").forward(request, response);
}

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
