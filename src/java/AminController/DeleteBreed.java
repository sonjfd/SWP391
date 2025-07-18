/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package AminController;

import DAO.BreedDAO;
import Model.Breed;
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
@WebServlet(name="DeleteBreed", urlPatterns={"/admin-delete-breed"})
public class DeleteBreed extends HttpServlet {
   
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
            out.println("<title>Servlet DeleteBreed</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DeleteBreed at " + request.getContextPath () + "</h1>");
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
        String message;
        BreedDAO breedDAO = new BreedDAO();
        try {
            int id = Integer.parseInt(request.getParameter("id"));

            // Gọi DAO để xóa
            boolean success = breedDAO.deleteBreed(id);

            if (success) {
                message = "Xóa giống thành công.";
            } else {
                message = "Không thể xóa giống vì đang được sử dụng ở bảng khác.";
            }

        } catch (NumberFormatException e) {
            message = "ID không hợp lệ.";
            e.printStackTrace();
        } catch (Exception e) {
            message = "Xóa thất bại do lỗi hệ thống.";
            e.printStackTrace();
        }

        // Luôn load lại danh sách giống
        List<Breed> breedList = breedDAO.getAllBreeds();
        request.setAttribute("breedList", breedList);
        request.setAttribute("message", message);

        // Chuyển tiếp đến JSP
        request.getRequestDispatcher("view/admin/content/ListBreed.jsp").forward(request, response);
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

}
