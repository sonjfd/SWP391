package AminController;

import DAO.ProductDAO;
import DAO.ProductVariantDAO;
import DAO.ProductVariantFlavorDAO;
import DAO.ProductVariantWeightDAO;
import Model.Product;
import Model.ProductVariant;
import Model.ProductVariantFlavor;
import Model.ProductVariantWeight;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,      // 1MB
    maxFileSize = 1024 * 1024 * 5,        // 5MB
    maxRequestSize = 1024 * 1024 * 10     // 10MB
)
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

    } else if (action.equals("toggleStatus")) {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            ProductVariant variant = variantDAO.getById(id);
            boolean newStatus = !variant.isStatus(); // đảo trạng thái
            variantDAO.updateStatus(id, newStatus);

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Cập nhật trạng thái thất bại: " + e.getMessage());
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

        // Hiển thị message/error nếu có từ session
        HttpSession session = request.getSession();
        if (session.getAttribute("message") != null) {
            request.setAttribute("message", session.getAttribute("message"));
            session.removeAttribute("message");
        }
        if (session.getAttribute("error") != null) {
            request.setAttribute("error", session.getAttribute("error"));
            session.removeAttribute("error");
        }

        request.setAttribute("variants", variants);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("keyword", keyword);
        request.setAttribute("status", statusRaw);
        request.getRequestDispatcher("view/admin/content/ProductVariantList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        try {
            int productId = Integer.parseInt(request.getParameter("product_id"));
            int weightId = Integer.parseInt(request.getParameter("weight_id"));
            int flavorId = Integer.parseInt(request.getParameter("flavor_id"));
            double price = Double.parseDouble(request.getParameter("price"));
            int stock = Integer.parseInt(request.getParameter("stock_quantity"));
            boolean status = "1".equals(request.getParameter("status"));

            Part filePart = request.getPart("image");
            String filename = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

            String uploadPath = "C:/MyUploads/avatars";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            String fullPath = uploadPath + File.separator + filename;
            filePart.write(fullPath);

            String imagePath = "image-loader/" + filename;

            ProductVariant variant = new ProductVariant();
            variant.setProductId(productId);
            variant.setWeightId(weightId);
            variant.setFlavorId(flavorId);
            variant.setPrice(price);
            variant.setStockQuantity(stock);
            variant.setStatus(status);
            variant.setImage(imagePath);

            if ("add".equals(action)) {
                if (variantDAO.isDuplicateVariant(productId, weightId, flavorId)) {
                    throw new Exception("Biến thể với cùng sản phẩm, trọng lượng và hương vị đã tồn tại.");
                }
                variantDAO.add(variant);
                request.getSession().setAttribute("message", "Thêm biến thể thành công.");
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
