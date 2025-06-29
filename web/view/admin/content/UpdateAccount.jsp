<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8" />
    <title>Doctris - Cập nhật tài khoản</title>
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

        .role-display {
            padding: 10px;
            background: #f8f9fa;
            border: 1px solid #ccc;
            border-radius: 6px;
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

        .btn-update {
            background-color: #4CAF50 !important;
        }

        .btn-update:hover {
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
        <h3>Cập nhật tài khoản</h3>

        <c:if test="${not empty message}">
            <div class="error-message show text-center">${message}</div>
        </c:if>

        <form action="admin-update-account" method="post" id="updateForm" onsubmit="return validateForm()">
            <input type="hidden" name="id" value="${user.id}">
            <input type="hidden" name="role_id" id="role_id" value="${user.role.id}">

            <div class="form-group">
                <label>Vai trò:</label>
                <div class="role-display">
                    <c:choose>
                        <c:when test="${user.role.id == 3}">Bác sĩ</c:when>
                        <c:when test="${user.role.id == 4}">Nhân viên</c:when>
                        <c:when test="${user.role.id == 5}">Y tá</c:when>
                        <c:otherwise>Không xác định</c:otherwise>
                    </c:choose>
                </div>
            </div>

            <div class="form-group">
                <label>Tên đăng nhập:</label>
                <input type="text" name="userName" id="userName" value="${user.userName}" required>
                <span class="error-message" id="userNameError">
                    <c:out value="${usernameError != null ? usernameError : 'Tên đăng nhập phải từ 3 ký tự, chỉ chứa chữ, số, gạch dưới.'}"/>
                </span>
            </div>

            <div class="form-group">
                <label>Email:</label>
                <input type="email" name="email" id="email" value="${user.email}" required>
                <span class="error-message" id="emailError">
                    <c:out value="${emailError != null ? emailError : 'Email không hợp lệ.'}"/>
                </span>
            </div>

            <div class="form-group">
                <label>Họ và tên:</label>
                <input type="text" name="fullName" id="fullName" value="${user.fullName}" required>
                <span class="error-message" id="fullNameError">Họ và tên phải từ 3 ký tự, chỉ chứa chữ tiếng Việt và khoảng trắng.</span>
            </div>

            <div class="form-group">
                <label>Số điện thoại:</label>
                <input type="text" name="phoneNumber" id="phoneNumber" value="${user.phoneNumber}" required>
                <span class="error-message" id="phoneNumberError">Số điện thoại phải bắt đầu bằng 0 hoặc +84, đủ 10 số.</span>
            </div>

            <div id="nurseFields" class="form-group" style="display: ${user.role.id == 5 ? 'block' : 'none'};">
                <label>Phòng ban:</label>
                <select name="department_id" id="department_id" ${user.role.id == 5 ? 'required' : ''}>
                    <option value="">Chọn phòng ban</option>
                    <c:forEach var="dept" items="${departments}">
                        <option value="${dept.id}" ${dept.id == dao.getDepartmentIdByUserId(user.id) ? 'selected' : ''}>
                            ${dept.name}
                        </option>
                    </c:forEach>
                </select>
                <span class="error-message" id="departmentIdError">Vui lòng chọn phòng ban cho Y tá.</span>
            </div>

            <div class="button-group">
                <button type="submit" class="btn-custom btn-update">Cập nhật</button>
                <a href="admin-list-account" class="btn-custom btn-back">Quay lại</a>
            </div>
        </form>
    </div>
</div>

<script>
    function validateField(field, regex, errorId, errorMessage) {
        const value = field.value.trim();
        const errorElement = document.getElementById(errorId);
        const hasServerError = errorElement.classList.contains('show');
        if (!hasServerError && (!value || (regex && !regex.test(value)))) {
            errorElement.classList.add('show');
            errorElement.textContent = errorMessage;
            return false;
        } else if (!hasServerError) {
            errorElement.classList.remove('show');
            return true;
        }
        return false;
    }

    function validateForm() {
        let isValid = true;

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
        const departmentIdError = document.getElementById('departmentIdError');
        if (roleId === '5' && (!departmentId || !departmentId.value)) {
            departmentIdError.classList.add('show');
            departmentIdError.textContent = 'Vui lòng chọn phòng ban cho Y tá.';
            isValid = false;
        } else {
            departmentIdError.classList.remove('show');
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
            if (field.id === 'userName') {
                validateField(field, /^[a-zA-Z0-9_]{3,}$/, 'userNameError', 'Tên đăng nhập phải từ 3 ký tự, chỉ chứa chữ, số, gạch dưới.');
            } else if (field.id === 'email') {
                validateField(field, /^[^\s@]+@[^\s@]+\.[a-zA-Z]{2,}$/, 'emailError', 'Email không hợp lệ.');
            } else if (field.id === 'fullName') {
                validateField(field, /^[\p{L}\s]{3,}$/u, 'fullNameError', 'Họ và tên phải từ 3 ký tự, chỉ chứa chữ tiếng Việt và khoảng trắng.');
            } else if (field.id === 'phoneNumber') {
                validateField(field, /^(0|\+84)\d{9}$/, 'phoneNumberError', 'Số điện thoại phải bắt đầu bằng 0 hoặc +84, đủ 10 số.');
            } else if (field.id === 'department_id' && document.getElementById('role_id').value === '5') {
                validateField(field, null, 'departmentIdError', 'Vui lòng chọn phòng ban cho Y tá.');
            }
        });
    });

    <c:if test="${not empty usernameError}">
        document.getElementById('userNameError').classList.add('show');
    </c:if>
    <c:if test="${not empty emailError}">
        document.getElementById('emailError').classList.add('show');
    </c:if>
</script>

</body>
</html>
