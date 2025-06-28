package DoctorController;

import DAO.MedicalRecordDAO;
import Model.MedicalRecord;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/doctor-print-medical-record")
public class PrintMedicalRecord extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        
        String id = request.getParameter("id");
        if (id == null || id.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu mã hồ sơ");
            return;
        }

        MedicalRecordDAO dao = new MedicalRecordDAO();
        MedicalRecord record = dao.getMedicalRecordAndServiceAndSymtompById(id);

        if (record == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy hồ sơ");
            return;
        }

        request.setAttribute("record", record);
        request.getRequestDispatcher("/view/doctor/content/PrintMedicalRecord.jsp").forward(request, response);
    }
}
