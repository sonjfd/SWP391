/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package StaffController;

import DAO.AppointmentDAO;
import DAO.StaffDAO;
import Mail.SendEmail;
import Model.Appointment;
import Model.Doctor;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.time.LocalTime;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Dell
 */
@WebServlet(name = "UpdateAppointment", urlPatterns = {"/update-appointment"})
public class UpdateAppointment extends HttpServlet {

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
            out.println("<title>Servlet UpdateAppointment</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateAppointment at " + request.getContextPath() + "</h1>");
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
        StaffDAO sdao = new StaffDAO();
        String id = request.getParameter("id");
        List<Doctor> doctors = sdao.getAllDoctors();
        request.setAttribute("doctors", doctors);
        AppointmentDAO adao = new AppointmentDAO();
        Appointment appointment = adao.getAppointmentById(id);
        request.setAttribute("appointment", appointment);
        request.getRequestDispatcher("view/staff/content/UpdateAppointment.jsp").forward(request, response);

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
        request.setCharacterEncoding("UTF-8");
        AppointmentDAO adao = new AppointmentDAO();
        String id = request.getParameter("id");
        String doctorId = request.getParameter("doctor");
        String appointmentDateStr = request.getParameter("appointmentTime");
        String startTimeStr = request.getParameter("startTime");
        String endTimeStr = request.getParameter("endTime");
        String status = request.getParameter("status");
        String paymentStatus = request.getParameter("paymentStatus");

        try {

            Appointment appointment = adao.getAppointmentById(id);

            if (appointmentDateStr == null || appointmentDateStr.isEmpty()) {
                appointmentDateStr = new SimpleDateFormat("yyyy-MM-dd").format(appointment.getAppointmentDate());
            }
            if (startTimeStr == null || startTimeStr.isEmpty()) {
                startTimeStr = appointment.getStartTime().toString();
            }
            if (endTimeStr == null || endTimeStr.isEmpty()) {
                endTimeStr = appointment.getEndTime().toString();
            }
            if (doctorId == null || doctorId.isEmpty()) {
                doctorId = appointment.getDoctor().getUser().getId();
            }
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date appointmentDate = sdf.parse(appointmentDateStr);
            appointment.setAppointmentDate(appointmentDate);
            appointment.setStartTime(LocalTime.parse(startTimeStr));
            appointment.setEndTime(LocalTime.parse(endTimeStr));

            Doctor doctor = new Doctor();
            User doctorUser = new User();
            doctorUser.setId(doctorId);
            doctor.setUser(doctorUser);
            appointment.setDoctor(doctor);

            appointment.setStatus(status);
            appointment.setPaymentStatus(paymentStatus);

            boolean updated = adao.updateAppointment(appointment);

            if (updated) {
                response.sendRedirect("list-appointment?success=update_success");
            } else {
                request.setAttribute("error", "Cập nhật thất bại");
                request.getRequestDispatcher("view/staff/content/UpdateAppointment.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
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
