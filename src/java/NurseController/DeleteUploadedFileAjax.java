package NurseController;

import DAO.FileUploadedDAO;
import Model.UploadedFile;
import java.io.File;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/nurse-deleteuploadedfileajax")
public class DeleteUploadedFileAjax extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        boolean success = false;
        String fileId = request.getParameter("id");

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            if (fileId != null) {
                FileUploadedDAO dao = new FileUploadedDAO();
                
                // Lấy thông tin file trước khi xóa
                UploadedFile file = dao.getById(fileId);
                
                if (file != null) {
                    // Xóa record trong DB
                    success = dao.deleteById(fileId);

                    if (success) {
                        // Đường dẫn folder chứa file
                        String uploadDirPath = "C:/MyUploads/avatars";

                        // Tách lấy tên file từ file_url
                        String fileName = file.getFile_url().substring(file.getFile_url().lastIndexOf("/") + 1);

                        // Tạo đối tượng File
                        File physicalFile = new File(uploadDirPath, fileName);

                        // Xóa file vật lý nếu tồn tại
                        if (physicalFile.exists()) {
                            physicalFile.delete();
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.getWriter().write("{\"success\":" + success + "}");
    }
}
