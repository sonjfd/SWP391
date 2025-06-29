<%-- 
    Document   : listShift
    Created on : Jun 12, 2025
    Author     : Web-based
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Quản lý ca làm việc</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico">
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/assets/css/simplebar.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
    <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
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
            <h5 class="mb-0">Quản lý ca làm việc</h5>
            
            <div class="form-container">
                <div class="toolbar">
                    <a href="${pageContext.request.contextPath}/admin-create-shift">Tạo mới</a>
                    <div class="form-group">
                        <label for="filterPeriod">Khoảng thời gian:</label>
                        <select id="filterPeriod">
                            <option value="">Tất cả</option>
                            <option value="morning">Sáng (6:00-14:00)</option>
                            <option value="afternoon">Chiều (14:00-22:00)</option>
                            <option value="night">Đêm (22:00-6:00)</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="sortStartTime">Sắp xếp thời gian bắt đầu:</label>
                        <select id="sortStartTime">
                            <option value="">Mặc định</option>
                            <option value="asc">Sớm nhất</option>
                            <option value="desc">Muộn nhất</option>
                        </select>
                    </div>
                    
                </div>
                
                <c:if test="${not empty message}">
                    <div class="${message.contains('successfully') ? 'message' : 'error-message'}">${message}</div>
                </c:if>
                
                <table id="shiftTable">
                    <thead>
                        <tr>
                            <th>STT</th>
                            <th>Tên ca</th>
                            <th>Thời gian bắt đầu</th>
                            <th>Thời gian kết thúc</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody id="shiftTbody">
                        <c:forEach var="shift" items="${shiftList}" varStatus="counter">
                            <tr data-period="${shift.start_time.hour >= 6 && shift.start_time.hour < 14 ? 'morning' : 
                                               shift.start_time.hour >= 14 && shift.start_time.hour < 22 ? 'afternoon' : 'night'}"
                                data-start-time="${shift.start_time != null ? shift.start_time : '00:00:00'}">
                                <td>${counter.count}</td>
                                <td>${shift.name}</td>
                                <td>${shift.start_time != null ? shift.start_time : 'N/A'}</td>
                                <td>${shift.end_time != null ? shift.end_time : 'N/A'}</td>
                                <td>
                                    <a href="admin-update-shift?id=${shift.id}" class="action-btn edit-btn">Sửa</a>
                                    <a href="${pageContext.request.contextPath}/admin-delete-shift?id=${shift.id}" class="action-btn delete-btn btn-delete" onclick="return confirm('Bạn có chắc muốn xóa ca này?')">Xóa</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                
                <c:if test="${empty shiftList}">
                    <p>Không tìm thấy ca làm việc.</p>
                </c:if>
            </div>
        </div>
    </div>

    <jsp:include page="../layout/Footer.jsp" />

    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/simplebar.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
    <script>
        document.querySelectorAll('.btn-delete').forEach(button => {
                button.addEventListener('click', (e) => {
                    console.log('Delete button clicked for URL: ' + button.href);
                    if (!confirm('Bạn có chắc muốn xóa ca này?')) {
                        e.preventDefault();
                        console.log('Delete cancelled');
                    } else {
                        console.log('Delete confirmed, sending request');
                    }
                });
            });
        document.addEventListener('DOMContentLoaded', () => {
            const filterPeriod = document.getElementById('filterPeriod');
            const sortStartTime = document.getElementById('sortStartTime');
            const shiftTbody = document.getElementById('shiftTbody');
            const originalRows = Array.from(shiftTbody.querySelectorAll('tr'));

            if (!filterPeriod || !sortStartTime || !shiftTbody) {
                console.error('DOM elements not found:', { filterPeriod, sortStartTime, shiftTbody });
                return;
            }

            function filterAndSortShifts() {
                try {
                    const periodValue = filterPeriod.value;
                    const sortValue = sortStartTime.value;

                    // Lọc theo thời gian
                    let filteredRows = originalRows.filter(row => {
                        const period = row.getAttribute('data-period');
                        return periodValue === '' || period === periodValue;
                    });

                    // Sắp xếp theo thời gian bắt đầu
                    if (sortValue) {
                        filteredRows.sort((a, b) => {
                            let timeA = a.getAttribute('data-start-time') || '00:00:00';
                            let timeB = b.getAttribute('data-start-time') || '00:00:00';
                            return sortValue === 'asc' ? timeA.localeCompare(timeB) : timeB.localeCompare(timeA);
                        });
                    }

                    // Cập nhật tbody
                    shiftTbody.innerHTML = '';
                    if (filteredRows.length === 0) {
                        shiftTbody.innerHTML = '<tr><td colspan="5">Không tìm thấy ca làm việc.</td></tr>';
                    } else {
                        filteredRows.forEach((row, index) => {
                            const clonedRow = row.cloneNode(true);
                            clonedRow.cells[0].textContent = index + 1;
                            shiftTbody.appendChild(clonedRow);
                        });
                    }
                } catch (error) {
                    console.error('Error in filterAndSortShifts:', error);
                }
            }

            function resetFilters() {
                filterPeriod.value = '';
                sortStartTime.value = '';
                filterAndSortShifts();
            }

            function confirmDelete(id) {
                if (confirm("Bạn chắc chắn muốn xóa ca làm việc này?")) {
                    window.location.href = "${pageContext.request.contextPath}/admin-delete-shift?id=" + id;
                }
            }

            filterPeriod.addEventListener('change', filterAndSortShifts);
            sortStartTime.addEventListener('change', filterAndSortShifts);
            filterAndSortShifts();
        });
    </script>
</body>
</html>