package DAO;

import Model.DashboardProducts;
import Model.TopProduct;

import java.sql.*;
import java.util.*;
import java.time.LocalDate;
import java.time.YearMonth;

public class DashboardProductsDAO extends DBContext {

    // ==============================
    // A. Tổng quan doanh thu
    // ==============================
    public double getRevenueToday() {
        String sql = "SELECT SUM(total_amount) FROM sales_invoices WHERE CAST(created_at AS DATE) = CAST(GETDATE() AS DATE) AND payment_status = 'paid'";
        return getDoubleValue(sql);
    }

    public double getRevenueYesterday() {
        String sql = "SELECT SUM(total_amount) FROM sales_invoices WHERE CAST(created_at AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE) AND payment_status = 'paid'";
        return getDoubleValue(sql);
    }

    public double getRevenueThisMonth() {
        String sql = "SELECT SUM(total_amount) FROM sales_invoices WHERE MONTH(created_at) = MONTH(GETDATE()) AND YEAR(created_at) = YEAR(GETDATE()) AND payment_status = 'paid'";
        return getDoubleValue(sql);
    }

    public double getRevenueLastMonth() {
        String sql = "SELECT SUM(total_amount) FROM sales_invoices WHERE MONTH(created_at) = MONTH(DATEADD(MONTH, -1, GETDATE())) AND YEAR(created_at) = YEAR(DATEADD(MONTH, -1, GETDATE())) AND payment_status = 'paid'";
        return getDoubleValue(sql);
    }

    public double getRevenueThisYear() {
        String sql = "SELECT SUM(total_amount) FROM sales_invoices WHERE YEAR(created_at) = YEAR(GETDATE()) AND payment_status = 'paid'";
        return getDoubleValue(sql);
    }

    // ==============================
    // B. Hóa đơn
    // ==============================
    public int getTotalInvoices() {
        return getIntValue("SELECT COUNT(*) FROM sales_invoices");
    }

    public int getTotalInvoicesPaid() {
        return getIntValue("SELECT COUNT(*) FROM sales_invoices WHERE payment_status = 'paid'");
    }

    public double getAverageOrderValue() {
        return getDoubleValue("SELECT AVG(total_amount) FROM sales_invoices WHERE payment_status = 'paid'");
    }

    // ==============================
    // C. Kho sản phẩm
    // ==============================
    public int getOutOfStockProductCount() {
        return getIntValue("SELECT COUNT(*) FROM product_variants WHERE stock_quantity = 0");
    }

    public int getLowStockProductCount() {
        return getIntValue("SELECT COUNT(*) FROM product_variants WHERE stock_quantity < 5 AND stock_quantity > 0");
    }

