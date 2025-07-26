/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package AminController;

import DAO.AdminDao;
import DAO.DepartmentDAO;
import static GoogleLogin.PasswordUtils.hashPassword;
import Model.Department;
import Model.Doctor;
import Model.Nurse;
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

/**
 *
 * @author FPT
 */
@WebServlet("/admin-create-account")
public class CreateAccount extends HttpServlet {

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
            out.println("<title>Servlet CreateAccount</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CreateAccount at " + request.getContextPath() + "</h1>");
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
        DepartmentDAO departmentDAO = new DepartmentDAO();
        List<Department> departments = departmentDAO.getAllDepartments();
        request.setAttribute("departments", departments);
        request.getRequestDispatcher("view/admin/content/CreateAccount.jsp").forward(request, response);
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

        int roleId;
        try {
            roleId = Integer.parseInt(request.getParameter("role_id"));
            if (roleId != 3 && roleId != 5 && roleId != 4) {
                request.setAttribute("message", "Vui lòng chọn vai trò hợp lệ.");
                request.setAttribute("messageType", "error");
                request.getRequestDispatcher("view/admin/content/CreateAccount.jsp").forward(request, response);
                return;
            }
        } catch (NumberFormatException e) {
            request.setAttribute("message", "Vui lòng chọn vai trò.");
            request.setAttribute("messageType", "error");
            request.getRequestDispatcher("view/admin/content/CreateAccount.jsp").forward(request, response);
            return;
        }

        String userName = request.getParameter("userName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");
        String phoneNumber = request.getParameter("phoneNumber");
        String hashedPass = hashPassword(password);

        // Kiểm tra các trường bắt buộc
        if (userName == null || userName.trim().isEmpty() || email == null || email.trim().isEmpty()
                || password == null || password.trim().isEmpty() || fullName == null || fullName.trim().isEmpty()) {
            request.setAttribute("message", "Vui lòng điền đầy đủ các trường bắt buộc.");
            request.setAttribute("messageType", "error");
            request.getRequestDispatcher("view/admin/content/CreateAccount.jsp").forward(request, response);
            return;
        }

        AdminDao accountDAO = new AdminDao();

        // Kiểm tra trùng username và email
        if (accountDAO.isUsernameTaken(userName)) {
            DepartmentDAO departmentDAO = new DepartmentDAO();
            List<Department> departments = departmentDAO.getAllDepartments();
            request.setAttribute("departments", departments);
            request.setAttribute("usernameError", "Tên đăng nhập đã tồn tại.");
            request.setAttribute("messageType", "error");
            request.getRequestDispatcher("view/admin/content/CreateAccount.jsp").forward(request, response);
            return;
        }
        if (accountDAO.isEmailTaken(email)) {
            DepartmentDAO departmentDAO = new DepartmentDAO();
            List<Department> departments = departmentDAO.getAllDepartments();
            request.setAttribute("departments", departments);
            request.setAttribute("emailError", "Email đã tồn tại.");
            request.setAttribute("messageType", "error");
            request.getRequestDispatcher("view/admin/content/CreateAccount.jsp").forward(request, response);
            return;
        }

        // Kiểm tra department_id cho Nurse
        Nurse nurse = null;
        Integer departmentId = null;
        if (roleId == 5) {
            try {
                departmentId = Integer.parseInt(request.getParameter("department_id"));
            } catch (NumberFormatException e) {
                request.setAttribute("message", "Vui lòng chọn phòng ban cho y tá.");
                request.setAttribute("messageType", "error");
                request.getRequestDispatcher("view/admin/content/CreateAccount.jsp").forward(request, response);
                return;
            }
            nurse = new Nurse();
            nurse.setDepartmentId(departmentId);
        }

        // Tạo đối tượng User
        User user = new User();
        user.setUserName(userName);
        user.setEmail(email);
        user.setPassword(hashedPass); // TODO: Mã hóa password
        user.setFullName(fullName);
        user.setPhoneNumber(phoneNumber);
        
        if(roleId==3){
            user.setStatus(0); // Mặc định active
        }else{
            user.setStatus(1); // Mặc định active
        }
        Role role = new Role(roleId, roleId == 3 ? "doctor" : roleId == 5 ? "nurse" : "staff");
        user.setRole(role);
        user.setCreateDate(new Date());
        user.setUpdateDate(new Date());

        // Gọi AdminDao để tạo tài khoản
        boolean success = accountDAO.createAccount(user, nurse, departmentId);
        if (success) {
            request.getSession().setAttribute("message", "Tạo tài khoản thành công!");

            response.sendRedirect("admin-list-account");
        } else {
            DepartmentDAO departmentDAO = new DepartmentDAO();
            List<Department> departments = departmentDAO.getAllDepartments();
            request.setAttribute("departments", departments);
            request.setAttribute("message", "Tạo tài khoản thất bại. Vui lòng thử lại.");

            request.getRequestDispatcher("view/admin/content/CreateAccount.jsp").forward(request, response);
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
