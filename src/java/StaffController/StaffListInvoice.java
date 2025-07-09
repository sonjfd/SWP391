package StaffController;

import DAO.ClinicInfoDAO;
import DAO.InvoiceDAO;
import Model.ClinicInfo;
import Model.Invoice;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "StaffListInvoice", urlPatterns = {"/staff-list-invoices"})
public class StaffListInvoice extends HttpServlet {

    private final int PAGE_SIZE = 5;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Lấy thông tin phòng khám
            ClinicInfoDAO clinicDao = new ClinicInfoDAO();
            ClinicInfo clinicInfo = clinicDao.getClinicInfo();
            request.setAttribute("ClinicInfo", clinicInfo);

            InvoiceDAO invoiceDAO = new InvoiceDAO();

            // Phân trang
            int page = 1;
            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                try {
                    page = Integer.parseInt(pageParam);
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }

            // Lọc theo ngày
            String searchDateStr = request.getParameter("searchDate");
            Date searchDate = null;
            if (searchDateStr != null && !searchDateStr.isEmpty()) {
                try {
                    searchDate = Date.valueOf(searchDateStr);
                } catch (IllegalArgumentException e) {
                    searchDate = null;
                }
            }

            // Lọc theo trạng thái
            String paymentStatus = request.getParameter("paymentStatus");
            if (paymentStatus != null && paymentStatus.isEmpty()) {
                paymentStatus = null; // nếu giá trị trống thì bỏ lọc
            }

            // Lấy danh sách hóa đơn có lọc
            List<Invoice> invoices = invoiceDAO.getInvoicesByFilter(searchDate, paymentStatus, page, PAGE_SIZE);
            int totalRecords = invoiceDAO.countInvoicesByFilter(searchDate, paymentStatus);
            int totalPages = (int) Math.ceil((double) totalRecords / PAGE_SIZE);

            // Truyền dữ liệu sang JSP
            request.setAttribute("invoices", invoices);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("searchDate", searchDateStr);
            request.setAttribute("paymentStatus", paymentStatus);
            request.setAttribute("offset", (page - 1) * PAGE_SIZE);

            request.getRequestDispatcher("view/staff/content/ListSaleInvoice.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
