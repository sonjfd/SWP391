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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.google.gson.Gson;

@WebServlet(name = "StaffInvoiceDetailPrintAjax", urlPatterns = {"/staff-invoice-detail-print-ajax"})
public class StaffInvoiceDetailPrintAjax extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");
        InvoiceDAO invoiceDAO = new InvoiceDAO();
        InvoiceItemDAO itemDAO = new InvoiceItemDAO();

        try {
            Invoice invoice = invoiceDAO.getInvoiceById(id);
            if (invoice == null) {
                Map<String, String> errorMap = new HashMap<>();
                errorMap.put("error", "Hóa đơn không tồn tại");
                sendJsonResponse(response, errorMap);
                return;
            }

            List<InvoiceItem> items = itemDAO.getItemsByInvoiceId(id);

            List<Map<String, Object>> detailsList = new ArrayList<>();

            for (InvoiceItem item : items) {
                Map<String, Object> detail = new HashMap<>();
                String productFullName = item.getProductName();
                detail.put("productName", productFullName);
                detail.put("unitPrice", item.getPrice());
                detail.put("quantity", item.getQuantity());
                detail.put("lineTotal", item.getPrice() * item.getQuantity());
                detailsList.add(detail);
            }

            Map<String, Object> resultMap = new HashMap<>();
            resultMap.put("details", detailsList);
            resultMap.put("totalAmount", invoice.getTotalAmount());

            sendJsonResponse(response, resultMap);

        } catch (Exception e) {
            e.printStackTrace();
            Map<String, String> errorMap = new HashMap<>();
            errorMap.put("error", "Lỗi hệ thống");
            sendJsonResponse(response, errorMap);
        }
    }

    private void sendJsonResponse(HttpServletResponse response, Object data) throws IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        Gson gson = new Gson();
        out.print(gson.toJson(data));
        out.flush();
    }
}
