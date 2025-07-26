/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package AminController;

import DAO.ReportDAO;
import Model.DashboardSummary;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.List;
import java.time.format.DateTimeParseException;

/**
 *
 * @author FPT
 */
@WebServlet(name = "Dashboard", urlPatterns = {"/admin-dashboard"})
public class Dashboard extends HttpServlet {
    private ReportDAO reportDAO;
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
            out.println("<title>Servlet Dashboard</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Dashboard at " + request.getContextPath() + "</h1>");
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
        reportDAO = new ReportDAO();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate today = LocalDate.now(); 
        LocalDate defaultStart = today.minusDays(30); 
        LocalDate defaultEnd = today; 

        // Lấy tham số từ form hoặc dùng mặc định
        String startDateParam = request.getParameter("startDate");
        String endDateParam = request.getParameter("endDate");
        String periodTypeParam = request.getParameter("periodType");

        // Validate và parse ngày
        String startDate;
        String endDate;
        try {
            startDate = (startDateParam != null) ? LocalDate.parse(startDateParam, formatter).toString() : defaultStart.toString();
            endDate = (endDateParam != null) ? LocalDate.parse(endDateParam, formatter).toString() : defaultEnd.toString();
        } catch (DateTimeParseException e) {
            startDate = defaultStart.toString();
            endDate = defaultEnd.toString();
        }

        // Validate periodType
        String periodType = (periodTypeParam != null && Arrays.asList("day", "month", "year").contains(periodTypeParam)) ? periodTypeParam : "day";

        // Kiểm tra logic startDate <= endDate
        if (LocalDate.parse(startDate).isAfter(LocalDate.parse(endDate))) {
            String temp = startDate;
            startDate = endDate;
            endDate = temp;
        }

        // Truyền các tham số vào request để JSP sử dụng
        request.setAttribute("startDate", startDate);
        request.setAttribute("endDate", endDate);
        request.setAttribute("periodType", periodType);

        // Gọi DAO
        try {
            DashboardSummary summary = reportDAO.getDashboardSummary(startDate, endDate, periodType);
            request.setAttribute("summary", summary);
            request.getRequestDispatcher("view/admin/content/Dashboard.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    

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
