/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package UserController;

import DAO.AppointmentDAO;
import DAO.DoctorDAO;
import DAO.RatingDAO;
import Model.Appointment;
import Model.Rating;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Admin
 */
@WebServlet(name = "RateService", urlPatterns = {"/customer-rateservice"})
public class RateService extends HttpServlet {

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
            out.println("<title>Servlet RateService</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RateService at " + request.getContextPath() + "</h1>");
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
        String appointmentId = request.getParameter("id");
        int satisfaction = Integer.parseInt(request.getParameter("satisfaction_level"));
        String comment = request.getParameter("comment");
        AppointmentDAO appDAO = new AppointmentDAO();
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        User user = (User) session.getAttribute("user");

        RatingDAO rdao = new RatingDAO();
        Rating existingRating = rdao.getRatingByAppId(appointmentId);

        if (existingRating != null) {
            String rateId = existingRating.getId();
            boolean updated = rdao.updateRating(rateId, satisfaction, comment);
            if (updated) {
                session.setAttribute("SuccessMessage", "Cập nhật đánh giá thành công!");
            } else {
                session.setAttribute("FailMessage", "Cập nhật đánh giá thất bại!");
            }
            response.sendRedirect("customer-viewappointment");
            return;
        }

        Rating rating = new Rating();
        rating.setAppointment(appDAO.getAppointmentById(appointmentId));
        rating.setUser(user);
        rating.setDoctor(appDAO.getAppointmentById(appointmentId).getDoctor());
        rating.setSatisfaction_level(satisfaction);
        rating.setComment(comment);

        boolean rate = rdao.addRating(rating);
        if (rate) {
            session.setAttribute("SuccessMessage", "Đánh giá thành công!");
        } else {
            session.setAttribute("FailMessage", "Đánh giá thất bại!");
        }
        response.sendRedirect("customer-viewappointment");
    }

}
