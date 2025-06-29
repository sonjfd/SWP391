<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8" />
    <title>Doctris - Tạo tài khoản</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico.png">
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" />

    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background: url('${pageContext.request.contextPath}/assets/images/background.jpg') no-repeat center center fixed;
            background-size: cover;
        }

        .main-wrapper {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        .form-container {
            width: 100%;
            max-width: 600px;
            background: rgba(255, 255, 255, 0.96);
            padding: 30px;
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
        }

        input, select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 15px;
        }

        input:focus, select:focus {
            border-color: #4CAF50;
            outline: none;
        }

        .error-message {
            display: none;
            color: #d32f2f;
            font-size: 0.9em;
            margin-top: 5px;
        }

        .error-message.show {
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
            background-color: #4CAF50 !important;
        }

        .btn-submit:hover {
            background-color: #43a047;
        }

        .btn-back {
            background-color: #f44336 !important;
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

        h3 {
            text-align: center;
            margin-bottom: 25px;
        }
    </style>
</head>
<body>
<%@include file="../layout/Header.jsp" %>

<div class="main-wrapper">
    <div class="form-container">
        <h3>Tạo tài khoản</h3>

        <c:if test="${not empty message}">
            <div class="error-message show text-center"><c:out value="${message}" /></div>
        </c:if>

        <form action="admin-create-account" method="post" id="createForm" onsubmit="return validateForm()">
            <div class="form-group">
                <label for="role_id">Vai trò:</label>
                <select name="role_id" id="role_id" onchange="toggleNurseFields()" required>
                    <option value="">-- Chọn vai trò --</option>
                    <option value="3" ${param.role_id == '3' ? 'selected' : ''}>Bác sĩ</option>
                    <option value="5" ${param.role_id == '5' ? 'selected' : ''}>Y tá</option>
                    <option value="4" ${param.role_id == '4' ? 'selected' : ''}>Nhân viên</option>
                </select>
                <span class="error-message" id="roleError"></span>
            </div>

            <div class="form-group">
                <label for="userName">Tên đăng nhập:</label>
                <input type="text" id="userName" name="userName" value="${param.userName}" required>
                <span class="error-message ${not empty usernameError ? 'show' : ''}" id="userNameError">
                    <c:if test="${not empty usernameError}"><c:out value="${usernameError}"/></c:if>
                </span>
            </div>

            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="${param.email}" required>
                <span class="error-message ${not empty emailError ? 'show' : ''}" id="emailError">
                    <c:if test="${not empty emailError}"><c:out value="${emailError}"/></c:if>
                </span>
            </div>

            <div class="form-group">
                <label for="password">Mật khẩu:</label>
                <input type="password" id="password" name="password" required>
                <span class="error-message" id="passwordError"></span>
            </div>

            <div class="form-group">
                <label for="fullName">Họ và tên:</label>
                <input type="text" id="fullName" name="fullName" value="${param.fullName}" required>
                <span class="error-message" id="fullNameError"></span>
            </div>

            <div class="form-group">
                <label for="phoneNumber">Số điện thoại:</label>
                <input type="text" id="phoneNumber" name="phoneNumber" value="${param.phoneNumber}" required>
                <span class="error-message" id="phoneNumberError"></span>
            </div>

            <div id="nurseFields" class="form-group" style="display: ${param.role_id == '5' ? 'block' : 'none'};">
                <label for="department_id">Phòng ban:</label>
                <select name="department_id" id="department_id" ${param.role_id == '5' ? 'required' : ''}>
                    <option value="">-- Chọn phòng ban --</option>
                    <c:forEach var="dept" items="${departments}">
                        <option value="${dept.id}" ${param.department_id == dept.id ? 'selected' : ''}>
                            <c:out value="${dept.name}" />
                        </option>
                    </c:forEach>
                </select>
                <span class="error-message" id="departmentError"></span>
            </div>

            <div class="button-group">
                <button type="submit" class="btn-custom btn-submit">Tạo tài khoản</button>
                <a href="admin-list-account" class="btn-custom btn-back">Quay lại</a>
            </div>
        </form>
    </div>
</div>

<script>
    function validateField(field, regex, errorId, errorMessage) {
        const value = field.value.trim();
        const errorElement = document.getElementById(errorId);
        const hasServerError = <c:out value="${not empty usernameError && errorId == 'userNameError' || not empty emailError && errorId == 'emailError' ? 'true' : 'false'}"/>;

        if (!value || (regex && !regex.test(value))) {
            if (!hasServerError) { // Only set client-side error if no server-side error
                errorElement.textContent = errorMessage;
                errorElement.classList.add('show');
            }
            return false;
        } else if (!hasServerError) { // Clear client-side errors if valid and no server-side error
            errorElement.textContent = '';
            errorElement.classList.remove('show');
            return true;
        }
        return !hasServerError; // Return false if server-side error exists
    }

    function validateForm() {
        let isValid = true;

        isValid &= validateField(
            document.getElementById('role_id'),
            null,
            'roleError',
            'Vui lòng chọn vai trò.'
        );
        isValid &= validateField(
            document.getElementById('userName'),
            /^[a-zA-Z0-9_]{3,}$/,
            'userNameError',
            'Tên đăng nhập phải từ 3 ký tự, chỉ chứa chữ, số, gạch dưới.'
        );
        isValid &= validateField(
            document.getElementById('email'),
            /^[^\s@]+@[^\s@]+\.[a-zA-Z]{2,}$/,
            'emailError',
            'Email không hợp lệ.'
        );
        isValid &= validateField(
            document.getElementById('password'),
            /.{6,}/,
            'passwordError',
            'Mật khẩu phải từ 6 ký tự.'
        );
        isValid &= validateField(
            document.getElementById('fullName'),
            /^[\p{L}\s]{3,}$/u,
            'fullNameError',
            'Họ và tên phải từ 3 ký tự, chỉ chứa chữ tiếng Việt và khoảng trắng.'
        );
        isValid &= validateField(
            document.getElementById('phoneNumber'),
            /^(0|\+84)\d{9}$/,
            'phoneNumberError',
            'Số điện thoại phải bắt đầu bằng 0 hoặc +84, đủ 10 số.'
        );

        const roleId = document.getElementById('role_id').value;
        const departmentId = document.getElementById('department_id');
        const departmentError = document.getElementById('departmentError');
        if (roleId === '5' && (!departmentId || !departmentId.value)) {
            departmentError.textContent = 'Vui lòng chọn phòng ban cho Y tá.';
            departmentError.classList.add('show');
            isValid = false;
        } else {
            departmentError.textContent = '';
            departmentError.classList.remove('show');
        }

        return isValid;
    }

    document.getElementById('fullName').addEventListener('input', function(e) {
        const value = e.target.value;
        const validValue = value.replace(/[^a-zA-ZÀ-ỹ\s]/g, '');
        if (value !== validValue) {
            e.target.value = validValue;
        }
    });

    document.querySelectorAll('input, select').forEach(field => {
        field.addEventListener('blur', () => {
            if (field.id === 'role_id') {
                validateField(field, null, 'roleError', 'Vui lòng chọn vai trò.');
            } else if (field.id === 'userName') {
                validateField(field, /^[a-zA-Z0-9_]{3,}$/, 'userNameError', 'Tên đăng nhập phải từ 3 ký tự, chỉ chứa chữ, số, gạch dưới.');
            } else if (field.id === 'email') {
                validateField(field, /^[^\s@]+@[^\s@]+\.[a-zA-Z]{2,}$/, 'emailError', 'Email không hợp lệ.');
            } else if (field.id === 'password') {
                validateField(field, /.{6,}/, 'passwordError', 'Mật khẩu phải từ 6 ký tự.');
            } else if (field.id === 'fullName') {
                validateField(field, /^[\p{L}\s]{3,}$/u, 'fullNameError', 'Họ và tên phải từ 3 ký tự, chỉ chứa chữ tiếng Việt và khoảng trắng.');
            } else if (field.id === 'phoneNumber') {
                validateField(field, /^(0|\+84)\d{9}$/, 'phoneNumberError', 'Số điện thoại phải bắt đầu bằng 0 hoặc +84, đủ 10 số.');
            } else if (field.id === 'department_id' && document.getElementById('role_id').value === '5') {
                validateField(field, null, 'departmentError', 'Vui lòng chọn phòng ban cho Y tá.');
            }
        });
    });

    function toggleNurseFields() {
        const isNurse = document.getElementById('role_id').value === '5';
        const nurseFields = document.getElementById('nurseFields');
        const departmentId = document.getElementById('department_id');
        nurseFields.style.display = isNurse ? 'block' : 'none';
        departmentId.required = isNurse;
        validateField(departmentId, null, 'departmentError', 'Vui lòng chọn phòng ban cho Y tá.');
    }

    document.addEventListener('DOMContentLoaded', function () {
        toggleNurseFields();
        document.getElementById('role_id').addEventListener('change', toggleNurseFields);
    });
</script>

</body>
</html>