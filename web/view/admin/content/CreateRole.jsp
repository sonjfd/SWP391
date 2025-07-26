<%-- 
    Document   : CreateRole
    Created on : Jun 24, 2025
    Author     : Grok
    Description: Create role page for SWP391, styled like CreateShift.jsp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="vi">
<head>
    <meta charset="utf-8" />
    <title>Pet24h - Tạo vai trò mới</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
    <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
    <meta name="author" content="Shreethemes" />
    <meta name="email" content="support@shreethemes.in" />
    <meta name="website" content="${pageContext.request.contextPath}/index.html" />
    <meta name="Version" content="v1.2.0" />
    <!-- favicon -->
    
    <!-- Bootstrap -->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- simplebar -->
    <link href="${pageContext.request.contextPath}/assets/css/simplebar.css" rel="stylesheet" type="text/css" />
    <!-- Select2 -->
    <link href="${pageContext.request.contextPath}/assets/css/select2.min.css" rel="stylesheet" />
    <!-- Icons -->
    <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
    <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
    <!-- SLIDER -->
    <link href="${pageContext.request.contextPath}/assets/css/tiny-slider.css" rel="stylesheet" />
    <!-- Css -->
    <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
    <style>
        .form-container {
            max-width: 600px;
            margin: 20px auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }
        input.invalid {
            border-color: red;
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
        .error-message {
            color: red;
            font-size: 14px;
            margin-top: 5px;
        }
        .error {
            color: red;
            margin-bottom: 15px;
        }
        .container-fluid { padding: 20px; }
        .layout-specing { max-width: 1200px; margin: 0 auto; }
        .btn-custom {
            display: inline-block;
            margin-left: 10px;
            padding: 10px 20px;
            background-color: #f44336;
            color: white;
            border: none;
            border-radius: 4px;
            font-weight: 500;
            text-align: center;
            text-decoration: none;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }
        .btn-custom:hover {
            background-color: #d32f2f;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
    <jsp:include page="../layout/Header.jsp" />
    
    <div class="container-fluid">
        <div class="layout-specing">
            <h5>Tạo vai trò mới</h5>
            
            <div class="form-container">
                <c:if test="${not empty message}">
            <div class="alert alert-danger">${message}</div>
        </c:if>
                
                <form id="createRoleForm" action="${pageContext.request.contextPath}/admin-create-role" method="POST">
                    <div class="form-group">
                        <label for="name">Tên vai trò:</label>
                        <input type="text" id="name" name="name" value="${name}" maxlength="50">
                        <div id="nameError" class="error-message"></div>
                    </div>
                    <button type="submit">Tạo mới</button>
                    <a href="${pageContext.request.contextPath}/admin-list-role" class="btn-custom">Quay lại</a>
                </form>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/simplebar.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
    <script>
        const form = document.getElementById('createRoleForm');
        const inputs = {
            name: document.getElementById('name')
        };
        const errors = {
            name: document.getElementById('nameError')
        };

        function validateName() {
            const value = inputs.name.value.trim();
            if (!value) {
                errors.name.textContent = 'Tên vai trò không được để trống.';
                inputs.name.classList.add('invalid');
                return false;
            }
            if (value.length > 50) {
                errors.name.textContent = 'Tên vai trò tối đa 50 ký tự.';
                inputs.name.classList.add('invalid');
                return false;
            }
            errors.name.textContent = '';
            inputs.name.classList.remove('invalid');
            return true;
        }

        inputs.name.addEventListener('input', () => {
            validateName();
        });

        form.addEventListener('submit', (e) => {
            e.preventDefault();
            if (validateName()) {
                form.submit();
            }
        });
    </script>
</body>
</html>