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

        try {
            if ("addForm".equalsIgnoreCase(action)) {
                List<Category> categories = categoryDAO.getCategoriesByStatus(true);
                request.setAttribute("categories", categories);
                request.getRequestDispatcher("/view/management/content/AddProduct.jsp").forward(request, response);
                return;
            }

            if ("edit".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Product p = productDAO.getProductById(id);
                if (p != null) {
                    List<Category> categories = categoryDAO.getCategoriesByStatus(true);
                    request.setAttribute("categories", categories);
                    request.setAttribute("editProduct", p);
                    request.getRequestDispatcher("/view/management/content/EditProduct.jsp").forward(request, response);
                } else {
                    response.sendRedirect("admin-product");
                }
                return;
            }

            if ("delete".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                productDAO.softDeleteProduct(id);
            }

            List<Product> list = productDAO.getAllActiveProducts();
            request.setAttribute("list", list);
            request.getRequestDispatcher("/view/management/content/Product.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Lỗi xử lý GET trong ProductServlet", e);
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

            // DEBUG
            System.out.println("=== DỮ LIỆU GỬI TỪ FORM ===");
            System.out.println("Action: " + action);
            System.out.println("Category ID: " + categoryId);
            System.out.println("Tên SP: " + name);
            System.out.println("Mô tả: " + desc);

            Category category = new Category();
            category.setCategoryId(categoryId);

            if ("add".equalsIgnoreCase(action)) {
                Product p = new Product();
                p.setProductName(name);
                p.setDescription(desc);
                p.setStatus(true);
                p.setCategory(category);

                boolean success = productDAO.insertProduct(p);
                if (!success) {
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
                p.setStatus(true);
                p.setCategory(category);

                boolean success = productDAO.updateProduct(p);
                if (!success) {
                    System.out.println("❌ Lỗi khi cập nhật sản phẩm!");
                } else {
                    System.out.println("✅ Cập nhật sản phẩm thành công!");
                }
            }

            response.sendRedirect("admin-product");

        } catch (Exception e) {
            System.out.println("❌ Exception trong doPost:");
            e.printStackTrace();
            throw new ServletException("Lỗi xử lý POST trong ProductServlet", e);
        }
    }
}
