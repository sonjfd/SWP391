/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package CommonController;

import DAO.AppointmentDAO;
import DAO.DoctorDAO;
import DAO.DoctorScheduleDAO;
import Model.Appointment;
import Model.Doctor;
import Model.DoctorSchedule;
import Model.Slot;
import Model.SlotService;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Calendar;
/**
 *
 * @author ASUS
 */
@WebServlet("/homedoctorschedule")
public class HomeDoctorSchedule extends HttpServlet {

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
            out.println("<title>Servlet HomeDoctorSchedule</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomeDoctorSchedule at " + request.getContextPath() + "</h1>");
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
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String doctorId = req.getParameter("doctorId");
        String dateStr = req.getParameter("date");
        Date today = new java.sql.Date(System.currentTimeMillis());

        // Xác định tuần chứa ngày đang xem (có thể là tuần hiện tại, hoặc tuần chứa ngày được chọn)
        Date currentDate = (dateStr != null) ? java.sql.Date.valueOf(dateStr) : today;
        Calendar cal = Calendar.getInstance();
        cal.setTime(currentDate);
        // Đặt về thứ 2 (Monday)
        cal.set(Calendar.DAY_OF_WEEK, cal.getFirstDayOfWeek()); // hoặc cal.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
        Date weekStart = cal.getTime();
        // Đặt về Chủ nhật (Sunday)
        cal.add(Calendar.DATE, 6);
        Date weekEnd = cal.getTime();

        DoctorScheduleDAO dsDao = new DoctorScheduleDAO();
        AppointmentDAO apptDao = new AppointmentDAO();
        DoctorDAO doctorDao = new DoctorDAO();
        SlotService slotService = new SlotService();

        Doctor doctor = doctorDao.getDoctorById(doctorId);

        // 1. Danh sách các ngày trong tuần mà bác sĩ có lịch
        List<Date> workDates = dsDao.getAllWorkDatesOfDoctorInWeek(doctorId, weekStart, weekEnd);

        // 2. Danh sách ca làm của ngày đang chọn
        List<DoctorSchedule> dsList = dsDao.getDoctorScheduleByDoctorAndDate(doctorId, currentDate);
        List<Appointment> appointments = apptDao.getAppointmentsByDoctorAndDate(doctorId, currentDate);

        // 3. Sinh slot
        List<Slot> allSlots = new ArrayList<>();
        for (DoctorSchedule ds : dsList) {
            allSlots.addAll(slotService.generateSlots(ds.getShift(), ds.getWorkDate(), appointments, 30));
        }

        req.setAttribute("doctor", doctor);
        req.setAttribute("date", currentDate);
        req.setAttribute("workDates", workDates);
        req.setAttribute("slotList", allSlots);

        req.getRequestDispatcher("/view/view_doctor_schedule.jsp").forward(req, resp);
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
