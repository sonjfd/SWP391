/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package UserController;

import DAO.AppointmentDAO;
import DAO.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

/**
 *
 * @author Admin
 */
@WebServlet(name = "CancelBooking", urlPatterns = {"/cancelbooking"})
public class CancelBooking extends HttpServlet {

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
            out.println("<title>Servlet CancelBooking</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CancelBooking at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("view/profile/Appointment.jsp").forward(request, response);
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
        String idApp = (String) request.getParameter("id");
        String appDate = request.getParameter("appTime");  // yyyy-MM-dd
        String startTime = request.getParameter("startTime");  // HH:mm
        if (idApp == null) {
            response.sendRedirect("viewappointment");
            return;
        }
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");

        LocalDate appointmentDate = LocalDate.parse(appDate, dateFormatter);
        LocalTime appointmentStartTime = LocalTime.parse(startTime, timeFormatter);

        LocalDateTime appointmentDateTime = LocalDateTime.of(appointmentDate, appointmentStartTime);
        LocalDateTime now = LocalDateTime.now();

        // So sánh thời gian
        Duration duration = Duration.between(now, appointmentDateTime);

        if (duration.toHours() < 1) {
            // Nếu còn dưới 1 tiếng thì báo lỗi
            request.setAttribute("errorMessage", "Chỉ được phép hủy lịch khám trước giờ hẹn ít nhất 1 tiếng.");
            request.getRequestDispatcher("appointment-list.jsp").forward(request, response);
            return;
        }

        AppointmentDAO ad = new AppointmentDAO();
        if (ad.cancelBooking(idApp)) {
            request.getSession().setAttribute("SuccessMessage", "Hủy đặt lịch thành công");
            response.sendRedirect("viewappointment");
        } else {
            request.getSession().setAttribute("FailMessage", "Hủy đặt lịch không thành công");
            response.sendRedirect("viewappointment");
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
