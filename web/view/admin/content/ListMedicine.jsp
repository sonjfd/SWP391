<%-- 
    Document   : ListMedicine
    Created on : Jun 11, 2025
    Author     : Web-based
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Quản lý thuốc - Doctris</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
    <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
    <meta name="author" content="Shreethemes" />
    <meta name="email" content="support@shreethemes.in" />
    <meta name="website" content="${pageContext.request.contextPath}/index.html" />
    <meta name="Version" content="v1.2.0" />
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico">
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/assets/css/simplebar.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/assets/css/select2.min.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
    <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/tiny-slider.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" />
    <style>
        .form-container {
            max-width: 1200px;
            margin: 20px auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 15px;
            display: inline-block;
            margin-right: 20px;
            vertical-align: top;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        select {
            width: 200px;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }
        button {
            padding: 10px 20px;
            background-color: #33CCFF;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: #29b3e6;
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
        .error-message {
            color: red;
            margin-bottom: 10px;
        }
        .container-fluid { padding: 20px; }
        .layout-specing { max-width: 1200px; margin: 0 auto; }
    </style>
</head>
<body>
    <jsp:include page="../layout/Header.jsp" />
    
    <div class="container-fluid">
        <div class="layout-specing">
            <h5 class="mb-0">Quản lý thuốc</h5>
            
            <div class="form-container">
                <div class="toolbar">
                    <a href="${pageContext.request.contextPath}/createmedicine">Tạo mới</a>
                    <div class="form-group">
                        <label for="filterStatus">Trạng thái:</label>
                        <select id="filterStatus">
                            <option value="">Tất cả</option>
                            <option value="1">Hoạt động</option>
                            <option value="0">Không hoạt động</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="sortPrice">Sắp xếp giá:</label>
                        <select id="sortPrice">
                            <option value="">Mặc định</option>
                            <option value="asc">Tăng dần</option>
                            <option value="desc">Giảm dần</option>
                        </select>
                    </div>
                    
                </div>
                
                <c:if test="${not empty message}">
                    <div class="${message.contains('successfully') ? 'message' : 'error-message'}">${message}</div>
                </c:if>
                
                <table id="medicineTable">
                    <thead>
                        <tr>
                            <th>STT</th>
                            <th>Tên thuốc</th>
                            <th>Mô tả</th>
                            <th>Giá</th>
                            <th>Trạng thái</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody id="medicineTbody">
                        <c:forEach var="medicine" items="${medicineList}" varStatus="counter">
                            <tr data-status="${medicine.status}" data-price="${medicine.price}">
                                <td>${counter.count}</td>
                                <td>${medicine.name}</td>
                                <td>${medicine.getDescripton()}</td>
                                <td>${medicine.price}</td>
                                <td>${medicine.status == 1 ? 'Hoạt động' : 'Không hoạt động'}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/updatemedicine?id=${medicine.id}" class="action-btn edit-btn">Sửa</a>
                                    <a href="javascript:confirmDelete('${medicine.id}')" class="action-btn delete-btn">Xóa</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                
                <c:if test="${empty medicineList}">
                    <p>Không tìm thấy thuốc.</p>
                </c:if>
            </div>
        </div>
    </div>

    <jsp:include page="../layout/Footer.jsp" />

    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/simplebar.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/apexcharts.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/columnchart.init.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
    <script>
        // Lưu trữ danh sách gốc
        const originalRows = Array.from(document.querySelectorAll('#medicineTbody tr[data-status]'));

        function filterMedicines() {
            const statusFilter = document.getElementById('filterStatus').value;
            const sortPrice = document.getElementById('sortPrice').value;
            const tbody = document.getElementById('medicineTbody');

            console.log('Status filter: ' + statusFilter + ', Sort price: ' + sortPrice); // Debug
            console.log('Original rows: ' + originalRows.length); // Debug

            // Lọc trạng thái từ danh sách gốc
            let filteredRows = originalRows.filter(row => {
                const status = row.getAttribute('data-status');
                return statusFilter === '' || status === statusFilter;
            });

            console.log('Rows after status filter: ' + filteredRows.length); // Debug
            console.log('Prices before sort: ' + filteredRows.map(row => row.getAttribute('data-price'))); // Debug

            // Sắp xếp giá
            if (sortPrice !== '') {
                filteredRows = filteredRows.sort((a, b) => {
                    const priceA = parseFloat(a.getAttribute('data-price'));
                    const priceB = parseFloat(b.getAttribute('data-price'));
                    return sortPrice === 'asc' ? priceA - priceB : priceB - priceA;
                });
            }

            console.log('Prices after sort: ' + filteredRows.map(row => row.getAttribute('data-price'))); // Debug

            // Cập nhật tbody
            tbody.innerHTML = '';
            if (filteredRows.length === 0) {
                tbody.innerHTML = '<tr><td colspan="6">Không tìm thấy thuốc.</td></tr>';
            } else {
                filteredRows.forEach(row => tbody.appendChild(row.cloneNode(true)));
            }

            console.log('Tbody children after update: ' + tbody.children.length); // Debug
        }

        function resetFilters() {
            document.getElementById('filterStatus').value = '';
            document.getElementById('sortPrice').value = '';
            filterMedicines();
        }

        function confirmDelete(id) {
            if (confirm("Bạn chắc chắn muốn xóa thuốc này?")) {
                window.location.href = "${pageContext.request.contextPath}/deletemedicine?id=" + id;
            }
        }

        // Gắn sự kiện
        document.getElementById('filterStatus').addEventListener('change', filterMedicines);
        document.getElementById('sortPrice').addEventListener('change', filterMedicines);

        // Chạy lần đầu
        filterMedicines();
    </script>
</body>
</html>