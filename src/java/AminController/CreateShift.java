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
@WebServlet(name="CreateShift", urlPatterns={"/createshift"})
public class CreateShift extends HttpServlet {
   
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
            out.println("<title>Servlet CreateShift</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CreateShift at " + request.getContextPath () + "</h1>");
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
        request.getRequestDispatcher("view/admin/content/CreateShift.jsp").forward(request, response);
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
            String name = request.getParameter("name").trim();
            LocalTime startTime = LocalTime.parse(request.getParameter("start_time"));
            LocalTime endTime = LocalTime.parse(request.getParameter("end_time"));

            Shift shift = new Shift();
            shift.setName(name);
            shift.setStart_time(startTime);
            shift.setEnd_time(endTime);

            ShiftDAO shiftDAO = new ShiftDAO();
            if (shiftDAO.addShift(shift)) {
                request.getSession().setAttribute("message", "Tạo ca thành công!");
                response.sendRedirect("listshift");
            } else {
                request.setAttribute("error", "Lỗi khi tạo ca làm việc!");
                request.setAttribute("name", name);
                request.setAttribute("start_time", request.getParameter("start_time"));
                request.setAttribute("end_time", request.getParameter("end_time"));
                request.getRequestDispatcher("view/admin/content/CreateShift.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Dữ liệu không hợp lệ!");
            request.setAttribute("name", request.getParameter("name"));
            request.setAttribute("start_time", request.getParameter("start_time"));
            request.setAttribute("end_time", request.getParameter("end_time"));
            request.getRequestDispatcher("view/admin/content/CreateShift.jsp").forward(request, response);
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
