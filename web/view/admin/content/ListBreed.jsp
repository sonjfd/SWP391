<%-- 
    Document   : ListBreed
    Created on : Jun 10, 2025
    Author     : Dell
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Quản lý giống - Doctris</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico">
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
    <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" />
    <style>
        .toolbar {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
        }
        .toolbar a {
            padding: 8px 15px;
            background-color: #33CCFF;
            color: white;
            border-radius: 4px;
            text-decoration: none;
        }
        .toolbar a:hover {
            background-color: #29b3e6;
        }
        table {
            width: 100%;
            border-collapse: collapse;
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
        .action-btn {
            padding: 5px 10px;
            margin-right: 5px;
            color: white;
            border-radius: 4px;
            text-decoration: none;
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
        .message {
            color: green;
            margin-bottom: 10px;
        }
        .error {
            color: red;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <%@include file="../layout/Header.jsp" %>
    
    <div class="container-fluid">
        <div class="layout-specing">
            <h5 class="mb-0">Quản lý giống</h5>
            
            <div class="toolbar">
                <a href="createbreed">Tạo mới</a>
            </div>
            
            <c:if test="${not empty message}">
                <div class="${message.contains('successfully') ? 'message' : 'error'}">${message}</div>
            </c:if>
            
            <table>
                <thead>
                    <tr>
                        <th>STT</th>
                        <th>Tên giống</th>
                        <th>Loài</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="breed" items="${breedList}" varStatus="counter">
                        <tr>
                            <td>${counter.count}</td>
                            <td>${breed.name}</td>
                            <td>${breed.specie.name}</td>
                            <td>
                                <a href="updatebreed?id=${breed.id}" class="action-btn edit-btn">Sửa</a>
                                <a href="javascript:confirmDelete(${breed.id})" class="action-btn delete-btn">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            
            <c:if test="${empty breedList}">
                <p>Không tìm thấy giống.</p>
            </c:if>
        </div>
    </div>

    <%@include file="../layout/Footer.jsp" %>

    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
    <script>
        function confirmDelete(id) {
            if (confirm("Bạn chắc chắn muốn xóa giống này?")) {
                window.location.href = "deletebreed?id=" + id;
            }
        }
    </script>
</body>
</html>