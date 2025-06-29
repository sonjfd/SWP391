/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package AminController;

import DAO.DBContext;
import DAO.SupplierDAO;
import Model.Supplier;
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
@WebServlet(name = "EditSupplierServlet", urlPatterns = {"/editSupplier"})
public class EditSupplierServlet extends HttpServlet {

    private SupplierDAO supplierDAO;

    @Override
    public void init() throws ServletException {
        supplierDAO = new SupplierDAO(DBContext.getConnection());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8"); // ✅ THÊM DÒNG NÀY
        response.setContentType("text/html;charset=UTF-8"); // ✅ TÙY CHỌN, KHÔNG BẮT BUỘC

        int id = Integer.parseInt(request.getParameter("id"));
        Supplier supplier = supplierDAO.getSupplierById(id);
        request.setAttribute("supplier", supplier);
        request.getRequestDispatcher("/view/management/content/EditSupplier.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8"); // ✅ THÊM DÒNG NÀY
        response.setContentType("text/html;charset=UTF-8"); // ✅ TÙY CHỌN, KHÔNG BẮT BUỘC

        int id = Integer.parseInt(request.getParameter("supplier_id"));
        Supplier s = new Supplier();
        s.setId(id);
        s.setSupplierName(request.getParameter("supplier_name"));
        s.setContactName(request.getParameter("contact_name"));
        s.setPhone(request.getParameter("phone"));
        s.setEmail(request.getParameter("email"));
        s.setAddress(request.getParameter("address"));

        supplierDAO.updateSupplier(s);
        response.sendRedirect("supplier");
    }
}
