<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Pet24h - Cập nhật loài</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" />
    <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" />
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background: url('${pageContext.request.contextPath}/assets/images/background.jpg') no-repeat center center fixed;
            background-size: cover;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .main-wrapper {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            min-height: calc(100vh - 70px);
        }

        .form-container {
            width: 100%;
            max-width: 600px;
            background: rgba(255, 255, 255, 0.96);
            padding: 30px;
            border: 2px solid #ccc;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.2);
            backdrop-filter: blur(6px);
        }

        .form-group {
            margin-bottom: 18px;
        }

        label {
            font-weight: bold;
            margin-bottom: 5px;
            display: block;
            color: #333;
        }

        input[type="text"],
        input[type="file"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 15px;
            box-sizing: border-box;
        }

        input:focus {
            border-color: #4CAF50;
            outline: none;
        }

        input.is-invalid {
            border-color: #d32f2f;
        }

        .error-text {
            color: #d32f2f;
            font-size: 0.9em;
            margin-top: 5px;
            display: none;
        }

        .error-text.show {
            display: block;
        }

        .btn-custom {
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            color: white;
            display: inline-block;
            text-align: center;
            transition: background-color 0.3s ease;
        }

        .btn-submit {
            background-color: #4CAF50;
        }

        .btn-submit:hover {
            background-color: #43a047;
        }

        .btn-back {
            background-color: #f44336;
            text-decoration: none;
        }

        .btn-back:hover {
            background-color: #d32f2f;
        }

        .button-group {
            display: flex;
            justify-content: space-between;
            gap: 15px;
            margin-top: 25px;
        }

        h5 {
            text-align: center;
            font-weight: 600;
            margin-bottom: 25px;
        }

        .alert.alert-danger {
            color: #d32f2f;
            margin-bottom: 15px;
            padding: 10px;
            border: 1px solid #d32f2f;
            border-radius: 6px;
        }

        .image-preview {
            margin-top: 10px;
            max-width: 200px;
            border: 1px solid #ccc;
            padding: 5px;
            border-radius: 6px;
            display: block;
        }

        #previewImage {
            display: none;
        }
    </style>
</head>
<body>
<%@include file="../layout/Header.jsp" %>

<div class="main-wrapper">
    <div class="form-container">
        <h5>Cập nhật loài</h5>
        <c:if test="${not empty message}">
            <div class="alert alert-danger">${message}</div>
        </c:if>
        <div class="row">
            <div class="col-lg-12">
                <form id="updateSpecieForm" method="post" action="admin-update-specie" enctype="multipart/form-data">
                    <input type="hidden" name="id" value="${specie.id}" />
                    <input type="hidden" name="currentImage" value="${specie.imageUrl}" />

                    <div class="form-group">
                        <label>Tên loài <span style="color: red;">*</span></label>
                        <input type="text" id="name" name="name" value="${specie.name}" placeholder="Nhập tên loài">
                        <div id="nameError" class="error-text"></div>
                    </div>

                    <div class="form-group">
                        <label>Ảnh hiện tại:</label>
                        <img id="currentImage" class="image-preview" src="${specie.imageUrl}" alt="Current Image" />
                    </div>

                    <div class="form-group">
                        <label>Chọn ảnh mới (tùy chọn):</label>
                        <input type="file" name="image" id="image" accept=".jpg,.jpeg,.png" />
                        <img id="previewImage" class="image-preview" />
                    </div>

                    <div class="button-group">
                        <button type="submit" class="btn-custom btn-submit">Cập nhật</button>
                        <a href="admin-list-specie" class="btn-custom btn-back">Quay lại</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

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

    document.getElementById('updateSpecieForm').addEventListener('submit', function(e) {
        e.preventDefault();
        if (validateField('name')) {
            this.submit();
        } else {
            document.getElementById('name').focus();
        }
    });

    document.getElementById('image').addEventListener('change', function (e) {
        const [file] = this.files;
        if (file) {
            const preview = document.getElementById('previewImage');
            preview.src = URL.createObjectURL(file);
            preview.style.display = 'block';
        }
    });
</script>
</body>
</html>