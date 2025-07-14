<%@page  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Chart.js for charts -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f9;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        .card {
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-bottom: 20px;
        }
        .metric {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 15px;
        }
        .metric i {
            font-size: 24px;
            color: #4CAF50;
        }
        .metric h3 {
            margin: 0;
            font-size: 18px;
            color: #333;
        }
        .metric p {
            margin: 0;
            font-size: 24px;
            font-weight: bold;
            color: #4CAF50;
        }
        .metric p span {
            font-size: 16px;
            color: #666;
        }
        .filter-form {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }
        .filter-form input, .filter-form select {
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .filter-form button {
            background-color: #4CAF50;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .filter-form button:hover {
            background-color: #45a049;
        }
        .chart-container {
            max-width: 600px;
            margin-bottom: 20px;
        }
        .container {
    margin-top: 60px; 
  }
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
</head>
<body>
    
        <!-- Loader -->

        <%@include file="../layout/Header.jsp" %>
        
    <div class="container">
        <a href="${pageContext.request.contextPath}/admin-dashboardProducts" class="highlight-link">Báo cáo sản phẩm</a>
        <!-- Filter Form -->
        <div class="card">
            <form method="get" action="admin-dashboard" class="filter-form">
                <label>
                    Start Date:
                    <input type="date" name="startDate" value="${startDate}">
                </label>
                <label>
                    End Date:
                    <input type="date" name="endDate" value="${endDate}">
                </label>
                <label>
                    Period Type:
                    <select name="periodType">
                        <option value="day" ${periodType == 'day' ? 'selected' : ''}>Ngày</option>
                        <option value="month" ${periodType == 'month' ? 'selected' : ''}>Tháng</option>
                        <option value="year" ${periodType == 'year' ? 'selected' : ''}>Năm</option>
                    </select>
                </label>
                <button type="submit"><i class="fas fa-filter"></i> Lọc</button>
            </form>
                    
        </div>
                    
        <!-- Summary Metrics -->
        <div class="card">
            <h2 class="text-2xl font-bold mb-4">Tổng quan</h2>
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
                <div class="metric">
                    <i class="fas fa-dollar-sign"></i>
                    <div>
                        <h3>Doanh thu dịch vụ (VNĐ)</h3>
                        <p><fmt:formatNumber value="${summary.serviceRevenue}" pattern="#,##0.00"/> 
                            <span>(Trước: <fmt:formatNumber value="${summary.previousServiceRevenue}" pattern="#,##0.00"/>)</span></p>
                    </div>
                </div>
                <div class="metric">
                    <i class="fas fa-users"></i>
                    <div>
                        <h3>Khách hàng mới</h3>
                        <p><c:out value="${summary.newCustomers}"/> 
                            <span>(Trước: <c:out value="${summary.previousNewCustomers}"/>)</span></p>
                    </div>
                </div>
                <div class="metric">
                    <i class="fas fa-paw"></i>
                    <div>
                        <h3>Thú cưng mới</h3>
                        <p><c:out value="${summary.newPets}"/> 
                            <span>(Trước: <c:out value="${summary.previousNewPets}"/>)</span></p>
                    </div>
                </div>
                <div class="metric">
                    <i class="fas fa-calendar-check"></i>
                    <div>
                        <h3>Tổng số cuộc hẹn</h3>
                        <p><c:out value="${summary.bookedCount + summary.completedCount + summary.cancelRequestedCount + summary.canceledCount}"/></p>
                    </div>
                </div>
                <div class="metric">
                    <i class="fas fa-stethoscope"></i>
                    <div>
                        <h3>Tổng số bác sĩ</h3>
                        <p><c:out value="${summary.doctorCount}"/></p>
                    </div>
                </div>
                <div class="metric">
                    <i class="fas fa-user-nurse"></i>
                    <div>
                        <h3>Tổng số y tá</h3>
                        <p><c:out value="${summary.nurseCount}"/></p>
                    </div>
                </div>
                <div class="metric">
                    <i class="fas fa-star"></i>
                    <div>
                        <h3>Điểm đánh giá bác sĩ</h3>
                        <p><fmt:formatNumber value="${summary.averageDoctorRating}" pattern="#,##0.00"/></p>
                    </div>
                </div>
                <div class="metric">
                    <i class="fas fa-thumbs-up"></i>
                    <div>
                        <h3>Tỷ lệ đánh giá tích cực</h3>
                        <p><fmt:formatNumber value="${summary.positiveRatingRate}" pattern="#,##0.00"/>%</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Charts -->
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-4">
            <div class="card chart-container">
                <h2 class="text-xl font-bold mb-4">Tỷ lệ trạng thái cuộc hẹn</h2>
                <canvas id="appointmentStatusChart"></canvas>
            </div>
            <div class="card chart-container">
                <h2 class="text-xl font-bold mb-4">So sánh doanh thu theo kỳ</h2>
                <canvas id="revenueComparisonChart"></canvas>
            </div>
            <div class="card chart-container">
                <h2 class="text-xl font-bold mb-4">Xu hướng doanh thu</h2>
                <canvas id="revenueTrendChart"></canvas>
            </div>
            <div class="card chart-container">
                <h2 class="text-xl font-bold mb-4">Xu hướng khách hàng mới</h2>
                <canvas id="customerTrendChart"></canvas>
            </div>
            <div class="card chart-container">
                <h2 class="text-xl font-bold mb-4">Xu hướng thú cưng mới</h2>
                <canvas id="petTrendChart"></canvas>
            </div>
            <div class="card chart-container">
                <h2 class="text-xl font-bold mb-4">Xu hướng cuộc hẹn</h2>
                <canvas id="appointmentTrendChart"></canvas>
            </div>
        </div>

        <!-- Chart.js Scripts -->
        <script>
            // Appointment Status Chart (Pie)
            new Chart(document.getElementById('appointmentStatusChart'), {
                type: 'pie',
                data: {
                    labels: ['Booked', 'Completed', 'Cancel Requested', 'Canceled'],
                    datasets: [{
                        data: [
                            ${summary.bookedCount},
                            ${summary.completedCount},
                            ${summary.cancelRequestedCount},
                            ${summary.canceledCount}
                        ],
                        backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56', '#E7E9ED']
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: { position: 'top' },
                        title: { display: true, text: 'Tỷ lệ trạng thái cuộc hẹn' }
                    }
                }
            });

            // Revenue Comparison Chart (Bar)
            new Chart(document.getElementById('revenueComparisonChart'), {
                type: 'bar',
                data: {
                    labels: ['Kỳ trước', 'Kỳ hiện tại'],
                    datasets: [{
                        label: 'Doanh thu (VNĐ)',
                        data: [${summary.previousServiceRevenue}, ${summary.serviceRevenue}],
                        backgroundColor: ['#36A2EB', '#4CAF50'],
                        borderColor: ['#36A2EB', '#4CAF50'],
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: { beginAtZero: true, title: { display: true, text: 'Doanh thu (VNĐ)' } },
                        x: { title: { display: true, text: 'Kỳ' } }
                    },
                    plugins: {
                        legend: { display: false },
                        title: { display: true, text: 'So sánh doanh thu theo kỳ' }
                    }
                }
            });

            // Revenue Trend Chart (Line)
            new Chart(document.getElementById('revenueTrendChart'), {
                type: 'line',
                data: {
                    labels: [<c:forEach items="${summary.revenueTrends}" var="trend">'${trend.period}',</c:forEach>],
                    datasets: [{
                        label: 'Doanh thu (VNĐ)',
                        data: [<c:forEach items="${summary.revenueTrends}" var="trend">${trend.value},</c:forEach>],
                        borderColor: '#36A2EB',
                        backgroundColor: 'rgba(54, 162, 235, 0.2)',
                        fill: true,
                        tension: 0.4
                    }, {
                        label: 'Kỳ trước (VNĐ)',
                        data: [<c:forEach items="${summary.revenueTrends}" var="trend">${trend.previousValue},</c:forEach>],
                        borderColor: '#FF6384',
                        backgroundColor: 'rgba(255, 99, 132, 0.2)',
                        fill: true,
                        tension: 0.4
                    }]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: { beginAtZero: true, title: { display: true, text: 'Doanh thu (VNĐ)' } },
                        x: { title: { display: true, text: '${periodType == "day" ? "Ngày" : periodType == "month" ? "Tháng" : "Năm"}' } }
                    },
                    plugins: {
                        legend: { position: 'top' },
                        title: { display: true, text: 'Xu hướng doanh thu' }
                    }
                }
            });

            // Customer Trend Chart (Line)
            new Chart(document.getElementById('customerTrendChart'), {
                type: 'line',
                data: {
                    labels: [<c:forEach items="${summary.customerTrends}" var="trend">'${trend.period}',</c:forEach>],
                    datasets: [{
                        label: 'Khách hàng mới',
                        data: [<c:forEach items="${summary.customerTrends}" var="trend">${trend.value},</c:forEach>],
                        borderColor: '#36A2EB',
                        backgroundColor: 'rgba(54, 162, 235, 0.2)',
                        fill: true,
                        tension: 0.4
                    }, {
                        label: 'Kỳ trước',
                        data: [<c:forEach items="${summary.customerTrends}" var="trend">${trend.previousValue},</c:forEach>],
                        borderColor: '#FF6384',
                        backgroundColor: 'rgba(255, 99, 132, 0.2)',
                        fill: true,
                        tension: 0.4
                    }]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: { beginAtZero: true, title: { display: true, text: 'Số khách hàng' } },
                        x: { title: { display: true, text: '${periodType == "day" ? "Ngày" : periodType == "month" ? "Tháng" : "Năm"}' } }
                    },
                    plugins: {
                        legend: { position: 'top' },
                        title: { display: true, text: 'Xu hướng khách hàng mới' }
                    }
                }
            });

            // Pet Trend Chart (Line)
            new Chart(document.getElementById('petTrendChart'), {
                type: 'line',
                data: {
                    labels: [<c:forEach items="${summary.petTrends}" var="trend">'${trend.period}',</c:forEach>],
                    datasets: [{
                        label: 'Thú cưng mới',
                        data: [<c:forEach items="${summary.petTrends}" var="trend">${trend.value},</c:forEach>],
                        borderColor: '#36A2EB',
                        backgroundColor: 'rgba(54, 162, 235, 0.2)',
                        fill: true,
                        tension: 0.4
                    }, {
                        label: 'Kỳ trước',
                        data: [<c:forEach items="${summary.petTrends}" var="trend">${trend.previousValue},</c:forEach>],
                        borderColor: '#FF6384',
                        backgroundColor: 'rgba(255, 99, 132, 0.2)',
                        fill: true,
                        tension: 0.4
                    }]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: { beginAtZero: true, title: { display: true, text: 'Số thú cưng' } },
                        x: { title: { display: true, text: '${periodType == "day" ? "Ngày" : periodType == "month" ? "Tháng" : "Năm"}' } }
                    },
                    plugins: {
                        legend: { position: 'top' },
                        title: { display: true, text: 'Xu hướng thú cưng mới' }
                    }
                }
            });

            // Appointment Trend Chart (Line)
            new Chart(document.getElementById('appointmentTrendChart'), {
                type: 'line',
                data: {
                    labels: [<c:forEach items="${summary.appointmentTrends}" var="trend">'${trend.period}',</c:forEach>],
                    datasets: [{
                        label: 'Cuộc hẹn',
                        data: [<c:forEach items="${summary.appointmentTrends}" var="trend">${trend.value},</c:forEach>],
                        borderColor: '#36A2EB',
                        backgroundColor: 'rgba(54, 162, 235, 0.2)',
                        fill: true,
                        tension: 0.4
                    }, {
                        label: 'Kỳ trước',
                        data: [<c:forEach items="${summary.appointmentTrends}" var="trend">${trend.previousValue},</c:forEach>],
                        borderColor: '#FF6384',
                        backgroundColor: 'rgba(255, 99, 132, 0.2)',
                        fill: true,
                        tension: 0.4
                    }]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: { beginAtZero: true, title: { display: true, text: 'Số cuộc hẹn' } },
                        x: { title: { display: true, text: '${periodType == "day" ? "Ngày" : periodType == "month" ? "Tháng" : "Năm"}' } }
                    },
                    plugins: {
                        legend: { position: 'top' },
                        title: { display: true, text: 'Xu hướng cuộc hẹn' }
                    }
                }
            });
        </script>
    </div>
</body>
</html>
```