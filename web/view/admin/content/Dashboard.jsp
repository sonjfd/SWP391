<%-- 
    Document   : Dashboard
    Created on : Jun 17, 2025
    Author     : Grok
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8" />
    <title>Dashboard - Phòng Khám Thú Y</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Hệ thống đặt lịch thú cưng" />
    <meta name="keywords" content="Pet, Appointment, Dashboard, Veterinary" />
    <meta name="author" content="FPT" />
    <!-- favicon -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico.png">
    <!-- Bootstrap -->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- simplebar -->
    <link href="${pageContext.request.contextPath}/assets/css/simplebar.css" rel="stylesheet" type="text/css" />
    <!-- Icons -->
    <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
    <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
    <!-- CSS nội tuyến -->
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
        }
        .layout-specing {
            padding: 15px;
        }
        h5.mb-0 {
            color: #333;
            margin-bottom: 15px;
            font-size: 20px;
        }
        .features.feature-primary {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            padding: 15px;
            text-align: center;
            transition: transform 0.3s ease-in-out;
            height: 100px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .features.feature-primary:hover {
            transform: translateY(-3px);
        }
        .features .icon {
            background-color: #007bff;
            color: #fff;
            border-radius: 5px;
            width: 30px;
            height: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 16px;
            line-height: 30px;
        }
        .features .flex-1 h5 {
            font-size: 20px;
            color: #007bff;
            margin: 8px 0 3px;
            line-height: 1.2;
        }
        .features .flex-1 p {
            color: #555;
            margin: 0;
            font-size: 12px;
            line-height: 1.4;
        }
        .card {
            border-radius: 10px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            padding: 15px;
            background-color: #fff;
            margin-bottom: 15px;
        }
        .card h6 {
            font-size: 14px;
            color: #333;
            margin-bottom: 10px;
            line-height: 1.4;
        }
        .form-select {
            width: 120px;
            padding: 4px;
            font-size: 12px;
            height: 30px;
        }
        .apex-chart {
            min-height: 250px;
        }
        #preloader {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255, 255, 255, 0.8);
            z-index: 9999;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        #preloader #status {
            text-align: center;
        }
        #preloader .spinner {
            width: 30px;
            height: 30px;
            position: relative;
        }
        #preloader .double-bounce1, #preloader .double-bounce2 {
            width: 100%;
            height: 100%;
            border-radius: 50%;
            background-color: #007bff;
            opacity: 0.6;
            position: absolute;
            top: 0;
            left: 0;
            animation: bounce 2.0s infinite ease-in-out;
        }
        #preloader .double-bounce2 {
            animation-delay: -1.0s;
        }
        @keyframes bounce {
            0%, 100% { transform: scale(0.0); }
            50% { transform: scale(1.0); }
        }
        /* Đảm bảo căn đều các cột */
        .row {
            display: flex;
            flex-wrap: wrap;
            margin: -7.5px;
        }
        .row > [class*="col-"] {
            padding: 7.5px;
        }
    </style>
