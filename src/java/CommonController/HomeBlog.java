/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package CommonController;

import DAO.BlogDAO;
import DAO.ClinicInfoDAO;
import DAO.DoctorDAO;
import DAO.ServiceDAO;
import DAO.SliderDAO;
import Model.Blog;
import Model.ClinicInfo;
import Model.Doctor;
import Model.Service;
import Model.Slider;
import Model.Tag;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ASUS
 */
@WebServlet("/homeblog")
public class HomeBlog extends HttpServlet {

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
            out.println("<title>Servlet HomeBlog</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomeBlog at " + request.getContextPath() + "</h1>");
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

        BlogDAO blogDAO = new BlogDAO();

        String index_raw = request.getParameter("index");
        String tagId = request.getParameter("tag");

        int index = (index_raw == null) ? 1 : Integer.parseInt(index_raw);
        int pageSize = 7;

        int totalBlog = (tagId != null && !tagId.isEmpty())
                ? blogDAO.countBlogsByTag(tagId)
                : blogDAO.countAllBlogs(); 

        int endP = (int) Math.ceil((double) totalBlog / pageSize);

   
        if (index < 1) {
            index = 1;
        } else if (index > endP && endP > 0) {
            index = endP;
        }

        int start = (index - 1) * pageSize + 1;
        int end = Math.min(index * pageSize, totalBlog);

        List<Blog> blogs = (tagId != null && !tagId.isEmpty())
                ? blogDAO.getBlogsByTagWithPagination(tagId, index, pageSize)
                : blogDAO.getPaginationBlog(index, pageSize);

        request.setAttribute("blogs", blogs);
        request.setAttribute("endP", endP);
        request.setAttribute("index", index);
        request.setAttribute("start", start);
        request.setAttribute("end", end);
        request.setAttribute("totalBlog", totalBlog);
        request.setAttribute("selectedTag", tagId);
        request.setAttribute("allTags", blogDAO.getAllTags());

        request.getRequestDispatcher("/view/home/content/Blog.jsp").forward(request, response);
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
        processRequest(request, response);
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
