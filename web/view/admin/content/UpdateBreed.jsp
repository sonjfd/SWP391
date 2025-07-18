<%-- 
    Document   : UpdateBreed
    Created on : Jun 10, 2025
    Author     : Dell
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Cập nhật giống - Doctris</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico">
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
    <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" />
    <style>
        .form-group { margin-bottom: 15px; }
        label { font-weight: 600; color: #333; margin-bottom: 5px; display: block; }
        input[type="text"], select { 
            width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; font-size: 14px; }
        button { 
            padding: 8px 16px; background-color: #33CCFF; color: white; border: none; 
            border-radius: 4px; cursor: pointer; font-weight: 600; }
        button:hover { background-color: #29b3e6; }
        .error-text { color: #dc3545; font-size: 12px; margin-top: 3px; display: none; }
        .error-text.show { display: block; }
        .is-invalid { border-color: #dc3545; }
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
        .btn-back:hover { background-color: #d32f2f; }
    </style>
</head>
<body>
    <%@include file="../layout/Header.jsp" %>
    
    <div class="container-fluid">
        <div class="layout-specing">
            <h5 class="mb-3">Cập nhật giống</h5>
            <div class="row">
                <div class="col-lg-6">
                    <form id="updateBreedForm" method="post" action="admin-update-breed">
                        <input type="hidden" name="id" value="${breed.id}">
                        <div class="form-group">
                            <label>Loài <span style="color: red;">*</span></label>
                            <select id="speciesId" name="speciesId">
                                <option value="">Chọn loài</option>
                                <c:forEach var="specie" items="${specieList}">
                                    <option value="${specie.id}" ${specie.id == breed.specie.id ? 'selected' : ''}>${specie.name}</option>
                                </c:forEach>
                            </select>
                            <div id="speciesIdError" class="error-text"></div>
                        </div>
                        <div class="form-group">
                            <label>Tên giống <span style="color: red;">*</span></label>
                            <input type="text" id="name" name="name" value="${breed.name}" placeholder="Nhập tên giống">
                            <div id="nameError" class="error-text"></div>
                        </div>
                        <button type="submit">Cập nhật</button>
                        <a href="admin-list-breed" class="btn-back">Quay lại</a>
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
            const value = document.getElementById(fieldId).value.trim();
            
            if (fieldId === 'speciesId') {
                if (!value) {
                    showError(fieldId, 'Vui lòng chọn loài.');
                    return false;
                }
            } else if (fieldId === 'name') {
                const allowedChars = /^[\p{L}0-9\s]+$/u;
                if (!value) {
                    showError(fieldId, 'Tên giống là bắt buộc.');
                    return false;
                }
                if (value.length < 2 || value.length > 100) {
                    showError(fieldId, 'Tên giống phải từ 2 đến 100 ký tự.');
                    return false;
                }
                if (!allowedChars.test(value)) {
                    showError(fieldId, 'Tên giống chỉ chứa chữ, số và khoảng trắng.');
                    return false;
                }
            }
            return true;
        }

        document.getElementById('speciesId').addEventListener('change', () => validateField('speciesId'));
        document.getElementById('name').addEventListener('blur', () => validateField('name'));

        document.getElementById('updateBreedForm').addEventListener('submit', function(e) {
            e.preventDefault();
            const isSpeciesValid = validateField('speciesId');
            const isNameValid = validateField('name');
            if (isSpeciesValid && isNameValid) {
                this.submit();
            } else {
                document.getElementById(isSpeciesValid ? 'name' : 'speciesId').focus();
            }
        });
    </script>
</body>
</html>