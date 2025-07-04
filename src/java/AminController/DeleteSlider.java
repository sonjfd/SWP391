/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package AminController;

import DAO.SliderDAO;
import Model.Slider;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author FPT
 */
@WebServlet(name = "DeleteSlider", urlPatterns = {"/admin-delete-slider"})
public class DeleteSlider extends HttpServlet {

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
            out.println("<title>Servlet DeleteSlider</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DeleteSlider at " + request.getContextPath() + "</h1>");
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
        SliderDAO sliderDAO = new SliderDAO();
        String id = request.getParameter("id");
        try {
            if (id != null && !id.trim().isEmpty()) {
                sliderDAO.deleteSlider(id);

                // Lấy danh sách slide mới
                List<Slider> slides = sliderDAO.getAllSlider();
                request.setAttribute("slides", slides);

                // Thông báo mặc định (vì không kiểm tra thành công hay thất bại)
                request.setAttribute("message", "Xóa thành công");
            } else {
                List<Slider> slides = sliderDAO.getAllSlider();
                request.setAttribute("slides", slides);
                request.setAttribute("message", "Invalid slide ID.");

            }
        } catch (Exception e) {
            e.printStackTrace();
            // Lấy danh sách slide nếu có lỗi
            List<Slider> slides = sliderDAO.getAllSlider();
            request.setAttribute("slides", slides);
            request.setAttribute("message", "Delete failed due to an error.");
        }

        // Forward về ListSlider.jspá
        request.getRequestDispatcher("view/admin/content/ListSlider.jsp").forward(request, response);
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
