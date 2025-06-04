<%-- 
    Document   : Header
    Created on : May 21, 2025, 8:36:07 PM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">



    </head>
    <body>
        <div class="page-wrapper doctris-theme toggled">
            <nav id="sidebar" class="sidebar-wrapper">
                <div class="sidebar-content" data-simplebar style="height: calc(100% - 60px);">
                    <div class="sidebar-brand">
                        <!-- Bootstrap Button with Icon -->
                        <a href="homepage" class=" d-flex align-items-center gap-2 px-3 py-2">
                            <img src="https://cdn-icons-png.flaticon.com/512/25/25694.png" alt="Home Icon" style="width: 20px; height: 20px;">
                            <span>Trang Chủ</span>
                        </a>

                    </div>

                    <ul class="sidebar-menu pt-3">
                        <li><a href="index.html"><i class="uil uil-user me-2 d-inline-block"></i>Khách Hàng</a></li>
                        <li>
                            <a href="appointment.html">
                                <i class="bi bi-heart-pulse me-2"></i>Thú Cưng
                            </a>
                        </li>


                        <li><a href="list-work-schedule"><i class="uil uil-calendar-alt d-inline-block"></i>Lịch Làm Việc Của Bác Sĩ</a></li>
                        <li><a href="appointment.html"><i class="uil uil-notes d-inline-block"></i>Lịch Hẹn</a></li>
                        <li><a href="contact"><i class="uil uil-envelope me-2 d-inline-block"></i>Liên Hệ</a></li>

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






                            <li class="list-inline-item mb-0 ms-1">
                                <div class="dropdown dropdown-primary">
                                    <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        <c:choose>
                                            <c:when test="${not empty sessionScope.user.avatar}">
                                                <img src="${pageContext.request.contextPath}/${sessionScope.user.avatar}" class="avatar avatar-ex-small rounded-circle" alt="User Avatar" />
                                            </c:when>
                                            <c:otherwise>
                                                <img src="../assets/images/default-avatar.png" class="avatar avatar-ex-small rounded-circle" alt="User Avatar" />
                                            </c:otherwise>
                                        </c:choose>
                                    </button>
                                    <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3" style="min-width: 200px;">
                                        <a class="dropdown-item d-flex align-items-center text-dark" href="profile">
                                            <c:choose>
                                                <c:when test="${not empty sessionScope.user.avatar}">
                                                    <img src="${pageContext.request.contextPath}/${sessionScope.user.avatar}" class="avatar avatar-md-sm rounded-circle border shadow" alt="User Avatar" />
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${pageContext.request.contextPath}/${sessionScope.user.avatar}" class="avatar avatar-md-sm rounded-circle border shadow" alt="User Avatar" />
                                                </c:otherwise>
                                            </c:choose>
                                            <div class="flex-1 ms-2">
                                                <span class="d-block mb-1">${sessionScope.user.fullName}</span>
                                                <small class="text-muted">${sessionScope.user.role.name}</small>
                                            </div>
                                        </a>
                                        <a class="dropdown-item text-dark" href="dashboard">
                                            <span class="mb-0 d-inline-block me-1"><i class="uil uil-dashboard align-middle h6"></i></span> Dashboard
                                        </a>
                                        <a class="dropdown-item text-dark" href="staff-profile-setting">
                                            <span class="mb-0 d-inline-block me-1"><i class="uil uil-setting align-middle h6"></i></span> Profile Settings
                                        </a>
                                        <div class="dropdown-divider border-top"></div>
                                        <a class="dropdown-item text-dark" href="logout">
                                            <span class="mb-0 d-inline-block me-1"><i class="uil uil-sign-out-alt align-middle h6"></i></span> Logout
                                        </a>
                                    </div>
                                </div>
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
