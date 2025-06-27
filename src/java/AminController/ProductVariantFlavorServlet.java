package AminController;

import DAO.ProductVariantFlavorDAO;
import Model.ProductVariantFlavor;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ProductVariantFlavorServlet", urlPatterns = {"/admin-productVariantFlavor"})
public class ProductVariantFlavorServlet extends HttpServlet {

    private final ProductVariantFlavorDAO flavorDAO = new ProductVariantFlavorDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null || action.equals("list")) {
            List<ProductVariantFlavor> list = flavorDAO.getAll();
            request.setAttribute("list", list);
            request.getRequestDispatcher("view/management/content/FlavorList.jsp").forward(request, response);

        } else if (action.equals("add")) {
            request.getRequestDispatcher("view/management/content/AddFlavor.jsp").forward(request, response);

        } else if (action.equals("edit")) {
            try {
                int flavorId = Integer.parseInt(request.getParameter("id"));
                ProductVariantFlavor flavor = flavorDAO.getById(flavorId);
                if (flavor != null) {
                    request.setAttribute("flavor", flavor);
                    request.getRequestDispatcher("view/management/content/EditFlavor.jsp").forward(request, response);
                } else {
                    response.sendRedirect("admin-productVariantFlavor");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect("admin-productVariantFlavor");
            }

        } else if (action.equals("delete")) {
            try {
                int flavorId = Integer.parseInt(request.getParameter("id"));
                flavorDAO.deleteById(flavorId);
            } catch (NumberFormatException e) {
                // log lỗi nếu muốn
            }
            response.sendRedirect("admin-productVariantFlavor");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect("admin-productVariantFlavor");
            return;
        }

        try {
            String flavorName = request.getParameter("flavor");

            ProductVariantFlavor f = new ProductVariantFlavor();
            f.setFlavor(flavorName);

            if (action.equals("add")) {
                flavorDAO.insert(f);

            } else if (action.equals("edit")) {
                int flavorId = Integer.parseInt(request.getParameter("flavorId"));
                f.setFlavorId(flavorId);
                flavorDAO.update(f);
            }

        } catch (Exception e) {
            System.err.println("Lỗi doPost(): " + e.getMessage());
        }

        response.sendRedirect("admin-productVariantFlavor");
    }
}
