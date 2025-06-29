/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package AminController;

import DAO.AdminDao;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author FPT
 */
@WebServlet("/admin-update-status")
public class UpdateStatus extends HttpServlet {
   
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
            out.println("<title>Servlet UpdateStatus</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateStatus at " + request.getContextPath () + "</h1>");
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
        processRequest(request, response);
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
        // Lấy id và status
        String id = request.getParameter("id");
        String statusStr = request.getParameter("status");
        int status;
        
        
        try {
            status = Integer.parseInt(statusStr);
            
        } catch (Exception e) {
            // Đặt thông báo lỗi
            request.setAttribute("message", "Invalid status!");
            request.setAttribute("messageType", "error");
            // Lấy danh sách tài khoản
            AdminDao adminDAO = new AdminDao();
            List<User> users = adminDAO.getAllAccounts();
            request.setAttribute("users", users);
            // Forward về listAccounts.jsp
            request.getRequestDispatcher("view/admin/content/ListAccount.jsp").forward(request, response);
            return;
        }

        // Cập nhật status
        AdminDao adminDAO = new AdminDao();
        boolean success = adminDAO.updateStatus(id, status);

        // Đặt thông báo
        request.setAttribute("message", success ? "Status updated!" : "Failed to update status!");
        request.setAttribute("messageType", success ? "success" : "error");

        // Lấy danh sách tài khoản mới
        List<User> users = adminDAO.getAllAccounts();
        request.setAttribute("users", users);

        // Forward về listAccounts.jsp
        request.getRequestDispatcher("view/admin/content/ListAccount.jsp").forward(request, response);
        
    
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
