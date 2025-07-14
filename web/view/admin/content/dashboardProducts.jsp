<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Model.DashboardProducts" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.stream.Collectors" %>

<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Dashboard Products</title>
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" />
    </head>
    <style>
        .highlight-link {
    display: inline-block;
    background-color: #007bff;  
    color: white;               
    padding: 10px 20px;         
    text-decoration: none;      
    border-radius: 8px;         
    font-weight: bold;
    transition: background-color 0.3s ease;
  }

  .highlight-link:hover {
    background-color: #0056b3;  
  }
    </style>
    <body>
        <%@ include file="../layout/Header.jsp" %>
        <div class="container-fluid">
            <div class="layout-specing">
                <h3 class="mb-3">Dashboard Products</h3>
                <a href="${pageContext.request.contextPath}/admin-dashboard" class="highlight-link">Báo cáo tổng quan</a>
                <%
                    DashboardProducts dashboard = (DashboardProducts) request.getAttribute("dashboard");
                    List<Double> thisMonthRevenue = (List<Double>) request.getAttribute("thisMonthRevenue");
                    List<Double> lastMonthRevenue = (List<Double>) request.getAttribute("lastMonthRevenue");
                    Map<String, Double> revenueByCategory = dashboard.getRevenueByCategory();

                    String thisMonthData = thisMonthRevenue.stream()
                        .map(d -> String.format("%.0f", d)).collect(Collectors.joining(","));
                    String lastMonthData = lastMonthRevenue.stream()
                        .map(d -> String.format("%.0f", d)).collect(Collectors.joining(","));

                    String categoryLabels = revenueByCategory.keySet().stream()
                        .map(label -> "'" + label + "'").collect(Collectors.joining(","));
                    String categoryData = revenueByCategory.values().stream()
                        .map(value -> String.format("%.0f", value)).collect(Collectors.joining(","));

                    int thisMonthDays = thisMonthRevenue.size();
                    int lastMonthDays = lastMonthRevenue.size();

                    double revenueToday = dashboard.getRevenueToday();
                    double revenueYesterday = dashboard.getRevenueYesterday();
                    double revenueThisMonth = dashboard.getRevenueThisMonth();
                    double revenueLastMonth = dashboard.getRevenueLastMonth();
                    double percentToday = (revenueYesterday > 0) ? ((revenueToday - revenueYesterday) / revenueYesterday) * 100 : 0;
                    double percentMonth = (revenueLastMonth > 0) ? ((revenueThisMonth - revenueLastMonth) / revenueLastMonth) * 100 : 0;
                %>

                <!-- Tailwind CSS CDN -->
                <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
                <!-- Chart.js CDN -->
                <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

                <!-- ===== 4 Thẻ Tổng Quan ===== -->
                <div class="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-4 gap-4 p-6">
                    <div class="bg-white rounded-2xl shadow-md p-4">
                        <p class="text-gray-500 text-sm">Doanh thu hôm nay</p>
                        <p class="text-2xl font-bold text-gray-800 mt-1">
                            <%= String.format("%,.0f", revenueToday) %> VND
                        </p>
                        <p class="text-sm <%= percentToday >= 0 ? "text-green-500" : "text-red-500" %>">
                            <%= percentToday >= 0 ? "▲" : "▼" %> <%= String.format("%.1f", Math.abs(percentToday)) %>% so với hôm qua
                        </p>
                    </div>
                    <div class="bg-white rounded-2xl shadow-md p-4">
                        <p class="text-gray-500 text-sm">Doanh thu tháng này</p>
                        <p class="text-2xl font-bold text-gray-800 mt-1">
                            <%= String.format("%,.0f", revenueThisMonth) %> VND
                        </p>
                        <p class="text-sm <%= percentMonth >= 0 ? "text-green-500" : "text-red-500" %>">
                            <%= percentMonth >= 0 ? "▲" : "▼" %> <%= String.format("%.1f", Math.abs(percentMonth)) %>% so với tháng trước
                        </p>
                    </div>
                    <div class="bg-white rounded-2xl shadow-md p-4">
                        <p class="text-gray-500 text-sm">Hóa đơn đã thanh toán</p>
                        <p class="text-2xl font-bold text-gray-800 mt-1">
                            <%= dashboard.getTotalInvoicesPaid() %> / <%= dashboard.getTotalInvoices() %>
                        </p>
                        <p class="text-sm text-blue-500">
                            <%= String.format("%.1f", ((double)dashboard.getTotalInvoicesPaid() / dashboard.getTotalInvoices()) * 100) %>% đã thanh toán
                        </p>
                    </div>
                   
                </div>

                <!-- ===== Biểu đồ Doanh thu theo Ngày ===== -->
                <div class="bg-white rounded-2xl shadow-md p-6 mt-4 mx-6">
                    <div class="flex justify-between items-center mb-4">
                        <h2 class="text-lg font-semibold text-gray-700">Doanh thu theo ngày</h2>
                        <select id="monthSelect" class="border border-gray-300 rounded px-3 py-1 text-sm">
                            <option value="this">Tháng này</option>
                            <option value="last">Tháng trước</option>
                        </select>
                    </div>
                    <canvas id="revenueChart" height="100"></canvas>
                </div>

                <!-- ===== Biểu đồ Doanh thu theo Danh mục ===== -->
                <div class="bg-white rounded-2xl shadow-md p-6 mt-6 mx-6">
                    <h2 class="text-lg font-semibold text-gray-700 mb-4">Tỷ lệ doanh thu theo danh mục</h2>
                    <div class="w-full max-w-md mx-auto">
                        <canvas id="categoryChart" style="height:300px;"></canvas>
                    </div>
                </div>
                <!-- ===== Top sản phẩm bán chạy ===== -->
                <div class="bg-white rounded-2xl shadow-md p-6 mt-6 mx-6">
                    <h2 class="text-lg font-semibold text-gray-700 mb-4">Top sản phẩm bán chạy</h2>
                    <div class="overflow-x-auto">
                        <table class="min-w-full text-sm text-left text-gray-600">
                            <thead class="text-xs uppercase bg-gray-100 text-gray-500">
                                <tr>
                                    <th scope="col" class="px-4 py-3">Sản phẩm</th>
                                    <th scope="col" class="px-4 py-3">Số lượng bán</th>
                                    <th scope="col" class="px-4 py-3">Doanh thu</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    for (Model.TopProduct p : dashboard.getTopSellingProducts()) {
                                %>
                                <tr class="border-b">
                                    <td class="px-4 py-2 font-medium text-gray-800"><%= p.getProductName() %></td>
                                    <td class="px-4 py-2"><%= p.getQuantitySold() %></td>
                                    <td class="px-4 py-2"><%= String.format("%,.0f", p.getTotalRevenue()) %> VND</td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <script>
            const thisMonthLabels = Array.from({length: <%= thisMonthDays %>}, (_, i) => i + 1);
            const lastMonthLabels = Array.from({length: <%= lastMonthDays %>}, (_, i) => i + 1);
            const thisMonthData = [<%= thisMonthData %>];
            const lastMonthData = [<%= lastMonthData %>];

            const ctx = document.getElementById('revenueChart').getContext('2d');
            const revenueChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: thisMonthLabels,
                    datasets: [{
                            label: 'Doanh thu hàng ngày',
                            data: thisMonthData,
                            fill: true,
                            borderColor: 'rgba(59, 130, 246, 1)',
                            backgroundColor: 'rgba(59, 130, 246, 0.2)',
                            tension: 0.3,
                            borderWidth: 3
                        }]
                },
                options: {
                    responsive: true,
                    plugins: {legend: {position: 'top'}},
                    scales: {
                        y: {
                            beginAtZero: true,
                            suggestedMax: 2000000, // gợi ý giới hạn trên gần với doanh thu cao nhất
                            ticks: {
                                stepSize: 100000,
                                callback: value => value.toLocaleString("vi-VN") + " VND"
                            }
                        },
                        x: {
                            title: {display: true, text: 'Ngày'}
                        }
                    }
                }
            });

            document.getElementById("monthSelect").addEventListener("change", function () {
                const selected = this.value;
                if (selected === "this") {
                    revenueChart.data.labels = thisMonthLabels;
                    revenueChart.data.datasets[0].data = thisMonthData;
                } else {
                    revenueChart.data.labels = lastMonthLabels;
                    revenueChart.data.datasets[0].data = lastMonthData;
                }
                revenueChart.update();
            });

            // Biểu đồ danh mục
            const categoryCtx = document.getElementById('categoryChart').getContext('2d');
            const categoryChart = new Chart(categoryCtx, {
                type: 'pie',
                data: {
                    labels: [<%= categoryLabels %>],
                    datasets: [{
                            data: [<%= categoryData %>],
                            backgroundColor: [
                                '#3b82f6', '#10b981', '#f59e0b', '#ef4444', '#8b5cf6',
                                '#ec4899', '#14b8a6', '#f97316', '#0ea5e9', '#22c55e'
                            ]
                        }]
                },
                options: {
                    plugins: {
                        legend: {position: 'right'}
                    }
                }
            });
        </script>
    </body>
</html>