package NurseController;

import DAO.FileUploadedDAO;
import DAO.NurseSpecializationResultDAO;
import Model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.nio.file.*;
import java.util.*;

@jakarta.servlet.annotation.MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 10 * 1024 * 1024,
        maxRequestSize = 50 * 1024 * 1024
)
@WebServlet("/nurse-uploadtestresultservice")
public class UploadTestResultServiceAJAX extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession ss = request.getSession();
        User user = (User) ss.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login");
            return;
        }
        boolean success = false;
        request.setCharacterEncoding("UTF-8");

        try {
            // Lấy id phiếu chỉ định và service id từ request
            String appointmentId = request.getParameter("appointmentId");
            String serviceId = request.getParameter("serviceId");
            String nurseId = user.getId();

            // 1. Tạo record nurse_specialization_results, trả về id
            String resultId = new NurseSpecializationResultDAO().insertIfNotExists(appointmentId, nurseId, serviceId);

            // 1. Đường dẫn lưu file ngoài project
            String uploadDirPath = "C:/MyUploads/avatars";
            File uploadDir = new File(uploadDirPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

// 2. Duyệt và xử lý từng file
            Collection<Part> parts = request.getParts();
            for (Part part : parts) {
                if (part.getName().equals("files") && part.getSize() > 0) {

                    // Lấy phần mở rộng của file
                    String fileExtension = part.getSubmittedFileName().substring(part.getSubmittedFileName().lastIndexOf("."));

                    // Tạo tên file ngẫu nhiên
                    String randomFileName = java.util.UUID.randomUUID().toString() + fileExtension;

                    // Ghi file
                    File file = new File(uploadDir, randomFileName);
                    part.write(file.getAbsolutePath());

                    // Đường dẫn lưu vào DB (chỉ lưu tên file hoặc có thể lưu đường dẫn đầy đủ tùy bạn)
                    String fileUrl = request.getContextPath() + "/image-loader/" + randomFileName;

                    // Insert DB
                    new FileUploadedDAO().insert(resultId, fileUrl, part.getSubmittedFileName());
                }
            }

            success = true;
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Trả về JSON cho fetch
        response.setContentType("application/json");
        response.getWriter().write("{\"success\":" + success + "}");
    }
}
