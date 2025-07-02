package AminController;

import DAO.ProductVariantFlavorDAO;
import Model.ProductVariantFlavor;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ProductVariantFlavorServlet", urlPatterns = {"/admin-productVariantFlavor"})
public class ProductVariantFlavorServlet extends HttpServlet {

    private final ProductVariantFlavorDAO flavorDAO = new ProductVariantFlavorDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "add":
                request.getRequestDispatcher("view/admin/content/AddFlavor.jsp").forward(request, response);
                break;

            case "edit":
                try {
                    int flavorId = Integer.parseInt(request.getParameter("id"));
                    ProductVariantFlavor flavor = flavorDAO.getById(flavorId);
                    if (flavor != null) {
                        request.setAttribute("flavor", flavor);
                        request.getRequestDispatcher("view/admin/content/EditFlavor.jsp").forward(request, response);
                    } else {
                        response.sendRedirect("admin-productVariantFlavor");
                    }
                } catch (NumberFormatException e) {
                    response.sendRedirect("admin-productVariantFlavor");
                }
                break;

            case "hide":
                try {
                    int flavorId = Integer.parseInt(request.getParameter("id"));
                    flavorDAO.softDelete(flavorId);
                    request.getSession().setAttribute("message", "Đã ẩn hương vị thành công.");
                } catch (NumberFormatException ignored) {
                    request.getSession().setAttribute("error", "Lỗi khi ẩn hương vị.");
                }
                response.sendRedirect("admin-productVariantFlavor");
                break;

            case "delete":
                try {
                    int flavorId = Integer.parseInt(request.getParameter("id"));
                    flavorDAO.delete(flavorId);
                    request.getSession().setAttribute("message", "Đã xoá hương vị thành công.");
                } catch (NumberFormatException ignored) {
                    request.getSession().setAttribute("error", "Lỗi khi xoá hương vị.");
                }
                response.sendRedirect("admin-productVariantFlavor");
                break;

            case "list":
            default:
                String kw = request.getParameter("keyword");
                String statusStr = request.getParameter("status");
                String pageStr = request.getParameter("page");

                String flavorName = (kw != null) ? kw.trim() : "";
                Boolean status = null;
                int page = 1, pageSize = 5;

                if (statusStr != null && !statusStr.isEmpty()) {
                    status = statusStr.equals("1");
                }

                try {
                    page = (pageStr != null) ? Integer.parseInt(pageStr) : 1;
                } catch (NumberFormatException ignored) {}

                List<ProductVariantFlavor> list = flavorDAO.search(flavorName, status, page, pageSize);
                int total = flavorDAO.countSearch(flavorName, status);
                int totalPage = (int) Math.ceil((double) total / pageSize);

                request.setAttribute("list", list);
                request.setAttribute("keyword", kw);
                request.setAttribute("status", statusStr);
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPage", totalPage);

                request.getRequestDispatcher("view/admin/content/FlavorList.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect("admin-productVariantFlavor");
            return;
        }

        String flavorName = request.getParameter("flavor");
        String statusStr = request.getParameter("status");

        try {
            boolean status = statusStr != null && statusStr.equals("1");

            ProductVariantFlavor f = new ProductVariantFlavor();
            f.setFlavor(flavorName);
            f.setStatus(status);

            if (action.equals("add")) {
                flavorDAO.insert(f);
                request.getSession().setAttribute("message", "Thêm hương vị thành công!");
            } else if (action.equals("edit")) {
                int flavorId = Integer.parseInt(request.getParameter("flavorId"));
                f.setFlavorId(flavorId);
                flavorDAO.update(f);
                request.getSession().setAttribute("message", "Cập nhật hương vị thành công!");
            }

            response.sendRedirect("admin-productVariantFlavor");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi xử lý dữ liệu!");
            request.setAttribute("flavor", flavorName);
            request.setAttribute("status", statusStr);

            if (action.equals("edit")) {
                request.setAttribute("flavorId", request.getParameter("flavorId"));
                request.getRequestDispatcher("view/admin/content/EditFlavor.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("view/admin/content/AddFlavor.jsp").forward(request, response);
            }
        }
    }
}
