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
@WebServlet(name = "CreateService", urlPatterns = {"/admin-create-service"})
public class CreateService extends HttpServlet {

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
            out.println("<title>Servlet CreateService</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CreateService at " + request.getContextPath() + "</h1>");
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
        ServiceDAO serviceDAO = new ServiceDAO();
        request.setAttribute("departments", serviceDAO.getAllDepartments());
        request.getRequestDispatcher("view/admin/content/CreateService.jsp").forward(request, response);
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
        try {
            request.setCharacterEncoding("UTF-8");
            int departmentId = Integer.parseInt(request.getParameter("department_id"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            int status = Integer.parseInt(request.getParameter("status"));

            Service service = new Service();
            service.setDepartmentId(departmentId);
            service.setName(name);
            service.setDescription(description);
            service.setPrice(price);
            service.setStatus(status);

            ServiceDAO serviceDAO = new ServiceDAO();
            if (serviceDAO.isServiceNameExists(name, null)) {
                request.setAttribute("error", "Tên dịch vụ đã tồn tại!");
                request.setAttribute("departments", serviceDAO.getAllDepartments());
                request.setAttribute("service", service);
                request.getRequestDispatcher("view/admin/content/CreateService.jsp").forward(request, response);
                return;
            }
            if (serviceDAO.addService(service)) {
                request.getSession().setAttribute("message", "Tạo dịch vụ thành công!");
                response.sendRedirect(request.getContextPath() + "/admin-list-service");
            } else {
                request.setAttribute("error", "Lỗi khi tạo dịch vụ!");
                request.setAttribute("departments", serviceDAO.getAllDepartments());
                request.setAttribute("service", service);
                request.getRequestDispatcher("view/admin/content/CreateService.jsp").forward(request, response);

            }
        } catch (Exception e) {
            request.setAttribute("error", "Dữ liệu không hợp lệ!");
            ServiceDAO serviceDAO = new ServiceDAO();
            request.setAttribute("departments", serviceDAO.getAllDepartments());
            request.getRequestDispatcher("view/admin/content/CreateService.jsp").forward(request, response);
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
