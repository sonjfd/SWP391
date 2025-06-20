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

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        try {
            if (action == null || action.isEmpty()) {
                // ======= PHÂN TRANG + TÌM KIẾM + LỌC TRẠNG THÁI =======
                String pageParam = request.getParameter("page");
                String statusParam = request.getParameter("status");
                String keyword = request.getParameter("keyword") != null ? request.getParameter("keyword").trim() : "";

                int page = (pageParam == null || pageParam.isEmpty()) ? 1 : Integer.parseInt(pageParam);
                int pageSize = 5;

                List<Category> list;
                int totalCategories;
                int totalPage;

                if (!keyword.isEmpty()) {
                    // ✅ Có tìm kiếm tên
                    list = categoryDAO.searchCategoriesByName(keyword, page, pageSize);
                    totalCategories = categoryDAO.countCategoriesByName(keyword);
                } else if (statusParam != null && !statusParam.isEmpty()) {
                    // ✅ Có lọc trạng thái
                    boolean status = "1".equals(statusParam);
                    list = categoryDAO.getCategoriesByStatusAndPage(status, page, pageSize);
                    totalCategories = categoryDAO.getTotalCategoriesByStatus(status);
                } else {
                    // ✅ Không có lọc gì cả
                    list = categoryDAO.getCategoriesByPage(page, pageSize);
                    totalCategories = categoryDAO.getTotalCategories();
                }

                totalPage = (int) Math.ceil((double) totalCategories / pageSize);

                request.setAttribute("list", list);
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPage", totalPage);
                request.setAttribute("status", statusParam);
                request.setAttribute("keyword", keyword);

                request.getRequestDispatcher("/view/management/content/CategoryAdmin.jsp").forward(request, response);

            } else if (action.equals("addForm")) {
                request.getRequestDispatcher("/view/management/content/AddCategory.jsp").forward(request, response);

            } else if (action.equals("edit")) {
                int id = Integer.parseInt(request.getParameter("id"));
                Category c = categoryDAO.getCategoryById(id);
                if (c == null) {
                    request.getSession().setAttribute("error", "Không tìm thấy danh mục!");
                    response.sendRedirect("category");
                } else {
                    request.setAttribute("category", c);
                    request.getRequestDispatcher("/view/management/content/EditCategory.jsp").forward(request, response);
                }

            } else if (action.equals("delete")) {
                int id = Integer.parseInt(request.getParameter("id"));
                categoryDAO.softDeleteCategory(id);
                request.getSession().setAttribute("message", "Xóa danh mục thành công!");
                response.sendRedirect("category");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Đã xảy ra lỗi khi xử lý yêu cầu!");
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

        try {
            // ✅ Chuyển status từ string ("0"/"1") sang boolean an toàn
            int statusInt = Integer.parseInt(request.getParameter("status"));
            boolean status = (statusInt == 1);

            if ("add".equals(action)) {
                Category c = new Category(0, name, desc, status);
                categoryDAO.addCategory(c);
                request.getSession().setAttribute("message", "Thêm danh mục thành công!");

            } else if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Category c = new Category(id, name, desc, status);
                categoryDAO.updateCategory(c);
                request.getSession().setAttribute("message", "Cập nhật danh mục thành công!");
            }

            response.sendRedirect("category");

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Có lỗi xảy ra khi xử lý dữ liệu!");
            response.sendRedirect("category");
        }
    }
}
