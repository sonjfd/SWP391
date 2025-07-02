/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package DoctorController;

import DAO.MedicalRecordDAO;
import DAO.MedicineDAO;
import Model.MedicalRecordFile;
import Model.Medicine;
import Model.PrescribedMedicine;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

/**
 *
 * @author ASUS
 */

@WebServlet("/doctor-add-medical-record")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1MB
        maxFileSize = 1024 * 1024 * 10, // 10MB/file
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class AddMedicalRecordAJAX extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    response.setContentType("application/json; charset=UTF-8");
    PrintWriter out = response.getWriter();

    try {
        // 1. Lấy thông tin cơ bản
        String appointmentId = request.getParameter("appointmentId");
        String diagnosis = request.getParameter("diagnosis");
        String treatment = request.getParameter("treatment");
        String reExamDateStr = request.getParameter("reExamDate");
        java.sql.Date reExamDate = null;
        if (reExamDateStr != null && !reExamDateStr.isEmpty()) {
            reExamDate = java.sql.Date.valueOf(reExamDateStr);
        }
        String doctorId = request.getParameter("doctorId");
        String petId = request.getParameter("petId");

        MedicalRecordDAO medicalRecordDAO = new MedicalRecordDAO();
        boolean hasMedicalRecord = medicalRecordDAO.checkExistingMedicalRecordForAppointment(appointmentId);

        if (hasMedicalRecord) {
            out.write("{\"status\":\"error\", \"message\":\"Cuộc hẹn đã có hồ sơ y tế, không thể thêm mới.\"}");
            return;
        }

        // 2. Lấy danh sách thuốc kê đơn từ form
        List<PrescribedMedicine> prescribedList = new ArrayList<>();
        String[] medIds = request.getParameterValues("medicineId");
        String[] quantities = request.getParameterValues("medicineQuantity");
        String[] dosages = request.getParameterValues("medicineDosage");
        String[] durations = request.getParameterValues("medicineDuration");
        String[] usageInstructions = request.getParameterValues("medicineInstructions");

        if (medIds != null) {
            for (int i = 0; i < medIds.length; i++) {
                if (medIds[i] == null || medIds[i].trim().isEmpty()) continue;
                PrescribedMedicine pm = new PrescribedMedicine();
                pm.setMedicineId(medIds[i]);
                pm.setQuantity(Integer.parseInt(quantities[i]));
                pm.setDosage(dosages[i]);
                pm.setDuration(durations[i]);
                pm.setUsageInstructions(usageInstructions[i]);
                prescribedList.add(pm);
            }
        }

        // 3. Xử lý file upload (nếu có)
        List<MedicalRecordFile> files = new ArrayList<>();
        if (request.getContentType() != null && request.getContentType().toLowerCase().startsWith("multipart/")) {
            Collection<Part> fileParts = request.getParts();
            // Thư mục lưu ngoài project
    String uploadDirPath = "C:/MyUploads/medical";
    File uploadDir = new File(uploadDirPath);
    if (!uploadDir.exists()) {
        uploadDir.mkdirs();
    }
            for (Part part : fileParts) {
                if ("files".equals(part.getName()) && part.getSize() > 0) {
                    // Lấy phần mở rộng của file
            String originalFileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
            String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
            String randomFileName = java.util.UUID.randomUUID().toString() + fileExtension;

            // Ghi file ra ổ cứng
            File savedFile = new File(uploadDir, randomFileName);
            part.write(savedFile.getAbsolutePath());


                    MedicalRecordFile uf = new MedicalRecordFile();
                    uf.setFileName(originalFileName);
                    uf.setFileUrl(request.getContextPath()+"/file-loader/" + randomFileName); 
                    uf.setUploadedAt(new java.util.Date());
                    files.add(uf);
                }
            }
        }

        // 4. Gọi DAO thực hiện transaction
        boolean ok = false;
        try {
            ok = medicalRecordDAO.createFullMedicalRecord(
                    appointmentId, doctorId, petId,
                    diagnosis, treatment, reExamDate,
                    prescribedList, files
            );
        } catch (Exception e) {
            e.printStackTrace();
            out.write("{\"status\":\"error\", \"message\":\"Có lỗi khi lưu dữ liệu!\"}");
            return;
        }

        if (ok) {
            out.write("{\"status\":\"success\", \"message\":\"Thêm hồ sơ y tế thành công!\"}");
        } else {
            out.write("{\"status\":\"error\", \"message\":\"Có lỗi xảy ra, vui lòng thử lại!\"}");
        }
    } catch (Exception ex) {
        ex.printStackTrace();
        out.write("{\"status\":\"error\", \"message\":\"Hệ thống gặp lỗi không xác định!\"}");
    }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
