/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package DoctorController;

import DAO.MedicineDAO;
import DAO.ServiceDAO;
import Model.Medicine;
import Model.Service;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.stream.Collectors;

/**
 *
 * @author ASUS
 */
@WebServlet("/doctor-clinical-diagnosis")
public class DoctorClinicalDiagnosis extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        MedicineDAO mDAO = new MedicineDAO();
        List<Medicine> medicines = mDAO.getAllMedicines();

// Lọc status = 1
        List<Medicine> activeMedicines = medicines.stream()
                .filter(m -> m.getStatus() == 1)
                .collect(Collectors.toList());
        request.setAttribute("medicines", activeMedicines);
        ServiceDAO sdao = new ServiceDAO();
        List<Service> l = sdao.getAllActiveServices();

        String backUrl = request.getParameter("back");
        if (backUrl != null && !backUrl.isEmpty()) {
            request.getSession().setAttribute("backUrl", backUrl);
        }

        String tab = request.getParameter("tab");
        request.setAttribute("activeTab", tab); // truyền sang JSP

        request.setAttribute("services", l);
        request.getRequestDispatcher("view/doctor/content/DoctorRecordExamination.jsp").forward(request, response);
    }

}
