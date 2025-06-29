/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package NurseController;

import DAO.AppointmentServiceDAO;
import DAO.ServiceDAO;
import Model.AppointmentService;
import Model.Service;
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
 * @author ASUS
 */
@WebServlet("/nurse-list-appointment-service")
public class ListAppointmentService extends HttpServlet {

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
        int page = 1, pageSize = 10;
        try {
            page = Integer.parseInt(request.getParameter("page"));
        } catch (Exception ignored) {
        }
        int offset = (page - 1) * pageSize;
        String petName = request.getParameter("petName");
        String ownerName = request.getParameter("ownerName");
        String serviceId = request.getParameter("serviceId");
        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");

        int[] totalCount = new int[1];
        AppointmentServiceDAO dao = new AppointmentServiceDAO();
        List<AppointmentService> list = dao.getPendingForNurse(
                petName, ownerName, serviceId,
                (fromDate != null && !fromDate.isEmpty()) ? java.sql.Date.valueOf(fromDate) : null,
                (toDate != null && !toDate.isEmpty()) ? java.sql.Date.valueOf(toDate) : null,
                offset, pageSize, totalCount
        );
        int totalPages = (int) Math.ceil((double) totalCount[0] / pageSize);
        List<Service> services = new ServiceDAO().getAllServices();
        
        request.setAttribute("serviceList", services);
        request.setAttribute("list", list);
        request.setAttribute("page", page);
        request.setAttribute("totalPages", totalPages);
        request.getRequestDispatcher("/view/nurse/content/ListAppointmentService.jsp").forward(request, response);

    }

}
