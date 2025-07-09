package NurseController;

import DAO.FileUploadedDAO;
import DAO.NurseSpecializationResultDAO;
import Model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.util.*;

@jakarta.servlet.annotation.MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 10 * 1024 * 1024, // giới hạn 10MB mỗi file
        maxRequestSize = 50 * 1024 * 1024 // tổng request tối đa 50MB
)
@WebServlet("/nurse-uploadtestresultservice")
public class UploadTestResultServiceAJAX extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpSession ss = request.getSession();
        User user = (User) ss.getAttribute("user");

        if (user == null) {
            response.getWriter().write("{\"success\": false, \"message\": \"Phiên làm việc hết hạn. Vui lòng đăng nhập lại.\"}");
            return;
        }

        boolean success = false;
        String message = "Tải file thất bại do lỗi không xác định.";

        request.setCharacterEncoding("UTF-8");

        try {
            String appointmentId = request.getParameter("appointmentId");
            String serviceId = request.getParameter("serviceId");
            String nurseId = user.getId();

            if (appointmentId == null || serviceId == null) {
                response.getWriter().write("{\"success\": false, \"message\": \"Thiếu thông tin phiếu hoặc dịch vụ.\"}");
                return;
            }

            String resultId = new NurseSpecializationResultDAO().insertIfNotExists(appointmentId, nurseId, serviceId);

            String uploadDirPath = "C:/MyUploads/avatars";
            File uploadDir = new File(uploadDirPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            Collection<Part> parts = request.getParts();
            List<Part> fileParts = new ArrayList<>();

            for (Part part : parts) {
                if (part.getName().equals("files") && part.getSize() > 0) {
                    fileParts.add(part);
                }
            }

            // Kiểm tra số lượng file tối đa 5
            if (fileParts.size() > 5) {
                message = "Chỉ được phép upload tối đa 5 file trong một lần.";
                response.getWriter().write(String.format("{\"success\": false, \"message\": \"%s\"}", message));
                return;
            }

            int uploadedCount = 0;

            for (Part part : fileParts) {
                if (part.getSize() > 10 * 1024 * 1024) { // Kiểm tra size từng file
                    message = "File \"" + part.getSubmittedFileName() + "\" vượt quá giới hạn 10MB.";
                    response.getWriter().write(String.format("{\"success\": false, \"message\": \"%s\"}", message));
                    return;
                }

                String fileExtension = part.getSubmittedFileName().substring(part.getSubmittedFileName().lastIndexOf("."));
                String randomFileName = java.util.UUID.randomUUID().toString() + fileExtension;

                File file = new File(uploadDir, randomFileName);
                part.write(file.getAbsolutePath());

                String fileUrl = request.getContextPath() + "/image-loader/" + randomFileName;

                new FileUploadedDAO().insert(resultId, fileUrl, part.getSubmittedFileName());
                uploadedCount++;
            }

            if (uploadedCount > 0) {
                success = true;
                message = "Tải lên thành công " + uploadedCount + " file.";
            } else {
                message = "Không có file nào được tải lên. Vui lòng chọn file hợp lệ.";
            }

        } catch (Exception e) {
            e.printStackTrace();
            message = "Lỗi hệ thống: " + e.getMessage();
        }

        String jsonResponse = String.format("{\"success\": %b, \"message\": \"%s\"}", success, message.replace("\"", "\\\""));
        response.getWriter().write(jsonResponse);
    }
}
