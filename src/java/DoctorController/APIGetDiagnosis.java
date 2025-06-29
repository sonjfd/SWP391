package DoctorController;

import DAO.AppointmentSymptomDAO;
import Model.AppointmentSymptom;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.List;

@WebServlet("/api/getdiagnosis")
public class APIGetDiagnosis extends HttpServlet {

    private AppointmentSymptomDAO appointmentSymptomDAO = new AppointmentSymptomDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String appointmentId = request.getParameter("appointmentId");

        // Lấy danh sách chuẩn đoán theo appointmentId
        List<AppointmentSymptom> symptoms = appointmentSymptomDAO.getDiagnosisByAppointmentId(appointmentId);

        // Cấu hình response để trả về định dạng JSON
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            JsonArray jsonSymptoms = new JsonArray();
            for (AppointmentSymptom symptom : symptoms) {
                JsonObject symptomObj = new JsonObject();
                
                symptomObj.addProperty("symptom", symptom.getSymptom());
                symptomObj.addProperty("id", symptom.getId());
                symptomObj.addProperty("diagnosis", symptom.getDiagnosis());
                symptomObj.addProperty("note", symptom.getNote());
                symptomObj.addProperty("createdAt", symptom.getCreated_at().toString());

                // Thêm vào JsonArray
                jsonSymptoms.add(symptomObj);
            }

            JsonObject jsonResult = new JsonObject();
            jsonResult.add("symptoms", jsonSymptoms);

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
