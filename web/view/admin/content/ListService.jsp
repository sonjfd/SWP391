<%-- 
    Document   : listService
    Created on : Jun 20, 2025
    Author     : Grok
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Danh sách dịch vụ</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico">
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/assets/css/simplebar.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
    <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" />
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            color: #333;
        }
        .container-fluid {
            padding: 20px;
        }
        .layout-specing {
            max-width: 1200px;
            margin: 0 auto;
        }
        .form-container {
            max-width: 1200px;
            margin: 20px auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h5 {
            margin-bottom: 20px;
            color: #333;
            font-size: 20px;
        }
        .toolbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }
        .toolbar a {
            padding: 10px 20px;
            background-color: #33CCFF;
            color: white;
            border-radius: 4px;
            text-decoration: none;
        }
        .toolbar a:hover {
            background-color: #29b3e6;
        }
        .filter-group {
            display: flex;
            gap: 15px;
            align-items: center;
        }
        .filter-group select {
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
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
            font-weight: bold;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #e6f7ff;
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
            color: #28a745;
            margin-bottom: 10px;
            animation: fadeIn 0.5s ease-in;
        }
        .error-message {
            color: #f44336;
            margin-bottom: 10px;
            animation: fadeIn 0.5s ease-in;
        }
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
    </style>
</head>
<body>
    <jsp:include page="../layout/Header.jsp" />
    
    <div class="container-fluid">
        <div class="layout-specing">
            <h5 class="mb-0">Danh sách dịch vụ</h5>
            
            <div class="form-container">
                <div class="toolbar">
                    <a href="${pageContext.request.contextPath}/createservice">Tạo mới</a>
                    <div class="filter-group">
                        <select id="statusFilter">
                            <option value="">Tất cả trạng thái</option>
                            <option value="1">Hoạt động</option>
                            <option value="0">Không hoạt động</option>
                        </select>
                        <select id="priceSort">
                            <option value="">Sắp xếp giá</option>
                            <option value="asc">Tăng dần</option>
                            <option value="desc">Giảm dần</option>
                        </select>
                    </div>
                </div>
                
                <c:if test="${not empty message}">
                    <div class="${message.contains('thành công') ? 'message' : 'error-message'}">${message}</div>
                </c:if>
                
                <table id="serviceTable">
                    <thead>
                        <tr>
                            <th>STT</th>
                            
                            <th>Phòng ban</th>
                            <th>Tên dịch vụ</th>
                            <th>Giá</th>
                            <th>Trạng thái</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody id="serviceTbody">
                        <c:forEach items="${listService}" var="service" varStatus="counter">
                            <tr data-price="${service.price}" data-status="${service.status}">
                                <td>${counter.count}</td>
                                
                                <td>
                                    <c:forEach items="${departments}" var="dept">
                                        <c:if test="${dept.id == service.departmentId}">
                                            ${dept.name}
                                        </c:if>
                                    </c:forEach>
                                </td>
                                <td>${service.name}</td>
                                <td>${service.price}</td>
                                <td>${service.status == 1 ? 'Hoạt động' : 'Không hoạt động'}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/updateservice?id=${service.id}" class="action-btn edit-btn">Sửa</a>
                                    <a href="${pageContext.request.contextPath}/deleteservice?id=${service.id}" class="action-btn delete-btn" >Xóa</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                
                <c:if test="${empty listService}">
                    <p>Không tìm thấy dịch vụ.</p>
                </c:if>
            </div>
        </div>
    </div>

    

    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/simplebar.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
    <script>
        const statusFilter = document.getElementById('statusFilter');
        const priceSort = document.getElementById('priceSort');
        const serviceTbody = document.getElementById('serviceTbody');
        const rows = Array.from(serviceTbody.querySelectorAll('tr'));

        function filterAndSort() {
            let filteredRows = rows;

            // Filter by status
            const status = statusFilter.value;
            if (status !== '') {
                filteredRows = filteredRows.filter(row => row.dataset.status === status);
            }

            // Sort by price
            const sort = priceSort.value;
            if (sort !== '') {
                filteredRows.sort((a, b) => {
                    const priceA = parseFloat(a.dataset.price);
                    const priceB = parseFloat(b.dataset.price);
                    return sort === 'asc' ? priceA - priceB : priceB - priceA;
                });
            }

            // Update table
            serviceTbody.innerHTML = '';
            filteredRows.forEach((row, index) => {
                row.cells[0].textContent = index + 1; // Update STT
                serviceTbody.appendChild(row);
            });

            // Show message if no results
            if (filteredRows.length === 0) {
                serviceTbody.innerHTML = '<tr><td colspan="7">Không tìm thấy dịch vụ.</td></tr>';
            }
        }

        statusFilter.addEventListener('change', filterAndSort);
        priceSort.addEventListener('change', filterAndSort);

        document.querySelectorAll('.delete-btn').forEach(button => {
            button.addEventListener('click', (e) => {
                console.log('Delete button clicked for URL: ' + button.href);
                if (!confirm('Bạn có chắc muốn xóa dịch vụ này?')) {
                    e.preventDefault();
                    console.log('Delete cancelled');
                } else {
                    console.log('Delete confirmed, sending request');
                }
            });
        });
    </script>
</body>
</html>