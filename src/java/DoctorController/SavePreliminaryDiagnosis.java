/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package DoctorController;

import DAO.AppointmentSymptomDAO;
import Model.AppointmentSymptom;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.FileWriter;
import java.util.Date;
import java.util.List;

/**
 *
 * @author ASUS
 */
@MultipartConfig
@WebServlet("/doctor-save-preliminary-diagnosis")
public class SavePreliminaryDiagnosis extends HttpServlet {

    

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        // Nhận các tham số từ form
        String appointmentId = request.getParameter("appointmentId");
        String symptom = request.getParameter("symptoms");
        String diagnosis = request.getParameter("preliminaryDiagnosis");
        String note = request.getParameter("note");
        

        // Tạo đối tượng AppointmentSymptom từ dữ liệu form
        AppointmentSymptom symptomObj = new AppointmentSymptom();
        symptomObj.setAppointmentId(appointmentId);
        symptomObj.setSymptom(symptom);
        symptomObj.setDiagnosis(diagnosis);
        symptomObj.setNote(note);
        symptomObj.setCreated_at(new Date());

        // Lưu chuẩn đoán vào cơ sở dữ liệu thông qua DAO
        boolean success = new AppointmentSymptomDAO().addAppointmentSymptom(symptomObj);

        // Cấu hình response để trả về thông báo
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        JsonObject jsonResponse = new JsonObject();

        if (success) {
            jsonResponse.addProperty("message", "Thêm chuẩn đoán thành công!");
            jsonResponse.addProperty("status", "success");
            // Lấy danh sách triệu chứng cập nhật từ cơ sở dữ liệu
            List<AppointmentSymptom> symptomsList = new AppointmentSymptomDAO().getDiagnosisByAppointmentId(appointmentId);

            JsonArray symptomsArray = new JsonArray();
            for (AppointmentSymptom s : symptomsList) {
                JsonObject symptomObj2 = new JsonObject();
                symptomObj2.addProperty("symptom", s.getSymptom());
                symptomObj2.addProperty("diagnosis", s.getDiagnosis());
                symptomObj2.addProperty("note", s.getNote());
                symptomObj2.addProperty("createdAt", s.getCreated_at().toString());
                symptomsArray.add(symptomObj2);
            }

            jsonResponse.add("symptoms", symptomsArray); // Thêm danh sách triệu chứng vào response
        } else {
            jsonResponse.addProperty("message", "Không thể thêm chuẩn đoán. Vui lòng thử lại!");
            jsonResponse.addProperty("status", "error");
        }

        // Trả về kết quả JSON
        out.print(jsonResponse.toString());
        out.flush();
    }

    

}
