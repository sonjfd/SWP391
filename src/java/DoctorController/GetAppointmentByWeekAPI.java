package DoctorController;

import DAO.AppointmentDAO;
import DAO.ShiftDAO;
import Model.Appointment;
import Model.Shift;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.ZoneId;
import java.time.temporal.WeekFields;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@WebServlet("/api/getappointmentbyweek")
public class GetAppointmentByWeekAPI extends HttpServlet {

    private AppointmentDAO appointmentDAO = new AppointmentDAO();
    private ShiftDAO shiftDAO = new ShiftDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String doctorId = request.getParameter("doctorId");
        String year = request.getParameter("year");
        String week = request.getParameter("week");

        if (year == null || year.isEmpty()) {
            year = String.valueOf(LocalDate.now().getYear());
        }

        if (week == null || week.isEmpty()) {
            week = String.valueOf(LocalDate.now().get(WeekFields.ISO.weekOfYear()));
        }

        int weekNumber = Integer.parseInt(week);
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.YEAR, Integer.parseInt(year));
        calendar.set(Calendar.WEEK_OF_YEAR, weekNumber);
        calendar.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY); // Lấy ngày thứ hai trong tuần

        // Tính toán ngày thứ Hai của tuần hiện tại
        Date startOfWeek = calendar.getTime();
        calendar.add(Calendar.DAY_OF_WEEK, 6); // Lấy ngày Chủ Nhật
        Date endOfWeek = calendar.getTime();

        // Lấy danh sách các cuộc hẹn của bác sĩ trong tuần
        List<Appointment> appointments = appointmentDAO.getAppointmentsByWeek(doctorId, startOfWeek, endOfWeek);

        // Lấy tất cả các ca làm việc (shifts)
        List<Shift> shifts = shiftDAO.getAllShifts();

        // Tạo danh sách các slot thời gian 30 phút cho mỗi ca
        List<String> timeSlots = new ArrayList<>();
        for (Shift shift : shifts) {
            LocalTime startTime = shift.getStart_time();
            LocalTime endTime = shift.getEnd_time();
            while (startTime.isBefore(endTime)) {
                timeSlots.add(startTime.toString() + " - " + startTime.plusMinutes(30).toString());
                startTime = startTime.plusMinutes(30);
            }
        }

        // Tạo danh sách các ngày trong tuần từ thứ hai đến chủ nhật
        List<Date> weekDates = new ArrayList<>();
        for (int i = 0; i < 7; i++) {
            LocalDate day = LocalDate.from(startOfWeek.toInstant().atZone(ZoneId.systemDefault()).toLocalDate()).plusDays(i);
            Date utilDate = Date.from(day.atStartOfDay(ZoneId.systemDefault()).toInstant());
            weekDates.add(utilDate);
        }

        // Trả về kết quả dưới dạng JSON
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            JsonObject jsonResult = new JsonObject();
            JsonArray jsonAppointments = new JsonArray();

            // Lặp qua danh sách cuộc hẹn để thêm vào JSON
            for (Appointment appt : appointments) {
                JsonObject appointmentObj = new JsonObject();
                appointmentObj.addProperty("petName", appt.getPet().getName());
                appointmentObj.addProperty("petGender", appt.getPet().getGender());
                appointmentObj.addProperty("petCode", appt.getPet().getPet_code());
                if (appt.getPet().getBirthDate() != null) {
                    appointmentObj.addProperty("petBirth", appt.getPet().getBirthDate().toString());
                } else {
                    appointmentObj.addProperty("petBirth", "-");
                }
                appointmentObj.addProperty("petId", appt.getPet().getId());
                appointmentObj.addProperty("doctorId", appt.getDoctor().getUser().getId());
                
                appointmentObj.addProperty("petAvatar", appt.getPet().getAvatar());
                appointmentObj.addProperty("petDescription", appt.getPet().getDescription());
                appointmentObj.addProperty("petBreed", appt.getPet().getBreed().getName());
                appointmentObj.addProperty("ownerName", appt.getPet().getUser().getFullName());
                appointmentObj.addProperty("ownerAddress", appt.getPet().getUser().getAddress());
                appointmentObj.addProperty("ownerPhone", appt.getPet().getUser().getPhoneNumber());
                appointmentObj.addProperty("ownerEmail", appt.getPet().getUser().getEmail());
                appointmentObj.addProperty("ownerAvatar", appt.getPet().getUser().getAvatar());
                appointmentObj.addProperty("appointmentNote", appt.getNote());
                appointmentObj.addProperty("appointmentCheckin", appt.getChekinStatus());
                appointmentObj.addProperty("appointmentStatus", appt.getStatus());
                appointmentObj.addProperty("appointmentDate", appt.getAppointmentDate().toString());
                appointmentObj.addProperty("startTime", appt.getStartTime().toString());
                appointmentObj.addProperty("endTime", appt.getEndTime().toString());
                appointmentObj.addProperty("id", appt.getId());
                jsonAppointments.add(appointmentObj);
            }

            // Thêm các danh sách vào JSON response
            jsonResult.add("appointments", jsonAppointments);
            jsonResult.add("timeSlots", new Gson().toJsonTree(timeSlots));
            jsonResult.add("weekDates", new Gson().toJsonTree(weekDates));

            out.print(jsonResult.toString());
            out.flush();

        } catch (Exception e) {
            e.printStackTrace();
            JsonObject error = new JsonObject();
            error.addProperty("error", "Có lỗi xảy ra");
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print(error.toString());
            out.flush();
        }
    }
}
