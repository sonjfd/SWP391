package DoctorController;

import DAO.AppointmentDAO;
import Model.Appointment;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/api/getappointmentdetails")
public class APIAppointmentDetail extends HttpServlet {

    private AppointmentDAO appointmentDAO = new AppointmentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        
        String appointmentId = request.getParameter("id");

        // Lấy danh sách các cuộc hẹn chi tiết của bác sĩ và cuộc hẹn
        List<Appointment> appointments = appointmentDAO.getAppointmentDetailsByDoctorAndAppointment( appointmentId);

        // Cấu hình response để trả về định dạng JSON
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            JsonArray jsonAppointments = new JsonArray();
            for (Appointment appt : appointments) {
                JsonObject appointmentObj = new JsonObject();
                appointmentObj.addProperty("petName", appt.getPet().getName());
                appointmentObj.addProperty("petGender", appt.getPet().getGender());
                appointmentObj.addProperty("petCode", appt.getPet().getPet_code());
                if(appt.getPet().getBirthDate()!=null){
                    appointmentObj.addProperty("petBirth", appt.getPet().getBirthDate().toString());
                }else{
                    appointmentObj.addProperty("petBirth", "-");
                }
                
                appointmentObj.addProperty("petAvatar", appt.getPet().getAvatar());
                appointmentObj.addProperty("petDescription", appt.getPet().getDescription());
                appointmentObj.addProperty("petBreed", appt.getPet().getBreed().getName());
                appointmentObj.addProperty("ownerName", appt.getPet().getUser().getFullName());
                appointmentObj.addProperty("ownerAddress", appt.getPet().getUser().getAddress());
                appointmentObj.addProperty("ownerPhone", appt.getPet().getUser().getPhoneNumber());
                appointmentObj.addProperty("ownerEmail", appt.getPet().getUser().getEmail());
                appointmentObj.addProperty("ownerAvatar", appt.getPet().getUser().getAvatar());
                appointmentObj.addProperty("appointmentNote", appt.getNote());
                appointmentObj.addProperty("appointmentCheckin", appt.getStatus());
                appointmentObj.addProperty("appointmentStatus", appt.getStatus());
                appointmentObj.addProperty("appointmentDate", appt.getAppointmentDate().toString());
                appointmentObj.addProperty("startTime", appt.getStartTime().toString());
                appointmentObj.addProperty("endTime", appt.getEndTime().toString());
                appointmentObj.addProperty("petId", appt.getPet().getId());
                appointmentObj.addProperty("doctorId", appt.getDoctor().getUser().getId());
                
                

                

                // Thêm vào JsonArray
                jsonAppointments.add(appointmentObj);
            }

            JsonObject jsonResult = new JsonObject();
            jsonResult.add("appointments", jsonAppointments);

            // Trả về kết quả JSON
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
