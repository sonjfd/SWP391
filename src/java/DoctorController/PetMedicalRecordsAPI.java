package DoctorController;

import DAO.MedicalRecordDAO;
import Model.Doctor;
import Model.MedicalRecord;
import Model.MedicalRecordFile;
import Model.User;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import com.google.gson.JsonSerializer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalTime;
import java.util.List;
import java.time.LocalTime;
import com.google.gson.*;
import java.lang.reflect.Type;

@WebServlet("/api/pet-medical-records")
public class PetMedicalRecordsAPI extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String petId = request.getParameter("petId");
        MedicalRecordDAO medicalRecordDAO = new MedicalRecordDAO();
        List<MedicalRecord> records = medicalRecordDAO.getMedicalRecordsByPetId(petId);

        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            JsonArray jsonRecords = new JsonArray();
            for (MedicalRecord record : records) {
                JsonObject obj = new JsonObject();
                // Thêm thuộc tính của MedicalRecord vào đây, ví dụ:

                obj.addProperty("diagnosis", record.getDiagnosis());
                obj.addProperty("treatment", record.getTreatment()); // Hoặc format ngày nếu cần
                if (record.getReExamDate() != null) {
                    obj.addProperty("reexamdate", record.getReExamDate().toString());
                } else {
                    obj.addProperty("reexamdate", "-");  // Or any other default value
                }
                // Thêm file đính kèm vào record
                JsonArray filesArray = new JsonArray();
                List<MedicalRecordFile> files = record.getFiles(); // Giả sử getFiles() trả về danh sách file
                for (MedicalRecordFile file : files) {
                    JsonObject fileObj = new JsonObject();
                    fileObj.addProperty("fileName", file.getFileName());
                    fileObj.addProperty("fileUrl", file.getFileUrl());
                    filesArray.add(fileObj);
                }
                obj.add("files", filesArray);
                obj.addProperty("createddate", record.getCreatedAt().toString());
                // Hoặc format ngày nếu cần
                // Thêm các thuộc tính khác nếu muốn...
                jsonRecords.add(obj);
            }

            JsonObject jsonResult = new JsonObject();
            jsonResult.add("medicalRecords", jsonRecords);

            out.print(jsonResult.toString());
            out.flush();

        } catch (Exception ex) {
            ex.printStackTrace();
            // Nếu muốn trả về lỗi dạng JSON cũng được
            JsonObject error = new JsonObject();
            error.addProperty("error", "Có lỗi xảy ra");
            out.print(error.toString());
            out.flush();
        }
    }
}
