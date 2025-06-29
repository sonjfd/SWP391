package AminController;

import DAO.ProductDAO;
import DAO.CategoryDAO;
import Model.Product;
import Model.Category;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "ProductServlet", urlPatterns = {"/admin-product"})
public class ProductServlet extends HttpServlet {

    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
        categoryDAO = new CategoryDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String keyword = request.getParameter("keyword") != null ? request.getParameter("keyword").trim() : "";
        String pageParam = request.getParameter("page");
        int page = (pageParam == null || pageParam.isEmpty()) ? 1 : Integer.parseInt(pageParam);
        int pageSize = 5;

        try {
            // ========================= ADD FORM =========================
            if ("addForm".equalsIgnoreCase(action)) {
                List<Category> categories = categoryDAO.getCategoriesByStatus(true);
                request.setAttribute("categories", categories);
                request.getRequestDispatcher("/view/admin/content/AddProduct.jsp").forward(request, response);
                return;
            }

            // ========================= EDIT FORM ========================
            if ("edit".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Product p = productDAO.getProductById(id);
                if (p != null) {
                    List<Category> categories = categoryDAO.getCategoriesByStatus(true);
                    request.setAttribute("categories", categories);
                    request.setAttribute("editProduct", p);
                    request.getRequestDispatcher("/view/admin/content/EditProduct.jsp").forward(request, response);
                } else {
                    // Nếu không tìm thấy product, quay lại trang chính
                    response.sendRedirect("admin-product?page=" + page);
                }
                return;
            }

            // ========================= DELETE ============================
            if ("delete".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                productDAO.softDeleteProduct(id);
                // Sau khi xóa xong vẫn hiển thị danh sách phía dưới
            }

            // ========================= HIỂN THỊ DANH SÁCH SẢN PHẨM =========================
            List<Product> list;
            int total;
            if (!keyword.isEmpty()) {
                list = productDAO.searchProductsByName(keyword, page, pageSize);
                total = productDAO.countProductsByName(keyword);
            } else {
                list = productDAO.getProductsByPage(page, pageSize);
                total = productDAO.countAllProducts();
            }

            int totalPages = (int) Math.ceil((double) total / pageSize);

            request.setAttribute("list", list);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("keyword", keyword);

            request.getRequestDispatcher("/view/admin/content/Product.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("❌ Lỗi xử lý GET trong ProductServlet", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        try {
            String action = request.getParameter("action");
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            String name = request.getParameter("productName");
            String desc = request.getParameter("description");

            Category category = new Category();
            category.setCategoryId(categoryId);

            if ("add".equalsIgnoreCase(action)) {
                Product p = new Product();
                p.setProductName(name);
                p.setDescription(desc);
                p.setCategory(category);

                if (!productDAO.insertProduct(p)) {
                    System.out.println("❌ Lỗi khi thêm sản phẩm!");
                } else {
                    System.out.println("✅ Thêm sản phẩm thành công!");
                }

            } else if ("update".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("id"));

                Product p = new Product();
                p.setProductId(id);
                p.setProductName(name);
                p.setDescription(desc);
                p.setCategory(category);

                if (!productDAO.updateProduct(p)) {
                    System.out.println("❌ Lỗi khi cập nhật sản phẩm!");
                } else {
                    System.out.println("✅ Cập nhật sản phẩm thành công!");
                }
            }

            response.sendRedirect("admin-product?page=1");

        } catch (Exception e) {
            System.out.println("❌ Exception trong doPost:");
            e.printStackTrace();
            throw new ServletException("Lỗi xử lý POST trong ProductServlet", e);
        }
    }
}
