/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package AminController;

import DAO.DepartmentDAO;
import Model.Department;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;

/**
 *
 * @author FPT
 */
@WebServlet(name="UpdateDepartment", urlPatterns={"/admin-update-department"})
public class UpdateDepartment extends HttpServlet {
   
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
            out.println("<title>Servlet UpdateDepartment</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateDepartment at " + request.getContextPath () + "</h1>");
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
        DepartmentDAO departmentDAO = new DepartmentDAO();
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Department department = departmentDAO.getDepartmentById(id);
            if (department == null) {
                request.setAttribute("message", "Phòng ban không tồn tại");
                response.sendRedirect(request.getContextPath() + "admin-list-department");
                return;
            }
            request.setAttribute("department", department);
            request.getRequestDispatcher("view/admin/content/UpdateDepartment.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("message", "Lỗi cơ sở dữ liệu");
            response.sendRedirect(request.getContextPath() + "admin-list-department");
        }
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
        DepartmentDAO departmentDAO = new DepartmentDAO();
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            if (name == null || name.trim().isEmpty() || name.length() > 255 || departmentDAO.isNameExists(name, id)) {
                request.setAttribute("message", "Tên phòng ban không hợp lệ hoặc đã tồn tại");
                request.setAttribute("department", new Department(id, name, description));
                request.getRequestDispatcher("view/admin/content/UpdateDepartment.jsp").forward(request, response);
                return;
            }
            departmentDAO.updateDepartment(id, name, description);
            request.getSession().setAttribute("message", "Cập nhật phòng ban thành công");
            response.sendRedirect(request.getContextPath() + "/admin-list-department");
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("message", "Lỗi cơ sở dữ liệu");
            request.getRequestDispatcher("view/admin/content/UpdateDepartment.jsp").forward(request, response);
        }
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
