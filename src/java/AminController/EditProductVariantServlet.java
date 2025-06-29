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
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.UUID;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "EditProductVariantServlet", urlPatterns = {"/admin-editProductVariant"})
@MultipartConfig
public class EditProductVariantServlet extends HttpServlet {

    private final ProductVariantDAO variantDAO = new ProductVariantDAO();
    private final ProductDAO productDAO = new ProductDAO();
    private final ProductVariantWeightDAO weightDAO = new ProductVariantWeightDAO();
    private final ProductVariantFlavorDAO flavorDAO = new ProductVariantFlavorDAO();

    private final String UPLOAD_DIR = "C:/MyUploads/avatars";

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

            ProductVariant oldVariant = variantDAO.getById(id);
            String oldImagePath = oldVariant.getImage();

            // Đảm bảo thư mục tồn tại
            File uploadDir = new File(UPLOAD_DIR);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            // Xử lý ảnh
            Part imagePart = request.getPart("imageFile");
            String newImagePath;

            if (imagePart != null && imagePart.getSize() > 0) {
                // Xoá ảnh cũ
                if (oldImagePath != null && oldImagePath.contains("/image-loader/")) {
                    String oldFileName = oldImagePath.substring(oldImagePath.lastIndexOf("/") + 1);
                    File oldFile = new File(UPLOAD_DIR, oldFileName);
                    if (oldFile.exists()) oldFile.delete();
                }

                // Lưu ảnh mới
                String ext = imagePart.getSubmittedFileName()
                        .substring(imagePart.getSubmittedFileName().lastIndexOf("."));
                String newFileName = UUID.randomUUID().toString() + ext;
                File newFile = new File(UPLOAD_DIR, newFileName);

                try (InputStream input = imagePart.getInputStream();
                     FileOutputStream output = new FileOutputStream(newFile)) {
                    byte[] buffer = new byte[1024];
                    int length;
                    while ((length = input.read(buffer)) != -1) {
                        output.write(buffer, 0, length);
                    }
                }

                newImagePath = request.getContextPath() + "/image-loader/" + newFileName;

            } else {
                // Không thay đổi ảnh
                newImagePath = oldImagePath;
            }

            // Kiểm tra trùng lặp
            if (variantDAO.isDuplicateVariantExcludeId(productId, weightId, flavorId, id)) {
                throw new Exception("Biến thể đã tồn tại với cùng sản phẩm, khối lượng và hương vị.");
            }

            // Cập nhật
            ProductVariant variant = new ProductVariant();
            variant.setProductVariantId(id);
            variant.setProductId(productId);
            variant.setWeightId(weightId);
            variant.setFlavorId(flavorId);
            variant.setPrice(price);
            variant.setStockQuantity(stock);
            variant.setStatus(status);
            variant.setImage(newImagePath);

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
