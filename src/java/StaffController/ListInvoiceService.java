/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package StaffController;

import DAO.ClinicInfoDAO;
import DAO.InvoiceServiceDAO;
import Model.ClinicInfo;
import Model.InvoiceService;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Dell
 */
@WebServlet(name = "InvoiceService", urlPatterns = {"/staff-list-invoice-service"})
public class ListInvoiceService extends HttpServlet {

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
            out.println("<title>Servlet InvoiceService</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet InvoiceService at " + request.getContextPath() + "</h1>");
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

        InvoiceServiceDAO dao = new InvoiceServiceDAO();
        ClinicInfoDAO clinicdao = new ClinicInfoDAO();

        String searchDateStr = request.getParameter("searchDate");
        List<InvoiceService> invoices = null;

        try {
            if (searchDateStr != null && !searchDateStr.trim().isEmpty()) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date searchDate = sdf.parse(searchDateStr);
                invoices = dao.getInvoicesByDate(searchDate);
                request.setAttribute("searchDate", searchDateStr); 
                
            }
        } catch (Exception e) {
            e.printStackTrace();
        
        }

        if (invoices == null) {
            invoices = dao.getAllInvoice();
        }
        String pageRaw = request.getParameter("page");
        int page = 1;
        int pageSize = 10;

        try {
            if (pageRaw != null) {
                page = Integer.parseInt(pageRaw);
            }
        } catch (NumberFormatException e) {
            page = 1;
        }

        int totalItems = invoices.size();
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);
        int start = (page - 1) * pageSize;
        int end = Math.min(start + pageSize, totalItems);

        List<InvoiceService> paginatedInvoices = invoices.subList(start, end);

        request.setAttribute("invoices", paginatedInvoices);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("offset", start); 

        ClinicInfo c = clinicdao.getClinicInfo();
        request.setAttribute("ClinicInfo", c);

        request.getRequestDispatcher("view/staff/content/ListInvoices.jsp").forward(request, response);
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
