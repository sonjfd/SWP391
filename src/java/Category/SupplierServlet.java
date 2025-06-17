package Category;
import Model.Supplier;
import DAO.SupplierDAO;
import DAO.DBContext; // ✅ Đảm bảo bạn thêm dòng này

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name="SupplierServlet", urlPatterns={"/supplier"})
public class SupplierServlet extends HttpServlet {

    private SupplierDAO supplierDAO;

    @Override
    public void init() throws ServletException {
        supplierDAO = new SupplierDAO(DBContext.getConnection()); // ✅ sửa tại đây
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        List<Supplier> list = supplierDAO.getAllSuppliers();
        request.setAttribute("supplierList", list);
        request.getRequestDispatcher("/view/management/content/SupplierAdmin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<html><body><h1>Supplier Servlet at " + request.getContextPath() + "</h1></body></html>");
        }
    }

    @Override
    public String getServletInfo() {
        return "Supplier management servlet";
    }
}
