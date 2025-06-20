/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package CommonController;

import DAO.ClinicInfoDAO;
import DAO.DoctorDAO;
import DAO.ServiceDAO;
import Model.ClinicInfo;
import Model.Doctor;
import Model.Service;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.jsp.PageContext;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 *
 * @author ASUS
 */
@WebServlet("/homeaboutus")
public class HomeAboutUs extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
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
            out.println("<title>Servlet ViewAboutUs</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewAboutUs at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ClinicInfo clinicInfo = getClinicInfo();
        List<Service> services = getAllService();
        List<Doctor> activeDoctors = getAllDoctorActive();

        request.setAttribute("clinicInfo", clinicInfo);
        request.setAttribute("services", services);
        request.setAttribute("doctors", activeDoctors);

        request.getRequestDispatcher("view/home/content/AboutUs.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    public ClinicInfo getClinicInfo() {
        ClinicInfo clinicInfo = null;

        try {
            ClinicInfoDAO clinicInfoDAO = new ClinicInfoDAO();
            clinicInfo = clinicInfoDAO.getClinicInfo();  // Lấy thông tin phòng khám từ database
        } catch (Exception e) {
            e.printStackTrace();  // Xử lý lỗi
        }
        return clinicInfo;
        // Đặt thông tin phòng khám vào request để chuyển tới JSP

    }

    public List<Service> getAllService() {
        List<Service> list = new ArrayList<>();
        try {
            ServiceDAO dao = new ServiceDAO();
            list = dao.getAllServices();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Doctor> getAllDoctorActive() {
        // Gọi phương thức getAllDoctors để lấy danh sách tất cả bác sĩ
        DoctorDAO doctorDAO = new DoctorDAO();
        List<Doctor> doctors = doctorDAO.getDoctorLimit(5);

   

        // Lưu danh sách bác sĩ đã lọc vào request attribute
        // Forward request và response đến JSP
        return doctors;
    }
}
