<%-- 
    Document   : ListSpecie
    Created on : Jun 10, 2025
    Author     : Dell
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Quản lý loài - Doctris</title>
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
        align-items: center;
        margin-bottom: 20px;
    }

    .toolbar a {
        padding: 10px 20px;
        background-color: #33CCFF;
        color: #fff;
        border-radius: 6px;
        font-weight: 500;
        transition: background-color 0.3s ease;
    }

    .toolbar a:hover {
        background-color: #29b3e6;
        text-decoration: none;
    }

    table {
    width: 100%;
    border-collapse: collapse;
    background-color: #fff;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
    border-radius: 8px;
    overflow: hidden;
    table-layout: fixed; /* NEW: giúp chia đều cột */
}
th, td {
    padding: 12px 16px;
    border-top: 1px solid #eee;
    word-wrap: break-word; /* NEW: chống tràn chữ */
    white-space: normal;
}


    thead {
        background-color: #33CCFF;
    }

    th {
        padding: 12px 16px;
        color: #fff;
        text-align: left;
        font-weight: 600;
    }

    td {
        padding: 12px 16px;
        border-top: 1px solid #eee;
    }

    tr:nth-child(even) {
        background-color: #f9f9f9;
    }

    .action-btn {
        padding: 6px 12px;
        margin-right: 5px;
        border-radius: 4px;
        color: #fff;
        font-size: 14px;
        transition: background-color 0.3s ease;
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

    .message, .error {
        padding: 10px 15px;
        border-radius: 4px;
        margin-bottom: 15px;
        font-weight: 500;
    }

    .message {
        background-color: #d4edda;
        color: #155724;
        border: 1px solid #c3e6cb;
    }

    .error {
        background-color: #f8d7da;
        color: #721c24;
        border: 1px solid #f5c6cb;
    }

    @media (max-width: 768px) {
        th, td {
            font-size: 14px;
            padding: 10px;
        }

        .toolbar a {
            padding: 8px 14px;
            font-size: 14px;
        }

        .action-btn {
            padding: 5px 10px;
            font-size: 13px;
        }
    }
</style>

</head>
<body>
    <%@include file="../layout/Header.jsp" %>
    
    <div class="container-fluid">
        <div class="layout-specing">
            <h5 class="mb-0">Quản lý loài</h5>
            
            <div class="toolbar">
                <a href="createspecie">Tạo mới</a>
            </div>
            
            <c:if test="${not empty message}">
                <div class="${message.contains('successfully') ? 'message' : 'error'}">${message}</div>
            </c:if>
            
            <table>
                <thead>
                    <tr>
                        <th>STT</th>
                        <th>Tên</th>
                        
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="specie" items="${specieList}" varStatus="counter">
                        <tr>
                            <td>${counter.count}</td>
                            <td>${specie.name}</td>
                            
                            <td>
                                <a href="updatespecie?id=${specie.id}" class="action-btn edit-btn">Sửa</a>
                                <a href="javascript:confirmDelete(${specie.id})" class="action-btn delete-btn">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            
            <c:if test="${empty specieList}">
                <p>Không tìm kiếm thấy loài.</p>
            </c:if>
        </div>
    </div>

    <%@include file="../layout/Footer.jsp" %>

    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
    <script>
        function confirmDelete(id) {
            if (confirm("Bạn chắc chắn muốn xóa loài này?")) {
                window.location.href = "deletespecie?id=" + id;
            }
        }
        // Debug: Log số giống
        <c:forEach var="specie" items="${specieList}">
            console.log("Specie: ${specie.name}, Breeds size: ${specie.breeds != null ? specie.breeds.size() : 0}");
        </c:forEach>
    </script>
</body>
</html>