    // ==============================
    // D. Biểu đồ: Doanh thu theo ngày
    // ==============================
    public List<Double> getDailyRevenueThisMonth() {
        List<Double> list = new ArrayList<>();
        YearMonth thisMonth = YearMonth.now();
        int days = thisMonth.lengthOfMonth();

        String sql
                = "SELECT ISNULL(SUM(total_amount),0) "
                + "FROM   sales_invoices "
                + "WHERE  CAST(created_at AS DATE) = ? "
                + "AND    payment_status = 'paid'";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            for (int day = 1; day <= days; day++) {
                LocalDate date = thisMonth.atDay(day);
                ps.setDate(1, java.sql.Date.valueOf(date));
                try (ResultSet rs = ps.executeQuery()) {
                    rs.next();
                    list.add(rs.getDouble(1));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // đảm bảo size đủ ngày, nếu lỗi thì toàn 0
            while (list.size() < days) {
                list.add(0.0);
            }
        }
        return list;
    }

    public List<Double> getDailyRevenueLastMonth() {
    List<Double> list = new ArrayList<>();
    YearMonth lastMonth = YearMonth.now().minusMonths(1);
    int days = lastMonth.lengthOfMonth();

    String sql =
        "SELECT ISNULL(SUM(total_amount),0) " +
        "FROM   sales_invoices " +
        "WHERE  CAST(created_at AS DATE) = ? " +
        "AND    payment_status = 'paid'";

    try (Connection conn = getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        for (int day = 1; day <= days; day++) {
            LocalDate date = lastMonth.atDay(day);
            ps.setDate(1, java.sql.Date.valueOf(date));
            try (ResultSet rs = ps.executeQuery()) {
                rs.next();
                list.add(rs.getDouble(1));
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
        while (list.size() < days) list.add(0.0);
    }
    return list;
}
    // ==============================
    // E. Biểu đồ: Doanh thu theo danh mục
    // ==============================
    public Map<String, Double> getRevenueByCategory() {
        Map<String, Double> map = new HashMap<>();
        String sql = "SELECT c.category_name, SUM(sii.quantity * sii.price) AS revenue "
                + "FROM sales_invoice_items sii "
                + "JOIN product_variants pv ON sii.product_variant_id = pv.product_variant_id "
                + "JOIN products p ON pv.product_id = p.product_id "
                + "JOIN categories c ON p.category_id = c.category_id "
                + "GROUP BY c.category_name";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                map.put(rs.getString("category_name"), rs.getDouble("revenue"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }

    // ==============================
    // F. Bảng: Top sản phẩm bán chạy
    // ==============================
    public List<TopProduct> getTopSellingProducts(int limit) {
        List<TopProduct> list = new ArrayList<>();
        String sql = "SELECT TOP (?) p.product_name, SUM(sii.quantity) AS quantity_sold, SUM(sii.quantity * sii.price) AS total_revenue "
                + "FROM sales_invoice_items sii "
                + "JOIN product_variants pv ON sii.product_variant_id = pv.product_variant_id "
                + "JOIN products p ON pv.product_id = p.product_id "
                + "GROUP BY p.product_name "
                + "ORDER BY quantity_sold DESC";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                TopProduct tp = new TopProduct();
                tp.setProductName(rs.getString("product_name"));
                tp.setQuantitySold(rs.getInt("quantity_sold"));
                tp.setTotalRevenue(rs.getDouble("total_revenue"));
                list.add(tp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ==============================
    // G. Load tổng thể dashboard
    // ==============================
    public DashboardProducts loadDashboardProducts() {
        DashboardProducts dp = new DashboardProducts();

        // A. Tổng quan doanh thu
        dp.setRevenueToday(getRevenueToday());
        dp.setRevenueYesterday(getRevenueYesterday());
        dp.setRevenueThisMonth(getRevenueThisMonth());
        dp.setRevenueLastMonth(getRevenueLastMonth());
        dp.setRevenueThisYear(getRevenueThisYear());

        // B. Hóa đơn
        dp.setTotalInvoices(getTotalInvoices());
        dp.setTotalInvoicesPaid(getTotalInvoicesPaid());
        dp.setTotalInvoicesUnpaid(dp.getTotalInvoices() - dp.getTotalInvoicesPaid());
        dp.setAverageOrderValue(getAverageOrderValue());

        // C. Kho
        dp.setOutOfStockProducts(getOutOfStockProductCount());
        dp.setLowStockProducts(getLowStockProductCount());

        // D. Sản phẩm
        dp.setTopSellingProducts(getTopSellingProducts(5));
        dp.setRevenueByCategory(getRevenueByCategory());

        return dp;
    }

    // ==============================
    // Helper Methods
    // ==============================
    private double getDoubleValue(String sql) {
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    private int getIntValue(String sql) {
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public static void main(String[] args) {
        DashboardProductsDAO dao = new DashboardProductsDAO();

        // A. Tổng quan doanh thu
        System.out.println("=== A. TỔNG QUAN DOANH THU ===");
        System.out.printf(" • Doanh thu hôm nay:        %.2f%n", dao.getRevenueToday());
        System.out.printf(" • Doanh thu hôm qua:        %.2f%n", dao.getRevenueYesterday());
        System.out.printf(" • Doanh thu tháng này:      %.2f%n", dao.getRevenueThisMonth());
        System.out.printf(" • Doanh thu tháng trước:    %.2f%n", dao.getRevenueLastMonth());
        System.out.printf(" • Doanh thu năm nay:        %.2f%n", dao.getRevenueThisYear());

        // B. Hóa đơn
        System.out.println("\n=== B. THỐNG KÊ HÓA ĐƠN ===");
        int totalInvoices = dao.getTotalInvoices();
        int paidInvoices = dao.getTotalInvoicesPaid();
        int unpaidInvoices = totalInvoices - paidInvoices;
        double avgOrderValue = dao.getAverageOrderValue();

        System.out.printf(" • Tổng số hóa đơn:          %d%n", totalInvoices);
        System.out.printf(" • Đã thanh toán:            %d%n", paidInvoices);
        System.out.printf(" • Chưa thanh toán:          %d%n", unpaidInvoices);
        System.out.printf(" • Giá trị đơn trung bình:   %.2f%n", avgOrderValue);

        // C. Kho hàng
        System.out.println("\n=== C. TỒN KHO SẢN PHẨM ===");
        System.out.printf(" • Hết hàng:                 %d%n", dao.getOutOfStockProductCount());
        System.out.printf(" • Sắp hết (<5):             %d%n", dao.getLowStockProductCount());

        // D. Doanh thu từng ngày trong tháng hiện tại
        System.out.println("\n=== D. DOANH THU THEO NGÀY (THÁNG HIỆN TẠI) ===");
        List<Double> revenues = dao.getDailyRevenueThisMonth();
        for (int i = 0; i < revenues.size(); i++) {
            System.out.printf("   Ngày %2d: %.2f%n", i + 1, revenues.get(i));
        }

        // E. Doanh thu theo danh mục
        System.out.println("\n=== E. DOANH THU THEO DANH MỤC ===");
        dao.getRevenueByCategory().forEach((cat, rev)
                -> System.out.printf(" • %-10s: %.2f%n", cat, rev)
        );

        // F. Top 5 sản phẩm bán chạy
        System.out.println("\n=== F. TOP 5 SẢN PHẨM BÁN CHẠY ===");
        dao.getTopSellingProducts(5).forEach(tp
                -> System.out.printf(" • %-25s  | SL: %-3d | Doanh thu: %.2f%n",
                        tp.getProductName(), tp.getQuantitySold(), tp.getTotalRevenue())
        );

        // G. Load toàn bộ dashboard (tổng hợp)
        System.out.println("\n=== G. DASHBOARD FULL OBJECT ===");
        DashboardProducts dash = dao.loadDashboardProducts();
        System.out.println(" ➤ Tổng hóa đơn:          " + dash.getTotalInvoices());
        System.out.println(" ➤ Đơn chưa thanh toán:   " + dash.getTotalInvoicesUnpaid());
        System.out.println(" ➤ Doanh thu hôm nay:     " + dash.getRevenueToday());
        System.out.println(" ➤ Số mục top sản phẩm:   " + dash.getTopSellingProducts().size());
    }
}
