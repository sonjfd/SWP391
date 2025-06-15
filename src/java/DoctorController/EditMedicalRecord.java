package DoctorController;

import DAO.MedicalRecordDAO;
import DAO.MedicineDAO;
import Model.MedicalRecord;
import Model.MedicalRecordFile;
import Model.Medicine;
import Model.PrescribedMedicine;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.util.Arrays;
import java.util.stream.Collectors;

@WebServlet("/edit-medical-record")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1MB
        maxFileSize = 1024 * 1024 * 10, // 10MB/file
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class EditMedicalRecord extends HttpServlet {

    // Xử lý GET - Hiển thị form sửa hồ sơ y tế
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String medicalRecordId = request.getParameter("id");

        if (medicalRecordId == null || medicalRecordId.isEmpty()) {
            response.sendRedirect("error.jsp");
            return;
        }

        // Lấy dữ liệu hồ sơ từ DB
        MedicalRecordDAO medicalRecordDAO = new MedicalRecordDAO();
        MedicalRecord medicalRecord = medicalRecordDAO.getMedicalRecordById(medicalRecordId);

        if (medicalRecord == null) {
            response.sendRedirect("error.jsp");
            return;
        }

        // Lấy danh sách thuốc kê đơn của hồ sơ này
        List<PrescribedMedicine> prescribedMedicines = medicalRecord.getPrescribedMedicines();
        MedicineDAO mDAO = new MedicineDAO();
        List<Medicine> medicines = mDAO.getAllMedicines();

// Lọc status = 1
        List<Medicine> activeMedicines = medicines.stream()
                .filter(m -> m.getStatus() == 1)
                .collect(Collectors.toList());
        request.setAttribute("medicines", activeMedicines);
        // Đưa dữ liệu vào request
        request.setAttribute("medicalRecord", medicalRecord);
        request.setAttribute("prescribedMedicines", prescribedMedicines);

        // Forward đến trang sửa hồ sơ
        request.getRequestDispatcher("/view/doctor/content/EditMedicalRecord.jsp").forward(request, response);
    }

    // Xử lý POST - Cập nhật hồ sơ y tế
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // Lấy thông tin từ form
        String medicalRecordId = request.getParameter("medicalRecordId");
        String diagnosis = request.getParameter("diagnosis");
        String treatment = request.getParameter("treatment");
        String reExamDateStr = request.getParameter("reExamDate");
        java.sql.Date reExamDate = null;
        if (reExamDateStr != null && !reExamDateStr.isEmpty()) {
            reExamDate = java.sql.Date.valueOf(reExamDateStr);
        }

        String doctorId = request.getParameter("doctorId");
        String petId = request.getParameter("petId");

        // Lấy danh sách thuốc kê đơn từ form
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

        // Xử lý file upload (nếu có)
        // 2. Lấy các file đã upload (cả file đã chọn và file mới)
        List<MedicalRecordFile> files = new ArrayList<>();
        List<String> removeFiles = new ArrayList<>();
        String[] fileIdsToRemove = request.getParameterValues("removeFiles");

        if (fileIdsToRemove != null) {
            removeFiles = Arrays.asList(fileIdsToRemove);
        }

        // Lưu trữ các file đã upload từ client
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

                    // Tạo đối tượng MedicalRecordFile để lưu vào cơ sở dữ liệu
                    MedicalRecordFile uf = new MedicalRecordFile();
                    uf.setFileName(fileName);
                    uf.setFileUrl("uploads/medical/" + fileName);
                    uf.setUploadedAt(new java.util.Date());
                    files.add(uf);
                }
            }
        }


        // Cập nhật thông tin hồ sơ và file đính kèm
        MedicalRecordDAO medicalRecordDAO = new MedicalRecordDAO();
        boolean updateSuccess = false;

        try {
            // Cập nhật hồ sơ y tế và file mới (nếu có)
            updateSuccess = medicalRecordDAO.updateMedicalRecordWithFiles(
                        medicalRecordId, diagnosis, treatment, reExamDate, prescribedList, files, removeFiles
                );
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Kiểm tra kết quả cập nhật
        if (updateSuccess) {
            request.getSession().setAttribute("message", "Cập nhật hồ sơ y tế thành công!");
            response.sendRedirect("edit-medical-record?id=" + medicalRecordId);
        } else {
            // Nếu có lỗi, hiển thị thông báo lỗi
            request.setAttribute("errorMessage", "Có lỗi xảy ra, vui lòng thử lại!");
            request.getRequestDispatcher("/view/doctor/content/EditMedicalRecord.jsp").forward(request, response);
        }
    }
}
