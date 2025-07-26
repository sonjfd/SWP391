<%-- 
    Document   : UpdateService
    Created on : Jun 20, 2025
    Author     : Grok
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Pet24 - Cập nhật dịch vụ</title>
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
        .container {
            max-width: 600px;
            margin: 20px auto;
            padding: 15px;
            background: white;
            border: 1px solid #ddd;
            border-radius: 8px;
        }
        h4 {
            margin-bottom: 20px;
            color: #333;
            font-size: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            font-weight: 600;
            color: #333;
            margin-bottom: 5px;
            display: block;
        }
        input[type="text"], input[type="number"], textarea, select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        textarea {
            resize: vertical;
            min-height: 80px;
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
        .error-text {
            color: #dc3545;
            font-size: 12px;
            margin-top: 5px;
            display: none;
        }
        .error-text.show {
            display: block;
        }
        .is-invalid {
            border-color: #dc3545;
        }
        .btn-back {
            padding: 10px 20px;
            background-color: #f44336;
            color: white;
            border: none;
            border-radius: 4px;
            text-decoration: none;
            margin-left: 10px;
        }
        .btn-back:hover {
            background-color: #d32f2f;
        }
        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <jsp:include page="../layout/Header.jsp" />

    <div class="container">
        <h4>Cập nhật dịch vụ</h4>

        <c:if test="${not empty error}">
            <div class="alert-danger">${error}</div>
        </c:if>

        <form id="updateServiceForm" action="${pageContext.request.contextPath}/admin-update-service" method="POST">
            <input type="hidden" name="id" value="${service.id}">

            <div class="form-group">
                <label for="department_id">Phòng ban <span style="color: red;">*</span></label>
                <select id="department_id" name="department_id">
                    <option value="">Chọn phòng ban</option>
                    <c:forEach items="${departments}" var="dept">
                        <option value="${dept.id}" ${service.departmentId == dept.id ? 'selected' : ''}>${dept.name}</option>
                    </c:forEach>
                </select>
                <div id="department_idError" class="error-text"></div>
            </div>

            <div class="form-group">
                <label for="name">Tên dịch vụ <span style="color: red;">*</span></label>
                <input type="text" id="name" name="name" value="${service.name}">
                <div id="nameError" class="error-text"></div>
            </div>

            <div class="form-group">
                <label for="price">Giá <span style="color: red;">*</span></label>
                <input type="number" id="price" name="price" value="${service.price}" step="0.01" min="0">
                <div id="priceError" class="error-text"></div>
            </div>

            <div class="form-group">
                <label for="description">Mô tả</label>
                <textarea id="description" name="description">${service.description}</textarea>
            </div>

            <div class="form-group">
                <label for="status">Trạng thái <span style="color: red;">*</span></label>
                <select id="status" name="status">
                    <option value="">Chọn trạng thái</option>
                    <option value="1" ${service.status == 1 ? 'selected' : ''}>Hoạt động</option>
                    <option value="0" ${service.status == 0 ? 'selected' : ''}>Không hoạt động</option>
                </select>
                <div id="statusError" class="error-text"></div>
            </div>

            <button type="submit">Cập nhật</button>
            <a href="${pageContext.request.contextPath}/admin-list-service" class="btn-back">Quay lại</a>
        </form>
    </div>

    

    <script>
        function showError(fieldId, message) {
            document.getElementById(fieldId + 'Error').textContent = message;
            document.getElementById(fieldId + 'Error').classList.add('show');
            document.getElementById(fieldId).classList.add('is-invalid');
        }

        function clearError(fieldId) {
            document.getElementById(fieldId + 'Error').textContent = '';
            document.getElementById(fieldId + 'Error').classList.remove('show');
            document.getElementById(fieldId).classList.remove('is-invalid');
        }

        function validateDepartment() {
            const value = document.getElementById('department_id').value;
            if (!value) {
                showError('department_id', 'Vui lòng chọn phòng ban.');
                return false;
            }
            clearError('department_id');
            return true;
        }

        function validateName() {
            const value = document.getElementById('name').value.trim();
            const regex = /^[\p{L}0-9\s]+$/u;
            if (!value) {
                showError('name', 'Tên dịch vụ không được trống.');
                return false;
            } else if (!regex.test(value)) {
                showError('name', 'Tên chỉ chứa chữ cái, số, dấu cách, và tiếng Việt.');
                return false;
            }
            clearError('name');
            return true;
        }

        function validatePrice() {
            const value = document.getElementById('price').value;
            if (!value || value < 0) {
                showError('price', 'Giá phải là số dương.');
                return false;
            }
            clearError('price');
            return true;
        }

        function validateStatus() {
            const value = document.getElementById('status').value;
            if (value !== '0' && value !== '1') {
                showError('status', 'Vui lòng chọn trạng thái.');
                return false;
            }
            clearError('status');
            return true;
        }

        // Gán sự kiện blur
        document.getElementById('department_id').addEventListener('blur', validateDepartment);
        document.getElementById('name').addEventListener('blur', validateName);
        document.getElementById('price').addEventListener('blur', validatePrice);
        document.getElementById('status').addEventListener('blur', validateStatus);

        // Gán sự kiện submit
        document.getElementById('updateServiceForm').addEventListener('submit', function (e) {
            e.preventDefault();
            const isValid =
                validateDepartment() &&
                validateName() &&
                validatePrice() &&
                validateStatus();

            if (isValid) {
                this.submit(); // Gửi form khi hợp lệ
            } else {
                console.log('Form có lỗi, không gửi.');
            }
        });
    </script>
</body>
</html>
