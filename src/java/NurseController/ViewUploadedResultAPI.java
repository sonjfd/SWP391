package NurseController;

import DAO.FileUploadedDAO;
import Model.UploadedFile;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.util.*;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import jakarta.servlet.annotation.WebServlet;
@WebServlet("/nurse-viewuploadedresultapi")
public class ViewUploadedResultAPI extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        String appointmentId = request.getParameter("appointmentId");
        String serviceId = request.getParameter("serviceId");
        List<UploadedFile> files = new FileUploadedDAO().getByAppointmentAndServiceId(appointmentId,serviceId);

        JsonArray arr = new JsonArray();
        for (UploadedFile f : files) {
            JsonObject obj = new JsonObject();
            obj.addProperty("id", f.getId());
        obj.addProperty("file_name", f.getFile_name());
        obj.addProperty("file_url", f.getFile_url());
        obj.addProperty("uploader_name", f.getUploaderName()); // JOIN users fullName hoặc nurse/doctor
        obj.addProperty("uploaded_at_fmt", new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(f.getUploaded_at()));
            arr.add(obj);
        }
        response.setContentType("application/json");
        response.getWriter().write("{\"files\":"+ arr.toString() + "}");
    }
}
