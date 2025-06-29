package DoctorController;

import DAO.AppointmentSymptomDAO;
import Model.AppointmentSymptom;

import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/api/getappointmentsymptombyid")
public class GetDiagnosisById extends HttpServlet {

    

   

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Nhận ID từ request (dễ dàng truyền qua URL)
        String symptomId = request.getParameter("id");

        // Cấu hình response để trả về JSON
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Lấy chuẩn đoán từ cơ sở dữ liệu
        AppointmentSymptom symptom = new AppointmentSymptomDAO().getDiagnosisById(symptomId);

        JsonObject jsonResponse = new JsonObject();

        if (symptom != null) {
            jsonResponse.addProperty("id", symptom.getId());
            jsonResponse.addProperty("appointmentId", symptom.getAppointmentId());
            jsonResponse.addProperty("symptom", symptom.getSymptom());
            jsonResponse.addProperty("diagnosis", symptom.getDiagnosis());
            jsonResponse.addProperty("note", symptom.getNote());
            jsonResponse.addProperty("createdAt", symptom.getCreated_at().toString());
            jsonResponse.addProperty("status", "success");
        } else {
            jsonResponse.addProperty("message", "Không tìm thấy chuẩn đoán với ID này!");
            jsonResponse.addProperty("status", "error");
        }

        // Trả về kết quả JSON
        out.print(jsonResponse.toString());
        out.flush();
    }
}
