/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package StaffController;

import DAO.AppointmentDAO;
import Mail.SendEmail;
import Model.Appointment;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;

/**
 *
 * @author Dell
 */
@WebServlet(name="ApproveCancelAppointmetn", urlPatterns={"/staff-approve-cancel-appointment"})
public class ApproveCancelAppointmetn extends HttpServlet {
   
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
            out.println("<title>Servlet ApproveCancelAppointmetn</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ApproveCancelAppointmetn at " + request.getContextPath () + "</h1>");
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
      String id=request.getParameter("id");
        AppointmentDAO dao=new AppointmentDAO();
       boolean result= dao.apprpoveBooking(id);
        Appointment appointment=dao.getAppointmentById(id);
        if(result){
            SendEmail send = new SendEmail();
             send.sendEmailAfterCancelBooking(appointment.getUser().getEmail(), appointment.getUser().getFullName(),
                            appointment.getUser().getPhoneNumber(), appointment.getUser().getAddress(),
                            appointment.getPet().getName(), 
                            new SimpleDateFormat("dd/MM/yyyy").format(appointment.getAppointmentDate()),
                            appointment.getStartTime().toString(), appointment.getEndTime().toString());
             response.sendRedirect("staff-list-appointment?success=cancel_success");
        }else {
      
        response.sendRedirect("staff-list-appointment?error=cancel_success");
    }
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
