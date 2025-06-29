package DoctorController;

import DAO.AppointmentDAO;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/doctor-update-status-appointment")
public class UpdateAppointmentStatusAJAX extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        PrintWriter out = resp.getWriter();

        try {
            // Đọc JSON từ body request
            StringBuilder jsonBuffer = new StringBuilder();
            BufferedReader reader = req.getReader();
            String line;
            while ((line = reader.readLine()) != null) {
                jsonBuffer.append(line);
            }

            // Parse JSON dùng Gson
            Gson gson = new Gson();
            JsonObject jsonObject = gson.fromJson(jsonBuffer.toString(), JsonObject.class);

            String appointmentId = jsonObject.get("appointmentId").getAsString();
            String status = jsonObject.get("status").getAsString();

            // Gọi DAO để update trạng thái
            boolean success = new AppointmentDAO().updateStatus(appointmentId, status);

            JsonObject responseJson = new JsonObject();
            if (success) {
                responseJson.addProperty("status", "success");
            } else {
                responseJson.addProperty("status", "error");
                responseJson.addProperty("message", "Cập nhật thất bại");
            }

            out.print(gson.toJson(responseJson));

        } catch (Exception e) {
            e.printStackTrace();
            JsonObject errorJson = new JsonObject();
            errorJson.addProperty("status", "error");
            errorJson.addProperty("message", "Lỗi server: " + e.getMessage());
            out.print(new Gson().toJson(errorJson));
        }
    }
}
