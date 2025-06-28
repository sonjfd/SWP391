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

            // Lấy ảnh cũ
            String oldImagePath = variantDAO.getById(id).getImage();

            // Lấy file upload mới
            Part imagePart = request.getPart("imageFile");

            String uploadDir = "C:/MyUploads/product-variants";
            File uploadDirFile = new File(uploadDir);
            if (!uploadDirFile.exists()) {
                uploadDirFile.mkdirs();
            }

            String newImagePath;
            if (imagePart != null && imagePart.getSize() > 0) {
                // Xoá ảnh cũ nếu có
                if (oldImagePath != null && oldImagePath.contains("/image-loader/")) {
                    String oldFileName = oldImagePath.substring(oldImagePath.lastIndexOf("/") + 1);
                    File oldFile = new File(uploadDir, oldFileName);
                    if (oldFile.exists()) oldFile.delete();
                }

                // Tạo tên mới
                String extension = imagePart.getSubmittedFileName().substring(imagePart.getSubmittedFileName().lastIndexOf("."));
                String newFileName = UUID.randomUUID().toString() + extension;
                File newFile = new File(uploadDir, newFileName);

                // Ghi file
                try (InputStream input = imagePart.getInputStream();
                     FileOutputStream output = new FileOutputStream(newFile)) {
                    byte[] buffer = new byte[1024];
                    int bytesRead;
                    while ((bytesRead = input.read(buffer)) != -1) {
                        output.write(buffer, 0, bytesRead);
                    }
                }

                newImagePath = request.getContextPath() + "/image-loader/" + newFileName;

            } else {
                // Không chọn ảnh mới → dùng ảnh cũ
                newImagePath = oldImagePath;
            }

            // Cập nhật dữ liệu
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
