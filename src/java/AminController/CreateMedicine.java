/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package AminController;

import DAO.MedicineDAO;
import Model.Medicine;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import static org.eclipse.jdt.internal.compiler.parser.Parser.name;

/**
 *
 * @author FPT
 */
@WebServlet(name="CreateMedicine", urlPatterns={"/admin-create-medicine"})
public class CreateMedicine extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CreateMedicine</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CreateMedicine at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        MedicineDAO medicineDAO = new MedicineDAO();
        request.getRequestDispatcher("view/admin/content/CreateMedicine.jsp").forward(request, response);
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
        MedicineDAO medicineDAO = new MedicineDAO();
        try {
            request.setCharacterEncoding("UTF-8");

            String name = request.getParameter("name").trim();
            String description = request.getParameter("description");
            int status = (request.getParameter("status") != null && request.getParameter("status").equals("1")) ? 1 : 0;

            Medicine medicine = new Medicine();
            medicine.setName(name);
            medicine.setDescripton(description);
            medicine.setStatus(status);

            
            if (medicineDAO.isMedicineNameExists(name, null)) {
                request.setAttribute("error", "Tên thuốc đã tồn tại!");
                request.setAttribute("medicine", medicine);
                request.getRequestDispatcher("view/admin/content/CreateMedicine.jsp").forward(request, response);
                return;
            }

            
            boolean success = medicineDAO.addMedicine(medicine);
            List<Medicine> medicineList = medicineDAO.getAllMedicines();
            request.setAttribute("medicineList", medicineList);
            request.setAttribute("message", success ? "Thuốc được thêm thành công!" : "Không thể thêm thuốc!");
            request.getRequestDispatcher("view/admin/content/ListMedicine.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Tạo thuốc thất bại do lỗi hệ thống!");
            List<Medicine> medicineList = medicineDAO.getAllMedicines();
            request.setAttribute("medicineList", medicineList);
            request.getRequestDispatcher("view/admin/content/ListMedicine.jsp").forward(request, response);
        }
            
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
