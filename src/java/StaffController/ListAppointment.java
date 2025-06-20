/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package StaffController;

import DAO.AppointmentDAO;
import DAO.ClinicInfoDAO;
import DAO.StaffDAO;
import Model.Appointment;
import Model.ClinicInfo;
import Model.Doctor;
import Model.ExaminationPrice;
import Model.Shift;
import Model.Slot;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Dell
 */
@WebServlet(name = "ListAppointment", urlPatterns = {"/staff-list-appointment"})
public class ListAppointment extends HttpServlet {

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
            out.println("<title>Servlet ListAppointment</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListAppointment at " + request.getContextPath() + "</h1>");
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
        StaffDAO staffDAO = new StaffDAO();
        ExaminationPrice price = appointmentDAO.getExaminationPrice();
        request.setAttribute("ExaminationPrice", price);
        ClinicInfoDAO clinicdao = new ClinicInfoDAO();
        ClinicInfo clinic = clinicdao.getClinicInfo();
        request.setAttribute("ClinicInfo", clinic);
        List<Shift> shifts = staffDAO.getAllShift();
        List<Doctor> doctors = staffDAO.getAllDoctors();
        request.setAttribute("shifts", shifts);
        request.setAttribute("doctors", doctors);    
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

        List<Appointment> allAppointments;
        if ((slotIdStr != null && !slotIdStr.isEmpty())
                || (dateStr != null && !dateStr.isEmpty())
                || (doctorId != null && !doctorId.isEmpty())) {
            allAppointments = appointmentDAO.filterAppointments(slotId, appointmentDate, doctorId);
        } else {
            allAppointments = appointmentDAO.getAllAppointment();
        }

        String page_raw = request.getParameter("page");
        int page = (page_raw != null) ? Integer.parseInt(page_raw) : 1;
        int pageSize = 10;
        int totalItems = allAppointments.size();
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);
        int start = (page - 1) * pageSize;
        int end = Math.min(start + pageSize, totalItems);
        int offset = (page - 1) * pageSize;
        List<Appointment> appointmentsPage = allAppointments.subList(start, end);
        request.setAttribute("appointments", appointmentsPage);
        request.setAttribute("offset", offset);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

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
