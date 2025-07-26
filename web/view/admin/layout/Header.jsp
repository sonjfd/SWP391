<%-- 
    Document   : Header
    Created on : May 21, 2025, 8:36:07 PM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>Doctris - Doctor Appointment Booking System</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
        <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
        <meta name="author" content="Shreethemes" />
        <meta name="email" content="support@shreethemes.in" />
        <meta name="website" content="${pageContext.request.contextPath}/index.html" />
        <meta name="Version" content="v1.2.0" />
        <!-- favicon -->
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico.png">
        <!-- Bootstrap -->
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- simplebar -->
        <link href="${pageContext.request.contextPath}/assets/css/simplebar.css" rel="stylesheet" type="text/css" />
        <!-- Select2 -->
        <link href="${pageContext.request.contextPath}/assets/css/select2.min.css" rel="stylesheet" />
        <!-- Icons -->
        <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- SLIDER -->
        <link href="${pageContext.request.contextPath}/assets/css/tiny-slider.css" rel="stylesheet" />
        <!-- Css -->
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />

    </head>

    <body>
        <div class="page-wrapper doctris-theme toggled">
            <nav id="sidebar" class="sidebar-wrapper">
                <div class="sidebar-content" data-simplebar style="height: calc(100% - 60px);">
                    <div class="sidebar-brand">
                        <a href="admin-dashboard">
                            
                            <img src="https://cdn-icons-png.flaticon.com/512/25/25694.png" alt="Home Icon" style="width: 20px; height: 20px;">
                            <span>Trang quản lí </span>
                        </a>
                        
                    </div>

                    <ul class="sidebar-menu pt-3">
                        <li><a href="admin-dashboard"><i class="uil uil-dashboard me-2 d-inline-block"></i>Dashboard</a></li>

                        <li class="sidebar-dropdown">
                            <a href="javascript:void(0)"><i class="uil uil-user me-2 d-inline-block"></i>Quản lý giống loài</a>
                            <div class="sidebar-submenu">
                                <ul>
                                    <li><a href="admin-list-specie">Danh sách loài</a></li>
                                    <li><a href="admin-list-breed">Danh sách giống</a></li>

                                </ul>
                            </div>
                        </li>

                        <li><a href="admin-list-medicine"><i class="uil uil-capsule me-2 d-inline-block"></i>Quản lý thuốc</a></li>

                        <li><a href="admin-list-account"><i class="uil uil-user-circle me-2 d-inline-block"></i>Quản lý tài khoản</a></li>

                        <li><a href="admin-list-clinic-info"><i class="uil uil-clinic-medical me-2 d-inline-block"></i>Thông tin phòng khám</a></li>                  

                        <li><a href="admin-list-slider"><i class="uil uil-clinic-medical me-2 d-inline-block"></i>Quản lý trình chiếu</a></li> 

                        <li><a href="admin-list-shift"><i class="uil uil-clinic-medical me-2 d-inline-block"></i>Quản lý ca làm việc</a></li>

                        <li><a href="admin-list-service"><i class="uil uil-clinic-medical me-2 d-inline-block"></i>Quản lý dịch vụ</a></li>

                        <li><a href="admin-list-department"><i class="uil uil-clinic-medical me-2 d-inline-block"></i>Quản lý phòng ban</a></li>

                        <li><a href="admin-list-role"><i class="uil uil-clinic-medical me-2 d-inline-block"></i>Quản lý vai trò</a></li>

                        
                       

                        <li class="sidebar-dropdown">
                            <a href="javascript:void(0)"><i class="uil uil-folder me-2 d-inline-block"></i>Quản lý sản phẩm</a>
                            <div class="sidebar-submenu">
                                <ul>
                                    <li><a href="admin-category">Quản lý danh mục</a></li>
                                    <li><a href="admin-product">Danh sách sản phẩm</a></li>
                                    <li><a href="admin-productVariantWeight">Danh sách khối lượng</a></li>
                                    <li><a href="admin-productVariantFlavor">Danh sách mùi hương</a></li>
                                    <li><a href="admin-productVariant">Danh sách biến thể</a></li>
                                </ul>
                            </div>
                        </li>
                        <li><a href="admin-listratings"><i class="uil uil-feedback me-2 d-inline-block"></i>Quản lí đánh giá</a></li>
                        <li><a href="admin-assignconsultingstaff"><i class="uil uil-user-check me-2 d-inline-block"></i> Chỉ định nhân viên tư vấn</a></li>

                    </ul>
                    <!-- sidebar-menu  -->
                </div>
                <!-- sidebar-content  -->
                <ul class="sidebar-footer list-unstyled mb-0">
                    <li class="list-inline-item mb-0 ms-1">
                        <a href="#" class="btn btn-icon btn-pills btn-soft-primary">
                            <i class="uil uil-comment icons"></i>
                        </a>
                    </li>
                </ul>
            </nav>
            <!-- sidebar-wrapper  -->

            <!-- Start Page Content -->
            <main class="page-content bg-light">
                <div class="top-header">
                    <div class="header-bar d-flex justify-content-between border-bottom">
                        <div class="d-flex align-items-center">
                            <a href="#" class="logo-icon">
                                <img src="${pageContext.request.contextPath}/assets/images/logo-icon.png" height="30" class="small" alt="">
                                <span class="big">
                                    <img src="${pageContext.request.contextPath}/assets/images/logo-dark.png" height="24" class="logo-light-mode" alt="">
                                    <img src="${pageContext.request.contextPath}/assets/images/logo-light.png" height="24" class="logo-dark-mode" alt="">
                                </span>
                            </a>
                            <a id="close-sidebar" class="btn btn-icon btn-pills btn-soft-primary ms-2" href="#">
                                <i class="uil uil-bars"></i>
                            </a>
                            
                        </div>

                        <ul class="list-unstyled mb-0">
    <li class="list-inline-item mb-0">
        <a href="${pageContext.request.contextPath}/logout" class="btn btn-pills btn-soft-danger p-2 d-flex align-items-center">
            <span class="text-dark">Đăng xuất</span>
        </a>
    </li>
</ul>
                                            
                                            
                    </div>
                </div>

                <!-- javascript -->
                <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
                <!-- simplebar -->
                <script src="${pageContext.request.contextPath}/assets/js/simplebar.min.js"></script>
                <!-- Chart -->
                <script src="${pageContext.request.contextPath}/assets/js/apexcharts.min.js"></script>
                <script src="${pageContext.request.contextPath}/assets/js/columnchart.init.js"></script>
                <!-- Icons -->
                <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
                <!-- Main Js -->
                <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
                </body>
                </html>
