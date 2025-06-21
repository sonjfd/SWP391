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
        if(user==null){
            response.sendRedirect("login");
            return;
        }
         boolean success = false;
    request.setCharacterEncoding("UTF-8");

    try {
        // Lấy id phiếu chỉ định và service id từ request
        String appointmentId = request.getParameter("appointmentId");
        String serviceId = request.getParameter("serviceId");
        String nurseId = ("ACACEB00-2C9E-4731-A668-05C88D95FBEF");

        // 1. Tạo record nurse_specialization_results, trả về id
        String resultId = new NurseSpecializationResultDAO().insertIfNotExists(appointmentId, nurseId, serviceId);
        

        // 2. Lưu file và insert vào uploaded_files
        String uploadDir = getServletContext().getRealPath("/uploads/test-results/");
        File dir = new File(uploadDir);
        if (!dir.exists()) dir.mkdirs();

        Collection<Part> parts = request.getParts();
        for (Part part : parts) {
            if (part.getName().equals("files") && part.getSize() > 0) {
                String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                String safeFileName = UUID.randomUUID() + "_" + fileName;
                File file = new File(dir, safeFileName);
                part.write(file.getAbsolutePath());
                String fileUrl = request.getContextPath() + "/uploads/test-results/" + safeFileName;
                // Insert DB
                new FileUploadedDAO().insert(resultId, fileUrl, fileName);
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
