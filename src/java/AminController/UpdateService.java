/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package AminController;

import DAO.ServiceDAO;
import Model.Service;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author FPT
 */
@WebServlet(name="UpdateService", urlPatterns={"/admin-update-service"})
public class UpdateService extends HttpServlet {
   
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
            out.println("<title>Servlet UpdateService</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateService at " + request.getContextPath () + "</h1>");
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
        try {
            String id = request.getParameter("id");
            ServiceDAO serviceDAO = new ServiceDAO();
            Service service = serviceDAO.getServiceById(id);
            if (service != null) {
                request.setAttribute("service", service);
                request.setAttribute("departments", serviceDAO.getAllDepartments());
                request.getRequestDispatcher("view/admin/content/UpdateService.jsp").forward(request, response);
            } else {
                request.getSession().setAttribute("message", "Không tìm thấy dịch vụ!");
                response.sendRedirect(request.getContextPath() + "/admin-list-service");
            }
        } catch (Exception e) {
            request.getSession().setAttribute("message", "ID dịch vụ không hợp lệ!");
            response.sendRedirect(request.getContextPath() + "/admin-list-service");
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
        try {
            request.setCharacterEncoding("UTF-8");
            String id = request.getParameter("id");
            int departmentId = Integer.parseInt(request.getParameter("department_id"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            int status = Integer.parseInt(request.getParameter("status"));

            Service service = new Service();
            service.setId(id);
            service.setDepartmentId(departmentId);
            service.setName(name);
            service.setDescription(description);
            service.setPrice(price);
            service.setStatus(status);

            ServiceDAO serviceDAO = new ServiceDAO();
            if (serviceDAO.updateService(service)) {
                request.getSession().setAttribute("message", "Cập nhật dịch vụ thành công!");
                response.sendRedirect(request.getContextPath() + "/admin-list-service");
            } else {
                request.setAttribute("error", "Lỗi khi cập nhật dịch vụ!");
                request.setAttribute("departments", serviceDAO.getAllDepartments());
                request.setAttribute("service", service);
                request.getRequestDispatcher("view/admin/content/UpdateService.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Dữ liệu không hợp lệ!");
            ServiceDAO serviceDAO = new ServiceDAO();
            request.setAttribute("departments", serviceDAO.getAllDepartments());
            request.getRequestDispatcher("view/admin/content/UpdateService.jsp").forward(request, response);
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
