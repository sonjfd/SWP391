/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package DoctorController;

import DAO.AppointmentDAO;
import DAO.DoctorScheduleDAO;
import DAO.MedicalRecordDAO;
import DAO.ShiftDAO;
import Model.Appointment;
import Model.Doctor;

import Model.DoctorSchedule;
import Model.MedicalRecord;
import Model.Shift;
import Model.User;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ASUS
 */
@WebServlet("/doctor-schedule")
public class DoctorScheduleCalendar extends HttpServlet {

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
            out.println("<title>Servlet test</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet test at " + request.getContextPath() + "</h1>");
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
        HttpSession ss = request.getSession();
        User u = (User) ss.getAttribute("user");

        String doctorId = u.getId();

        int offset = 0;
        String offsetParam = request.getParameter("offset");
        if (offsetParam != null) {
            try {
                offset = Integer.parseInt(offsetParam);
            } catch (NumberFormatException e) {
                offset = 0;
            }
        }
        // Lấy tuần hiện tại hoặc truyền từ client
        LocalDate today = LocalDate.now().plusWeeks(offset);
        LocalDate monday = today.with(DayOfWeek.MONDAY);
        LocalDate sunday = monday.plusDays(6);

        Date from = java.sql.Date.valueOf(monday);
        Date to = java.sql.Date.valueOf(sunday);
        List<Date> weekDates = new ArrayList<>();
        for (int i = 0; i < 7; i++) {
            LocalDate day = monday.plusDays(i);
            Date utilDate = Date.from(day.atStartOfDay(ZoneId.systemDefault()).toInstant());
            weekDates.add(utilDate);
        }

        request.setAttribute("weekDates", weekDates);

        DoctorScheduleDAO dao = new DoctorScheduleDAO();
        List<DoctorSchedule> schedules = dao.getDoctorSchedulesOfDoctorInWeek(doctorId, from, to);

        // Lấy tất cả các ca (shift) để làm dòng cho bảng
        ShiftDAO shiftDAO = new ShiftDAO();
        List<Shift> shiftList = shiftDAO.getAllShifts();

        request.setAttribute("schedules", schedules);
        request.setAttribute("shiftList", shiftList);
        request.getRequestDispatcher("/view/doctor/content/DoctorSchedule.jsp").forward(request, response);
    }

}
