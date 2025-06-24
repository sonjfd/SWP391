package AminController;

import DAO.ProductDAO;
import DAO.ProductVariantDAO;
import DAO.ProductVariantFlavorDAO;
import DAO.ProductVariantWeightDAO;
import Model.Product;
import Model.ProductVariant;
import Model.ProductVariantFlavor;
import Model.ProductVariantWeight;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

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

            if (variant == null) {
                response.sendRedirect("admin-productVariant?action=list");
                return;
            }

            request.setAttribute("variant", variant);
            loadFormData(request);
            request.getRequestDispatcher("view/admin/content/EditProductVariant.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin-productVariant?action=list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        try {
            int id = Integer.parseInt(request.getParameter("variant_id"));
            int productId = Integer.parseInt(request.getParameter("product_id"));
            int weightId = Integer.parseInt(request.getParameter("weight_id"));
            int flavorId = Integer.parseInt(request.getParameter("flavor_id"));
            double price = Double.parseDouble(request.getParameter("price"));
            int stock = Integer.parseInt(request.getParameter("stock_quantity"));
            boolean status = "1".equals(request.getParameter("status"));
            String image = request.getParameter("image");

            // Kiểm tra trùng nếu thay đổi product/weight/flavor
            if (variantDAO.isDuplicateVariantExcludeId(productId, weightId, flavorId, id)) {
                throw new Exception("Biến thể đã tồn tại với cùng sản phẩm, khối lượng và hương vị.");
            }

            ProductVariant variant = new ProductVariant();
            variant.setProductVariantId(id);
            variant.setProductId(productId);
            variant.setWeightId(weightId);
            variant.setFlavorId(flavorId);
            variant.setPrice(price);
            variant.setStockQuantity(stock);
            variant.setStatus(status);
            variant.setImage(image);

            variantDAO.update(variant);
            response.sendRedirect("admin-productVariant?action=list");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi: " + e.getMessage());
            loadFormData(request);
            request.getRequestDispatcher("view/admin/content/EditProductVariant.jsp").forward(request, response);
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
