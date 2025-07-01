<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8" />
        <title>Pet24h</title>
        <style>
            .logo-text {
                font-family: 'Arial', sans-serif;
                font-weight: bold;
                font-size: 16px;
                background: linear-gradient(45deg, #28a745, #007bff);
                -webkit-background-clip: text;
                color: transparent;
                margin-left: 10px;
            }
            .btn-schedule {
                font-size: 14px;
                font-weight: 600;
                color: #fff;
                background: linear-gradient(135deg, #4CAF50, #2e7d32);
                border: none;
                padding: 10px 22px;
                border-radius: 30px;
                box-shadow: 0 4px 14px rgba(76, 175, 80, 0.3);
                transition: all 0.3s ease-in-out;
            }
            .btn-schedule:hover {
                background: #43a047;
                box-shadow: 0 6px 20px rgba(67, 160, 71, 0.4);
            }
            .btn-login {
                font-size: 14px;
                font-weight: 600;
                color: #fff;
                background: linear-gradient(135deg, #007bff, #0056b3);
                border: none;
                padding: 10px 22px;
                border-radius: 30px;
                box-shadow: 0 4px 14px rgba(0, 123, 255, 0.25);
                transition: all 0.3s ease-in-out;
            }
            .btn-login:hover {
                background: #0056b3;
                box-shadow: 0 6px 20px rgba(0, 86, 179, 0.35);
            }
            .dropdown-menu.dd-menu {
                border-radius: 12px;
                box-shadow: 0 6px 24px rgba(0, 0, 0, 0.08);
                padding: 12px 0;
            }
            .dropdown-item {
                border-radius: 8px;
                transition: background 0.2s ease;
            }
            .dropdown-item:hover {
                background-color: #f1f1f1;
            }
            .avatar {
                object-fit: cover;
            }
            .avatar-md-sm {
                width: 40px;
                height: 40px;
            }
            .avatar-ex-small {
                width: 34px;
                height: 34px;
            }
            #topnav.navigation.sticky {
                position: fixed;
                top: 0;
                width: 100%;
                z-index: 999;
                background-color: white;
                box-shadow: 0 2px 6px rgba(0,0,0,0.05);
            }
            body {
                padding-top: 70px;
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

        <c:set var="cl" value="${sessionScope.clinicInfo}" />
        <!-- Navbar Start -->
        <header id="topnav" class="navigation sticky">
            <div class="container-fluid">
                <div class="d-flex justify-content-center align-items-center w-100">
                    <div class="menu-extras">
                        <div class="menu-item">
                            <a class="navbar-toggle" id="isToggle" onclick="toggleMenu()">
                                <div class="lines">
                                    <span></span>
                                    <span></span>
                                    <span></span>
                                </div>
                            </a>
                        </div>
                    </div>

                    <div class="d-flex align-items-center">
                        <a class="logo d-flex align-items-center" href="homepage">
                            <img src="${cl.logo}" height="30" width="30" alt="Logo">
                            <span class="logo-text">Pet24h</span>
                        </a>
                        <div id="navigation" class="d-flex justify-content-between align-items-center">
                            <ul class="navigation-menu nav-left">
                                <li><a href="homepage" class="sub-menu-item">Trang chủ</a></li>
                                <li><a href="homeaboutus" class="sub-menu-item">Về chúng tôi</a></li>
                                <li class="sub-menu-item"><a href="homeblog" class="sub-menu-item">Tin tức</a></li>
                                <li class="has-submenu parent-menu-item position-relative">
                                    <c:set var="services" value="${sessionScope.services}" />
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

                                <li><a href="home-list-product" class="sub-menu-item">Sản Phẩm</a></li>
                                <li><a href="home-contact" class="sub-menu-item">Liên hệ</a></li>
                            </ul>
                        </div>

                        <ul class="dropdowns list-inline mb-0" style="min-width:220px;">
                            <!-- Schedule Button -->
                            <li class="list-inline-item mb-0 ms-1" style="min-width: 150px;">
                                <c:choose>
                                    <c:when test="${empty sessionScope.user}">
                                        <a href="login" class="btn btn-schedule shadow rounded-pill">
                                            Đặt lịch khám
                                        </a>
                                    </c:when>
                                    <c:when test="${sessionScope.user.role.name == 'customer'}">
                                        <a href="booking" class="btn btn-schedule shadow rounded-pill">
                                            Đặt lịch khám
                                        </a>
                                    </c:when>


                                    <c:otherwise>
                                        <%-- Không hiển thị nút nhưng giữ khoảng trắng để không bị xô --%>
                                        <span style="display:inline-block; width:100%; height:38px;"></span>
                                    </c:otherwise>
                                </c:choose>
                            </li>


                            <c:set var="cartSize" value="${sessionScope.cartSize != null ? sessionScope.cartSize : 0}" />
                            <c:if test="${sessionScope.user.role.name == 'customer'}">
                                <li class="list-inline-item mb-0 me-2 ms-3 position-relative">
                                    <a href="user-cart" class="text-dark position-relative" title="Giỏ hàng">
                                        <i class="bi bi-cart3 fs-4"></i>
                                        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                            ${cartSize}
                                        </span>
                                    </a>
                                </li>
                            </c:if>


                            <c:choose>
                                <c:when test="${not empty sessionScope.user}">
                                    <li class="list-inline-item mb-0 ms-1">
                                        <div class="dropdown dropdown-primary">
                                            <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0" data-bs-toggle="dropdown">
                                                <img  src="${sessionScope.user.avatar}" class="avatar avatar-ex-small rounded-circle" alt="Avatar">

                                            </button>
                                            <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3" style="min-width: 200px;">
                                                <a class="dropdown-item d-flex align-items-center text-dark" href="#">
                                                    <img src="${sessionScope.user.avatar}" class="avatar avatar-md-sm rounded-circle border shadow" alt="User Avatar">
                                                    <div class="flex-1 ms-2">
                                                        <span class="d-block mb-1">${sessionScope.user.fullName}</span>


                                                        <c:choose>
                                                            <c:when test="${sessionScope.user.role.id==1}">
                                                                <span class="badge bg-warning text-dark">Khách Hàng</span>
                                                            </c:when>
                                                            <c:when test="${sessionScope.user.role.id==2}">
                                                                <span class="badge bg-warning text-dark">Admin</span>
                                                            </c:when>
                                                            <c:when test="${sessionScope.user.role.id==3}">
                                                                <span class="badge bg-warning text-dark">Bác sĩ</span>
                                                            </c:when>
                                                            <c:when test="${sessionScope.user.role.id==4}">
                                                                <span class="badge bg-warning text-dark">Nhân Viên</span>
                                                            </c:when>
                                                            <c:when test="${sessionScope.user.role.id==5}">
                                                                <span class="badge bg-warning text-dark">Y tá</span>
                                                            </c:when>


                                                        </c:choose>
                                                    </div>
                                                </a>
                                                <c:if test="${sessionScope.user.role.name == 'customer'}">
                                                    <a class="dropdown-item text-dark" href="customer-updateuserinformation"><i class="uil uil-setting align-middle h6 me-1"></i> Hồ sơ</a>
                                                </c:if>
                                                <c:if test="${sessionScope.user.role.name == 'doctor'}">
                                                    <a class="dropdown-item text-dark" href="doctor-schedule"><i class="uil uil-dashboard align-middle h6 me-1"></i> Bảng điều khiển</a>
                                                    <a class="dropdown-item text-dark" href="doctor-profile-setting"><i class="uil uil-setting align-middle h6 me-1"></i> Hồ sơ</a>
                                                </c:if>
                                                <c:if test="${sessionScope.user.role.name == 'staff'}">
                                                    <a class="dropdown-item text-dark" href="staff-list-pet-and-owner"><i class="uil uil-dashboard align-middle h6 me-1"></i> Bảng điều khiển</a>
                                                    <a class="dropdown-item text-dark" href="staff-profile-setting"><i class="uil uil-setting align-middle h6 me-1"></i> Hồ sơ</a>
                                                </c:if>
                                                <c:if test="${sessionScope.user.role.name == 'admin'}">
                                                    <a class="dropdown-item text-dark" href="admin-dashboard"><i class="uil uil-dashboard align-middle h6 me-1"></i> Bảng điều khiển</a>
                                                    <a class="dropdown-item text-dark" href="admin-profile-setting"><i class="uil uil-setting align-middle h6 me-1"></i> Hồ sơ</a>
                                                </c:if>
                                                <c:if test="${sessionScope.user.role.name == 'nurse'}">
                                                    <a class="dropdown-item text-dark" href="nurse-list-appointment-service"><i class="uil uil-dashboard align-middle h6 me-1"></i> Bảng điều khiển</a>
                                                    <a class="dropdown-item text-dark" href="nurse-viewprofile"><i class="uil uil-setting align-middle h6 me-1"></i> Hồ sơ</a>
                                                </c:if>
                                                <div class="dropdown-divider border-top"></div>
                                                <a class="dropdown-item text-dark" href="logout"><i class="uil uil-sign-out-alt align-middle h6 me-1"></i> Đăng xuất</a>
                                            </div>
                                        </div>
                                    </li>
                                </c:when>
                                <c:otherwise>
                                    <li class="list-inline-item mb-0">
                                        <a href="login" class="btn btn-login">Đăng nhập</a>
                                    </li>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </div>
                </div>
            </div>
        </header>
        <!-- Navbar End -->

    </body>
</html>

