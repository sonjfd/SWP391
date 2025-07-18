/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package StaffController;

import DAO.StaffDAO;
import Model.DoctorSchedule;
import Model.Shift;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.util.List;

/**
 *
 * @author Dell
 */


@WebServlet("/staff-update-work-schedule")
public class UpdateDoctorWorkSchedule extends HttpServlet {

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
            out.println("<title>Servlet UpdateDoctorWorkSchedule</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateDoctorWorkSchedule at " + request.getContextPath() + "</h1>");
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
        int id = Integer.parseInt(request.getParameter("id"));
        DoctorSchedule ds = sdao.getOneDoctorSchedule(id);
        List<Shift> shifts = sdao.getAllShift();
        request.setAttribute("shift", shifts);
        request.setAttribute("DoctorSchedule", ds);
        request.getRequestDispatcher("view/staff/content/UpdateDoctorWorkShedule.jsp").forward(request, response);

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
        StaffDAO sdao = new StaffDAO();

        int id = Integer.parseInt(request.getParameter("schedule_id"));
        Date workDate = Date.valueOf(request.getParameter("work_date"));
        int shiftId = Integer.parseInt(request.getParameter("shift_id"));

        DoctorSchedule ds = sdao.getOneDoctorSchedule(id);
        

        String doctorId = ds.getDoctor().getUser().getId(); 
        boolean isDuplicate = sdao.isDuplicateSchedule(doctorId, workDate, shiftId, id);

        if (isDuplicate) {
            request.setAttribute("error", "Lỗi: Bác sĩ đã có lịch vào ngày và ca này.");
            request.setAttribute("DoctorSchedule", ds);
            request.setAttribute("shift", sdao.getAllShift());
            request.getRequestDispatcher("view/staff/content/UpdateDoctorWorkShedule.jsp").forward(request, response);
            return;
        }

        
        int result = sdao.updateDoctorWorkShedule(id, workDate, shiftId);

        if (result > 0) {
            response.sendRedirect("staff-list-work-schedule?success=2");
        } else {
            request.setAttribute("error", "Cập nhật thất bại. Vui lòng thử lại.");
            request.setAttribute("DoctorSchedule", ds);
            request.setAttribute("shift", sdao.getAllShift());
            request.getRequestDispatcher("view/staff/content/UpdateDoctorWorkShedule.jsp").forward(request, response);
        }
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
