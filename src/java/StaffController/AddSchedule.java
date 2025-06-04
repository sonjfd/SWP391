
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package StaffController;



import DAO.StaffDAO;
import Model.Doctor;
import Model.ScheduleTemplate;
import Model.Shift;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 *
 * @author Dell
 */
public class AddSchedule extends HttpServlet {

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
            out.println("<title>Servlet AddSchedule</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddSchedule at " + request.getContextPath() + "</h1>");
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
        // lấy ra danh sách doctor
        StaffDAO sdao = new StaffDAO();
        List<Doctor> doctors = sdao.getAllDoctors();
        request.setAttribute("doctors", doctors);

        //lấy ra danh sách ca làm việc
        
        List<Shift> shifts = sdao.getAllShift();
        request.setAttribute("shifts", shifts);

        request.getRequestDispatcher("view/staff/content/AddDoctorWorkSchedule.jsp").forward(request, response);

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

          StaffDAO sdao = new StaffDAO();

        try {
            String doctorId = request.getParameter("doctor_id");
            int shiftId = Integer.parseInt(request.getParameter("shift_id"));
            String[] dayOfWeeks = request.getParameterValues("day_of_week");
            String[] months = request.getParameterValues("months");

            Shift shift = sdao.getShiftByID(shiftId);

            boolean allDuplicate = true;

            for (String dayStr : dayOfWeeks) {
                int day = Integer.parseInt(dayStr);

                if (sdao.isDuplicateWeeklySchedule(doctorId, day, shiftId)) {
                    continue;
                }

                int insert = sdao.AddWeeklySchedule(doctorId, day, shift);
                if (insert> 0) {
                    allDuplicate = false;
                }
            }

            if (allDuplicate) {
                String errorMessage = "Tất cả lịch mẫu bạn chọn đã tồn tại ";
                List<Shift> shifts = sdao.getAllShift();
                List<Doctor> doctors = new StaffDAO().getAllDoctors();
                request.setAttribute("shifts", shifts);
                request.setAttribute("doctors", doctors);
                request.setAttribute("error", errorMessage);
                request.getRequestDispatcher("view/staff/content/AddDoctorWorkSchedule.jsp").forward(request, response);
                return;
            }

            for (String monthStr : months) {
                int month = Integer.parseInt(monthStr);
                sdao.generateMonthlySchedule(month, doctorId);
            }

            response.sendRedirect("list-work-schedule?success=1");

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
