/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package StaffController;

import DAO.StaffDAO;
import DAO.UserDAO;

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
 * @author ASUS
 */


@WebServlet("/staff-changepass")
public class StaffChangePass extends HttpServlet {

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
            out.println("<title>Servlet ChangePassword</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ChangePassword at " + request.getContextPath() + "</h1>");
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

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect("login");
            return;
        }

        User staff = (User) session.getAttribute("staff");

        if (staff == null) {
            response.sendRedirect("login");
            return;
        }

        // Nếu đến đây thì staff != null, mới được gọi getId()
        String uuid = staff.getId();

        StaffDAO sdao = new StaffDAO();
        User updatedStaff = sdao.getUserById(uuid);

        session.setAttribute("staff", updatedStaff);
        request.setAttribute("staff", updatedStaff);

        request.getRequestDispatcher("/view/staff/content/StaffProfile.jsp").forward(request, response);
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
        String oldPassword = request.getParameter("oldPassword").trim();
        String newPassword = request.getParameter("newPassword");

        HttpSession session = request.getSession(false);

        // ✅ Đổi từ "user" → "staff"
        if (session == null || session.getAttribute("staff") == null) {
            response.sendRedirect("login");
            return;
        }

        // ✅ Lấy "staff" đúng với session hiện tại
        User staff = (User) session.getAttribute("staff");
        UserDAO ud = new UserDAO();

        String hashedOldPassword = ud.hashPassword(oldPassword);

        if (!staff.getPassword().equals(hashedOldPassword)) {
            request.setAttribute("staff", staff); // ✅ Gửi lại staff, không phải user
            request.setAttribute("errorOldPass", "Mật khẩu cũ không đúng.");
            request.getRequestDispatcher("view/staff/content/StaffProfile.jsp").forward(request, response);
            return;
        }

        String hashedNewPassword = ud.hashPassword(newPassword);

        if (ud.updatePassword(staff.getId(), hashedNewPassword)) {
            staff.setPassword(hashedNewPassword);
            session.setAttribute("staff", staff); // ✅ Cập nhật session staff

            session.setAttribute("SuccessMessage", "Đổi mật khẩu thành công.");
            response.sendRedirect("staff-profile-setting");
        } else {
            request.setAttribute("staff", staff);
            request.getRequestDispatcher("view/staff/content/StaffProfile.jsp").forward(request, response);
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
