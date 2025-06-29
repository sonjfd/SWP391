<%-- 
    Document   : Dashboard
    Created on : Jun 18, 2025
    Author     : Grok
    Description: Admin dashboard for SWP391 with bar charts, clears old charts on period change
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Dashboard - PetCareSystem</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/apexcharts@3.53.0/dist/apexcharts.min.js"></script>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f5f6fa; margin: 0; padding: 0; }
        .container-fluid { padding: 20px; }
        .dashboard-title { color: #2c3e50; font-size: 24px; margin-bottom: 20px; font-weight: bold; }
        .metric-card {
            background: #fff; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            padding: 15px; text-align: center; height: 100px; display: flex; align-items: center; justify-content: center;
        }
        .metric-card .icon {
            background: #007bff; color: #fff; border-radius: 50%; width: 40px; height: 40px;
            display: flex; align-items: center; justify-content: center; font-size: 18px; margin-right: 10px;
        }
        .metric-card .icon.green { background: #28a745; }
        .metric-card h5 { font-size: 20px; color: #007bff; margin: 0; font-weight: bold; }
        .metric-card p { color: #6c757d; font-size: 12px; margin: 5px 0 0; }
        .chart-card {
            background: #fff; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            padding: 15px; margin-bottom: 20px;
        }
        .chart-card h6 { font-size: 16px; color: #333; margin-bottom: 10px; font-weight: bold; }
        .chart-card .form-select { width: 150px; padding: 8px; font-size: 12px; border-radius: 4px; }
        .apex-chart { min-height: 250px; }
        .no-data { text-align: center; color: #6c757d; font-size: 14px; padding: 20px; }
        .row { margin: -10px; }
        .row > [class*="col-"] { padding: 10px; }
        .navbar { background-color: #fff; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        @media (max-width: 768px) {
            .metric-card { height: 80px; }
            .metric-card h5 { font-size: 16px; }
            .metric-card p { font-size: 10px; }
            .chart-card .form-select { width: 120px; }
            .dashboard-title { font-size: 20px; }
            .apex-chart { min-height: 200px; }
        }
    </style>
</head>
<body>
    <%@include file="../layout/Header.jsp" %>
    <nav class="navbar navbar-expand-lg">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">PetCareSystem</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/admin-dashboard">Dashboard</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <div class="container-fluid">
        <h5 class="dashboard-title">Tổng Quan</h5>
        <div class="row">
            <div class="col-xl-2 col-lg-4 col-md-6 col-sm-6">
                <div class="metric-card">
                    <div class="icon"><i class="fas fa-paw"></i></div>
                    <div>
                        <h5>${dashboardData.totalPets}</h5>
                        <p>Thú cưng</p>
                    </div>
                </div>
            </div>
            <div class="col-xl-2 col-lg-4 col-md-6 col-sm-6">
                <div class="metric-card">
                    <div class="icon"><i class="fas fa-money-bill-wave"></i></div>
                    <div>
                        <h5>${dashboardData.totalRevenue}</h5>
                        <p>Doanh thu (VND)</p>
                    </div>
                </div>
            </div>
            <div class="col-xl-2 col-lg-4 col-md-6 col-sm-6">
                <div class="metric-card">
                    <div class="icon"><i class="fas fa-calendar-check"></i></div>
                    <div>
                        <h5>${dashboardData.totalAppointments}</h5>
                        <p>Cuộc hẹn</p>
                    </div>
                </div>
            </div>
            <div class="col-xl-2 col-lg-4 col-md-6 col-sm-6">
                <div class="metric-card">
                    <div class="icon"><i class="fas fa-users"></i></div>
                    <div>
                        <h5>${dashboardData.totalUsers}</h5>
                        <p>Người dùng</p>
                    </div>
                </div>
            </div>
            <div class="col-xl-2 col-lg-4 col-md-6 col-sm-6">
                <div class="metric-card">
                    <div class="icon green"><i class="fas fa-user-md"></i></div>
                    <div>
                        <h5>${dashboardData.totalDoctors}</h5>
                        <p>Bác sĩ</p>
                    </div>
                </div>
            </div>
            <div class="col-xl-2 col-lg-4 col-md-6 col-sm-6">
                <div class="metric-card">
                    <div class="icon green"><i class="fas fa-medkit"></i></div>
                    <div>
                        <h5>${dashboardData.totalNurses}</h5>
                        <p>Y tá</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xl-6 col-lg-12">
                <div class="chart-card">
                    <div class="d-flex justify-content-between align-items-center">
                        <h6>Doanh Thu Theo Ngày</h6>
                        <select class="form-select" id="period-revenue">
                            <option value="7days" selected>7 ngày qua</option>
                            <option value="30days">30 ngày qua</option>
                        </select>
                    </div>
                    <div id="revenueChart" class="apex-chart"></div>
                </div>
            </div>
            <div class="col-xl-6 col-lg-12">
                <div class="chart-card">
                    <div class="d-flex justify-content-between align-items-center">
                        <h6>Số Lượng Cuộc Hẹn</h6>
                        <select class="form-select" id="period-appointment">
                            <option value="7days" selected>7 ngày qua</option>
                            <option value="30days">30 ngày qua</option>
                        </select>
                    </div>
                    <div id="appointmentChart" class="apex-chart"></div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        console.log('Dashboard script started');

        // Lưu instance của biểu đồ
        let revenueChartInstance = null;
        let appointmentChartInstance = null;

        function showNoData(chartId, chartType) {
            const chartElement = document.getElementById(chartId);
            if (chartElement) {
                const message = chartType === 'revenue' ? 'Không có dữ liệu doanh thu' : 'Không có dữ liệu cuộc hẹn';
                console.log(`No data for ${chartId}: ${message}`);
                chartElement.innerHTML = `<div class="no-data">${message}</div>`;
            }
        }

        function renderChart(chartId, chartType, categories, data) {
            console.log(`Rendering ${chartType} chart for ${chartId}`);
            // Xóa biểu đồ cũ nếu tồn tại
            if (chartType === 'revenue' && revenueChartInstance) {
                console.log('Destroying old revenue chart');
                revenueChartInstance.destroy();
                revenueChartInstance = null;
            } else if (chartType === 'appointment' && appointmentChartInstance) {
                console.log('Destroying old appointment chart');
                appointmentChartInstance.destroy();
                appointmentChartInstance = null;
            }
            // Xóa nội dung cũ trong div
            const chartElement = document.getElementById(chartId);
            if (chartElement) chartElement.innerHTML = '';

            const options = {
                chart: { type: 'bar', height: 250, toolbar: { show: false } },
                series: [{ name: chartType === 'revenue' ? 'Doanh thu' : 'Cuộc hẹn', data }],
                xaxis: { categories, title: { text: 'Ngày' } },
                yaxis: {
                    title: { text: chartType === 'revenue' ? 'VND' : 'Số lượng' },
                    labels: { formatter: val => chartType === 'revenue' ? val.toLocaleString('vi-VN') : Math.floor(val) }
                },
                colors: [chartType === 'revenue' ? '#007bff' : '#28a745'],
                plotOptions: { bar: { columnWidth: '50%' } }
            };
            const chart = new ApexCharts(document.getElementById(chartId), options);
            chart.render();
            console.log(`${chartType} chart rendered`);
            // Lưu instance
            if (chartType === 'revenue') revenueChartInstance = chart;
            else appointmentChartInstance = chart;
        }

        function loadChartData(period, chartType) {
            const url = `${window.location.origin}/SWP391/admin-appointment-report?period=${period}`;
            console.log(`Fetching ${chartType} data: ${url}`);
            fetch(url)
                .then(response => {
                    console.log(`Status for ${chartType}: ${response.status}`);
                    if (!response.ok) throw new Error('Fetch failed');
                    return response.json();
                })
                .then(data => {
                    console.log(`Data for ${chartType}:`, data);
                    if (chartType === 'revenue' && data.revenueDates?.length > 0 && data.revenues?.length > 0) {
                        renderChart('revenueChart', 'revenue', data.revenueDates, data.revenues);
                    } else if (chartType === 'revenue') {
                        showNoData('revenueChart', 'revenue');
                    }
                    if (chartType === 'appointment' && data.appointmentDates?.length > 0 && data.appointmentCounts?.length > 0) {
                        renderChart('appointmentChart', 'appointment', data.appointmentDates, data.appointmentCounts);
                    } else if (chartType === 'appointment') {
                        showNoData('appointmentChart', 'appointment');
                    }
                })
                .catch(error => {
                    console.error(`Error fetching ${chartType}:`, error);
                    showNoData(chartType === 'revenue' ? 'revenueChart' : 'appointmentChart', chartType);
                });
        }

        document.addEventListener('DOMContentLoaded', () => {
            console.log('DOM loaded');
            loadChartData('7days', 'revenue');
            loadChartData('7days', 'appointment');
            document.getElementById('period-revenue').addEventListener('change', e => {
                console.log('Revenue period:', e.target.value);
                loadChartData(e.target.value, 'revenue');
            });
            document.getElementById('period-appointment').addEventListener('change', e => {
                console.log('Appointment period:', e.target.value);
                loadChartData(e.target.value, 'appointment');
            });
        });
    </script>
</body>
</html>