package Category;

import DAO.ProductDAO;
import Model.Product;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "ProductServlet", urlPatterns = {"/product"})
public class ProductServlet extends HttpServlet {

    private ProductDAO productDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO(); // ❌ KHÔNG cần truyền Connection nữa
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Product p = productDAO.getProductById(id);
                if (p != null) {
                    request.setAttribute("editProduct", p);
                    request.getRequestDispatcher("/view/management/content/EditProduct.jsp").forward(request, response);
                    return;
                } else {
                    response.sendRedirect("product");
                    return;
                }
            }

            if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                productDAO.deleteProduct(id);
            }

            List<Product> list = productDAO.getAll(); // ✅ Đổi thành getAll() (cách 1)
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
        try {
            String action = request.getParameter("action");
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            int supplierId = Integer.parseInt(request.getParameter("supplierId"));
            String name = request.getParameter("productName");
            String desc = request.getParameter("description");
            String image = request.getParameter("image");

            if ("add".equals(action)) {
                Product p = new Product(0, categoryId, supplierId, name, desc, image, null, null);
                productDAO.insertProduct(p);
            } else if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Product p = new Product(id, categoryId, supplierId, name, desc, image, null, null);
                productDAO.updateProduct(p);
            }

            response.sendRedirect("product");

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Lỗi xử lý POST trong ProductServlet", e);
        }
    }
}
