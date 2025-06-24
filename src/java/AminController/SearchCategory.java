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

@WebServlet(name = "SearchCategory", urlPatterns = {"/admin-searchCategory"})
public class SearchCategory extends HttpServlet {

    private CategoryDAO categoryDAO;

    @Override
    public void init() throws ServletException {
        categoryDAO = new CategoryDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // Lấy tham số tìm kiếm
        String keyword = request.getParameter("keyword") != null ? request.getParameter("keyword").trim() : "";
        String statusParam = request.getParameter("status");
        Boolean status = null;

        if ("1".equals(statusParam)) {
            status = true;
        } else if ("0".equals(statusParam)) {
            status = false;
        }

        // Phân trang
        String pageParam = request.getParameter("page");
        int page = (pageParam == null || pageParam.isEmpty()) ? 1 : Integer.parseInt(pageParam);
        int pageSize = 5;

        // Gọi DAO tìm kiếm + đếm
        List<Category> list = categoryDAO.searchCategories(keyword, status, page, pageSize);
        int total = categoryDAO.countSearchCategories(keyword, status);
        int totalPage = (int) Math.ceil((double) total / pageSize);

        // Gửi dữ liệu về view
        request.setAttribute("list", list);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("keyword", keyword);
        request.setAttribute("status", statusParam);

        request.getRequestDispatcher("/view/admin/content/Category.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); // POST gọi lại GET
    }

    @Override
    public String getServletInfo() {
        return "Tìm kiếm danh mục theo tên và trạng thái có phân trang";
    }
}
