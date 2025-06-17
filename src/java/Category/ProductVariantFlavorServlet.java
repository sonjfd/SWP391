/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Category;

import DAO.ProductVariantDAO;
import DAO.ProductVariantFlavorDAO;
import Model.ProductVariant;
import Model.ProductVariantFlavor;
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
 * @author Admin
 */
@WebServlet(name="ProductVariantFlavorServlet", urlPatterns={"/productVariantFlavor"})
public class ProductVariantFlavorServlet extends HttpServlet {
   
    private final ProductVariantFlavorDAO flavorDAO = new ProductVariantFlavorDAO();
    private final ProductVariantDAO variantDAO = new ProductVariantDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null || action.equals("list")) {
            List<ProductVariantFlavor> list = flavorDAO.getAll();
            request.setAttribute("list", list);
            request.getRequestDispatcher("view/management/content/FlavorList.jsp").forward(request, response);

        } else if (action.equals("add")) {
            List<ProductVariant> variantList = variantDAO.getAllVariants();
            request.setAttribute("variantList", variantList);
            request.getRequestDispatcher("view/management/content/AddFlavor.jsp").forward(request, response);

        } else if (action.equals("edit")) {
            try {
                int flavorId = Integer.parseInt(request.getParameter("id"));
                ProductVariantFlavor flavor = flavorDAO.getById(flavorId);
                if (flavor != null) {
                    List<ProductVariant> variantList = variantDAO.getAllVariants();
                    request.setAttribute("variantList", variantList);
                    request.setAttribute("flavor", flavor);
                    request.getRequestDispatcher("view/management/content/EditFlavor.jsp").forward(request, response);
                } else {
                    response.sendRedirect("productVariantFlavor");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect("productVariantFlavor");
            }

        } else if (action.equals("delete")) {
            try {
                int flavorId = Integer.parseInt(request.getParameter("id"));
                flavorDAO.deleteById(flavorId);
            } catch (NumberFormatException e) {
                // Có thể log lỗi
            }
            response.sendRedirect("productVariantFlavor");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect("productVariantFlavor");
            return;
        }

        try {
            int variantId = Integer.parseInt(request.getParameter("variantId"));
            String flavorName = request.getParameter("flavor");

            ProductVariantFlavor f = new ProductVariantFlavor();
            f.setProductVariantId(variantId);
            f.setFlavor(flavorName);

            if (action.equals("add")) {
                flavorDAO.insert(f);

            } else if (action.equals("edit")) {
                int flavorId = Integer.parseInt(request.getParameter("flavorId"));
                f.setFlavorId(flavorId);
                flavorDAO.update(f);
            }

        } catch (NumberFormatException e) {
            // Có thể redirect lại với thông báo lỗi
        }

        response.sendRedirect("productVariantFlavor");
    }
}