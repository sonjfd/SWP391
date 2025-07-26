<%-- 
    Document   : Admin
    Created on : May 21, 2025, 8:24:23 PM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <title>Pet24h - Quản lý slider</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
    <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
    <meta name="author" content="Shreethemes" />
    <meta name="email" content="support@shreethemes.in" />
    <meta name="website" content="${pageContext.request.contextPath}/index.html" />
    <meta name="Version" content="v1.2.0" />
    <!-- favicon -->
  
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
    <link href="${pageContext.request.contextPath}/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
    <style>
        .toolbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            flex-wrap: wrap;
            gap: 10px;
        }
        .toolbar a, .search-form button, .reset-btn {
            padding: 8px 15px;
            background-color: #33CCFF;
            color: white;
            border: none;
            border-radius: 4px;
            text-decoration: none;
            cursor: pointer;
        }
        .toolbar a:hover, .search-form button:hover, .reset-btn:hover {
            background-color: #29b3e6;
        }
        .search-form {
            display: flex;
            gap: 10px;
        }
        .search-form input {
            padding: 8px;
            width: 200px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .filter-container {
            display: flex;
            gap: 10px;
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
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }
        th {
            background-color: #33CCFF;
            color: white;
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
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .edit-btn {
            background-color: #2196F3;
        }
        .edit-btn:hover {
            background-color: #1e88e5;
        }
        .delete-btn {
            background-color: #f44336;
        }
        .delete-btn:hover {
            background-color: #d32f2f;
        }
        .switch {
            position: relative;
            display: inline-flex;
            align-items: center;
            width: 80px;
            height: 34px;
            vertical-align: middle;
        }
        .switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }
        .slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #ccc; /* Màu xám khi tắt */
            border-radius: 34px;
            transition: all 0.4s ease;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 10px;
            box-sizing: border-box;
        }
        .slider:before {
            content: "";
            position: absolute;
            height: 26px;
            width: 26px;
            left: 4px;
            bottom: 4px;
            background-color: white;
            border-radius: 50%;
            transition: all 0.4s ease;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }
    .slider .status-text {
        position: absolute;
        color: white;
        font-size: 12px;
        font-weight: bold;
        transition: all 0.4s ease;
    }
    .slider .on-text {
        left: 14px;
        opacity: 0;
    }
    .slider .off-text {
        right: 14px;
        opacity: 1;
    }
    input:checked + .slider {
        background-color: #4CAF50; /* Màu xanh khi bật */
    }
    input:checked + .slider:before {
        transform: translateX(46px); /* Di chuyển nút khi bật */
    }
    input:checked + .slider .on-text {
        opacity: 1;
    }
    input:checked + .slider .off-text {
        opacity: 0;
    }
    .slider:hover {
        background-color: #bbb; /* Hover khi tắt */
    }
    input:checked + .slider:hover {
        background-color: #45a049; /* Hover khi bật */
    }
    .slide-image {
        max-width: 80px;
        height: auto;
        border-radius: 4px;
    }
    .error {
        color: red;
        margin-bottom: 10px;
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
            <h5 class="mb-0">Quản lý trình chiếu</h5>
            
            
            <div class="toolbar">
                <a href="admin-create-slider">Tạo mới</a>
                <div class="toolbar-right">
                    
                    <div class="filter-container">
                        <select id="filterStatus" onchange="filterSlides()">
                            <option value="">Tất cả</option>
                            <option value="1">Hoạt động</option>
                            <option value="0">Không hoạt động</option>
                        </select>
                        <button class="reset-btn" onclick="resetFilters()">Tất cả</button>
                    </div>
                </div>
                
            </div>
                <c:if test="${not empty message}">
    <div class="alert alert-success">${message}</div>
</c:if>
            
            <table id="slideTable">
                <thead>
                    <tr>
                        <th>STT</th>
                        <th>Tiêu đề</th>
                        <th>Hình ảnh</th>
                        <th>Liên kết</th>
                        <th>Trạng thái</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="slide" items="${slides}" varStatus="counter">
                        <tr data-status="${slide.isActive}">
                            <td>${counter.count}</td>
                            <td>${slide.title}</td>
                            <td><img src="${slide.imageUrl}" alt="${slide.title}" class="slide-image"></td>
                            <td><a href="${slide.link}" target="_blank">${slide.link}</a></td>
                            <td>
                                <form method="post" action="admin-update-status-slider">
                                    <input type="hidden" name="id" value="${slide.id}">
                                    <input type="hidden" name="isActive" value="${slide.isActive == 1 ? 0 : 1}">
                                    
                                    <label class="switch">
                                        <input type="checkbox" ${slide.isActive == 1 ? 'checked' : ''} onchange="this.form.submit()">
                                        <span class="slider">
                                            <span class="status-text on-text">ON</span>
                                            <span class="status-text off-text">OFF</span>
                                        </span>
                                    </label>
                                </form>
                            </td>
                            <td>
                                <a href="admin-update-slider?id=${slide.id}" class="action-btn edit-btn">Sửa</a>
                                <button class="action-btn delete-btn" onclick="confirmDelete('${slide.id}')">Xóa</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <c:if test="${empty slides}">
                <p>Không tìm thấy slideshow nào.</p>
            </c:if>
        </div>
    </div>

    

    <script>
        function confirmDelete(id) {
            if (confirm("Bạn chắc chắn muốn xóa slideshow này?")) {
                window.location.href = "admin-delete-slider?id=" + id;
            }
        }

        function filterSlides() {
            const statusFilter = document.getElementById('filterStatus').value;
            const rows = document.querySelectorAll('#slideTable tr[data-status]');
            rows.forEach(row => {
                const status = row.getAttribute('data-status');
                row.style.display = (statusFilter === '' || status === statusFilter) ? '' : 'none';
            });
        }

        function resetFilters() {
            document.getElementById('filterStatus').value = '';
            filterSlides();
        }
    </script>

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