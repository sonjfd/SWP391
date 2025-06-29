/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package AminController;

import DAO.DepartmentDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author FPT
 */
@WebServlet(name="CreateDepartment", urlPatterns={"/admin-create-department"})
public class CreateDepartment extends HttpServlet {
   
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
            out.println("<title>Servlet CreateDepartment</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CreateDepartment at " + request.getContextPath () + "</h1>");
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
        request.getRequestDispatcher("view/admin/content/CreateDepartment.jsp").forward(request, response);
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
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        try {
            if (name == null || name.trim().isEmpty() || name.length() > 255 || departmentDAO.isNameExists(name, 0)) {
                request.setAttribute("message", "Tên phòng ban không hợp lệ hoặc đã tồn tại");
                request.setAttribute("name", name);
                request.setAttribute("description", description);
                request.getRequestDispatcher("view/admin/content/CreateDepartment.jsp").forward(request, response);
                return;
            }
            departmentDAO.addDepartment(name, description);
            response.sendRedirect(request.getContextPath() + "/admin-list-department");
            request.setAttribute("message", "Tạo phòng ban thành công!");
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("message", "Lỗi cơ sở dữ liệu");
            request.getRequestDispatcher("view/admin/content/CreateDepartment.jsp").forward(request, response);
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
