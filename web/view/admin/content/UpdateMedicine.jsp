<%-- 
    Document   : UpdateMedicine
    Created on : June 11, 2025
    Author     : Web-based
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Cập nhật thuốc - Doctris</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico">
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
    <link href="https://unicons.iconscout.com/release/v4.0.8/css/line.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" />
    <style>
        .form-group { margin-bottom: 15px; }
        label { font-weight: 600; color: #333; margin-bottom: 5px; display: block; }
        input[type="text"], input[type="number"], textarea, select { 
            padding: 8px; border: 1px solid #ddd; border-radius: 4px; font-size: 16px; width: 100%; }
        textarea { height: 100px; }
        button { 
            padding: 8px 16px; background-color: #33CCFF; color: white; border: none; 
            border-radius: 4px; cursor: pointer; }
        button:hover { background-color: #29b3e6; }
        .error-text { color: #dc3545; font-size: 12px; margin-top: 2px; display: none; }
        .error-text.show { display: block; }
        .is-invalid { border-color: #dc3545; }
        .btn-back { 
            display: inline-block; margin-left: 10px; padding: 8px 16px; background-color: #f44336; 
            color: white; border-radius: 4px; text-decoration: none; }
        .btn-back:hover { background-color: #d32f2f; }
        .container-fluid { padding: 20px; }
        .layout-specing { max-width: 1200px; margin: 0 auto; }
        .success-message { color: #28a745; font-size: 14px; margin-bottom: 10px; }
    </style>
</head>
<body>
    <jsp:include page="../layout/Header.jsp" />
    
    <div class="container-fluid">
        <div class="layout-specing">
            <h5 class="mb-3">Cập nhật thuốc</h5>
            <div class="row">
                <div class="col-lg-6">
                    <c:if test="${not empty message}">
                        <div class="${message.contains('Error') ? 'error-text show' : 'success-message'}">${message}</div>
                    </c:if>
                    <form id="updateMedicineForm" method="post" action="${pageContext.request.contextPath}/updatemedicine">
                        <input type="hidden" name="id" value="${medicine.id}">
                        <div class="form-group">
                            <label for="name">Tên thuốc <span style="color: red;">*</span></label>
                            <input type="text" id="name" name="name" placeholder="Nhập tên thuốc" value="${medicine.name}">
                            <div id="nameError" class="error-text"></div>
                        </div>
                        <div class="form-group">
                            <label for="description">Mô tả</label>
                            <textarea id="description" name="description" placeholder="Nhập mô tả">${medicine.getDescripton()}</textarea>
                            <div id="descriptionError" class="error-text"></div>
                        </div>
                        <div class="form-group">
                            <label for="price">Giá (VND) <span style="color: red;">*</span></label>
                            <input type="number" id="price" name="price" placeholder="0.00" step="0.01" min="0" value="${medicine.price}">
                            <div id="priceError" class="error-text"></div>
                        </div>
                        <div class="form-group">
                            <label for="status">Trạng thái <span style="color: red;">*</span></label>
                            <select id="status" name="status" required>
                                <option value="1" ${medicine.status == 1 ? 'selected' : ''}>Hoạt động</option>
                                <option value="0" ${medicine.status == 0 ? 'selected' : ''}>Không hoạt động</option>
                            </select>
                            <div id="statusError" class="error-text"></div>
                        </div>
                        <button type="submit">Cập nhật thuốc</button>
                        <a href="${pageContext.request.contextPath}/listmedicine" class="btn-back">Quay lại</a>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="../layout/Footer.jsp" />

    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
    <script>
        function escapeHtml(elementId) {
            const input = document.getElementById(elementId);
            const text = input.value;
            const div = document.createElement('div');
            div.textContent = text;
            return div.innerHTML;
        }

        function showError(elementId, message) {
            const errorElement = document.getElementById(elementId + 'Error');
            const inputElement = document.getElementById(elementId);
            errorElement.textContent = message;
            errorElement.classList.add('show');
            inputElement.classList.add('is-invalid');
        }

        function clearError(elementId) {
            const errorElement = document.getElementById(elementId + 'Error');
            const inputElement = document.getElementById(elementId);
            errorElement.textContent = '';
            errorElement.classList.remove('show');
            inputElement.classList.remove('is-invalid');
        }

        function validateField(elementId) {
            clearError(elementId);
            const value = elementId === 'price' ? document.getElementById(elementId).value : escapeHtml(elementId).trim();
            const vietnameseNameRegex = /^[\p{L}\d\s]+$/u;

            if (elementId === 'name') {
                if (!value) {
                    showError('name', 'Tên thuốc là bắt buộc.');
                    return false;
                }
                if (value.length < 2 || value.length > 255) {
                    showError('name', 'Tên thuốc phải từ 2 đến 255 ký tự.');
                    return false;
                }
                if (!vietnameseNameRegex.test(value)) {
                    showError('name', 'Tên thuốc chỉ chứa chữ, số và khoảng trắng.');
                    return false;
                }
            } else if (elementId === 'description') {
                if (value.length > 4000) {
                    showError('description', 'Mô tả không được vượt quá 4000 ký tự.');
                    return false;
                }
                if (value && !vietnameseNameRegex.test(value)) {
                    showError('description', 'Mô tả chỉ chứa chữ, số và khoảng trắng.');
                    return false;
                }
            } else if (elementId === 'price') {
                const price = parseFloat(value);
                if (!value || isNaN(price)) {
                    showError('price', 'Giá là bắt buộc và phải là số.');
                    return false;
                }
                if (price <= 0) {
                    showError('price', 'Giá phải lớn hơn 0.');
                    return false;
                }
                if (price > 99999999.99) {
                    showError('price', 'Giá không được vượt quá 99,999,999.99.');
                    return false;
                }
            }
            return true;
        }

        document.getElementById('name').addEventListener('blur', () => validateField('name'));
        document.getElementById('description').addEventListener('blur', () => validateField('description'));
        document.getElementById('price').addEventListener('blur', () => validateField('price'));

        document.getElementById('updateMedicineForm').addEventListener('submit', function(e) {
            e.preventDefault();
            const isNameValid = validateField('name');
            const isDescriptionValid = validateField('description');
            const isPriceValid = validateField('price');
            if (isNameValid && isDescriptionValid && isPriceValid) {
                this.submit();
            } else {
                const firstInvalid = !isNameValid ? 'name' : (!isDescriptionValid ? 'description' : 'price');
                document.getElementById(firstInvalid).focus();
            }
        });
    </script>
</body>
</html>