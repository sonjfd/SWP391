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
    String yearParam = request.getParameter("year");
    String weekParam = request.getParameter("week");

    // Xử lý giá trị năm và tuần nếu thiếu
    LocalDate now = LocalDate.now();
    int year = (yearParam == null || yearParam.isEmpty()) ? now.getYear() : Integer.parseInt(yearParam);
    int week = (weekParam == null || weekParam.isEmpty())
            ? now.get(WeekFields.ISO.weekOfYear())
            : Integer.parseInt(weekParam);

    // Lấy ngày thứ Hai đầu tuần theo chuẩn ISO
    LocalDate startOfWeek = LocalDate.now()
            .withYear(year)
            .with(WeekFields.ISO.weekOfYear(), week)
            .with(WeekFields.ISO.dayOfWeek(), 1); // 1 = Monday
    LocalDate endOfWeek = startOfWeek.plusDays(6); // Chủ nhật

    // Convert sang java.util.Date để gọi DAO
    Date startOfWeekDate = Date.from(startOfWeek.atStartOfDay(ZoneId.systemDefault()).toInstant());
    Date endOfWeekDate = Date.from(endOfWeek.atStartOfDay(ZoneId.systemDefault()).toInstant());

    // Lấy danh sách các cuộc hẹn trong tuần của bác sĩ
    List<Appointment> appointments = appointmentDAO.getAppointmentsByWeek(doctorId, startOfWeekDate, endOfWeekDate);

    // Lấy tất cả các ca làm việc
    List<Shift> shifts = shiftDAO.getAllShifts();

    // Tạo danh sách các slot thời gian 30 phút
    List<String> timeSlots = new ArrayList<>();
    for (Shift shift : shifts) {
        LocalTime startTime = shift.getStart_time();
        LocalTime endTime = shift.getEnd_time();
        while (startTime.isBefore(endTime)) {
            timeSlots.add(startTime.toString() + " - " + startTime.plusMinutes(30).toString());
            startTime = startTime.plusMinutes(30);
        }
    }

    // Tạo danh sách 7 ngày trong tuần (thứ hai đến chủ nhật)
    List<String> weekDates = new ArrayList<>();
    for (int i = 0; i < 7; i++) {
        weekDates.add(startOfWeek.plusDays(i).toString()); // yyyy-MM-dd
    }

    // Trả về JSON
    response.setContentType("application/json;charset=UTF-8");
    PrintWriter out = response.getWriter();

    try {
        JsonObject jsonResult = new JsonObject();
        JsonArray jsonAppointments = new JsonArray();

        for (Appointment appt : appointments) {
            JsonObject appointmentObj = new JsonObject();
            appointmentObj.addProperty("petName", appt.getPet().getName());
            appointmentObj.addProperty("petGender", appt.getPet().getGender());
            appointmentObj.addProperty("petCode", appt.getPet().getPet_code());
            appointmentObj.addProperty("petBirth", 
                appt.getPet().getBirthDate() != null ? appt.getPet().getBirthDate().toString() : "-");
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
