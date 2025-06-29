package AminController;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;

@WebServlet("/image-loader/*")
public class ImageLoaderServlet extends HttpServlet {

    // Đường dẫn thư mục ảnh
    private final String imageBasePath = "C:/MyUploads/avatars";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        // Lấy tên file bỏ dấu "/"
        String filename = request.getPathInfo();
        if (filename == null || filename.equals("/")) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu tên file.");
            return;
        }

        filename = filename.substring(1); // Bỏ dấu "/" đầu tiên

        File file = new File(imageBasePath, filename);

        if (!file.exists()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy file.");
            return;
        }

        // Gửi đúng loại MIME
        response.setContentType(getServletContext().getMimeType(file.getName()));

        // Gửi file ra trình duyệt
        try (FileInputStream in = new FileInputStream(file);
             OutputStream out = response.getOutputStream()) {
            byte[] buffer = new byte[4096];
            int length;
            while ((length = in.read(buffer)) > 0) {
                out.write(buffer, 0, length);
            }
        }
    }
}
