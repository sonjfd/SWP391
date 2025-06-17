package Category;

import DAO.ProductVariantDAO;
import DAO.ProductVariantWeightDAO;
import Model.ProductVariant;
import Model.ProductVariantWeight;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ProductVariantWeightServlet", urlPatterns = {"/productVariantWeight"})
public class ProductVariantWeightServlet extends HttpServlet {

    private final ProductVariantWeightDAO weightDAO = new ProductVariantWeightDAO();
    private final ProductVariantDAO variantDAO = new ProductVariantDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null || action.equals("list")) {
            List<ProductVariantWeight> list = weightDAO.getAllWeights();
            request.setAttribute("list", list);
            request.getRequestDispatcher("view/management/content/WeightList.jsp").forward(request, response);

        } else if (action.equals("add")) {
            // Lấy danh sách biến thể để hiển thị trong dropdown
            List<ProductVariant> variantList = variantDAO.getAllVariants();
            request.setAttribute("variantList", variantList);
            request.getRequestDispatcher("view/management/content/AddWeight.jsp").forward(request, response);

        } else if (action.equals("edit")) {
            try {
                int weightId = Integer.parseInt(request.getParameter("id"));
                ProductVariantWeight weight = weightDAO.getByWeightId(weightId);
                if (weight != null) {
                    List<ProductVariant> variantList = variantDAO.getAllVariants();
                    request.setAttribute("variantList", variantList);
                    request.setAttribute("weight", weight);
                    request.getRequestDispatcher("view/management/content/EditWeight.jsp").forward(request, response);
                } else {
                    response.sendRedirect("productVariantWeight");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect("productVariantWeight");
            }

        } else if (action.equals("delete")) {
            try {
                int weightId = Integer.parseInt(request.getParameter("id"));
                weightDAO.deleteByWeightId(weightId);
            } catch (NumberFormatException e) {
                // Có thể log lỗi
            }
            response.sendRedirect("productVariantWeight");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect("productVariantWeight");
            return;
        }

        try {
            int variantId = Integer.parseInt(request.getParameter("variantId"));
            double weightValue = Double.parseDouble(request.getParameter("weight"));

            ProductVariantWeight w = new ProductVariantWeight();
            w.setProductVariantId(variantId);
            w.setWeight(weightValue);

            if (action.equals("add")) {
                weightDAO.insert(w);

            } else if (action.equals("edit")) {
                int weightId = Integer.parseInt(request.getParameter("weightId"));
                w.setWeightId(weightId);
                weightDAO.update(w);
            }

        } catch (NumberFormatException e) {
            // Có thể redirect lại với thông báo lỗi
        }

        response.sendRedirect("productVariantWeight");
    }
}