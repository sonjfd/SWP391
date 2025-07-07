package AminController;

import DAO.ProductVariantWeightDAO;
import Model.ProductVariantWeight;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ProductVariantWeightServlet", urlPatterns = {"/admin-productVariantWeight"})
public class ProductVariantWeightServlet extends HttpServlet {

    private final ProductVariantWeightDAO weightDAO = new ProductVariantWeightDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "add":
                request.getRequestDispatcher("view/admin/content/AddWeight.jsp").forward(request, response);
                break;

            case "edit":
                try {
                    int weightId = Integer.parseInt(request.getParameter("id"));
                    ProductVariantWeight weight = weightDAO.getById(weightId);
                    if (weight != null) {
                        request.setAttribute("weight", weight);
                        request.getRequestDispatcher("view/admin/content/EditWeight.jsp").forward(request, response);
                    } else {
                        response.sendRedirect("admin-productVariantWeight");
                    }
                } catch (NumberFormatException e) {
                    response.sendRedirect("admin-productVariantWeight");
                }
                break;

            case "hide":
                try {
                    int weightId = Integer.parseInt(request.getParameter("id"));
                    weightDAO.softDelete(weightId);
                } catch (NumberFormatException ignored) {}
                response.sendRedirect("admin-productVariantWeight");
                break;

            case "delete":
                try {
                    int weightId = Integer.parseInt(request.getParameter("id"));
                    weightDAO.delete(weightId);
                } catch (NumberFormatException ignored) {}
                response.sendRedirect("admin-productVariantWeight");
                break;

            case "list":
            default:
                String kw = request.getParameter("keyword");
                String statusStr = request.getParameter("status");
                String pageStr = request.getParameter("page");

                Double weight = null;
                Boolean status = null;
                int page = 1, pageSize = 5;

                try {
                    if (kw != null && !kw.trim().isEmpty()) {
                        weight = Double.parseDouble(kw.trim());
                    }
                } catch (NumberFormatException ignored) {}

                if (statusStr != null && !statusStr.isEmpty()) {
                    status = statusStr.equals("1");
                }

                try {
                    page = pageStr != null ? Integer.parseInt(pageStr) : 1;
                } catch (NumberFormatException ignored) {}

                List<ProductVariantWeight> list = weightDAO.search(weight, status, page, pageSize);
                int total = weightDAO.countSearch(weight, status);
                int totalPage = (int) Math.ceil((double) total / pageSize);

                request.setAttribute("list", list);
                request.setAttribute("keyword", kw);
                request.setAttribute("status", statusStr);
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPage", totalPage);

                request.getRequestDispatcher("view/admin/content/WeightList.jsp").forward(request, response);
                break;
        }
    }

    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    request.setCharacterEncoding("UTF-8");
    String action = request.getParameter("action");

    if (action == null) {
        response.sendRedirect("admin-productVariantWeight");
        return;
    }

    String weightStr = request.getParameter("weight");
    String statusStr = request.getParameter("status");

    try {
        double weightValue = Double.parseDouble(weightStr.trim());
        boolean status = "1".equals(statusStr);

        if (weightValue <= 0) {
            throw new NumberFormatException("Trọng lượng phải lớn hơn 0.");
        }

        ProductVariantWeight w = new ProductVariantWeight();
        w.setWeight(weightValue);
        w.setStatus(status);

        if (action.equals("add")) {
            if (weightDAO.isWeightExists(weightValue)) {
                request.setAttribute("error", "Trọng lượng này đã tồn tại!");
                request.setAttribute("weightValue", weightStr);
                request.setAttribute("status", statusStr);
                request.getRequestDispatcher("view/admin/content/AddWeight.jsp").forward(request, response);
                return;
            }

            weightDAO.insert(w);
            request.getSession().setAttribute("message", "Thêm trọng lượng thành công!");
            response.sendRedirect("admin-productVariantWeight");

        } else if (action.equals("edit")) {
            int weightId = Integer.parseInt(request.getParameter("weightId"));
            w.setWeightId(weightId);

            if (weightDAO.isWeightExistsExceptId(weightValue, weightId)) {
                request.setAttribute("error", "Trọng lượng này đã tồn tại!");
                request.setAttribute("weightValue", weightStr);
                request.setAttribute("status", statusStr);
                request.setAttribute("weight", weightDAO.getById(weightId)); // ✅ Đúng kiểu dữ liệu
                request.getRequestDispatcher("view/admin/content/EditWeight.jsp").forward(request, response);
                return;
            }

            weightDAO.update(w);
            request.getSession().setAttribute("message", "Cập nhật trọng lượng thành công!");
            response.sendRedirect("admin-productVariantWeight");
        }

    } catch (NumberFormatException e) {
        request.setAttribute("error", "Trọng lượng không hợp lệ! " + e.getMessage());
        request.setAttribute("weightValue", weightStr);
        request.setAttribute("status", statusStr);

        if ("edit".equals(action)) {
            try {
                int weightId = Integer.parseInt(request.getParameter("weightId"));
                request.setAttribute("weightId", weightId);
                request.setAttribute("weight", weightDAO.getById(weightId)); // ✅ Bắt buộc để JSP không lỗi
            } catch (NumberFormatException ignored) {}

            request.getRequestDispatcher("view/admin/content/EditWeight.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("view/admin/content/AddWeight.jsp").forward(request, response);
        }
    }
}
}