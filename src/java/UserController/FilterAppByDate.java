/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package UserController;

import DAO.AppointmentDAO;
import Model.Appointment;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.security.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
@WebServlet(name = "FilterAppByDate", urlPatterns = {"/filterappbydate"})
public class FilterAppByDate extends HttpServlet {

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
            out.println("<title>Servlet FilterAppByDate</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet FilterAppByDate at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("view/profile/Appointment.jsp").forward(request, response);
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
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        String id = user.getId();

        String dateFromStr = request.getParameter("datefrom");
        String dateToStr = request.getParameter("dateto");

        Date dateFrom = null;
        Date dateTo = null;
        SimpleDateFormat dailo = new SimpleDateFormat("yyyy-MM-dd");
        if (dateFromStr != null && !dateFromStr.isEmpty()) {
            try {
                dateFrom = dailo.parse(dateFromStr);
            } catch (ParseException ex) {
                Logger.getLogger(FilterAppByDate.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
         if (dateToStr != null && !dateToStr.isEmpty()) {
            try {
                dateTo = dailo.parse(dateToStr);
            } catch (ParseException ex) {
                Logger.getLogger(FilterAppByDate.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        AppointmentDAO dao = new AppointmentDAO();
        List<Appointment> list = dao.getAppointmentByDate(id, dateFrom, dateTo);
         if (list.isEmpty()) {
            request.setAttribute("Message", "Không tìm thấy lịch hẹn tương ứng!");
        }
        request.setAttribute("appointments", list);
        
        request.getRequestDispatcher("view/profile/Appointment.jsp").forward(request, response);
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
