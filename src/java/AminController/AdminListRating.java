/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package AminController;

import DAO.RatingDAO;
import Model.Rating;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
@WebServlet(name = "AdminListRating", urlPatterns = {"/admin-listratings"})
public class AdminListRating extends HttpServlet {

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
            out.println("<title>Servlet AdminListRating</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminListRating at " + request.getContextPath() + "</h1>");
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
        RatingDAO rd = new RatingDAO();
        List<Rating> rlist = new ArrayList<>();
        rlist = rd.getAllRatings();
        request.setAttribute("RateList", rlist);
        request.getRequestDispatcher("view/admin/content/ManageRatings.jsp").forward(request, response);
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
        String namecustomer = request.getParameter("text");
        String ratingId = request.getParameter("ratingId");
        String status = request.getParameter("status");
        
         RatingDAO dao = new RatingDAO();
       
//        if((!namecustomer.isEmpty()|| !namecustomer.isBlank()) && (statusrating.isEmpty()|| statusrating==null)){
//            rateList = dao.getRatingsByStatus(statusrating);
//        }else if(!statusrating.isEmpty()|| !statusrating.isBlank() && (namecustomer.isEmpty()||namecustomer==null)){
//            rateList = dao.getRatingsByStatus(statusrating);
//        }
//        request.setAttribute("RateList", rateList);
        
        if(dao.updateRatingStatus(ratingId, status)){
             request.getSession().setAttribute("SuccessMessage", "Cập nhật trạng thái thành công");
            
        }else{
             request.getSession().setAttribute("FailMessage", "Cập nhật trạng thái không thành công");
            
        }
        response.sendRedirect("admin-listratings");
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
