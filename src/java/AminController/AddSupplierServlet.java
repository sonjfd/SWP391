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
@WebServlet(name="AddSupplierServlet", urlPatterns={"/addSupplier"})
public class AddSupplierServlet extends HttpServlet {
   
    private SupplierDAO supplierDAO;

    @Override
    public void init() throws ServletException {
        supplierDAO = new SupplierDAO(DBContext.getConnection());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String supplierName = request.getParameter("supplier_name");
        String contactName = request.getParameter("contact_name");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String address = request.getParameter("address");

        Supplier s = new Supplier();
        s.setSupplierName(supplierName);
        s.setContactName(contactName);
        s.setPhone(phone);
        s.setEmail(email);
        s.setAddress(address);

        supplierDAO.insertSupplier(s);

        response.sendRedirect("supplier");
    }
}
