/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package CommonController;

import Mail.ResetService;
import DAO.RoleDAO;
import DAO.TokenForgetDAO;
import DAO.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import Model.User;
import GoogleLogin.GoogleAccount;
import GoogleLogin.GoogleToken;
import GoogleLogin.TokenForgetPassword;
import Model.Role;
import java.security.MessageDigest;
import java.time.LocalDateTime;
import java.util.UUID;

/**
 *
 * @author Admin
 */
@WebServlet(name = "GoogleLogin", urlPatterns = {"/googleLogin"})
public class GoogleLogin extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String code = request.getParameter("code");
        

        try {
            String accessToken = GoogleToken.getToken(code);
            GoogleAccount acc = GoogleToken.getUserInfo(accessToken);

            if (acc != null && acc.getEmail() != null) {
                UserDAO dao = new UserDAO();
                User user = dao.getUserByEmail(acc.getEmail());

                if (user == null) {
                    user = new User();
                    user.setEmail(acc.getEmail());
                    user.setFullName(acc.getName());
                    user.setAvatar(acc.getAvatar());
                    user.setRole(new RoleDAO().getRoleById(1));
                    user.setStatus(0);
                    dao.insertUser(user);

                    user = dao.getUserByEmail(user.getEmail());
                    sendActivationToken(user);
                    response.sendRedirect("verify-home");
                    return;
                }

                if (user.getStatus() == 0) {
                    sendActivationToken(user);
                    response.sendRedirect("verify-home");
                    return;
                }

                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                response.sendRedirect("homepage");
                return;
            }

            response.sendRedirect("login");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login");
        }
    }

    private void sendActivationToken(User user) {
        ResetService resetService = new ResetService();
        TokenForgetDAO tokenDAO = new TokenForgetDAO();

        String token = resetService.generateToken();
        LocalDateTime expiry = resetService.expireDateTime();

        TokenForgetPassword tokenObj = new TokenForgetPassword(
                user.getId(), false, token, expiry);
        tokenObj.setType("ACTIVATE");
        tokenDAO.insertTokenForget(tokenObj);

        String link = "http://localhost:8080/SWP391/verify?token=" + token;
        resetService.sendEmailLoginGoogle(user.getEmail(), link, user.getFullName());
    }

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
        processRequest(request, response);
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
