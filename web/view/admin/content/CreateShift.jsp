<%-- 
    Document   : CreateShift
    Created on : Jun 19, 2025
    Author     : Grok
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Tạo ca mới</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" />
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
            <h5>Tạo ca mới</h5>
            
            <div class="form-container">
                <c:if test="${not empty error}">
                    <div class="error">${error}</div>
                </c:if>
                
                <form id="createShiftForm" action="${pageContext.request.contextPath}/createshift" method="POST">
                    <div class="form-group">
                        <label for="name">Tên ca:</label>
                        <input type="text" id="name" name="name" value="${name}" maxlength="50">
                        <div id="nameError" class="error-message"></div>
                    </div>
                    <div class="form-group">
                        <label for="start_time">Thời gian bắt đầu:</label>
                        <input type="time" id="start_time" name="start_time" value="${start_time}">
                        <div id="startTimeError" class="error-message"></div>
                    </div>
                    <div class="form-group">
                        <label for="end_time">Thời gian kết thúc:</label>
                        <input type="time" id="end_time" name="end_time" value="${end_time}">
                        <div id="endTimeError" class="error-message"></div>
                    </div>
                    <button type="submit">Tạo mới</button>
                    <a href="javascript:history.back()" class="btn-custom">Quay lại</a>
                </form>
            </div>
        </div>
    </div>

    <jsp:include page="../layout/Footer.jsp" />

    <script>
        const form = document.getElementById('createShiftForm');
        const inputs = {
            name: document.getElementById('name'),
            start_time: document.getElementById('start_time'),
            end_time: document.getElementById('end_time')
        };
        const errors = {
            name: document.getElementById('nameError'),
            start_time: document.getElementById('startTimeError'),
            end_time: document.getElementById('endTimeError')
        };

        function validateName() {
            const value = inputs.name.value.trim();
            if (!value) {
                errors.name.textContent = 'Tên ca không được để trống.';
                inputs.name.classList.add('invalid');
                return false;
            }
            if (value.length > 50) {
                errors.name.textContent = 'Tên ca tối đa 50 ký tự.';
                inputs.name.classList.add('invalid');
                return false;
            }
            errors.name.textContent = '';
            inputs.name.classList.remove('invalid');
            return true;
        }

        function validateTime(field, value) {
            const timeRegex = /^([0-1][0-9]|2[0-3]):[0-5][0-9]$/;
            if (!value || !timeRegex.test(value)) {
                errors[field].textContent = `Thời gian ${field == 'start_time' ? 'bắt đầu' : 'kết thúc'} không hợp lệ (HH:mm).`;
                inputs[field].classList.add('invalid');
                return false;
            }
            errors[field].textContent = '';
            inputs[field].classList.remove('invalid');
            return true;
        }

        function validateTimeOrder() {
            const startTime = inputs.start_time.value;
            const endTime = inputs.end_time.value;
            if (startTime && endTime && validateTime('start_time', startTime) && validateTime('end_time', endTime)) {
                const start = new Date(`1970-01-01T${startTime}:00`);
                const end = new Date(`1970-01-01T${endTime}:00`);
                if (end <= start) {
                    errors.end_time.textContent = 'Thời gian kết thúc phải sau thời gian bắt đầu.';
                    inputs.end_time.classList.add('invalid');
                    return false;
                }
            }
            errors.end_time.textContent = '';
            inputs.end_time.classList.remove('invalid');
            return true;
        }

        // Real-time validation
        inputs.name.addEventListener('input', () => {
            console.log('Validating name');
            validateName();
        });
        inputs.start_time.addEventListener('input', () => {
            console.log('Validating start_time');
            validateTime('start_time', inputs.start_time.value);
            validateTimeOrder();
        });
        inputs.end_time.addEventListener('input', () => {
            console.log('Validating end_time');
            validateTime('end_time', inputs.end_time.value);
            validateTimeOrder();
        });

        // Form submit
        form.addEventListener('submit', (e) => {
            e.preventDefault();
            console.log('Form submit attempted');
            const isNameValid = validateName();
            const isStartTimeValid = validateTime('start_time', inputs.start_time.value);
            const isEndTimeValid = validateTime('end_time', inputs.end_time.value);
            const isTimeOrderValid = validateTimeOrder();
            if (isNameValid && isStartTimeValid && isEndTimeValid && isTimeOrderValid) {
                console.log('Form valid, submitting to ' + form.action);
                form.submit();
            } else {
                console.log('Form invalid, submission blocked');
            }
        });
    </script>
</body>
</html>