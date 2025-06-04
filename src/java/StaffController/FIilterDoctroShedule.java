/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package StaffController;

import DAO.StaffDAO;
import Model.DoctorSchedule;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author Dell
 */
public class FIilterDoctroShedule extends HttpServlet {

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
            out.println("<title>Servlet FIilterDoctroShedule</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet FIilterDoctroShedule at " + request.getContextPath() + "</h1>");
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
        StaffDAO sdao = new StaffDAO();
        String doctorId = request.getParameter("doctorId");
        String monthStr = request.getParameter("month");
        String shiftIdStr = request.getParameter("shiftId");

        Integer month = null;
        Integer shiftId = null;

        try {
            if (monthStr != null && !monthStr.isEmpty()) {
                month = Integer.parseInt(monthStr);
            }
            if (shiftIdStr != null && !shiftIdStr.isEmpty()) {
                shiftId = Integer.parseInt(shiftIdStr);
            }
        } catch (NumberFormatException e) {
            System.out.println(e);

        }
        List<DoctorSchedule> list = sdao.filterDoctorSchedules(doctorId, month, shiftId);
        request.setAttribute("listshedules", list);
        request.setAttribute("doctorId", doctorId);
        request.setAttribute("month", month);
        request.setAttribute("shiftId", shiftId);
        request.setAttribute("shiftList", sdao.getAllShift());
        request.setAttribute("doctorList", sdao.getAllDoctors());
        request.getRequestDispatcher("/view/staff/content/ListDoctorSchedule.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
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
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
