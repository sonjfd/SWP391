package API;


import DAO.FileUploadedDAO;
import Model.UploadedFile;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/api/get-files")
public class GetFilesAPI extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String appointmentId = request.getParameter("appointmentId");
        String serviceId = request.getParameter("serviceId");

        if (appointmentId == null || serviceId == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        // Tìm các tệp liên quan đến appointmentId và serviceId
        FileUploadedDAO uploadedFilesDAO = new FileUploadedDAO();
        List<UploadedFile> files = uploadedFilesDAO.getFilesByAppointmentAndService(appointmentId, serviceId);

        // Tạo JSON response
        JsonObject jsonResponse = new JsonObject();
        JsonArray filesArray = new JsonArray();
        
        for (UploadedFile file : files) {
            JsonObject fileObj = new JsonObject();
            fileObj.addProperty("fileUrl", file.getFile_url());
            fileObj.addProperty("fileName", file.getFile_name());
            filesArray.add(fileObj);
        }

        jsonResponse.add("files", filesArray);

        // Trả về kết quả dưới dạng JSON
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print(jsonResponse.toString());
        out.flush();
    }
}
