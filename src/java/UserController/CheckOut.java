package UserController;

import DAO.CartDAO;
import DAO.CartItemDAO;
import DAO.InvoiceDAO;
import DAO.InvoiceItemDAO;
import Model.CartItem;
import Model.Invoice;
import Model.InvoiceItem;
import Model.User;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;
import java.util.UUID;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "CheckOut", urlPatterns = {"/user-checkout-cart"})
public class CheckOut extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || user.getRole().getId() != 1) {
            response.sendRedirect("login");
            return;
        }

        String userId = user.getId();
        CartDAO cartDAO = new CartDAO();
        CartItemDAO itemDAO = new CartItemDAO();
        InvoiceDAO invoiceDAO = new InvoiceDAO();
        InvoiceItemDAO invoiceItemDAO = new InvoiceItemDAO();

        try {
            int cartId = cartDAO.getCartIdByUserId(userId);

            // Xóa giỏ hàng
            itemDAO.deleteItemsByCartId(cartId);
            session.setAttribute("cartSize", 0);

            response.sendRedirect("user-cart?checkout=success");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("user-cart?error=system");
        }
    }
}
