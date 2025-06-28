package DoctorController;

import DAO.AppointmentSymptomDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/api/delete-diagnosis")
public class DeleteDiagnosisAJAX extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Cấu hình response trả về JSON
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String action = request.getParameter("action");
        String symptomId = request.getParameter("id");

        if ("delete".equals(action) && symptomId != null && !symptomId.isEmpty()) {
            boolean success = new AppointmentSymptomDAO().deleteAppointmentSymptom(symptomId);

            if (success) {
                response.setStatus(HttpServletResponse.SC_OK);
                out.print("{\"success\": true}");
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                out.print("{\"success\": false}");
            }
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"success\": false, \"message\": \"Invalid request\"}");
        }

        out.flush();
    }
}
