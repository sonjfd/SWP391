package Category;

import DAO.CategoryDAO;
import Model.Category;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "CategoryServlet", urlPatterns = {"/category"})
public class CategoryServlet extends HttpServlet {

    private CategoryDAO categoryDAO;

    @Override
    public void init() throws ServletException {
        categoryDAO = new CategoryDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null || action.equals("")) {
            // Hiển thị danh sách
            List<Category> list = categoryDAO.getAllCategories();
            request.setAttribute("list", list);
            request.getRequestDispatcher("/view/management/content/CategoryAdmin.jsp").forward(request, response);

        } else if (action.equals("addForm")) {
            // Hiển thị form thêm
            request.getRequestDispatcher("/view/management/content/AddCategory.jsp").forward(request, response);

        } else if (action.equals("edit")) {
            // Hiển thị form chỉnh sửa
            int id = Integer.parseInt(request.getParameter("id"));
            Category c = categoryDAO.getCategoryById(id);
            request.setAttribute("category", c);
            request.getRequestDispatcher("/view/management/content/EditCategory.jsp").forward(request, response);

        } else if (action.equals("delete")) {
            int id = Integer.parseInt(request.getParameter("id"));
            categoryDAO.deleteCategory(id);
            response.sendRedirect("category");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        String name = request.getParameter("name");
        String desc = request.getParameter("description");

        if ("add".equals(action)) {
            Category c = new Category(0, name, desc);
            categoryDAO.addCategory(c);
        } else if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Category c = new Category(id, name, desc);
            categoryDAO.updateCategory(c);
        }

        response.sendRedirect("category");
    }
}
