/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package StaffController;

import DAO.AppointmentDAO;
import DAO.StaffDAO;
import Model.Appointment;
import Model.Doctor;
import Model.ExaminationPrice;
import Model.Shift;
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
 * @author Dell
 */
@WebServlet(name = "FilterAppointment", urlPatterns = {"/filter-appoinment"})
public class FilterAppointment extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet FilterAppointment</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet FilterAppointment at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
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
        String slotIdStr = request.getParameter("slot");
        String dateStr = request.getParameter("date");
        String doctorId = request.getParameter("doctor");
        AppointmentDAO appointmentDAO = new AppointmentDAO();
        ExaminationPrice price=appointmentDAO.getExaminationPrice();
        request.setAttribute("ExaminationPrice", price);
        StaffDAO staffDAO = new StaffDAO();
        List<Shift> shifts = staffDAO.getAllShift();
        List<Doctor> doctors = staffDAO.getAllDoctors();
        int slotId = -1;
        java.sql.Date appointmentDate = null;

   
        if (slotIdStr != null && !slotIdStr.trim().isEmpty()) {
            try {
                slotId = Integer.parseInt(slotIdStr);
            } catch (NumberFormatException e) {
                slotId = -1;
            }
        }

       
        if (dateStr != null && !dateStr.trim().isEmpty()) {
            try {
                appointmentDate = java.sql.Date.valueOf(dateStr);
            } catch (IllegalArgumentException e) {
                appointmentDate = null;
            }
        }
        List<Appointment> filteredAppointments = appointmentDAO.filterAppointments(slotId, appointmentDate, doctorId);
        request.setAttribute("appointments", filteredAppointments);
        request.setAttribute("shifts", shifts);
        request.setAttribute("doctors", doctors);

        request.setAttribute("selectedSlot", slotIdStr);
        request.setAttribute("selectedDate", dateStr);
        request.setAttribute("selectedDoctor", doctorId);

        request.getRequestDispatcher("view/staff/content/ListAppointment.jsp").forward(request, response);
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
