/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package StaffController;

import DAO.StaffDAO;
import Model.Doctor;
import Model.DoctorSchedule;
import Model.Shift;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author Dell
 */
@WebServlet("/staff-list-work-schedule")
public class ListWorkShedule extends HttpServlet {

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
            out.println("<title>Servlet ListWorkShedule</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListWorkShedule at " + request.getContextPath() + "</h1>");
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
            if (monthStr != null && !monthStr.trim().isEmpty()) {
                month = Integer.parseInt(monthStr);
            }
            if (shiftIdStr != null && !shiftIdStr.trim().isEmpty()) {
                shiftId = Integer.parseInt(shiftIdStr);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        List<DoctorSchedule> scheduleList;
        if ((doctorId != null && !doctorId.trim().isEmpty()) || month != null || shiftId != null) {
            scheduleList = sdao.filterDoctorSchedules(doctorId, month, shiftId);
        } else {
            scheduleList = sdao.getAllDoctorSchedule();
        }

        String page_raw = request.getParameter("page");
        int page = (page_raw != null) ? Integer.parseInt(page_raw) : 1;
        int pageSize = 10;
        int totalItems = scheduleList.size();
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);
        int start = (page - 1) * pageSize;
        int end = Math.min(start + pageSize, totalItems);
        List<DoctorSchedule> pagedList = scheduleList.subList(start, end);
        int offset = (page - 1) * pageSize;

        request.setAttribute("listshedules", pagedList);
        request.setAttribute("offset", offset);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        request.setAttribute("doctorId", doctorId);
        request.setAttribute("month", month);
        request.setAttribute("shiftId", shiftId);
        request.setAttribute("shiftList", sdao.getAllShift());
        request.setAttribute("doctorList", sdao.getAllDoctors());

        request.getRequestDispatcher("view/staff/content/ListDoctorSchedule.jsp").forward(request, response);
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
        processRequest(request, response);
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
