package DoctorController;

import DAO.AppointmentServiceDAO;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
//CÓ DÙng
@WebServlet("/update-status-appointment-service")
public class UpdateStatusAppointmentServiceServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
         String appointmentServiceId = request.getParameter("id");
        String status = request.getParameter("status");

        // Kiểm tra tham số
        if (appointmentServiceId == null || status == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // Lỗi 400 nếu thiếu tham số
            return;
        }

        // Cập nhật trạng thái
        AppointmentServiceDAO appointmentServiceDAO = new AppointmentServiceDAO();
        boolean updated = appointmentServiceDAO.updateStatus(appointmentServiceId, status);

        // Kiểm tra kết quả cập nhật
        // Đoạn này trong doGet
if (updated) {
    response.setContentType("application/json");
    PrintWriter out = response.getWriter();
    JsonObject json = new JsonObject();
    json.addProperty("success", true);
    out.print(json.toString());
    out.flush();
} else {
    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
    PrintWriter out = response.getWriter();
    JsonObject json = new JsonObject();
    json.addProperty("success", false);
    out.print(json.toString());
    out.flush();
}
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
          
    }
}
