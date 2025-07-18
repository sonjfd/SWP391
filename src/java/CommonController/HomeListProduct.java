/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package CommonController;

import DAO.CategoryDAO;
import DAO.ProductDAO;
import DAO.ProductVariantDAO;
import DAO.ProductVariantFlavorDAO;
import DAO.ProductVariantWeightDAO;
import Model.Category;
import Model.Product;
import Model.ProductVariant;
import Model.ProductVariantFlavor;
import Model.ProductVariantWeight;
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
 * @author Dell
 */
@WebServlet(name = "HomeListProduct", urlPatterns = {"/home-list-product"})
public class HomeListProduct extends HttpServlet {

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
            out.println("<title>Servlet HomeListProduct</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomeListProduct at " + request.getContextPath() + "</h1>");
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
        int page = 1;
        int limit = 6;

        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        String categoryIdStr = request.getParameter("categoryId");
        String[] selectedWeights = request.getParameterValues("weight");
        String[] selectedFlavors = request.getParameterValues("flavor");
        String[] priceRanges = request.getParameterValues("priceRange");
        String sort = request.getParameter("sort");

        Integer categoryId = (categoryIdStr != null && !categoryIdStr.isEmpty()) ? Integer.parseInt(categoryIdStr) : null;

        ProductVariantDAO dao = new ProductVariantDAO();
        List<ProductVariant> productVariants = dao.filterProductVariants(
                categoryId, selectedWeights, selectedFlavors, priceRanges, sort, page, limit
        );

        int totalRecords = dao.countFilteredVariants(categoryId, selectedWeights, selectedFlavors, priceRanges);
        int totalPages = (int) Math.ceil((double) totalRecords / limit);

        request.setAttribute("productVariants", productVariants);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.setAttribute("selectedWeights", selectedWeights);
        request.setAttribute("selectedFlavors", selectedFlavors);
        request.setAttribute("selectedPriceRanges", priceRanges);
        request.setAttribute("sort", sort);
        request.setAttribute("categoryId", categoryId);

        CategoryDAO cdao = new CategoryDAO();
        request.setAttribute("categories", cdao.getAllCategories());

        ProductVariantWeightDAO wdao = new ProductVariantWeightDAO();
        request.setAttribute("weights", wdao.getAllWeights());

        ProductVariantFlavorDAO fdao = new ProductVariantFlavorDAO();
        request.setAttribute("flavors", fdao.getAll());

        request.getRequestDispatcher("/view/home/content/HomeListProduct.jsp").forward(request, response);

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
