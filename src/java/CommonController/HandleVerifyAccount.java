package CommonController;



import DAO.UserDAO;
import Model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet xử lý xác thực tài khoản từ liên kết trong email
 */
@WebServlet(name = "VerifyAccount", urlPatterns = {"/handle-verify-account"})
public class HandleVerifyAccount extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        

        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserByEmail(email);

        

        

        // Cập nhật status = 1 (đã xác thực)
        userDAO.updateUserStatus(user.getId(), 1);

        // Lưu user vào session
        HttpSession session = request.getSession();
        
        session.setAttribute("user", userDAO.getUserById(user.getId()));

        // Chuyển sang trang cập nhật hồ sơ lần đầu
        if(user.getRole().getName().equals("doctor")){
        response.sendRedirect("update-profile-first-time");}
        else{
            response.sendRedirect("homepage");
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
