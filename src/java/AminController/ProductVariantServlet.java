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

@WebServlet(name = "ProductVariantServlet", urlPatterns = {"/admin-productVariant"})
public class ProductVariantServlet extends HttpServlet {

    private final ProductVariantDAO variantDAO = new ProductVariantDAO();
    private final ProductDAO productDAO = new ProductDAO();
    private final ProductVariantWeightDAO weightDAO = new ProductVariantWeightDAO();
    private final ProductVariantFlavorDAO flavorDAO = new ProductVariantFlavorDAO();
    private final int PAGE_SIZE = 5;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null || action.equals("list")) {
            handleList(request, response);

        } else if (action.equals("add")) {
            loadFormData(request);
            request.getRequestDispatcher("view/admin/content/AddProductVariant.jsp").forward(request, response);

        } else if (action.equals("delete")) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                variantDAO.delete(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
            response.sendRedirect("admin-productVariant?action=list");
        }
    }

    private void handleList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");
        String statusRaw = request.getParameter("status");
        String pageRaw = request.getParameter("page");

        Boolean status = null;
        if ("1".equals(statusRaw)) status = true;
        else if ("0".equals(statusRaw)) status = false;

        int page = 1;
        if (pageRaw != null) {
            try {
                page = Integer.parseInt(pageRaw);
            } catch (NumberFormatException ignored) {}
        }

        List<ProductVariant> variants = variantDAO.search(keyword, status, page, PAGE_SIZE);
        int total = variantDAO.countSearch(keyword, status);
        int totalPage = (int) Math.ceil((double) total / PAGE_SIZE);

        request.setAttribute("variants", variants);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("keyword", keyword);
        request.setAttribute("status", statusRaw); // giữ lại lựa chọn trong form lọc

        request.getRequestDispatcher("view/admin/content/ProductVariantList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        String productIdRaw = request.getParameter("product_id");
        String weightIdRaw = request.getParameter("weight_id");
        String flavorIdRaw = request.getParameter("flavor_id");
        String priceRaw = request.getParameter("price");
        String stockRaw = request.getParameter("stock_quantity");
        String statusRaw = request.getParameter("status");
        String image = request.getParameter("image");

        try {
            int productId = Integer.parseInt(productIdRaw);
            int weightId = Integer.parseInt(weightIdRaw);
            int flavorId = Integer.parseInt(flavorIdRaw);
            double price = Double.parseDouble(priceRaw);
            int stock = Integer.parseInt(stockRaw);
            boolean status = "1".equals(statusRaw);

            ProductVariant variant = new ProductVariant();
            variant.setProductId(productId);
            variant.setWeightId(weightId);
            variant.setFlavorId(flavorId);
            variant.setPrice(price);
            variant.setStockQuantity(stock);
            variant.setStatus(status);
            variant.setImage(image);

            if ("add".equals(action)) {
                if (variantDAO.isDuplicateVariant(productId, weightId, flavorId)) {
                    throw new Exception("Biến thể với cùng sản phẩm, trọng lượng và hương vị đã tồn tại.");
                }
                variantDAO.add(variant);
            }

            response.sendRedirect("admin-productVariant?action=list");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi: " + e.getMessage());
            loadFormData(request);
            request.getRequestDispatcher("view/admin/content/AddProductVariant.jsp").forward(request, response);
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
