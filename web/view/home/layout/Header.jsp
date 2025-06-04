<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8" />
        <title>Pet24h</title>
     
        <style>
            /* Gradient text for Pet24h */
            .logo-text {
                font-family: 'Arial', sans-serif;
                font-weight: bold;
                font-size: 16px;
                background: linear-gradient(45deg, #28a745, #007bff); /* Gradient green and blue */
                -webkit-background-clip: text;
                color: transparent;
                margin-left: 10px;
            }

            /* Custom styling for buttons */
            .btn-schedule {
                font-size: 14px;
                font-weight: bold;
                color: white;
                background-color: #28a745; /* Green background */
                margin-right: 20px; /* Adding space between buttons */
            }

            .btn-schedule:hover {
                background-color: #218838;
            }

            .btn-login {
                font-size: 14px;
                font-weight: bold;
                color: white;
                background-color: #007bff; /* Blue background */
            }

            .btn-login:hover {
                background-color: #0056b3;
            }

            /* Mobile-friendly adjustments */
            .navbar-toggler {
                border: none;
                background-color: transparent;
            }

            .navbar-nav {
                display: flex;
                align-items: center;
                justify-content: center;
                width: 100%;
            }

            .dropdown-menu {
                width: 200px;
            }

            .dropdown-item {
                font-size: 14px;
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
        <c:set var="cl" value="${sessionScope.clinicInfo}"></c:set>
            <!-- Navbar Start -->
            <header id="topnav" class="navigation sticky">
                <div class="container-fluid"> <!-- Use container-fluid for full-width container -->
                    <div class="d-flex justify-content-center align-items-center w-100"> <!-- Flexbox for layout -->
                        <!-- Logo container-->

                        <!-- End Logo container-->

                        <!-- Start Mobile Toggle -->
                        <div class="menu-extras">
                            <div class="menu-item">
                                <!-- Mobile menu toggle-->
                                <a class="navbar-toggle" id="isToggle" onclick="toggleMenu()">
                                    <div class="lines">
                                        <span></span>
                                        <span></span>
                                        <span></span>
                                    </div>
                                </a>
                                <!-- End mobile menu toggle-->
                            </div>
                        </div>
                        <!-- End Mobile Toggle -->

                        <!-- Start Dropdown -->
                        <div class="d-flex align-items-center">
                            <a class="logo d-flex align-items-center" href="homepage">
                                <img src="${pageContext.request.contextPath}/${cl.logo}" height="30" width="30" alt="Logo">
                            <span class="logo-text">Pet24h</span> <!-- Gradient Text -->
                        </a>
                        <div id="navigation" class="d-flex justify-content-between align-items-center">
                            <!-- Navigation Menu-->   
                            <ul class="navigation-menu nav-left">
                                <li>
                                    <a href="homepage" class="sub-menu-item">Trang chủ</a>
                                </li>
                                <li>
                                    <a href="homeaboutus" class="sub-menu-item">Về chúng tôi</a>
                                </li>
                                <li class="sub-menu-item">
                                    <a href="homeblog" class="sub-menu-item">Tin tức</a>
                                </li>
                                <li class="has-submenu parent-menu-item position-relative">
                                    <c:set var="services" value="${sessionScope.services}"></c:set>
                                        <a href="homeaboutus#services">Dịch vụ</a>
                                        <ul class="submenu p-0" style="width: 400px;">
                                            <div class="row px-3 py-2">
                                            <c:set var="half" value="${fn:length(services) div 2 + fn:length(services) mod 2}" />
                                            <div class="col-6">
                                                <c:forEach var="s" items="${services}" varStatus="status">
                                                    <c:if test="${status.index < half}">
                                                        <li style="list-style:none;">
                                                            <a href="homeaboutus#services" class="sub-menu-item">${s.name}</a>
                                                        </li>
                                                    </c:if>
                                                </c:forEach>
                                            </div>
                                            <div class="col-6">
                                                <c:forEach var="s" items="${services}" varStatus="status">
                                                    <c:if test="${status.index >= half}">
                                                        <li style="list-style:none;">
                                                            <a href="homeaboutus#services" class="sub-menu-item">${s.name}</a>
                                                        </li>
                                                    </c:if>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </ul>
                                </li>
                                <li><a href="home-contact" class="sub-menu-item">Liên hệ</a></li>
                            </ul><!--end navigation menu-->
                        </div><!--end navigation-->

                        <ul class="dropdowns list-inline mb-0" style="min-width:220px;">
                            <!-- Schedule Button -->
                            <c:if test="${empty sessionScope.user}">
                                <li class="list-inline-item mb-0 ms-1">
                                    <a href="javascript:void(0)" class="btn btn-schedule">
                                        Đặt lịch khám
                                    </a>
                                </li>
                            </c:if>

                            <c:if test="${not empty sessionScope.user and sessionScope.user.role.name == 'customer'}">
                                <li class="list-inline-item mb-0 ms-1">
                                    <a href="booking" class="btn btn-schedule">
                                        Đặt lịch khám
                                    </a>
                                </li>
                            </c:if>



                            <!-- User Login/Avatar Dropdown -->
                            <c:choose>
                                <c:when test="${not empty sessionScope.user}">
                                    <li class="list-inline-item mb-0 ms-1">
                                        <div class="dropdown dropdown-primary">
                                            <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                <img src="${pageContext.request.contextPath}/${sessionScope.user.avatar}" class="avatar avatar-ex-small rounded-circle" alt="User Avatar">
                                            </button>
                                            <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3" style="min-width: 200px;">
                                                <a class="dropdown-item d-flex align-items-center text-dark" href="#">
                                                    <img src="${pageContext.request.contextPath}/${sessionScope.user.avatar}" class="avatar avatar-md-sm rounded-circle border shadow" alt="User Avatar">
                                                    <div class="flex-1 ms-2">
                                                        <span class="d-block mb-1">${sessionScope.user.fullName}</span>
                                                        <small class="text-muted">${sessionScope.user.role.name}</small>
                                                    </div>
                                                </a>

                                                <!-- Role-based Links -->
                                                <c:if test="${sessionScope.user.role.name == 'customer'}">
                                                    <a class="dropdown-item text-dark" href="viewuserinformation">
                                                        <i class="uil uil-setting align-middle h6 me-1"></i> Hồ sơ
                                                    </a>
                                                </c:if>
                                                <c:if test="${sessionScope.user.role.name == 'doctor'}">
                                                    <a class="dropdown-item text-dark" href="doctor-dashboard">
                                                        <i class="uil uil-dashboard align-middle h6 me-1"></i> Bảng điều khiển
                                                    </a>
                                                    <a class="dropdown-item text-dark" href="doctor-profile-setting">
                                                        <i class="uil uil-setting align-middle h6 me-1"></i> Hồ sơ
                                                    </a>
                                                </c:if>
                                                <c:if test="${sessionScope.user.role.name == 'staff'}">
                                                    <a class="dropdown-item text-dark" href="staff-dashboard">
                                                        <i class="uil uil-dashboard align-middle h6 me-1"></i> Bảng điều khiển
                                                    </a>
                                                    <a class="dropdown-item text-dark" href="staff-profile-setting">
                                                        <i class="uil uil-setting align-middle h6 me-1"></i> Hồ sơ
                                                    </a>
                                                </c:if>
                                                <c:if test="${sessionScope.user.role.name == 'admin'}">
                                                    <a class="dropdown-item text-dark" href="admin-dashboard">
                                                        <i class="uil uil-dashboard align-middle h6 me-1"></i> Bảng điều khiển
                                                    </a>
                                                    <a class="dropdown-item text-dark" href="admin-profile-setting">
                                                        <i class="uil uil-setting align-middle h6 me-1"></i> Hồ sơ
                                                    </a>
                                                </c:if>

                                                <div class="dropdown-divider border-top"></div>
                                                <a class="dropdown-item text-dark" href="logout">
                                                    <i class="uil uil-sign-out-alt align-middle h6 me-1"></i> Đăng xuất
                                                </a>
                                            </div>
                                        </div>
                                    </li>
                                </c:when>
                                <c:otherwise>
                                    <li class="list-inline-item mb-0">
                                        <a href="login" class="btn btn-login">
                                            Đăng nhập
                                        </a>
                                    </li>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </div>
                    <!-- End Dropdown -->
                </div>
            </div><!--end container-->
        </header><!--end header-->
        <!-- Navbar End -->


       
    </body>
</html>
