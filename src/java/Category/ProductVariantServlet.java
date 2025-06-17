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

@WebServlet(name = "ProductVariantServlet", urlPatterns = {"/productVariant"})
public class ProductVariantServlet extends HttpServlet {

    private ProductVariantDAO variantDAO = new ProductVariantDAO();
    private ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null || action.equals("list")) {
            List<ProductVariant> variants = variantDAO.getAllVariants();
            request.setAttribute("variants", variants);
            request.getRequestDispatcher("view/management/content/ProductVariantList.jsp").forward(request, response);
        }

        else if (action.equals("add")) {
            List<Product> products = productDAO.getAll();
            request.setAttribute("products", products);
            request.getRequestDispatcher("view/management/content/AddProductVariant.jsp").forward(request, response);
        }

        else if (action.equals("edit")) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                ProductVariant variant = variantDAO.getById(id);
                List<Product> products = productDAO.getAll();
                request.setAttribute("variant", variant);
                request.setAttribute("products", products);
                request.getRequestDispatcher("view/management/content/EditProductVariant.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("productVariant?action=list");
            }
        }

        else if (action.equals("delete")) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                variantDAO.deleteVariant(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
            response.sendRedirect("productVariant?action=list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        String name = request.getParameter("variant_name");
        String productIdRaw = request.getParameter("product_id");
        String priceRaw = request.getParameter("price");
        String stockRaw = request.getParameter("stock_quantity");

        try {
            int productId = Integer.parseInt(productIdRaw);
            double price = Double.parseDouble(priceRaw);
            int stock = Integer.parseInt(stockRaw);

            ProductVariant variant = new ProductVariant();
            variant.setVariantName(name);
            variant.setProductId(productId);
            variant.setPrice(price);
            variant.setStockQuantity(stock);

            if (!variantDAO.isProductIdValid(productId)) {
                throw new Exception("Product ID không tồn tại.");
            }

            if ("add".equals(action)) {
                variantDAO.addVariant(variant);
            } else if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("variant_id"));
                variant.setProductVariantId(id);
                variantDAO.updateVariant(variant);
            }

            response.sendRedirect("productVariant?action=list");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi: " + e.getMessage());
            request.setAttribute("products", productDAO.getAll());

            if ("edit".equals(action)) {
                try {
                    int id = Integer.parseInt(request.getParameter("variant_id"));
                    ProductVariant fallback = variantDAO.getById(id);
                    request.setAttribute("variant", fallback);
                } catch (Exception ex) {
                    // bỏ qua lỗi
                }
                request.getRequestDispatcher("view/management/content/EditProductVariant.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("view/management/content/AddProductVariant.jsp").forward(request, response);
            }
        }
    }
}
