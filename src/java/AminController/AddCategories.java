/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package AminController;

import DAO.CategoriesDAO;
import Model.Categories;
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
 * @author Dell
 */
@WebServlet(name = "AddCategories", urlPatterns = {"/admin-add-categories"})
public class AddCategories extends HttpServlet {

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
            out.println("<title>Servlet AddCategories</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddCategories at " + request.getContextPath() + "</h1>");
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
        String categoryName = request.getParameter("categoryName");
        String categoryDescription = request.getParameter("categoryDescription");

        CategoriesDAO categoriesDAO = new CategoriesDAO();
        boolean isCategoryExist = categoriesDAO.isCategoryExist(categoryName);

        if (isCategoryExist) {
      
            List<Categories> categories = categoriesDAO.getAllCategories();
            request.setAttribute("categories", categories);
            request.setAttribute("message", "Danh mục đã tồn tại. Vui lòng chọn tên khác.");
           
            request.setAttribute("categoryName", categoryName);
            request.setAttribute("categoryDescription", categoryDescription);
            request.getRequestDispatcher("/view/admin/content/ListCategories.jsp").forward(request, response);
        } else {
            Categories newCategory = new Categories();
            newCategory.setName(categoryName);
            newCategory.setDescription(categoryDescription);

            boolean isAdded = categoriesDAO.addCategory(newCategory);
            if (isAdded) {
                response.sendRedirect(request.getContextPath() + "/admin/listcategories");
            } else {
                request.setAttribute("message", "Lỗi thêm danh mục!");
                request.setAttribute("categoryName", categoryName);
                request.setAttribute("categoryDescription", categoryDescription);
                request.getRequestDispatcher("/view/admin/content/ListCategories.jsp").forward(request, response);
            }
        }
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
