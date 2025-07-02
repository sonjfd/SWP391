package AminController;

import DAO.CategoryDAO;
import Model.Category;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "CategoryServlet", urlPatterns = {"/admin-category"})
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
                // PHÂN TRANG + TÌM KIẾM + LỌC TRẠNG THÁI
                String pageParam = request.getParameter("page");
                String statusParam = request.getParameter("status");
                String keyword = request.getParameter("keyword") != null ? request.getParameter("keyword").trim() : "";

                int page = (pageParam == null || pageParam.isEmpty()) ? 1 : Integer.parseInt(pageParam);
                int pageSize = 5;

                Boolean status = null;
                if ("1".equals(statusParam)) {
                    status = true;
                } else if ("0".equals(statusParam)) {
                    status = false;
                }

                List<Category> list = categoryDAO.searchCategories(keyword, status, page, pageSize);
                int total = categoryDAO.countSearchCategories(keyword, status);
                int totalPage = (int) Math.ceil((double) total / pageSize);

                request.setAttribute("list", list);
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPage", totalPage);
                request.setAttribute("keyword", keyword);
                request.setAttribute("status", statusParam);

                request.getRequestDispatcher("/view/admin/content/Category.jsp").forward(request, response);

            } else if (action.equals("addForm")) {
                request.getRequestDispatcher("/view/admin/content/AddCategory.jsp").forward(request, response);

            } else if (action.equals("edit")) {
                int id = Integer.parseInt(request.getParameter("id"));
                Category c = categoryDAO.getCategoryById(id);
                if (c == null) {
                    request.getSession().setAttribute("error", "Không tìm thấy danh mục!");
                    response.sendRedirect("admin-category");
                } else {
                    request.setAttribute("category", c);
                    request.getRequestDispatcher("/view/admin/content/EditCategory.jsp").forward(request, response);
                }

            } else if (action.equals("hide")) { 
                int id = Integer.parseInt(request.getParameter("id"));
                categoryDAO.softHiddenCategory(id); // set status = 0
                request.getSession().setAttribute("message", "Ẩn danh mục thành công!");
                response.sendRedirect("admin-category");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Đã xảy ra lỗi khi xử lý yêu cầu!");
            response.sendRedirect("admin-category");
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
            int statusInt = Integer.parseInt(request.getParameter("status"));
            boolean status = (statusInt == 1);

            if ("add".equals(action)) {
                // ✅ Kiểm tra tên đã tồn tại chưa
                if (categoryDAO.isNameExists(name)) {
                    request.getSession().setAttribute("error", "Tên danh mục đã tồn tại!");
                    response.sendRedirect("admin-category?action=addForm");
                    return;
                }

                Category c = new Category(0, name, desc, status);
                categoryDAO.addCategory(c);
                request.getSession().setAttribute("message", "Thêm danh mục thành công!");

            } else if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));

                // ✅ Kiểm tra tên đã tồn tại ở bản ghi khác chưa
                if (categoryDAO.isNameExistsExceptId(name, id)) {
                    request.getSession().setAttribute("error", "Tên danh mục đã tồn tại!");
                    response.sendRedirect("admin-category?action=edit&id=" + id);
                    return;
                }

                Category c = new Category(id, name, desc, status);
                categoryDAO.updateCategory(c);
                request.getSession().setAttribute("message", "Cập nhật danh mục thành công!");
            }

            response.sendRedirect("admin-category");

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Có lỗi xảy ra khi xử lý dữ liệu!");
            response.sendRedirect("admin-category");
        }
    }
}
