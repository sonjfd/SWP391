package AminController;

import DAO.ProductVariantWeightDAO;
import Model.ProductVariantWeight;
import java.io.IOException;
import java.math.BigDecimal;
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
        request.getRequestDispatcher("view/management/content/AddWeight.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String weightStr = request.getParameter("weight");

        try {
            BigDecimal weight = new BigDecimal(weightStr.trim());

            if (weight.compareTo(BigDecimal.ZERO) <= 0) {
                throw new NumberFormatException("Trọng lượng phải lớn hơn 0.");
            }

            ProductVariantWeight w = new ProductVariantWeight();
            w.setWeight(weight);

            boolean success = dao.insert(w);

            if (success) {
                response.sendRedirect("productVariantWeight");
            } else {
                request.setAttribute("error", "Thêm thất bại! Vui lòng thử lại.");
                request.setAttribute("weight", weightStr);
                request.getRequestDispatcher("view/management/content/AddWeight.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Trọng lượng không hợp lệ! " + e.getMessage());
            request.setAttribute("weight", weightStr);
            request.getRequestDispatcher("view/management/content/AddWeight.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            request.setAttribute("weight", weightStr);
            request.getRequestDispatcher("view/management/content/AddWeight.jsp").forward(request, response);
        }
    }
}
