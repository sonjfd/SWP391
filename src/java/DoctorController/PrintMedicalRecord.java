package DoctorController;

import DAO.ClinicInfoDAO;
import DAO.MedicalRecordDAO;
import Model.ClinicInfo;
import Model.MedicalRecord;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/doctor-print-medical-record")
public class PrintMedicalRecord extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String id = request.getParameter("id");
            if (id == null || id.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu mã hồ sơ");
                return;
            }

            MedicalRecordDAO dao = new MedicalRecordDAO();
            MedicalRecord record = dao.getMedicalRecordAndServiceAndSymtompById(id);
            ClinicInfo clinicInfo = new ClinicInfoDAO().getClinicInfo();
            if (record == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy hồ sơ");
                return;
            }
            request.setAttribute("clinic", clinicInfo);
            request.setAttribute("record", record);
            request.getRequestDispatcher("/view/doctor/content/PrintMedicalRecord.jsp").forward(request, response);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
