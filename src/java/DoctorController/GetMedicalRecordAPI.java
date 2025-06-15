package DoctorController;

import DAO.MedicalRecordDAO;
import Model.MedicalRecord;
import Model.MedicalRecordFile;
import Model.PrescribedMedicine;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/api/get-medical-records")
public class GetMedicalRecordAPI extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String appointmentId = request.getParameter("appointmentId");

        if (appointmentId == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        // Gọi DAO để lấy danh sách Medical Records theo appointmentId
        MedicalRecordDAO medicalRecordDAO = new MedicalRecordDAO();
        List<MedicalRecord> records = medicalRecordDAO.getMedicalRecordsByAppointmentId(appointmentId);

        // Tạo JSON response
        JsonObject jsonResponse = new JsonObject();
        JsonArray recordsArray = new JsonArray();

        for (MedicalRecord record : records) {
            JsonObject recordObj = new JsonObject();
            recordObj.addProperty("id", record.getId());
            recordObj.addProperty("diagnosis", record.getDiagnosis());
            recordObj.addProperty("treatment", record.getTreatment());
            if(record.getReExamDate()!=null){
            recordObj.addProperty("reExamDate", record.getReExamDate().toString());}
            else{
                            recordObj.addProperty("reExamDate", "");

            }
            recordObj.addProperty("createdAt", record.getCreatedAt().toString());
            recordObj.addProperty("updatedAt", record.getUpdatedAt().toString());

            // Thêm file đính kèm vào record
            JsonArray filesArray = new JsonArray();
            List<MedicalRecordFile> files = record.getFiles(); // Giả sử getFiles() trả về danh sách file
            for (MedicalRecordFile file : files) {
                JsonObject fileObj = new JsonObject();
                fileObj.addProperty("fileName", file.getFileName());
                fileObj.addProperty("fileUrl", file.getFileUrl());
                filesArray.add(fileObj);
            }
            recordObj.add("files", filesArray);

            // Thêm kê đơn thuốc vào record
            JsonArray medicinesArray = new JsonArray();
            List<PrescribedMedicine> prescribedMedicines = record.getPrescribedMedicines(); // Giả sử getPrescribedMedicines() trả về danh sách thuốc kê đơn
            for (PrescribedMedicine medicine : prescribedMedicines) {
                JsonObject medicineObj = new JsonObject();
                medicineObj.addProperty("medicineName", medicine.getMedicineId());
                medicineObj.addProperty("quantity", medicine.getQuantity());
                medicineObj.addProperty("dosage", medicine.getDosage());
                medicineObj.addProperty("duration", medicine.getDuration());
                medicineObj.addProperty("usageInstructions", medicine.getUsageInstructions());
                medicinesArray.add(medicineObj);
            }
            recordObj.add("prescribedMedicines", medicinesArray);

            recordsArray.add(recordObj);
        }

        jsonResponse.add("records", recordsArray);

        // Trả về kết quả dưới dạng JSON
        response.setContentType("application/json");
        response.getWriter().print(jsonResponse.toString());
    }
}
