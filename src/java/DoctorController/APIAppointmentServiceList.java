package DoctorController;

import DAO.AppointmentServiceDAO;
import Model.AppointmentService;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/api/get-appointment-service-list")
public class APIAppointmentServiceList extends HttpServlet {

    private AppointmentServiceDAO apsDAO = new AppointmentServiceDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String appointmentId = request.getParameter("appointmentId");

        List<AppointmentService> services = apsDAO.getAppointmentServicesByAppointmentId(appointmentId);

        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        JsonObject json = new JsonObject();
        JsonArray arr = new JsonArray();

        for (AppointmentService aps : services) {
            JsonObject o = new JsonObject();
            o.addProperty("id", aps.getId());
            o.addProperty("serid", aps.getService().getId());
            o.addProperty("serviceName", aps.getService().getName());
            o.addProperty("price", aps.getPrice());
            o.addProperty("status", aps.getStatus());
            arr.add(o);
        }

        json.add("services", arr);

        out.print(json.toString());
        out.flush();
    }
}
