package AminController;

import DAO.DashboardProductsDAO;
import Model.DashboardProducts;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "DashboardProductsServlet", urlPatterns = {"/admin-dashboardProducts"})
public class DashboardProductsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        DashboardProductsDAO dao = new DashboardProductsDAO();

        // A. Tổng quan dashboard
        DashboardProducts dashboard = dao.loadDashboardProducts();
        request.setAttribute("dashboard", dashboard);

        // B. Dữ liệu biểu đồ line: doanh thu theo ngày
        List<Double> thisMonthRevenue = dao.getDailyRevenueThisMonth();
        List<Double> lastMonthRevenue = dao.getDailyRevenueLastMonth();
        request.setAttribute("thisMonthRevenue", thisMonthRevenue);
        request.setAttribute("lastMonthRevenue", lastMonthRevenue);

        // C. Forward tới JSP
        request.getRequestDispatcher("view/admin/content/dashboardProducts.jsp").forward(request, response);
    }
}
