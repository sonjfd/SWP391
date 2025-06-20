package Category;

import DAO.ProductDAO;
import DAO.ProductVariantDAO;
import DAO.ProductVariantWeightDAO;
import DAO.ProductVariantFlavorDAO;

import Model.Product;
import Model.ProductVariant;
import Model.ProductVariantWeight;
import Model.ProductVariantFlavor;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "AddProductVariantServlet", urlPatterns = {"/admin-addProductVariant"})
public class AddProductVariantServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();
    private final ProductVariantDAO variantDAO = new ProductVariantDAO();
    private final ProductVariantWeightDAO weightDAO = new ProductVariantWeightDAO();
    private final ProductVariantFlavorDAO flavorDAO = new ProductVariantFlavorDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        loadFormData(request);
        request.getRequestDispatcher("view/management/content/AddProductVariant.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        try {
            // Lấy dữ liệu từ form
            String variantName = request.getParameter("variant_name");
            int productId = Integer.parseInt(request.getParameter("product_id"));
            int weightId = Integer.parseInt(request.getParameter("weight_id"));
            int flavorId = Integer.parseInt(request.getParameter("flavor_id"));
            BigDecimal price = new BigDecimal(request.getParameter("price"));
            int stockQuantity = Integer.parseInt(request.getParameter("stock_quantity"));
            String statusRaw = request.getParameter("status");
            boolean status = "1".equals(statusRaw);
            String image = request.getParameter("image");

            // Kiểm tra trùng biến thể
            if (variantDAO.isDuplicateVariant(productId, weightId, flavorId)) {
                throw new Exception("Biến thể đã tồn tại với cùng sản phẩm, khối lượng và hương vị.");
            }

            // Tạo đối tượng ProductVariant
            ProductVariant variant = new ProductVariant();
            variant.setVariantName(variantName);
            variant.setProductId(productId);
            variant.setWeightId(weightId);
            variant.setFlavorId(flavorId);
            variant.setPrice(price);
            variant.setStockQuantity(stockQuantity);
            variant.setStatus(status);
            variant.setImage(image);

            // Thêm vào database
            variantDAO.add(variant);

            // Chuyển hướng về danh sách biến thể
            response.sendRedirect("productVariant?action=list");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi: " + e.getMessage());

            // Gửi lại dữ liệu đã nhập để người dùng không cần nhập lại
            request.setAttribute("variant_name", request.getParameter("variant_name"));
            request.setAttribute("product_id", request.getParameter("product_id"));
            request.setAttribute("weight_id", request.getParameter("weight_id"));
            request.setAttribute("flavor_id", request.getParameter("flavor_id"));
            request.setAttribute("price", request.getParameter("price"));
            request.setAttribute("stock_quantity", request.getParameter("stock_quantity"));
            request.setAttribute("status", request.getParameter("status"));
            request.setAttribute("image", request.getParameter("image"));

            loadFormData(request);
            request.getRequestDispatcher("view/management/content/AddProductVariant.jsp").forward(request, response);
        }
    }

    // Nạp dữ liệu dropdown
    private void loadFormData(HttpServletRequest request) {
        List<Product> products = productDAO.getAllActiveProducts();
        List<ProductVariantWeight> weights = weightDAO.getAllWeights();
        List<ProductVariantFlavor> flavors = flavorDAO.getAll();

        request.setAttribute("products", products);
        request.setAttribute("weights", weights);
        request.setAttribute("flavors", flavors);
    }
}
