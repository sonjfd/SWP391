package DoctorController;


import DAO.AppointmentSymptomDAO;
import Model.AppointmentSymptom;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
@MultipartConfig
@WebServlet("/doctor-save-edited-diagnosis")
public class SaveEditedDiagnosisAJAX extends HttpServlet {

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Nhận các tham số từ form
        String id = request.getParameter("id");
        String symptom = request.getParameter("symptoms");
        String diagnosis = request.getParameter("preliminaryDiagnosis");
        String note = request.getParameter("note");
        String appointmentId = request.getParameter("appointmentId");

        // Tạo đối tượng AppointmentSymptom từ dữ liệu form
        AppointmentSymptom symptomObj = new AppointmentSymptom();
        symptomObj.setId(id);
        symptomObj.setSymptom(symptom);
        symptomObj.setDiagnosis(diagnosis);
        symptomObj.setNote(note);

        // Cập nhật chuẩn đoán vào cơ sở dữ liệu
        boolean success = new AppointmentSymptomDAO().updateAppointmentSymptom(symptomObj);

        // Cấu hình response để trả về thông báo
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        JsonObject jsonResponse = new JsonObject();

        if (success) {
            jsonResponse.addProperty("message", "Sửa chuẩn đoán thành công!");
            jsonResponse.addProperty("status", "success");
        } else {
            jsonResponse.addProperty("message", "Không thể sửa chuẩn đoán. Vui lòng thử lại!");
            jsonResponse.addProperty("status", "error");
        }

        out.print(jsonResponse.toString());
        out.flush();
    }
}
