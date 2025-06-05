<%-- 
    Document   : Admin
    Created on : May 21, 2025, 8:24:23 PM
    Author     : Dell
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8" />
    <title>Doctris - Cập nhật tài khoản nhân viên/bác sĩ</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
    <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
    <meta name="author" content="Shreethemes" />
    <meta name="email" content="support@shreethemes.in" />
    <meta name="website" content="${pageContext.request.contextPath}/index.html" />
    <meta name="Version" content="v1.2.0" />
    <!-- favicon -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico.png">
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
        body {
            font-family: Arial, sans-serif;
            margin: 50px;
            background-color: #f4f4f4;
        }
        .form-container {
            max-width: 600px;
            margin: auto;
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
        input, select, textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        button {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: #45a049;
        }
        .doctor-fields {
            display: ${user.role.id == 3 ? 'block' : 'none'};
        }
        .error {
            color: red;
            font-size: 0.9em;
            display: none;
            margin-top: 0.25rem;
            opacity: 0;
            transition: opacity 0.3s ease-in-out;
        }
        .error.show {
            display: block;
            opacity: 1;
        }
        .is-invalid {
            border-color: #dc3545 !important;
        }
        .message {
            padding: 1rem;
            margin-bottom: 1.5rem;
            border-radius: 4px;
            font-size: 0.95rem;
        }
        .message.success {
            background: #dff0d8;
            color: #3c763d;
        }
        .message.error {
            background: #f2dede;
            color: #a94442;
        }
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
    <!-- Loader -->
    <div id="preloader">
        <div id="status">
            <div class="spinner">
                <div class="double-bounce1"></div>
                <div class="double-bounce2"></div>
            </div>
        </div>
    </div>
    <!-- Loader -->

    <%@include file="../layout/Header.jsp" %>
    <div class="container-fluid">
        <div class="layout-specing">
            <h5 class="mb-0">Cập nhật tài khoản</h5>

            <div class="form-container">
                <c:if test="${not empty message}">
                    ${message}
                </c:if>
                <form id="updateForm" action="updateaccount" method="post" onsubmit="return validateForm()">
                    <input type="hidden" name="id" value="${user.id}">
                    <div class="form-group">
                        <label for="role_id">Vai trò:</label>
                        <select id="role_id" name="role_id">
                            <option value="4" ${user.role.id == 4 ? 'selected' : ''}>Nhân viên</option>
                            <option value="3" ${user.role.id == 3 ? 'selected' : ''}>Bác sĩ</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="userName">Tên đăng nhập:</label>
                        <input type="text" id="userName" name="userName" value="${not empty param.userName ? param.userName : user.userName}" required onblur="validateUsername()">
                        <span id="userNameError" class="error">${requestScope.messagee}</span>
                    </div>
                    <div class="form-group">
                        <label for="fullName">Họ và tên:</label>
                        <input type="text" id="fullName" name="fullName" value="${not empty param.fullName ? param.fullName : user.fullName}" required onblur="validateFullName()">
                        <span id="fullNameError" class="error"></span>
                    </div>
                    <div class="form-group">
                        <label for="phoneNumber">Số điện thoại:</label>
                        <input type="text" id="phoneNumber" name="phoneNumber" value="${not empty param.phoneNumber ? param.phoneNumber : user.phoneNumber}" required onblur="validatePhoneNumber()">
                        <span id="phoneNumberError" class="error"></span>
                    </div>
                    <div class="form-group">
                        <label for="email">Email:</label>
                        <input type="email" id="email" name="email" value="${not empty param.email ? param.email : user.email}" required onblur="validateEmail()">
                        <span id="emailError" class="error"></span>
                    </div>
                    <div class="form-group">
                        <button type="submit">Cập nhật tài khoản</button>
                        <a href="javascript:history.back()" class="btn-custom">Quay lại</a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        // Hàm thoát HTML để ngăn XSS
        function escapeHtml(fieldId) {
            const input = document.getElementById(fieldId);
            const html = input.value;
            const div = document.createElement("div");
            div.innerText = html;
            return div.innerHTML;
        }

        // Hàm kiểm tra username hợp lệ
        function isValidUsername(username) {
            return /^[a-zA-Z0-9_]{3,30}$/.test(username);
        }

        // Hàm kiểm tra email hợp lệ
        function isValidEmail(email) {
            return /^[^\s@]+@[^\s@]+\.[a-zA-Z]{2,}$/.test(email);
        }

        // Hàm kiểm tra full name hợp lệ
        function isValidFullName(fullName) {
            const allowedChars = /^[\p{L}\s,.-]{2,50}$/u;
            return allowedChars.test(fullName);
        }

        // Hàm kiểm tra số điện thoại hợp lệ
        function isValidPhoneNumber(phone) {
            return /^(0|\+84)\d{9}$/.test(phone); // Bắt đầu bằng 0 hoặc +84, đủ 10 số
        }

        // Hàm hiển thị lỗi
        function showError(inputId, message) {
            const errorElement = document.getElementById(inputId + 'Error');
            const inputElement = document.getElementById(inputId);
            if (errorElement && inputElement) {
                errorElement.textContent = message;
                errorElement.classList.toggle('show', !!message);
                inputElement.classList.toggle('is-invalid', !!message);
            }
        }

        // Hàm xóa lỗi
        function clearError(inputId) {
            const errorElement = document.getElementById(inputId + 'Error');
            const inputElement = document.getElementById(inputId);
            if (errorElement && inputElement) {
                errorElement.textContent = '';
                errorElement.classList.remove('show');
                inputElement.classList.remove('is-invalid');
            }
        }

        // Hàm kiểm tra username
        function validateUsername() {
            clearError('userName');
            const username = escapeHtml('userName').trim();
            let isValid = true;
            if (!username) {
                showError('userName', 'Tên đăng nhập không được để trống.');
                isValid = false;
            } else if (!isValidUsername(username)) {
                showError('userName', 'Tên đăng nhập phải từ 3 đến 30 ký tự, chỉ chứa chữ, số hoặc dấu gạch dưới.');
                isValid = false;
            }
            console.log(`Blur event triggered for userName: ${isValid ? 'Valid' : 'Invalid'}`);
            return isValid;
        }

        // Hàm kiểm tra email
        function validateEmail() {
            clearError('email');
            const email = escapeHtml('email').trim();
            let isValid = true;
            if (!email) {
                showError('email', 'Email không được để trống.');
                isValid = false;
            } else if (!isValidEmail(email)) {
                showError('email', 'Email không hợp lệ, phải có tên miền (VD: .com, .vn).');
                isValid = false;
            }
            console.log(`Blur event triggered for email: ${isValid ? 'Valid' : 'Invalid'}`);
            return isValid;
        }

        // Hàm kiểm tra full name
        function validateFullName() {
            clearError('fullName');
            const fullName = escapeHtml('fullName').trim();
            let isValid = true;
            if (!fullName) {
                showError('fullName', 'Họ và tên không được để trống.');
                isValid = false;
            } else if (!isValidFullName(fullName)) {
                showError('fullName', 'Họ và tên phải từ 2 đến 50 ký tự, chỉ chứa chữ, khoảng trắng, dấu phẩy, dấu chấm hoặc dấu gạch ngang.');
                isValid = false;
            }
            console.log(`Blur event triggered for fullName: ${isValid ? 'Valid' : 'Invalid'}`);
            return isValid;
        }

        // Hàm kiểm tra phone number
        function validatePhoneNumber() {
            clearError('phoneNumber');
            const phone = escapeHtml('phoneNumber').trim();
            let isValid = true;
            if (!phone) {
                showError('phoneNumber', 'Số điện thoại không được để trống.');
                isValid = false;
            } else if (!isValidPhoneNumber(phone)) {
                showError('phoneNumber', 'Số điện thoại phải bắt đầu bằng 0 hoặc +84 và có đúng 10 số.');
                isValid = false;
            }
            console.log(`Blur event triggered for phoneNumber: ${isValid ? 'Valid' : 'Invalid'}`);
            return isValid;
        }

        // Hàm kiểm tra toàn bộ biểu mẫu khi submit
        function validateForm() {
            const isUsernameValid = validateUsername();
            const isEmailValid = validateEmail();
            const isFullNameValid = validateFullName();
            const isPhoneNumberValid = validatePhoneNumber();
            const isValid = isUsernameValid && isEmailValid && isFullNameValid && isPhoneNumberValid;
            if (!isValid) {
                const firstInvalid = document.querySelector('.is-invalid');
                if (firstInvalid) firstInvalid.focus();
            }
            return isValid;
        }

        // Gắn sự kiện khi trang tải
        document.addEventListener('DOMContentLoaded', function () {
            const inputs = [
                { id: 'userName', validate: validateUsername },
                { id: 'email', validate: validateEmail },
                { id: 'fullName', validate: validateFullName },
                { id: 'phoneNumber', validate: validatePhoneNumber }
            ];

            inputs.forEach(({ id, validate }) => {
                const input = document.getElementById(id);
                if (input) {
                    input.addEventListener('blur', () => {
                        validate();
                    });
                } else {
                    console.error(`Element with ID ${id} not found`);
                }
            });

            // Gắn sự kiện change cho role_id
            const roleSelect = document.getElementById('role_id');
            if (roleSelect) {
                roleSelect.addEventListener('change', toggleDoctorFields);
            }

            // Gắn sự kiện submit cho form
            const form = document.getElementById('updateForm');
            if (form) {
                form.addEventListener('submit', function (e) {
                    if (!validateForm()) {
                        e.preventDefault();
                    }
                });
            }
        });

        // Hàm toggleDoctorFields
        function toggleDoctorFields() {
            const roleId = document.getElementById('role_id').value;
            const doctorFields = document.querySelector('.doctor-fields');
            if (doctorFields) {
                doctorFields.style.display = roleId === '3' ? 'block' : 'none';
            }
        }
    </script>

    <!-- javascript -->
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/simplebar.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/apexcharts.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/columnchart.init.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
</body>
</html>