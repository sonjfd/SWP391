<%-- 
    Document   : CreateMedicine
    Created on : June 11, 2025
    Author     : Web-based
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>Tạo thuốc mới - Doctris</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico">
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" />
        <link href="https://unicons.iconscout.com/release/v4.0.8/css/line.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" />
        <style>
            .form-container {
                border: 1px solid #ddd;
                border-radius: 8px;
                padding: 30px;
                background-color: #fff;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
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

            input[type="text"], textarea, select {
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
                font-size: 16px;
                width: 100%;
            }

            textarea {
                height: 100px;
            }

            .btn-submit {
                background-color: #33CCFF;
                color: white;
                border: none;
                border-radius: 4px;
                padding: 8px 16px;
                cursor: pointer;
            }

            .btn-submit:hover {
                background-color: #29b3e6;
            }

            .btn-back {
                background-color: #f44336;
                color: white;
                border-radius: 4px;
                padding: 8px 16px;
                text-decoration: none;
            }

            .btn-back:hover {
                background-color: #d32f2f;
            }

            .error-text {
                color: #dc3545;
                font-size: 12px;
                margin-top: 2px;
                display: none;
            }

            .error-text.show {
                display: block;
            }

            .is-invalid {
                border-color: #dc3545;
            }

            .button-group {
                display: flex;
                justify-content: space-between;
                margin-top: 20px;
            }

            .layout-specing {
                max-width: 800px;
                margin: 0 auto;
            }

            .container-fluid {
                padding: 20px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="../layout/Header.jsp" />

        <div class="container-fluid">
            <div class="layout-specing">
                <h5 class="mb-3">Tạo thuốc mới</h5>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="form-container">
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger">${error}</div>
                            </c:if>
                            <form id="createMedicineForm" method="post" action="${pageContext.request.contextPath}/admin-create-medicine">
                                <div class="form-group">
                                    <label for="name">Tên thuốc <span style="color: red;">*</span></label>
                                    <input type="text" id="name" name="name" placeholder="Nhập tên thuốc" value="${param.name}">
                                    <div id="nameError" class="error-text"></div>
                                </div>

                                <div class="form-group">
                                    <label for="description">Mô tả</label>
                                    <textarea id="description" name="description" placeholder="Nhập mô tả">${param.description}</textarea>
                                    <div id="descriptionError" class="error-text"></div>
                                </div>

                                <div class="form-group">
                                    <label for="status">Trạng thái <span style="color: red;">*</span></label>
                                    <select id="status" name="status" required>
                                        <option value="1" ${param.status == '1' ? 'selected' : ''}>Hoạt động</option>
                                        <option value="0" ${param.status == '0' ? 'selected' : ''}>Không hoạt động</option>
                                    </select>
                                    <div id="statusError" class="error-text"></div>
                                </div>

                                <div class="button-group">
                                    <button type="submit" class="btn-submit">Tạo thuốc</button>
                                    <a href="${pageContext.request.contextPath}/admin-list-medicine" class="btn-back">Quay lại</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="../layout/Footer.jsp" />

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
                const value = escapeHtml(elementId).trim();
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
                }
                return true;
            }

            document.getElementById('name').addEventListener('blur', () => validateField('name'));
            document.getElementById('description').addEventListener('blur', () => validateField('description'));

            document.getElementById('createMedicineForm').addEventListener('submit', function (e) {
                const isNameValid = validateField('name');
                const isDescriptionValid = validateField('description');
                if (!isNameValid || !isDescriptionValid) {
                    e.preventDefault();
                    const firstInvalid = !isNameValid ? 'name' : 'description';
                    document.getElementById(firstInvalid).focus();
                }
            });
        </script>
    </body>
</html>
