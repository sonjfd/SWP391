package AminController;

import DAO.ProductDAO;
import DAO.ProductVariantDAO;
import DAO.ProductVariantWeightDAO;
import DAO.ProductVariantFlavorDAO;

import Model.Product;
import Model.ProductVariant;
import Model.ProductVariantWeight;
import Model.ProductVariantFlavor;

import java.io.File;
import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "AddProductVariantServlet", urlPatterns = {"/admin-addProductVariant"})
@MultipartConfig
public class AddProductVariantServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();
    private final ProductVariantDAO variantDAO = new ProductVariantDAO();
    private final ProductVariantWeightDAO weightDAO = new ProductVariantWeightDAO();
    private final ProductVariantFlavorDAO flavorDAO = new ProductVariantFlavorDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        loadFormData(request);
        request.getRequestDispatcher("view/admin/content/AddProductVariant.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        try {
            int productId = Integer.parseInt(request.getParameter("product_id"));
            int weightId = Integer.parseInt(request.getParameter("weight_id"));
            int flavorId = Integer.parseInt(request.getParameter("flavor_id"));
            double price = Double.parseDouble(request.getParameter("price"));
            int stockQuantity = Integer.parseInt(request.getParameter("stock_quantity"));
            boolean status = "1".equals(request.getParameter("status"));

            Part imagePart = request.getPart("imageFile");
            String imagePath = null;

            // Tạo thư mục lưu ảnh nếu chưa có
            String uploadDirPath = "C:/MyUploads/product-variants";
            File uploadDir = new File(uploadDirPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            // Nếu có file ảnh
            if (imagePart != null && imagePart.getSize() > 0) {
                String fileExt = imagePart.getSubmittedFileName()
                        .substring(imagePart.getSubmittedFileName().lastIndexOf("."));
                String randomFileName = java.util.UUID.randomUUID().toString() + fileExt;
                File savedFile = new File(uploadDir, randomFileName);
                imagePart.write(savedFile.getAbsolutePath());

                // Đường dẫn lưu DB
                imagePath = request.getContextPath() + "/image-loader/" + randomFileName;
            }

            // Kiểm tra trùng lặp biến thể
            if (variantDAO.isDuplicateVariant(productId, weightId, flavorId)) {
                throw new Exception("Biến thể đã tồn tại với cùng sản phẩm, khối lượng và hương vị.");
            }

            // Tạo đối tượng ProductVariant
            ProductVariant variant = new ProductVariant();
            variant.setProductId(productId);
            variant.setWeightId(weightId);
            variant.setFlavorId(flavorId);
            variant.setPrice(price);
            variant.setStockQuantity(stockQuantity);
            variant.setStatus(status);
            variant.setImage(imagePath);

            // Thêm vào DB
            variantDAO.add(variant);
            response.sendRedirect("admin-productVariant?action=list");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi: " + e.getMessage());

            // Giữ lại dữ liệu người dùng đã nhập
            request.setAttribute("product_id", request.getParameter("product_id"));
            request.setAttribute("weight_id", request.getParameter("weight_id"));
            request.setAttribute("flavor_id", request.getParameter("flavor_id"));
            request.setAttribute("price", request.getParameter("price"));
            request.setAttribute("stock_quantity", request.getParameter("stock_quantity"));
            request.setAttribute("status", request.getParameter("status"));

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
