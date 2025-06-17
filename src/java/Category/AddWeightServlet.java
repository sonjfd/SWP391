/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Category;

import DAO.ProductVariantWeightDAO;
import Model.ProductVariantWeight;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
@WebServlet(name="AddWeightServlet", urlPatterns={"/addWeight"})
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

        String variantIdStr = request.getParameter("variantId");
        String weightStr = request.getParameter("weight");

        try {
            int variantId = Integer.parseInt(variantIdStr);
            double weight = Double.parseDouble(weightStr);

            ProductVariantWeight w = new ProductVariantWeight();
            w.setProductVariantId(variantId);
            w.setWeight(weight);

            boolean success = dao.insert(w);

            if (success) {
                response.sendRedirect("productVariantWeight");
            } else {
                request.setAttribute("error", "Thêm thất bại! Vui lòng thử lại.");
                request.setAttribute("variantId", variantIdStr);
                request.setAttribute("weight", weightStr);
                request.getRequestDispatcher("view/management/content/AddWeight.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Dữ liệu không hợp lệ! Vui lòng nhập đúng định dạng.");
            request.setAttribute("variantId", variantIdStr);
            request.setAttribute("weight", weightStr);
            request.getRequestDispatcher("view/management/content/AddWeight.jsp").forward(request, response);
        }
    }
}