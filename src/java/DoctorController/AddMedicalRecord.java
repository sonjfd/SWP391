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
@WebServlet("/add-medical-record")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1MB
        maxFileSize = 1024 * 1024 * 10, // 10MB/file
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class AddMedicalRecord extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        MedicineDAO mDAO = new MedicineDAO();
        List<Medicine> medicines = mDAO.getAllMedicines();

// Lọc status = 1
        List<Medicine> activeMedicines = medicines.stream()
                .filter(m -> m.getStatus() == 1)
                .collect(Collectors.toList());
        request.setAttribute("medicines", activeMedicines);

        request.getRequestDispatcher("/view/doctor/content/AddMedicalRecord.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // 1. Lấy thông tin cơ bản
        String appointmentId = request.getParameter("appointmentId");
        String diagnosis = request.getParameter("diagnosis");
        String treatment = request.getParameter("treatment");
        String reExamDateStr = request.getParameter("reExamDate");
        java.sql.Date reExamDate = null;
        if (reExamDateStr != null && !reExamDateStr.isEmpty()) {
            reExamDate = java.sql.Date.valueOf(reExamDateStr);
        }

        // Lấy doctorId, petId theo appointmentId (có thể phải query DB hoặc gửi lên từ client)
        String doctorId = request.getParameter("doctorId");
        String petId = request.getParameter("petId");
        MedicalRecordDAO medicalRecordDAO = new MedicalRecordDAO();
        boolean hasMedicalRecord = medicalRecordDAO.checkExistingMedicalRecordForAppointment(appointmentId);

        if (hasMedicalRecord) {
            request.setAttribute("errorMessage", "Cuộc hẹn đã có hồ sơ y tế, không thể thêm mới.");
            request.getRequestDispatcher("/view/doctor/content/AddMedicalRecord.jsp").forward(request, response);
            return; // Dừng lại ở đây nếu đã có hồ sơ
        }
        // TODO: Truy vấn DB lấy doctorId, petId từ appointmentId (tùy hệ thống bạn)
        // Ví dụ: AppointmentDAO.getAppointmentById(appointmentId);
        // 2. Lấy danh sách thuốc kê đơn từ form
        List<PrescribedMedicine> prescribedList = new ArrayList<>();
        String[] medIds = request.getParameterValues("medicineId");
        String[] quantities = request.getParameterValues("medicineQuantity");
        String[] dosages = request.getParameterValues("medicineDosage");
        String[] durations = request.getParameterValues("medicineDuration");
        String[] usageInstructions = request.getParameterValues("medicineInstructions");

        if (medIds != null) {
            for (int i = 0; i < medIds.length; i++) {
                if (medIds[i] == null || medIds[i].trim().isEmpty()) {
                    continue;
                }
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
            for (Part part : fileParts) {
                if ("files".equals(part.getName()) && part.getSize() > 0) {
                    // Lưu file vào thư mục server
                    String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    String uploadDir = getServletContext().getRealPath("/uploads/medical/");
                    File uploadFolder = new File(uploadDir);
                    if (!uploadFolder.exists()) {
                        uploadFolder.mkdirs();
                    }
                    String filePath = uploadDir + File.separator + fileName;
                    part.write(filePath);

                    MedicalRecordFile uf = new MedicalRecordFile();
                    uf.setFileName(fileName);
                    uf.setFileUrl("uploads/medical/" + fileName);
                    uf.setUploadedAt(new java.util.Date());
                    files.add(uf);
                }
            }
        }

        // 4. Gọi DAO thực hiện transaction
        MedicalRecordDAO dao = new MedicalRecordDAO();
        boolean ok = false;
        try {
            ok = dao.createFullMedicalRecord(
                    appointmentId, doctorId, petId,
                    diagnosis, treatment, reExamDate,
                    prescribedList, files
            );
        } catch (Exception e) {
            e.printStackTrace();
        }

        // 5. Chuyển hướng hoặc trả về kết quả
        if (ok) {
            // Thêm thành công
            request.getSession().setAttribute("message", "Thêm hồ sơ y tế thành công!");
            response.sendRedirect("add-medical-record?appointmentId=" + appointmentId);
        } else {
            // Lỗi
            request.setAttribute("errorMessage", "Có lỗi xảy ra, vui lòng thử lại!");
            request.getRequestDispatcher("/view/doctor/content/AddMedicalRecord.jsp").forward(request, response);
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
