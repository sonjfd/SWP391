<%-- 
    Document   : DepartmentManagement
    Created on : Jun 20, 2025
    Author     : Grok
    Description: Department management page for SWP391, styled like Admin.jsp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8" />
        <title>Quản lý phòng ban - PetCareSystem</title>
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
                justify-content: flex-start;
                align-items: center;
                margin-bottom: 20px;
            }
            .toolbar a {
                padding: 10px 20px;
                background-color: #33CCFF;
                color: white;
                text-decoration: none;
                border-radius: 4px;
                transition: background-color 0.3s, transform 0.2s;
            }
            .toolbar a:hover {
                background-color: #29b3e6;
                transform: translateY(-2px);
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
            .delete-btn {
                background-color: #dc3545;
            }
            .delete-btn:hover {
                background-color: #c82333;
            }
            .error {
                color: red;
                margin-bottom: 15px;
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

        <jsp:include page="../layout/Header.jsp" />

        <div class="container">


            <div class="header">
                <h2>Danh sách phòng ban</h2>
            </div>
            
            <div class="toolbar">
                <a href="${pageContext.request.contextPath}/admin-create-department" class="create-btn">Tạo phòng ban mới</a>
            </div>
            <c:if test="${not empty message}">
            ${message}
        </c:if>
            <table>
                <tr>
                    <th>STT</th>
                    <th>Tên phòng ban</th>
                    <th>Mô tả</th>
                    <th>Hành động</th>
                </tr>
                <c:forEach var="dept" items="${departments}" varStatus="counter">
                    <tr>
                        <td>${counter.count}</td>
                        <td>${dept.name}</td>
                        <td>${dept.description}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin-update-department?id=${dept.id}" class="action-btn edit-btn">Sửa</a>
                            <form method="post" action="${pageContext.request.contextPath}/admin-delete-department" style="display:inline;">
                                <input type="hidden" name="id" value="${dept.id}">
                                <button type="submit" class="action-btn delete-btn" onclick="return confirm('Bạn có chắc muốn xóa phòng ban này?')">Xóa</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </table>

            <c:if test="${empty departments}">
                <p>Không có phòng ban nào.</p>
            </c:if>
        </div>

        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/simplebar.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
    </body>
</html>