/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package NurseController;

import DAO.AppointmentServiceDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Dell
 */
@WebServlet(name="UpdateStatusService", urlPatterns={"/nurse-update-status-appointment-service"})
public class UpdateStatusService extends HttpServlet {
   
    

    
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
        
          String id = request.getParameter("id");
        String status = request.getParameter("status");
        boolean success = false;
        if (id != null && status != null) {
            AppointmentServiceDAO dao = new AppointmentServiceDAO();
            success = dao.updateStatus(id, status);
        }
        response.setContentType("application/json");
        response.getWriter().write("{\"success\": " + success + "}");
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
