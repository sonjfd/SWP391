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
        request.setAttribute("services", l);
        request.getRequestDispatcher("view/doctor/content/DoctorRecordExamination.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
