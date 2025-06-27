package AminController;

import DAO.ProductDAO;
import DAO.ProductVariantDAO;
import DAO.ProductVariantFlavorDAO;
import DAO.ProductVariantWeightDAO;
import Model.Product;
import Model.ProductVariant;
import Model.ProductVariantFlavor;
import Model.ProductVariantWeight;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet(name = "EditProductVariantServlet", urlPatterns = {"/admin-editProductVariant"})
public class EditProductVariantServlet extends HttpServlet {

    private final ProductVariantDAO variantDAO = new ProductVariantDAO();
    private final ProductDAO productDAO = new ProductDAO();
    private final ProductVariantWeightDAO weightDAO = new ProductVariantWeightDAO();
    private final ProductVariantFlavorDAO flavorDAO = new ProductVariantFlavorDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            ProductVariant variant = variantDAO.getById(id);
            loadFormData(request);
            request.setAttribute("variant", variant);
            request.getRequestDispatcher("view/management/content/EditProductVariant.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin-productVariant?action=list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String name = request.getParameter("variant_name");
        String productIdRaw = request.getParameter("product_id");
        String weightIdRaw = request.getParameter("weight_id");
        String flavorIdRaw = request.getParameter("flavor_id");
        String priceRaw = request.getParameter("price");
        String stockRaw = request.getParameter("stock_quantity");
        String statusRaw = request.getParameter("status");
        String image = request.getParameter("image");
        String idRaw = request.getParameter("variant_id");

        try {
            int id = Integer.parseInt(idRaw);
            int productId = Integer.parseInt(productIdRaw);
            int weightId = Integer.parseInt(weightIdRaw);
            int flavorId = Integer.parseInt(flavorIdRaw);
            double price = Double.parseDouble(priceRaw);
            int stock = Integer.parseInt(stockRaw);
            boolean status = "1".equals(statusRaw);

            ProductVariant variant = new ProductVariant();
            variant.setProductVariantId(id);
            variant.setVariantName(name);
            variant.setProductId(productId);
            variant.setWeightId(weightId);
            variant.setFlavorId(flavorId);
            variant.setPrice(price);
            variant.setStockQuantity(stock);
            variant.setStatus(status);
            variant.setImage(image);

            if (variantDAO.isDuplicateVariantExcludeId(productId, weightId, flavorId, id)) {
                throw new Exception("Biến thể với cùng sản phẩm, trọng lượng và hương vị đã tồn tại.");
            }

            variantDAO.update(variant);
            response.sendRedirect("admin-productVariant?action=list");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi: " + e.getMessage());

            try {
                int fallbackId = Integer.parseInt(request.getParameter("variant_id"));
                ProductVariant fallback = variantDAO.getById(fallbackId);
                request.setAttribute("variant", fallback);
            } catch (Exception ignored) {
            }

            loadFormData(request);
            request.getRequestDispatcher("view/management/content/EditProductVariant.jsp").forward(request, response);
        }
    }

    private void loadFormData(HttpServletRequest request) {
        List<Product> products = productDAO.getAllActiveProducts();
        List<ProductVariantWeight> weights = weightDAO.getAllWeights();
        List<ProductVariantFlavor> flavors = flavorDAO.getAll();

        request.setAttribute("products", products);
        request.setAttribute("weights", weights);
        request.setAttribute("flavors", flavors);
    }
}
