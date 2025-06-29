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
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ViewAppointMent", urlPatterns = {"/customer-viewappointment"})
public class ViewAppointMent extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        User user = (User) session.getAttribute("user");

        String petName = request.getParameter("search");
        String status = request.getParameter("status");
        String fromDateStr = request.getParameter("datefrom");
        String toDateStr = request.getParameter("dateto");
        String pageStr = request.getParameter("page");

        java.util.Date fromDate = null;
        java.util.Date toDate = null;
        int page = 1;
        int pageSize = 5; // Số bản ghi mỗi trang

        try {
            if (fromDateStr != null && !fromDateStr.isEmpty()) {
                fromDate = new java.text.SimpleDateFormat("yyyy-MM-dd").parse(fromDateStr);
            }
            if (toDateStr != null && !toDateStr.isEmpty()) {
                toDate = new java.text.SimpleDateFormat("yyyy-MM-dd").parse(toDateStr);
            }
            if (pageStr != null) {
                page = Integer.parseInt(pageStr);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        AppointmentDAO ad = new AppointmentDAO();

        List<Appointment> list = ad.getAppointmentByCustomer(
                user.getId(),
                petName,
                status,
                fromDate,
                toDate,
                page,
                pageSize
        );

        int totalRecords = ad.countAppointmentByCustomer(user.getId(), petName, status, fromDate, toDate);
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        // Giữ lại dữ liệu filter để hiện lại trên form
        request.setAttribute("appointments", list);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("petName", petName);
        request.setAttribute("status", status);
        request.setAttribute("fromDate", fromDateStr);
        request.setAttribute("toDate", toDateStr);

        request.getRequestDispatcher("view/profile/Appointment.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); // Cho phép form method="post" hoạt động bình thường
    }
}
