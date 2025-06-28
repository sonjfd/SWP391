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
@WebServlet("/doctor-time-table")
public class DoctorTimeTable extends HttpServlet {

   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        // Lấy thông tin người dùng (bác sĩ) từ session
        HttpSession ss = request.getSession();
        User u = (User) ss.getAttribute("user");

        if (u == null) {
            response.sendRedirect("/login"); // Nếu không có người dùng trong session, chuyển hướng về trang đăng nhập
            return;
        }

        // Lấy thông tin bác sĩ
        String doctorId = u.getId();
        
        // Lấy tuần hiện tại hoặc truyền từ client (nếu có)
        LocalDate today = LocalDate.now();
        LocalDate monday = today.with(DayOfWeek.MONDAY);  // Ngày thứ 2 trong tuần
        LocalDate sunday = monday.plusDays(6);  // Ngày chủ nhật trong tuần

        // Chuyển đổi sang kiểu Date
        Date from = java.sql.Date.valueOf(monday);
        Date to = java.sql.Date.valueOf(sunday);

        // Tạo danh sách các ngày trong tuần để hiển thị
        List<Date> weekDates = new ArrayList<>();
        for (int i = 0; i < 7; i++) {
            LocalDate day = monday.plusDays(i);
            Date utilDate = Date.from(day.atStartOfDay(ZoneId.systemDefault()).toInstant());
            weekDates.add(utilDate);
        }

        // Set dữ liệu vào request để JSP có thể sử dụng
        request.setAttribute("weekDates", weekDates);

        // Lấy lịch làm việc của bác sĩ trong tuần
        DoctorScheduleDAO dao = new DoctorScheduleDAO();
//        List<DoctorSchedule> schedules = dao.getDoctorSchedulesOfDoctorInWeek(doctorId, from, to);

        // Lấy tất cả các ca làm việc (shift)
        ShiftDAO shiftDAO = new ShiftDAO();
        List<Shift> shiftList = shiftDAO.getAllShifts();

        // Set dữ liệu lịch làm việc và ca vào request
//        request.setAttribute("schedules", schedules);
        request.setAttribute("shiftList", shiftList);

        // Chuyển tiếp (forward) đến trang JSP để hiển thị
        request.getRequestDispatcher("/view/doctor/content/DoctorTimeTable.jsp").forward(request, response);
    }

    

}
