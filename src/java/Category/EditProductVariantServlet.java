package Category;

import DAO.ProductDAO;
import DAO.ProductVariantDAO;
import Model.Product;
import Model.ProductVariant;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "EditProductVariantServlet", urlPatterns = {"/editProductVariant"})
public class EditProductVariantServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        try {
            String idRaw = request.getParameter("variant_id");
            if (idRaw == null || idRaw.trim().isEmpty()) {
                response.sendRedirect("productVariant?action=list");
                return;
            }

            int variantId = Integer.parseInt(idRaw);
            ProductVariant variant = new ProductVariantDAO().getById(variantId);

            if (variant == null) {
                response.sendRedirect("productVariant?action=list");
                return;
            }

            List<Product> products = new ProductDAO().getAll();
            request.setAttribute("variant", variant);
            request.setAttribute("products", products);
            request.getRequestDispatcher("view/management/content/EditProductVariant.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("productVariant?action=list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        try {
            String idRaw = request.getParameter("variant_id");
            String variantName = request.getParameter("variant_name");
            String productIdRaw = request.getParameter("product_id");
            String priceRaw = request.getParameter("price");
            String stockRaw = request.getParameter("stock_quantity");

            if (idRaw == null || productIdRaw == null || priceRaw == null || stockRaw == null ||
                idRaw.trim().isEmpty() || productIdRaw.trim().isEmpty() ||
                priceRaw.trim().isEmpty() || stockRaw.trim().isEmpty()) {
                throw new Exception("Thiếu dữ liệu đầu vào.");
            }

            int variantId = Integer.parseInt(idRaw);
            int productId = Integer.parseInt(productIdRaw);
            double price = Double.parseDouble(priceRaw);
            int stockQuantity = Integer.parseInt(stockRaw);

            ProductVariant variant = new ProductVariant();
            variant.setProductVariantId(variantId);
            variant.setVariantName(variantName);
            variant.setProductId(productId);
            variant.setPrice(price);
            variant.setStockQuantity(stockQuantity);

            boolean updated = new ProductVariantDAO().updateVariant(variant);
            if (updated) {
                response.sendRedirect("productVariant?action=list");
            } else {
                throw new Exception("Không thể cập nhật biến thể.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi: " + e.getMessage());

            try {
                int fallbackId = Integer.parseInt(request.getParameter("variant_id"));
                ProductVariant fallbackVariant = new ProductVariantDAO().getById(fallbackId);
                request.setAttribute("variant", fallbackVariant);
            } catch (Exception ex) {
                request.setAttribute("variant", null);
            }

            request.setAttribute("products", new ProductDAO().getAll());
            request.getRequestDispatcher("view/management/content/EditProductVariant.jsp").forward(request, response);
        }
    }
}
