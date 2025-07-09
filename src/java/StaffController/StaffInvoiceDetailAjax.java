package StaffController;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import DAO.InvoiceDAO;
import DAO.InvoiceItemDAO;
import Model.Invoice;
import Model.InvoiceItem;
import java.util.List;

@WebServlet(name = "StaffInvoiceDetailAjax", urlPatterns = {"/staff-invoice-detail-ajax"})
public class StaffInvoiceDetailAjax extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");
        InvoiceDAO invoiceDAO = new InvoiceDAO();
        InvoiceItemDAO itemDAO = new InvoiceItemDAO();
        DecimalFormat df = new DecimalFormat("#,###");

        try {
            Invoice invoice = invoiceDAO.getInvoiceById(id);

            if (invoice == null) {
                response.setContentType("text/html;charset=UTF-8");
                response.getWriter().println("<p class='text-danger'>Không tìm thấy hóa đơn!</p>");
                return;
            }

            List<InvoiceItem> items = itemDAO.getItemsByInvoiceId(id);

            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();

            out.println("<p><strong>Mã hóa đơn:</strong> " + invoice.getInvoiceId() + "</p>");
            out.println("<p><strong>Tổng tiền:</strong> " + df.format(invoice.getTotalAmount()) + " VNĐ</p>");
            out.println("<p><strong>Phương thức thanh toán:</strong> " + formatPaymentMethod(invoice.getPaymentMethod()) + "</p>");
            out.println("<hr>");

            out.println("<h6>Danh sách sản phẩm:</h6>");
            out.println("<table class='table table-bordered'>");
            out.println("<thead><tr><th>STT</th><th>Sản phẩm</th><th>Đơn giá</th><th>Số lượng</th><th>Thành tiền</th></tr></thead>");
            out.println("<tbody>");

            int index = 1;
            for (InvoiceItem item : items) {
                String productFullName = item.getProductName();
                out.println("<tr>");
                out.println("<td>" + index++ + "</td>");
                out.println("<td>" + productFullName + "</td>");
                out.println("<td>" + df.format(item.getPrice()) + " VNĐ</td>");
                out.println("<td>" + item.getQuantity() + "</td>");
                out.println("<td>" + df.format(item.getPrice() * item.getQuantity()) + " VNĐ</td>");
                out.println("</tr>");
            }

            out.println("</tbody>");
            out.println("</table>");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<p class='text-danger'>Lỗi hệ thống, không thể lấy chi tiết hóa đơn!</p>");
        }
    }

    private String formatPaymentMethod(String method) {
        switch (method) {
            case "cash":
                return "Tiền mặt";
            case "bank_transfer":
                return "Chuyển khoản";
            case "qr_code":
                return "Quét mã";
            default:
                return method;
        }
    }
}
