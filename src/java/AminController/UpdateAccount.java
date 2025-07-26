/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package AminController;

import DAO.AdminDao;

import DAO.RoleDAO;
import Model.Department;
import Model.Doctor;
import Model.Role;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.List;
import java.sql.SQLException;

/**
 *
 * @author FPT
 */
@WebServlet("/admin-update-account")
public class UpdateAccount extends HttpServlet {
    private final AdminDao dao = new AdminDao();
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet UpdateAccount</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateAccount at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String id = request.getParameter("id");
        User user = dao.getUserById(id);
        List<Department> departments = dao.getAllDepartments();

        request.setAttribute("user", user);
        request.setAttribute("departments", departments);
        request.getRequestDispatcher("view/admin/content/UpdateAccount.jsp").forward(request, response);
        
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String id = request.getParameter("id");
        String username = request.getParameter("userName");
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phoneNumber");
        String roleIdStr = request.getParameter("role_id");
        String departmentIdStr = request.getParameter("department_id");

        // Kiểm tra role_id
        int roleId;
        try {
            roleId = roleIdStr != null && !roleIdStr.isEmpty() ? Integer.parseInt(roleIdStr) : 0;
        } catch (NumberFormatException e) {
            roleId = 0;
        }
        if (roleId != 3 && roleId != 4 && roleId != 5) {
            request.setAttribute("message", "Vai trò không hợp lệ");
            forwardToForm(request, response, id, username, email, fullName, phone, roleId);
            return;
        }

        // Kiểm tra trùng username và email
        User currentUser = dao.getUserById(id);
        if (!username.equals(currentUser.getUserName()) && dao.isUsernameTaken(username)) {
            request.setAttribute("usernameError", "Tên đăng nhập đã tồn tại");
            forwardToForm(request, response, id, username, email, fullName, phone, roleId);
            return;
        }
        if (!email.equals(currentUser.getEmail()) && dao.isEmailTaken(email)) {
            request.setAttribute("emailError", "Email đã tồn tại");
            forwardToForm(request, response, id, username, email, fullName, phone, roleId);
            return;
        }

        // Kiểm tra department_id
        Integer departmentId = null;
        if (roleId == 5 && departmentIdStr != null && !departmentIdStr.isEmpty()) {
            try {
                departmentId = Integer.parseInt(departmentIdStr);
            } catch (NumberFormatException e) {
                request.setAttribute("message", "Phòng ban không hợp lệ");
                forwardToForm(request, response, id, username, email, fullName, phone, roleId);
                return;
            }
        } else if (roleId == 5) {
            request.setAttribute("message", "Vui lòng chọn phòng ban cho Y tá");
            forwardToForm(request, response, id, username, email, fullName, phone, roleId);
            return;
        }

        User user = new User();
        user.setId(id);
        user.setUserName(username);
        user.setEmail(email);
        user.setFullName(fullName);
        user.setPhoneNumber(phone);
        Role role = new Role();
        role.setId(roleId);
        user.setRole(role);

        boolean success = dao.updateAccount(user, departmentId);
        if (success) {
            request.getSession().setAttribute("message", "Cập nhật tài khoản thành công");
            response.sendRedirect("admin-list-account");
        } else {
            request.setAttribute("message", "Cập nhật thất bại");
            forwardToForm(request, response, id, username, email, fullName, phone, roleId);
        }
    }

    private void forwardToForm(HttpServletRequest request, HttpServletResponse response, 
                               String id, String username, String email, String fullName, 
                               String phone, int roleId) 
            throws ServletException, IOException {
        User user = new User();
        user.setId(id);
        user.setUserName(username);
        user.setEmail(email);
        user.setFullName(fullName);
        user.setPhoneNumber(phone);
        Role role = new Role();
        role.setId(roleId);
        user.setRole(role);

        request.setAttribute("user", user);
        request.setAttribute("departments", dao.getAllDepartments());
        request.getRequestDispatcher("view/admin/content/UpdateAccount.jsp").forward(request, response);
    }
    

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
