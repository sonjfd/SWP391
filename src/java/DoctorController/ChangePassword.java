/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package DoctorController;

import DAO.UserDAO;

import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author ASUS
 */
@WebServlet("/change-password")
public class ChangePassword extends HttpServlet {

   

    
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String oldPassword = request.getParameter("oldPassword").trim();
        String newPassword = request.getParameter("newPassword");

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {

            response.sendRedirect("login");
            return;
        }
        User user = (User) session.getAttribute("user");
        UserDAO ud = new UserDAO();
        String hashedOldPassword = ud.hashPassword(oldPassword);

        if (!user.getPassword().equals(hashedOldPassword)) {
            request.setAttribute("user", user);
            request.setAttribute("errorOldPass", "Mật khẩu cũ không đúng.");
            request.getRequestDispatcher("view/doctor/content/DoctorProfileSetting.jsp#password").forward(request, response);
            return;
        }

        String hashedNewPassword = ud.hashPassword(newPassword);

        if (ud.updatePassword(user.getId(), hashedNewPassword)) {
            session.setAttribute("SuccessMessage", "Đổi mật khẩu thành công.");

            user.setPassword(hashedNewPassword);
            session.setAttribute("user", user);
            response.sendRedirect("doctor-profile-setting");
        } else {
            request.setAttribute("user", user);
            request.getRequestDispatcher("view/doctor/content/DoctorProfileSetting.jsp").forward(request, response);
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
