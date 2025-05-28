<%-- 
    Document   : Admin
    Created on : May 21, 2025, 8:24:23 PM
    Author     : Dell
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Doctris - Doctor Appointment Booking System</title>
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
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- SLIDER -->
        <link href="${pageContext.request.contextPath}/assets/css/tiny-slider.css" rel="stylesheet" />
        <!-- Css -->
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />

        <title>Create Staff/Doctor Account</title>
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
                display: none;
            }
            .error {
                color: red;
                font-size: 0.9em;
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
        <!--sadasdasdasdas-->
        <div class="container-fluid">
            <div class="layout-specing">
                <h5 class="mb-0">Tạo tài khoản</h5>



                <div class="form-container">
                    <h2>Create Staff/Doctor Account</h2>

                    <c:if test="${not empty message}">
                        ${message}
                    </c:if>

                    <form id="createForm" action="createaccount" method="post" onsubmit="return validateForm()">
                        <div class="form-group">
                            <label for="role_id">Role:</label>
                            <select id="role_id" name="role_id" >
                                <option value="4">Staff</option>
                                <option value="3">Doctor</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="userName">Username:</label>
                            <input type="text" id="userName" name="userName" required value="${param.userName}">
                            <div id="userNameError" class="invalid-feedback">${requestScope.messagee}</div>
                        </div>
                        <div class="form-group">
                            <label for="email">Email:</label>
                            <input type="email" id="email" name="email" required value="${param.email}">
                            <div id="emailError" class="invalid-feedback"></div>
                        </div>
                        <div class="form-group">
                            <label for="password">Password:</label>
                            <input type="password" id="password" name="password" required value="${param.password}">
                            <div id="passwordError" class="invalid-feedback"></div>
                        </div>
                        <div class="form-group">
                            <label for="fullName">Full Name:</label>
                            <input type="text" id="fullName" name="fullName" required value="${param.fullName}">
                            <div id="fullNameError" class="invalid-feedback"></div>
                        </div>
<!--                        <div class="form-group">
                            <label for="status">Status:</label>
                            <select id="status" name="status">
                                <option value="1">Active</option>
                                <option value="0">Inactive</option>
                            </select>
                        </div>-->
                        <button type="submit">Create Account</button>
                    </form>

                    <script>
                        // Hàm kiểm tra email hợp lệ
                        function isValidEmail(email) {
                            return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
                        }

                        // Hàm kiểm tra username hợp lệ
                        function isValidUsername(username) {
                            return /^[a-zA-Z0-9_]{3,}$/.test(username);
                        }

                        // Hàm hiển thị lỗi
                        function showError(inputId, message) {
                            const errorElement = document.getElementById(inputId + 'Error');
                            errorElement.textContent = message;
                            errorElement.style.display = message ? 'block' : 'none';
                        }

                        // Hàm kiểm tra username
                        function validateUsername() {
                            const usernameInput = document.getElementById('userName');
                            const username = usernameInput.value.trim();
                            if (!username) {
                                showError('userName', 'Tên đăng nhập không được để trống!');
                                return false;
                            } else if (!isValidUsername(username)) {
                                showError('userName', 'Tên đăng nhập phải có ít nhất 3 ký tự ');
                                return false;
                            }
                            showError('userName', '');
                            return true;
                        }

                        // Hàm kiểm tra email
                        function validateEmail() {
                            const emailInput = document.getElementById('email');
                            const email = emailInput.value.trim();
                            if (!email) {
                                showError('email', 'Email không được để trống!');
                                return false;
                            } else if (!isValidEmail(email)) {
                                showError('email', 'Email không hợp lệ!');
                                return false;
                            }
                            showError('email', '');
                            return true;
                        }

                        // Hàm kiểm tra password
                        function validatePassword() {
                            const passwordInput = document.getElementById('password');
                            const password = passwordInput.value.trim();
                            if (!password) {
                                showError('password', 'Mật khẩu không được để trống!');
                                return false;
                            } else if (password.length < 6) {
                                showError('password', 'Mật khẩu phải có ít nhất 6 ký tự!');
                                return false;
                            }
                            showError('password', '');
                            return true;
                        }

                        // Hàm kiểm tra full name
                        function validateFullName() {
                            const fullNameInput = document.getElementById('fullName');
                            const fullName = fullNameInput.value.trim();
                            if (!fullName) {
                                showError('fullName', 'Họ và tên không được để trống!');
                                return false;
                            }
                            showError('fullName', '');
                            return true;
                        }

                        // Hàm kiểm tra toàn bộ biểu mẫu khi submit
                        function validateForm() {
                            const isUsernameValid = validateUsername();
                            const isEmailValid = validateEmail();
                            const isPasswordValid = validatePassword();
                            const isFullNameValid = validateFullName();
                            return isUsernameValid && isEmailValid && isPasswordValid && isFullNameValid;
                        }



                        // Gắn sự kiện blur khi trang tải
                        document.addEventListener('DOMContentLoaded', function () {
                            const inputs = [
                                {id: 'userName', validate: validateUsername},
                                {id: 'email', validate: validateEmail},
                                {id: 'password', validate: validatePassword},
                                {id: 'fullName', validate: validateFullName}
                            ];

                            inputs.forEach(({ id, validate }) => {
                                const input = document.getElementById(id);
                                input.addEventListener('blur', validate);
                            });

                            // Gắn sự kiện change cho role_id
                            document.getElementById('role_id').addEventListener('change', toggleDoctorFields);
                        });
                    </script>






                    <!-- javascript -->
                    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
                    <!-- simplebar -->
                    <script src="${pageContext.request.contextPath}/assets/js/simplebar.min.js"></script>
                    <!-- Chart -->
                    <script src="${pageContext.request.contextPath}/assets/js/apexcharts.min.js"></script>
                    <script src="${pageContext.request.contextPath}/assets/js/columnchart.init.js"></script>
                    <!-- Icons -->
                    <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
                    <!-- Main Js -->
                    <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>

                    </body>

                    </html>