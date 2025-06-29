/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package AminController;

import DAO.RoleDAO;
import Model.Role;
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
@WebServlet(name="UpdateRole", urlPatterns={"/admin-update-role"})
public class UpdateRole extends HttpServlet {
   
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
            out.println("<title>Servlet UpdateRole</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateRole at " + request.getContextPath () + "</h1>");
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
        RoleDAO roleDAO = new RoleDAO();
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Role role = roleDAO.getRoleByIdAll(id);
            if (role == null) {
                request.setAttribute("message", "Vai trò không tồn tại");
                request.getRequestDispatcher("view/admin/content/ListRole.jsp").forward(request, response);
                return;
            }
            request.setAttribute("role", role);
            request.getRequestDispatcher("view/admin/content/UpdateRole.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("message", "ID vai trò không hợp lệ");
            request.getRequestDispatcher("view/admin/content/ListRole.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(UpdateRole.class.getName()).log(Level.SEVERE, null, ex);
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
        RoleDAO roleDAO = new RoleDAO();
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");

            if (name == null || name.trim().isEmpty() || name.length() > 50 || roleDAO.isNameExists(name, id)) {
                request.setAttribute("message", "Tên vai trò không hợp lệ hoặc đã tồn tại");
                request.setAttribute("role", new Role(id, name));
                request.getRequestDispatcher("view/admin/content/UpdateRole.jsp").forward(request, response);
                return;
            }

            roleDAO.updateRole(id, name);
            request.setAttribute("roles", roleDAO.getAllRoles());
            request.setAttribute("message", "Cập nhật vai trò thành công");
            request.getRequestDispatcher("view/admin/content/ListRole.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("message", "Lỗi cơ sở dữ liệu");
            request.setAttribute("role", new Role(
                Integer.parseInt(request.getParameter("id")),
                request.getParameter("name")
            ));
            request.getRequestDispatcher("view/admin/content/UpdateRole.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("message", "ID vai trò không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/admin-list-role");
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
