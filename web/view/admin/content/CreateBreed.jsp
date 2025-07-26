<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Pet24h - Tạo giống mới</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
    <link href="https://unicons.iconscout.com/release/v4.0.8/css/line.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" />
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
            min-height: calc(100vh - 70px - 50px);
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
        select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 15px;
            box-sizing: border-box;
        }

        input:focus,
        select:focus {
            border-color: #4CAF50;
            outline: none;
        }

        input.is-invalid,
        select.is-invalid {
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
    </style>
</head>
<body>
    <jsp:include page="../layout/Header.jsp" />
    
    <div class="main-wrapper">
        <div class="form-container">
            <h5>Tạo giống mới</h5>
            <c:if test="${not empty message}">
                <div class="alert alert-danger">${message}</div>
            </c:if>
            <div class="row">
                <div class="col-lg-12">
                    <form id="createBreedForm" method="post" action="${pageContext.request.contextPath}/admin-create-breed">
                        <div class="form-group">
                            <label>Loài <span style="color: red;">*</span></label>
                            <select id="speciesId" name="speciesId">
                                <option value="">Chọn loài</option>
                                <c:forEach var="specie" items="${specieList}">
                                    <option value="${specie.id}">${specie.name}</option>
                                </c:forEach>
                            </select>
                            <div id="speciesIdError" class="error-text"></div>
                        </div>
                        <div class="form-group">
                            <label>Tên giống <span style="color: red;">*</span></label>
                            <input type="text" id="name" name="name" placeholder="Nhập tên giống">
                            <div id="nameError" class="error-text"></div>
                        </div>
                        <div class="button-group">
                            <button type="submit" class="btn-custom btn-submit">Tạo giống</button>
                            <a href="${pageContext.request.contextPath}/admin-list-breed" class="btn-custom btn-back">Quay lại</a>
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
            const errorElement = document.getElementById(fieldId + 'Error');
            const fieldElement = document.getElementById(fieldId);
            errorElement.textContent = message;
            errorElement.classList.add('show');
            fieldElement.classList.add('is-invalid');
        }

        function clearError(fieldId) {
            const errorElement = document.getElementById(fieldId + 'Error');
            const fieldElement = document.getElementById(fieldId);
            errorElement.textContent = '';
            errorElement.classList.remove('show');
            fieldElement.classList.remove('is-invalid');
        }

        function validateField(fieldId) {
            clearError(fieldId);
            const value = fieldId === 'speciesId' ? document.getElementById(fieldId).value : escapeHtml(fieldId).trim();
            
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

        document.getElementById('createBreedForm').addEventListener('submit', function(e) {
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