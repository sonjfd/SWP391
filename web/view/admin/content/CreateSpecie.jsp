<%-- 
    Document   : CreateSpecie
    Created on : Jun 10, 2025
    Author     : Dell
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>Tạo loài mới - Doctris</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico">
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" />
        <style>
            .form-group {
                margin-bottom: 15px;
            }
            label {
                font-weight: 600;
                color: #333;
                margin-bottom: 5px;
                display: block;
            }
            input[type="text"], input[type="file"] {
                width: 100%;
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
                font-size: 14px;
            }
            button {
                padding: 8px 16px;
                background-color: #33CCFF;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-weight: 600;
            }
            button:hover {
                background-color: #29b3e6;
            }
            .error-text {
                color: #dc3545;
                font-size: 12px;
                margin-top: 3px;
                display: none;
            }
            .error-text.show {
                display: block;
            }
            .is-invalid {
                border-color: #dc3545;
            }
            .btn-back {
                display: inline-block;
                margin-left: 10px;
                padding: 8px 16px;
                background-color: #f44336;
                color: white;
                border-radius: 4px;
                text-decoration: none;
                font-weight: 600;
            }
            .btn-back:hover {
                background-color: #d32f2f;
            }
            #imagePreview {
                display: none;
                margin-top: 10px;
                max-width: 200px;
                border: 1px solid #ccc;
                padding: 5px;
                border-radius: 4px;
            }
        </style>
    </head>
    <body>
        <%@include file="../layout/Header.jsp" %>

        <div class="container-fluid">
            <div class="layout-specing">
                <h5 class="mb-3">Tạo loài mới</h5>
                <div class="row">
                    <div class="col-lg-6">
                        <form id="createSpecieForm" method="post" action="admin-create-specie" enctype="multipart/form-data">
                            <div class="form-group">
                                <label>Tên loài <span style="color: red;">*</span></label>
                                <input type="text" id="name" name="name" placeholder="Nhập tên loài">
                                <div id="nameError" class="error-text"></div>
                            </div>

                            <div class="form-group">
                                <label>Ảnh đại diện loài <span style="color: red;">*</span></label>
                                <input type="file" name="image" accept=".jpg,.jpeg,.png" required onchange="previewImage(event)" />
                                <!-- Preview Image -->
                                <img id="imagePreview" src="#" alt="Image Preview" />
                            </div>

                            <button type="submit">Tạo loài</button>
                            <a href="admin-list-specie" class="btn-back">Quay lại</a>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <%@include file="../layout/Footer.jsp" %>

        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <script>
            function escapeHtml(fieldId) {
                const input = document.getElementById(fieldId);
                const html = input.value;
                const div = document.createElement("div");
                div.innerText = html;
                return div.innerHTML;
            }

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

            function validateField(fieldId) {
                clearError(fieldId);
                const allowedChars = /^[\p{L}0-9\s]+$/u;
                const value = escapeHtml(fieldId).trim();

                if (!value) {
                    showError(fieldId, 'Tên loài là bắt buộc.');
                    return false;
                }
                if (value.length < 2 || value.length > 100) {
                    showError(fieldId, 'Tên loài phải từ 2 đến 100 ký tự.');
                    return false;
                }
                if (!allowedChars.test(value)) {
                    showError(fieldId, 'Tên loài chỉ chứa chữ, số và khoảng trắng.');
                    return false;
                }
                return true;
            }

            document.getElementById('name').addEventListener('blur', () => validateField('name'));

            document.getElementById('createSpecieForm').addEventListener('submit', function (e) {
                e.preventDefault();
                if (validateField('name')) {
                    this.submit();
                } else {
                    document.getElementById('name').focus();
                }
            });

            function previewImage(event) {
                const input = event.target;
                const preview = document.getElementById('imagePreview');

                if (input.files && input.files[0]) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        preview.src = e.target.result;
                        preview.style.display = 'block';
                    };
                    reader.readAsDataURL(input.files[0]);
                }
            }
        </script>
    </body>
</html>
