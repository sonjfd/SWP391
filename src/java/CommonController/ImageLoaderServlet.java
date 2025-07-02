package CommonController;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

@WebServlet("/image-loader/*")
public class ImageLoaderServlet extends HttpServlet {

    private final String imageBasePath = "C:/MyUploads/avatars";

    @Override

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String filename = request.getPathInfo(); // /abc.docx
        if (filename == null || filename.equals("/")) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu tên file.");
            return;
        }

        File file = new File(imageBasePath, filename);
        if (!file.exists()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // Xác định MIME
        String mimeType = getServletContext().getMimeType(file.getName());
        if (mimeType == null) {
            mimeType = "application/octet-stream"; // fallback
        }
        response.setContentType(mimeType);

        // Set để trình duyệt cố gắng mở trong tab (không tải ngay)
        response.setHeader("Content-Disposition", "inline; filename=\"" + file.getName() + "\"");

        // Gửi nội dung file
        try (FileInputStream in = new FileInputStream(file); OutputStream out = response.getOutputStream()) {
            in.transferTo(out);
        }
    }
}
