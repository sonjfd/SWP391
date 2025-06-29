package AminController;

import DAO.ProductVariantWeightDAO;
import Model.ProductVariantWeight;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AddWeightServlet", urlPatterns = {"/admin-addWeight"})
public class AddWeightServlet extends HttpServlet {

    private final ProductVariantWeightDAO dao = new ProductVariantWeightDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("view/admin/content/AddWeight.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String weightStr = request.getParameter("weight");
        String statusStr = request.getParameter("status");

        try {
            double weight = Double.parseDouble(weightStr.trim());
            boolean status = "1".equals(statusStr); // "1" = đang bán

            if (weight <= 0) {
                throw new NumberFormatException("Trọng lượng phải lớn hơn 0.");
            }

            ProductVariantWeight w = new ProductVariantWeight();
            w.setWeight(weight);
            w.setStatus(status);

            dao.insert(w); // Không cần kiểm tra trả về vì DAO đang dùng void

            response.sendRedirect("admin-productVariantWeight");

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Trọng lượng không hợp lệ! " + e.getMessage());
            request.setAttribute("weight", weightStr);
            request.setAttribute("status", statusStr);
            request.getRequestDispatcher("view/admin/content/AddWeight.jsp").forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            request.setAttribute("weight", weightStr);
            request.setAttribute("status", statusStr);
            request.getRequestDispatcher("view/admin/content/AddWeight.jsp").forward(request, response);
        }
    }
}
