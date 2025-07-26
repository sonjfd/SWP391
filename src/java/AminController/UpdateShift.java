/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package AminController;

import DAO.ShiftDAO;
import Model.Shift;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalTime;

/**
 *
 * @author FPT
 */
@WebServlet(name="UpdateShift", urlPatterns={"/admin-update-shift"})
public class UpdateShift extends HttpServlet {
   
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
            out.println("<title>Servlet UpdateShift</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateShift at " + request.getContextPath () + "</h1>");
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
            int id = Integer.parseInt(request.getParameter("id"));
            ShiftDAO shiftDAO = new ShiftDAO();
            Shift shift = shiftDAO.getShiftById(id);
            if (shift != null) {
                request.setAttribute("shift", shift);
                request.getRequestDispatcher("view/admin/content/UpdateShift.jsp").forward(request, response);
            } else {
                request.getSession().setAttribute("message", "Không tìm thấy ca làm việc!");
                response.sendRedirect("admin-list-shift");
            }
        } catch (Exception e) {
            request.getSession().setAttribute("message", "ID ca không hợp lệ!");
            response.sendRedirect("admin-list-shift");
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
        request.setCharacterEncoding("UTF-8");
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name").trim();
            LocalTime startTime = LocalTime.parse(request.getParameter("start_time"));
            LocalTime endTime = LocalTime.parse(request.getParameter("end_time"));

            ShiftDAO shiftDAO = new ShiftDAO();

            // Kiểm tra trùng tên (loại trừ chính nó)
            if (shiftDAO.isDuplicateNameExcludeId(name, id)) {
                request.setAttribute("error", "Tên ca làm việc đã tồn tại!");
                Shift shift = new Shift(id, name, startTime, endTime);
                request.setAttribute("shift", shift);
                request.getRequestDispatcher("view/admin/content/UpdateShift.jsp").forward(request, response);
                return;
            }

            // Kiểm tra trùng giờ (loại trừ chính nó)
            if (shiftDAO.isOverlappingShiftExcludeId(startTime, endTime, id)) {
                request.setAttribute("error", "Thời gian ca làm việc bị trùng với ca khác!");
                Shift shift = new Shift(id, name, startTime, endTime);
                request.setAttribute("shift", shift);
                request.getRequestDispatcher("view/admin/content/UpdateShift.jsp").forward(request, response);
                return;
            }

            // Nếu hợp lệ thì cập nhật
            Shift shift = new Shift(id, name, startTime, endTime);
            if (shiftDAO.updateShift(shift)) {
                request.getSession().setAttribute("message", "Cập nhật ca thành công!");
                response.sendRedirect("admin-list-shift");
            } else {
                request.setAttribute("error", "Lỗi khi cập nhật ca làm việc!");
                request.setAttribute("shift", shift);
                request.getRequestDispatcher("view/admin/content/UpdateShift.jsp").forward(request, response);
            }

        } catch (Exception e) {
            Shift shift = new Shift();
            try {
                shift.setId(Integer.parseInt(request.getParameter("id")));
            } catch (Exception ignored) {
            }
            shift.setName(request.getParameter("name"));
            request.setAttribute("error", "Dữ liệu không hợp lệ!");
            request.setAttribute("shift", shift);
            request.getRequestDispatcher("view/admin/content/UpdateShift.jsp").forward(request, response);
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
