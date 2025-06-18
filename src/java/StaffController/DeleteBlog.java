/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package StaffController;

import DAO.BlogDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author ASUS
 */

@WebServlet("/staff-delete-blog")
public class DeleteBlog extends HttpServlet {
   
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
            out.println("<title>Servlet DeleteBlog</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DeleteBlog at " + request.getContextPath () + "</h1>");
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
        if (id != null && !id.trim().isEmpty()) {
            BlogDAO dao = new BlogDAO();
            dao.deleteBlog(id);
        }

        response.sendRedirect("list-blog");
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
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       String blogId = request.getParameter("id");  // Lấy id từ tham số request
    if (blogId == null || blogId.isEmpty()) {
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);  // Nếu không có id, trả về lỗi 400
        return;
    }

    BlogDAO bdao = new BlogDAO();
    try {
        boolean isDeleted = bdao.deleteBlog(blogId);
        if (isDeleted) {
            response.setStatus(HttpServletResponse.SC_OK);  // Trả về trạng thái thành công
        } else {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);  // Xóa không thành công
            response.getWriter().write("Không thể xóa bài viết.");
        }
    } catch (Exception e) {
        e.printStackTrace();  // In ra lỗi để kiểm tra
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);  // Trả về lỗi server
        response.getWriter().write("Đã xảy ra lỗi khi xóa bài viết: " + e.getMessage());
    }
}
}
