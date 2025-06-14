/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package CommonController;

import Mail.ResetService;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author ASUS
 */

@WebServlet("/verifylogin")
public class VerifyLogin extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet VerifyLogin</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet VerifyLogin at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // Lấy thông tin người dùng từ session
        User user = (User) request.getSession().getAttribute("user");

        if (user != null && user.getStatus() == 0) {
            // Tạo đường dẫn xác thực
            String contextPath = request.getRequestURL().toString().replace(request.getRequestURI(), request.getContextPath());
            String verifyLink = contextPath + "/handle-verify-account?email=" + user.getEmail();  // Hoặc token nếu bạn dùng xác thực qua token

            // Gửi mail
            boolean sent = new ResetService().sendEmailVerifyAccount(user.getEmail(), verifyLink, user.getFullName());

            if (sent) {
                request.setAttribute("message", "Chúng tôi đã gửi lại email xác thực đến " + user.getEmail());
            } else {
                request.setAttribute("message", "Không thể gửi email xác thực. Vui lòng thử lại sau.");
            }

            request.setAttribute("resendEmail", true);
            request.setAttribute("email", user.getEmail());
        } else {
            request.setAttribute("message", "Không tìm thấy tài khoản cần xác thực.");
        }

        // Forward sang trang xác thực
        request.getRequestDispatcher("/view/home/content/VerifyHome.jsp").forward(request, response);
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
        processRequest(request, response);
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
