package Category;

import DAO.ProductDAO;
import DAO.ProductVariantDAO;
import Model.Product;
import Model.ProductVariant;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "AddProductVariantServlet", urlPatterns = {"/addProductVariant"})
public class AddProductVariantServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        List<Product> products = new ProductDAO().getAll();
        request.setAttribute("products", products);
        request.getRequestDispatcher("view/management/content/AddProductVariant.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        try {
            String variantName = request.getParameter("variant_name");
            int productId = Integer.parseInt(request.getParameter("product_id"));
            double price = Double.parseDouble(request.getParameter("price"));
            int stockQuantity = Integer.parseInt(request.getParameter("stock_quantity"));

            ProductVariant variant = new ProductVariant();
            variant.setVariantName(variantName);
            variant.setProductId(productId);
            variant.setPrice(price);
            variant.setStockQuantity(stockQuantity);

            new ProductVariantDAO().addVariant(variant);

            response.sendRedirect("productVariant?action=list");
        } catch (Exception e) {
            request.setAttribute("error", "Dữ liệu không hợp lệ: " + e.getMessage());
            request.setAttribute("products", new ProductDAO().getAll());
            request.getRequestDispatcher("view/management/content/AddProductVariant.jsp").forward(request, response);
        }
    }
}
