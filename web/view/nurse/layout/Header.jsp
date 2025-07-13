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
        <title>Y Tá - TRANG LÀM VIỆC CỦA Y TÁ</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
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

                        <li><a href="nurse-list-appointment-service"><i class="uil uil-file-alt me-2 d-inline-block"></i>Quản Lý Kết Quả</a></li>
                        <li><a href="nurse-viewprofile"><i class="ri-user-settings-line align-middle navbar-icon"></i>Thông tin cá nhân</a></li>

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
                                                <img src="${sessionScope.user.avatar}" class="avatar avatar-ex-small rounded-circle" alt="User Avatar" />
                                            </c:when>
                                            <c:otherwise>
                                                <img src="../assets/images/default_user.png" class="avatar avatar-ex-small rounded-circle" alt="User Avatar" />
                                            </c:otherwise>
                                        </c:choose>
                                    </button>
                                    <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3" style="min-width: 200px;">
                                        <a class="dropdown-item d-flex align-items-center text-dark" href="profile">
                                            <c:choose>
                                                <c:when test="${not empty sessionScope.user.avatar}">
                                                    <img src="${sessionScope.user.avatar}" class="avatar avatar-md-sm rounded-circle border shadow" alt="User Avatar" />
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${sessionScope.user.avatar}" class="avatar avatar-md-sm rounded-circle border shadow" alt="User Avatar" />
                                                </c:otherwise>
                                            </c:choose>
                                            <div class="flex-1 ms-2">
                                                <span class="d-block mb-1">${sessionScope.user.fullName}</span>
                                                <small class="text-muted">${sessionScope.user.role.name}</small>
                                            </div>
                                        </a>
                                        <a class="dropdown-item text-dark" href="nurse-list-appointment-service">
                                            <span class="mb-0 d-inline-block me-1"><i class="uil uil-dashboard align-middle h6"></i></span> Bảng điều khiển
                                        </a>
                                       
                                        <div class="dropdown-divider border-top"></div>
                                        <a class="dropdown-item text-dark" href="logout">
                                            <span class="mb-0 d-inline-block me-1"><i class="uil uil-sign-out-alt align-middle h6"></i></span> Đăng xuất
                                        </a>
                                    </div>
                                </div>
                            </li>


                        </ul>
                    </div>
                </div>

                <!-- javascript -->
                <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>

                </body>
                </html>
