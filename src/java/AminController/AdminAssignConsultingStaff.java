/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package AminController;

import DAO.ChatDAO;
import DAO.StaffDAO;
import DAO.UserDAO;
import Model.Conversation;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author Admin
 */
@WebServlet(name = "AdminAssignConsultingStaff", urlPatterns = {"/admin-assignconsultingstaff"})
public class AdminAssignConsultingStaff extends HttpServlet {

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
            out.println("<title>Servlet AdminAssignConsultingStaff</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminAssignConsultingStaff at " + request.getContextPath() + "</h1>");
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
        UserDAO ud = new UserDAO();
        ChatDAO cd = new ChatDAO();

        List<User> ulist = ud.getAllStaff();
        String staffAssignId = cd.getCurrentConsultingStaffId(); // lấy từ bảng consulting_staff

        request.setAttribute("STAFFASSIGNID", staffAssignId);
        request.setAttribute("STAFFLIST", ulist);
        request.getRequestDispatcher("view/admin/content/AssignConsultingStaff.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String newStaffId = request.getParameter("staffId");
        ChatDAO cd = new ChatDAO();
        UserDAO ud = new UserDAO();
        String oldStaffId = cd.getCurrentConsultingStaffId();
        boolean isSuccess = cd.assignNewConsultingStaff(newStaffId);
        if (isSuccess && oldStaffId != null) {
            cd.updateNewConsultingStaff(oldStaffId, newStaffId);
        }
        HttpSession session = request.getSession();
        if (isSuccess) {
            session.setAttribute("SuccessMessage", "Chỉ định nhân viên thành công.");
        } else {
            session.setAttribute("FailMessage", "Chỉ định nhân viên không thành công.");
        }
        response.sendRedirect("admin-assignconsultingstaff");
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
