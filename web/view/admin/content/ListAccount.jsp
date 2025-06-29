<%-- 
    Document   : Admin
    Created on : May 21, 2025, 8:24:23 PM
    Author     : Dell
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8" />
        <title>Doctris - Quản lý tài khoản nhân viên/bác sĩ</title>
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
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
        <!-- SLIDER -->
        <link href="${pageContext.request.contextPath}/assets/css/tiny-slider.css" rel="stylesheet" />
        <!-- Css -->
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 50px;
                background-color: #f4f4f4;
            }
            .container {
                max-width: 1200px;
                margin: auto;
                background: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            .header {
                margin-bottom: 20px;
            }
            .header h2 {
                margin: 0;
                font-size: 1.8rem;
                color: #333;
            }
            .toolbar {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
                flex-wrap: wrap;
                gap: 15px;
            }
            .toolbar-left a {
                padding: 10px 20px;
                background-color: #33CCFF;
                color: white;
                text-decoration: none;
                border-radius: 4px;
                transition: background-color 0.3s, transform 0.2s;
            }
            .toolbar-left a:hover {
                background-color: #29b3e6;
                transform: translateY(-2px);
            }
            .toolbar-right {
                display: flex;
                gap: 15px;
                align-items: center;
                flex-wrap: wrap;
            }
            .search-form {
                display: flex;
                gap: 10px;
            }
            .search-form input[type="text"] {
                padding: 8px;
                width: 200px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }
            .search-form button, .reset-btn {
                padding: 8px 15px;
                background-color: #33CCFF;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.3s;
            }
            .search-form button:hover, .reset-btn:hover {
                background-color: #29b3e6;
            }
            .filter-container {
                display: flex;
                gap: 15px;
                align-items: center;
            }
            .filter-container select {
                padding: 8px;
                width: 150px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            th, td {
                padding: 12px;
                border: 1px solid #ddd;
                text-align: left;
            }
            th {
                background-color: #33CCFF;
                color: white;
                font-weight: bold;
            }
            tr:nth-child(even) {
                background-color: #f2f2f2;
            }
            tr:hover {
                background-color: #e9f7ff;
            }
            .action-btn {
                padding: 5px 10px;
                margin-right: 5px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                color: white;
                transition: background-color 0.3s;
            }
            .edit-btn {
                background-color: #2196F3;
            }
            .edit-btn:hover {
                background-color: #1e88e5;
            }
            .switch {
                position: relative;
                display: inline-block;
                width: 60px;
                height: 24px;
            }
            .switch input {
                opacity: 0;
                width: 0;
                height: 0;
            }
            .slider {
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: #ccc;
                transition: 0.4s;
                border-radius: 24px;
            }
            .slider:before {
                position: absolute;
                content: "";
                height: 20px;
                width: 20px;
                left: 2px;
                bottom: 2px;
                background-color: white;
                transition: 0.4s;
                border-radius: 50%;
            }
            input:checked+.slider {
                background-color: #4CAF50;
            }
            input:checked+.slider:before {
                transform: translateX(36px);
            }
            .slider:after {
                content: 'OFF';
                color: white;
                position: absolute;
                right: 8px;
                top: 4px;
                font-size: 12px;
                font-weight: bold;
            }
            input:checked+.slider:after {
                content: 'ON';
                left: 8px;
                right: auto;
            }
            .message {
                padding: 10px;
                border-radius: 4px;
                margin-bottom: 15px;
            }
            .message.success {
                background-color: #dff0d8;
                color: #3c763d;
            }
            .message.error {
                background-color: #f2dede;
                color: #a94442;
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

        <div class="container">
            
            <div class="header">
                <h2>Danh sách tài khoản nhân viên/bác sĩ</h2>
            </div>
            <div class="toolbar">
                <div class="toolbar-left">
                    <a href="admin-create-account" class="create-btn">Tạo tài khoản mới</a>
                </div>
                <c:if test="${not empty message}">
                ${message}
            </c:if>
                <div class="toolbar-right">
                    <form method="post" action="admin-search-account" class="search-form">
                        <input type="text" name="search" value="${search}" placeholder="Tìm kiếm theo tên">
                        <button type="submit">Tìm kiếm</button>
                    </form>
                    <div class="filter-container">
                        <div>
                            <label for="filterRole">Vai trò:</label>
                            <select id="filterRole" onchange="filterAccounts()">
                                <option value="">Tất cả</option>
                                <option value="1">Khách hàng</option>
                                <option value="3">Bác sĩ</option>
                                <option value="4">Nhân viên</option>
                                <option value="5">Y tá</option>
                            </select>
                        </div>
                        <div>
                            <label for="filterStatus">Trạng thái:</label>
                            <select id="filterStatus" onchange="filterAccounts()">
                                <option value="">Tất cả</option>
                                <option value="1">Hoạt động</option>
                                <option value="2">Ban</option>
                                
                                
                            </select>
                        </div>
                        <a href="admin-list-account" class="reset-btn" >Tất cả tài khoản</a>
                    </div>
                </div>
            </div>

            <table id="accountTable">
                <tr>
                    <th>STT</th>
                    <th>Tên đăng nhập</th>
                    <th>Email</th>
                    <th>Họ và tên</th>
                    <th>Vai trò</th>
                    <th>Trạng thái</th>
                    <th>Hành động</th>
                </tr>
                <c:forEach var="user" items="${users}" varStatus="counter">
                    <tr data-role="${user.role.id}" data-status="${user.status}">
                        <td>${counter.count}</td>
                        <td>${user.userName}</td>
                        <td>${user.email}</td>
                        <td>${user.fullName}</td>
                        <td>
                            <c:choose>
                                <c:when test="${user.role.id == 1}">Khách hàng</c:when>
                                <c:when test="${user.role.id == 3}">Bác sĩ</c:when>
                                <c:when test="${user.role.id == 4}">Nhân viên</c:when>
                                <c:when test="${user.role.id == 5}">Y tá</c:when>
                                <c:otherwise>Unknown</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <form method="post" action="admin-update-status">
                                <input type="hidden" name="id" value="${user.id}">
                                <input type="hidden" name="status" value="${user.status == 1 ? 2 : 1}">
                                <input type="hidden" name="search" value="${search}">
                                <label class="switch">
                                    <input type="checkbox" ${user.status == 1 ? 'checked' : ''} onchange="this.form.submit()">
                                    <span class="slider"></span>
                                </label>
                            </form>
                        </td>
                        <td>
                            <a href="admin-update-account?id=${user.id}" class="action-btn edit-btn">Sửa</a>

                        </td>
                    </tr>
                </c:forEach>
            </table>

            <c:if test="${empty users}">
                <p>Không tìm thấy tài khoản nào.</p>
            </c:if>
        </div>

        <script>
            

            function filterAccounts() {
                const roleFilter = document.getElementById('filterRole').value;
                const statusFilter = document.getElementById('filterStatus').value;
                const rows = document.querySelectorAll('#accountTable tr[data-role]');

                rows.forEach(row => {
                    const role = row.getAttribute('data-role');
                    const status = row.getAttribute('data-status');
                    let showRow = true;

                    if (roleFilter && role !== roleFilter) {
                        showRow = false;
                    }
                    if (statusFilter && status !== statusFilter) {
                        showRow = false;
                    }

                    row.style.display = showRow ? '' : 'none';
                    console.log(`Filter applied: Role=${roleFilter}, Status=${statusFilter}, Row visible=${showRow}`);
                });
            }

            function resetFilters() {
                const filterRole = document.getElementById('filterRole');
                const filterStatus = document.getElementById('filterStatus');
                filterRole.value = '';
                filterStatus.value = '';
                filterAccounts();
                console.log('Filters reset: Showing all accounts');
            }

            document.addEventListener('DOMContentLoaded', function () {
                const filterRole = document.getElementById('filterRole');
                const filterStatus = document.getElementById('filterStatus');
                if (filterRole && filterStatus) {
                    filterAccounts();
                } else {
                    console.error('Filter elements not found');
                }
            });
        </script>

        <!-- javascript -->
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/simplebar.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/apexcharts.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/columnchart.init.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
    </body>
</html>