</head>
<body>
    <!-- Loader -->
    <div id="preloader">
        <div id="status">
            <div class="spinner">
                <div class="double-bounce1"></div>
                <div class="double-bounce2"></div>
            </div>
        </div>
    </div>
    <!-- Loader -->
    <%@include file="../layout/Header.jsp" %>
    <div class="container-fluid">
        <div class="layout-specing">
            <h5 class="mb-0">Dashboard</h5>

            <div class="row">
                <div class="col-xl-2 col-lg-4 col-md-4 col-sm-6 mt-3">
                    <div class="card features feature-primary rounded border-0 shadow">
                        <div class="d-flex align-items-center">
                            <div class="icon text-center rounded-md">
                                <i class="uil uil-paw"></i>
                            </div>
                            <div class="flex-1 ms-2">
                                <h5 class="mb-0">${dashboardData.totalPets}</h5>
                                <p class="text-muted mb-0">Thú cưng</p>
                            </div>
                        </div>
                    </div>
                </div><!--end col-->

                <div class="col-xl-2 col-lg-4 col-md-4 col-sm-6 mt-3">
                    <div class="card features feature-primary rounded border-0 shadow">
                        <div class="d-flex align-items-center">
                            <div class="icon text-center rounded-md">
                                <i class="uil uil-usd-circle"></i>
                            </div>
                            <div class="flex-1 ms-2">
                                <h5 class="mb-0">${dashboardData.totalRevenue}</h5>
                                <p class="text-muted mb-0">Doanh thu (VND)</p>
                            </div>
                        </div>
                    </div>
                </div><!--end col-->

                <div class="col-xl-2 col-lg-4 col-md-4 col-sm-6 mt-3">
                    <div class="card features feature-primary rounded border-0 shadow">
                        <div class="d-flex align-items-center">
                            <div class="icon text-center rounded-md">
                                <i class="uil uil-calendar-alt"></i>
                            </div>
                            <div class="flex-1 ms-2">
                                <h5 class="mb-0">${dashboardData.totalAppointments}</h5>
                                <p class="text-muted mb-0">Cuộc hẹn</p>
                            </div>
                        </div>
                    </div>
                </div><!--end col-->

                <div class="col-xl-2 col-lg-4 col-md-4 col-sm-6 mt-3">
                    <div class="card features feature-primary rounded border-0 shadow">
                        <div class="d-flex align-items-center">
                            <div class="icon text-center rounded-md">
                                <i class="uil uil-users-alt"></i>
                            </div>
                            <div class="flex-1 ms-2">
                                <h5 class="mb-0">${dashboardData.totalUsers}</h5>
                                <p class="text-muted mb-0">Người dùng</p>
                            </div>
                        </div>
                    </div>
                </div><!--end col-->

                <div class="col-xl-2 col-lg-4 col-md-4 col-sm-6 mt-3">
                    <div class="card features feature-primary rounded border-0 shadow">
                        <div class="d-flex align-items-center">
                            <div class="icon text-center rounded-md">
                                <i class="uil uil-stethoscope"></i>
                            </div>
                            <div class="flex-1 ms-2">
                                <h5 class="mb-0">${dashboardData.totalDoctors}</h5>
                                <p class="text-muted mb-0">Bác sĩ</p>
                            </div>
                        </div>
                    </div>
                </div><!--end col-->

                <div class="col-xl-2 col-lg-4 col-md-4 col-sm-6 mt-3">
                    <div class="card features feature-primary rounded border-0 shadow">
                        <div class="d-flex align-items-center">
                            <div class="icon text-center rounded-md">
                                <i class="uil uil-medkit"></i>
                            </div>
                            <div class="flex-1 ms-2">
                                <h5 class="mb-0">${dashboardData.totalNurses}</h5>
                                <p class="text-muted mb-0">Y tá</p>
                            </div>
                        </div>
                    </div>
                </div><!--end col-->
            </div><!--end row-->

            <div class="row">
                <div class="col-xl-8 col-lg-7 mt-3">
                    <div class="card shadow border-0">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <h6 class="align-items-center mb-0">Cuộc hẹn theo ngày</h6>
                            <div class="mb-0 position-relative">
                                <select class="form-select form-control" id="yearchart">
                                    <option value="7days" selected>7 ngày qua</option>
                                    <option value="30days">30 ngày qua</option>
                                </select>
                            </div>
                        </div>
                        <div id="appointmentChart" class="apex-chart"></div>
                    </div>
                </div><!--end col-->

                <div class="col-xl-4 col-lg-5 mt-3">
                    <div class="card shadow border-0">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <h6 class="align-items-center mb-0">Thú cưng theo loài</h6>
                            <div class="mb-0 position-relative">
                                <select class="form-select form-control" id="specieschart">
                                    <option value="7days" selected>7 ngày qua</option>
                                    <option value="30days">30 ngày qua</option>
                                </select>
                            </div>
                        </div>
                        <div id="speciesChart" class="apex-chart"></div>
                    </div>
                </div><!--end col-->
            </div><!--end row-->
        </div>
    </div><!--end container-->

    <!-- JavaScript -->
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/simplebar.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/apexcharts.min.js"></script>
    <script>
        // Ẩn preloader
        function hidePreloader() {
            const preloader = document.getElementById('preloader');
            if (preloader) {
                preloader.style.display = 'none';
            }
        }

        // Khai báo biến toàn cục cho biểu đồ
        let appointmentChart = null;
        let speciesChart = null;

        // Hàm fetch với timeout
        async function fetchWithTimeout(url, options = {}, timeout = 5000) {
            const controller = new AbortController();
            const id = setTimeout(() => controller.abort(), timeout);
            try {
                const response = await fetch(url, { ...options, signal: controller.signal });
                clearTimeout(id);
                return response;
            } catch (error) {
                clearTimeout(id);
                throw error;
            }
        }

        document.addEventListener('DOMContentLoaded', function () {
            // Hàm lấy dữ liệu biểu đồ
            function loadChartData(period) {
                // Kiểm tra period, mặc định là '7days' nếu không hợp lệ
                if (!period) {
                    console.warn('Period không được định nghĩa, sử dụng mặc định: 7days');
                    period = '7days';
                }
                console.log('Period:', period);

                // Tạo URL
                const contextPath = '${pageContext.request.contextPath}';
                const url = contextPath + '/appointmentreport?period=' + encodeURIComponent(period);
                console.log('Fetching URL:', url);

                fetchWithTimeout(url)
                    .then(response => {
                        if (!response.ok) {
                            throw new Error(`HTTP error! Status: ${response.status}`);
                        }
                        return response.json();
                    })
                    .then(data => {
                        console.log('Received data:', data);
                        hidePreloader();

                        // Kiểm tra dữ liệu
                        if (!data.dates || !data.counts || !data.species || !data.speciesCounts) {
                            console.error('Dữ liệu không hợp lệ:', data);
                            return;
                        }

                        // Hủy biểu đồ cũ
                        if (appointmentChart) {
                            appointmentChart.destroy();
                        }
                        // Vẽ biểu đồ cuộc hẹn theo ngày
                        const appointmentOptions = {
                            chart: {
                                type: 'bar',
                                height: 250
                            },
                            series: [{
                                name: 'Số cuộc hẹn',
                                data: data.counts
                            }],
                            xaxis: {
                                categories: data.dates,
                                title: { text: 'Ngày' }
                            },
                            yaxis: {
                                title: { text: 'Số lượng' }
                            },
                            colors: ['#007bff']
                        };
                        appointmentChart = new ApexCharts(document.querySelector("#appointmentChart"), appointmentOptions);
                        appointmentChart.render();

                        // Hủy biểu đồ loài cũ
                        if (speciesChart) {
                            speciesChart.destroy();
                        }
                        // Vẽ biểu đồ thú cưng theo loài
                        const speciesOptions = {
                            chart: {
                                type: 'bar',
                                height: 250
                            },
                            series: [{
                                name: 'Số lượng thú cưng',
                                data: data.speciesCounts
                            }],
                            xaxis: {
                                categories: data.species,
                                title: { text: 'Loài' }
                            },
                            yaxis: {
                                title: { text: 'Số lượng' }
                            },
                            colors: ['#28a745']
                        };
                        speciesChart = new ApexCharts(document.querySelector("#speciesChart"), speciesOptions);
                        speciesChart.render();
                    })
                    .catch(error => {
                        console.error('Lỗi khi tải dữ liệu biểu đồ:', error);
                        hidePreloader();
                    });
            }

            // Load dữ liệu mặc định (7 ngày)
            loadChartData('7days');

            // Xử lý thay đổi khoảng thời gian
            const yearChartSelect = document.getElementById('yearchart');
            if (yearChartSelect) {
                yearChartSelect.addEventListener('change', function() {
                    loadChartData(this.value);
                });
            } else {
                console.error('Không tìm thấy element #yearchart');
            }

            const speciesChartSelect = document.getElementById('specieschart');
            if (speciesChartSelect) {
                speciesChartSelect.addEventListener('change', function() {
                    loadChartData(this.value);
                });
            } else {
                console.error('Không tìm thấy element #specieschart');
            }

            // Ẩn preloader sau 5 giây nếu fetch bị treo
            setTimeout(hidePreloader, 5000);
        });
    </script>
</body>
</html>