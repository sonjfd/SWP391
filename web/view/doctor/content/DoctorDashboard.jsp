<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8" />
    <title>Bảng điều khiển bác sĩ</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- Favicon -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico">
    
    <!-- Bootstrap CSS -->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Icons -->
    <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" />
    <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/remixicon.css" rel="stylesheet" type="text/css" />

    <!-- Custom CSS -->
    <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet">
</head>

<body>
    <%@include file="../layout/Header.jsp" %>

    <section class="bg-dashboard">
        <div class="container-fluid">
            <div class="row">
                <!-- Sidebar -->
                <div class="col-xl-3 col-lg-3 col-md-4 col-12" id="sidebarContainer">
                    <div class="rounded shadow overflow-hidden sticky-bar" id="sidebar">
                        <ul class="list-unstyled sidebar-nav mb-0">
                            <li class="navbar-item"><a href="doctor-dashboard" class="navbar-link active"><i class="ri-dashboard-line navbar-icon"></i> Bảng điều khiển</a></li>
                            <li class="navbar-item"><a href="doctor-time-table" class="navbar-link"><i class="ri-calendar-check-line navbar-icon"></i> Lịch làm việc</a></li>
                            <li class="navbar-item"><a href="doctor-record-examination" class="navbar-link"><i class="ri-file-line navbar-icon"></i> Ghi chép khám bệnh</a></li>
                            <li class="navbar-item"><a href="doctor-profile-setting" class="navbar-link"><i class="ri-user-settings-line navbar-icon"></i> Cài đặt hồ sơ</a></li>
                        </ul>
                    </div>
                </div>

                <!-- Main Content -->
                <div id="mainContent" class="col-xl-9 col-lg-9 col-md-8">
                    <h5 class="mb-4">Bảng điều khiển</h5>

                    <!-- Stats Section -->
                    <div class="row">
                        <div class="col-xl-3 col-lg-6 mt-4">
                            <div class="card shadow border-0 p-4">
                                <div class="d-flex justify-content-between mb-3">
                                    <h6 class="align-items-center mb-0">Cuộc hẹn <span class="badge badge-pill badge-soft-primary ms-1">+15%</span></h6>
                                    <p class="mb-0 text-muted">${appointmentsCount} tuần này</p>
                                </div>
                                <div id="chart-1"></div>
                            </div>
                        </div>

                        <div class="col-xl-3 col-lg-6 mt-4">
                            <div class="card shadow border-0 p-4">
                                <div class="d-flex justify-content-between mb-3">
                                    <h6 class="align-items-center mb-0">Bệnh nhân <span class="badge badge-pill badge-soft-success ms-1">+20%</span></h6>
                                    <p class="mb-0 text-muted">${patientsCount} tuần này</p>
                                </div>
                                <div id="chart-2"></div>
                            </div>
                        </div>
                    </div>

                    <!-- Cuộc hẹn mới nhất -->
                    <div class="row">
                        <div class="col-xl-4 col-lg-6 mt-4">
                            <div class="card border-0 shadow rounded">
                                <div class="d-flex justify-content-between p-4 border-bottom">
                                    <h6 class="mb-0">Cuộc hẹn mới nhất</h6>
                                    <h6 class="text-muted mb-0">5 cuộc hẹn</h6>
                                </div>
                                <ul class="list-unstyled mb-0 p-4">
                                    <c:forEach items="${latestAppointments}" var="appointment">
                                        <li class="mt-4">
                                            <a href="javascript:void(0)">
                                                <div class="d-flex align-items-center justify-content-between">
                                                    <div class="d-inline-flex">
                                                        <img src="${pageContext.request.contextPath}/${appointment.pet.avatar}" class="avatar avatar-md-sm rounded-circle border shadow" alt="Pet Avatar">
                                                        <div class="ms-3">
                                                            <h6 class="text-dark mb-0">${appointment.pet.name}</h6>
                                                            <small class="text-muted">Đặt lịch vào ${appointment.appointmentDate}</small>
                                                        </div>
                                                    </div>
                                                    <i class="uil uil-arrow-right h4 text-dark"></i>
                                                </div>
                                            </a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Back to top -->
    <a href="#" onclick="topFunction()" id="back-to-top" class="btn btn-icon btn-pills btn-primary back-to-top">
        <i data-feather="arrow-up" class="icons"></i>
    </a>

<script>
    // Toggle Sidebar
    document.getElementById('toggleSidebarBtn').addEventListener('click', function() {
        var sidebar = document.getElementById('sidebar');
        var sidebarContainer = document.getElementById('sidebarContainer');
        
        sidebar.classList.toggle('d-none');
        sidebarContainer.classList.toggle('col-xl-3');
        sidebarContainer.classList.toggle('col-lg-3');
        sidebarContainer.classList.toggle('col-md-4');
        sidebarContainer.classList.toggle('col-12');
        
        var mainContent = document.getElementById('mainContent');
        mainContent.classList.toggle('col-xl-12');
        mainContent.classList.toggle('col-xl-9');
    });
</script>

<script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/apexcharts.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/areachart.init.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
</body>

</html>
