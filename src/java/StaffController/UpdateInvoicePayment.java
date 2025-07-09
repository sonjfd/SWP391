package StaffController;

import DAO.InvoiceDAO;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "UpdateInvoicePayment", urlPatterns = {"/staff-update-invoice-payment"})
public class UpdateInvoicePayment extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {

            response.sendRedirect("login");
            return;
        }

        User user = (User) session.getAttribute("user");
        String staffId = user.getId();
        String paymentStatus = request.getParameter("paymentStatus");

        String invoiceId = request.getParameter("invoiceId");
        String paymentMethod = request.getParameter("paymentMethod");

        if (invoiceId == null || paymentMethod == null || paymentMethod.isEmpty()) {
            response.sendRedirect("staff-list-invoices?error=invalid");
            return;
        }

        InvoiceDAO invoiceDAO = new InvoiceDAO();

        try {
            boolean updated = invoiceDAO.updateInvoicePayment(invoiceId, paymentMethod, paymentStatus, staffId);
            if (updated) {
                response.sendRedirect("staff-list-invoices?success=update");
            } else {
                response.sendRedirect("staff-list-invoices?error=notfound");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("staff-list-invoices?error=system");
        }
    }
}
