<%-- 
    Document   : UpdateClinic
    Created on : May 6, 2025
    Author     : Grok
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8" />
    <title>Pet24h - Cập nhật thông tin phòng khám</title>
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
        .form-group { margin-bottom: 1.5rem; }
        label { font-weight: normal; margin-bottom: 0.25rem; }
        input, textarea { width: 100%; padding: 0.75rem; border: 1px solid #ced4da; border-radius: 8px; }
        textarea { height: 100px; }
        .btn-custom { 
            padding: 0.6rem 1.5rem; 
            border-radius: 8px; 
            color: white; 
            display: inline-block; 
            text-decoration: none; 
            margin-right: 0.5rem; 
            font-size: 0.95rem; 
            line-height: 1.5;
            transition: background-color 0.2s;
        }
        .submit-btn { background: #4CAF50; border: none; }
        .submit-btn:hover { background: #45a049; }
        .close-btn { background: #f44336; }
        .close-btn:hover { background: #d32f2f; }
        .message { 
            padding: 1rem; 
            margin-bottom: 1.5rem; 
            border-radius: 4px; 
            font-size: 0.95rem;
        }
        .message.success { background: #dff0d8; color: #3c763d; }
        .message.error { background: #f2dede; color: #a94442; }
        .logo-img { max-width: 200px; margin-top: 0.5rem; border-radius: 8px; }
        .form-container { background: #fff; padding: 2rem; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
        .error-text { 
            color: #dc3545; 
            font-size: 0.85rem; 
            margin-top: 0.25rem; 
            display: none; 
            opacity: 0; 
            transition: opacity 0.3s ease-in-out; 
        }
        .error-text.show { display: block; opacity: 1; }
        .is-invalid { border-color: #dc3545 !important; }
    </style>
</head>
<body>
    <div id="preloader">
        <div id="status">
            <div class="spinner">
                <div class="double-bounce1"></div>
                <div class="double-bounce2"></div>
            </div>
        </div>
    </div>

    <%@include file="../layout/Header.jsp" %>

    <div class="container-fluid">
        <div class="layout-specing">
            <h5 class="mb-0">Cập nhật thông tin phòng khám</h5>

            <div class="form-container mt-4">
                <c:if test="${not empty message}">
                    <div class="message ${messageType}">${message}</div>
                </c:if>

                <form method="POST" action="admin-update-clinic-info" enctype="multipart/form-data" id="clinicForm" novalidate>
                    <input type="hidden" name="id" value="${clinic.id}">
                    
                    <div class="form-group">
                        <label for="name">Tên phòng khám</label>
                        <input type="text" id="name" name="name" value="${clinic.name}" required onblur="validateField('name')">
                        <div class="error-text" id="nameError"></div>
                    </div>
                    <div class="form-group">
                        <label for="address">Địa chỉ</label>
                        <input type="text" id="address" name="address" value="${clinic.address}" onblur="validateField('address')">
                        <div class="error-text" id="addressError"></div>
                    </div>
                    <div class="form-group">
                        <label for="phone">Số điện thoại</label>
                        <input type="text" id="phone" name="phone" value="${clinic.phone}" onblur="validateField('phone')">
                        <div class="error-text" id="phoneError"></div>
                    </div>
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" id="email" name="email" value="${clinic.email}" onblur="validateField('email')">
                        <div class="error-text" id="emailError"></div>
                    </div>
                    <div class="form-group">
                        <label for="website">Website</label>
                        <input type="text" id="website" name="website" value="${clinic.website}" onblur="validateField('website')">
                        <div class="error-text" id="websiteError"></div>
                    </div>
                    <div class="form-group">
                        <label for="workingHours">Giờ làm việc</label>
                        <input type="text" id="workingHours" name="workingHours" value="${clinic.workingHours}" onblur="validateField('workingHours')">
                        <div class="error-text" id="workingHoursError"></div>
                    </div>
                    <div class="form-group">
                        <label for="description">Mô tả</label>
                        <textarea id="description" name="description" onblur="validateField('description')">${clinic.description}</textarea>
                        <div class="error-text" id="descriptionError"></div>
                    </div>
                    <div class="form-group">
                        <label for="logo">Logo</label>
                        <input type="file" id="logo" name="logo" accept=".png,.jpg,.jpeg" onchange="validateField('logo')">
                        <div class="error-text" id="logoError"></div>
                        <c:if test="${not empty clinic.logo}">
                            <img src="${clinic.logo}" alt="Logo phòng khám" class="logo-img">
                        </c:if>
                    </div>
                    <div class="form-group">
                        <label for="googleMap">URL Google Maps</label>
                        <input type="text" id="googleMap" name="googleMap" value="${clinic.googleMap}" onblur="validateField('googleMap')" required>
                        <div class="error-text" id="googleMapError"></div>
                    </div>
                    <div class="form-group">
                        <button type="submit" class="btn-custom submit-btn">Lưu</button>
                        <a href="admin-list-clinic-info" class="btn-custom close-btn">Quay lại</a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/simplebar.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/apexcharts.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/columnchart.init.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
    <script>
        document.getElementById('clinicForm').addEventListener('submit', function(e) {
            e.preventDefault();
            let isValid = validateForm();
            if (isValid) {
                this.submit();
            } else {
                const firstInvalid = document.querySelector('.is-invalid');
                if (firstInvalid) firstInvalid.focus();
            }
        });

        function escapeHtml(fieldId) {
            const input = document.getElementById(fieldId);
            const html = input.value;
            const div = document.createElement("div");
            div.innerText = html;
            return div.innerHTML;
        }

        function validateField(fieldId) {
            clearError(fieldId);
            const allowedChars = /^[\p{L}0-9\s,-.:]+$/u;
            const googleMapRegex = /^https?:\/\/(www\.)?google\.com\/maps\/.*/;

            let value = escapeHtml(fieldId).trim();
            let isValid = true;

            switch (fieldId) {
                case 'name':
                    if (!value) {
                        showError('name', 'Tên phòng khám là bắt buộc.');
                        isValid = false;
                    } else if (value.length < 2 || value.length > 255) {
                        showError('name', 'Tên phòng khám phải từ 2 đến 255 ký tự.');
                        isValid = false;
                    } else if (!allowedChars.test(value)) {
                        showError('name', 'Tên phòng khám chỉ được chứa chữ, số, khoảng trắng, dấu phẩy, gạch ngang, dấu chấm hoặc dấu hai chấm.');
                        isValid = false;
                    }
                    break;
                case 'address':
                    if (!value) {
                        showError('address', 'Địa chỉ là bắt buộc.');
                        isValid = false;
                    } else if (value.length < 5 || value.length > 255) {
                        showError('address', 'Địa chỉ phải từ 5 đến 255 ký tự.');
                        isValid = false;
                    } else if (!allowedChars.test(value)) {
                        showError('address', 'Địa chỉ chỉ được chứa chữ, số, khoảng trắng, dấu phẩy, gạch ngang, dấu chấm hoặc dấu hai chấm.');
                        isValid = false;
                    }
                    break;
                case 'phone':
                    if (!value) {
                        showError('phone', 'Số điện thoại là bắt buộc.');
                        isValid = false;
                    } else if (!/^(0|\+84)[0-9]{9,10}$/.test(value)) {
                        showError('phone', 'Số điện thoại phải có 10-12 chữ số, bắt đầu bằng 0 hoặc +84.');
                        isValid = false;
                    }
                    break;
                case 'email':
                    if (!value) {
                        showError('email', 'Email là bắt buộc.');
                        isValid = false;
                    } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value)) {
                        showError('email', 'Định dạng email không hợp lệ.');
                        isValid = false;
                    } else if (!/\.[a-zA-Z]{2,}$/.test(value)) {
                        showError('email', 'Email phải có tên miền hợp lệ (VD: .com, .vn).');
                        isValid = false;
                    }
                    break;
                case 'website':
                    if (value && !/^(?:https?:\/\/)?(?:[\da-z.-]+)\.[a-z.]{2,6}(?:[\/\w .-]*)*\/?$/.test(value)) {
                        showError('website', 'Định dạng URL website không hợp lệ.');
                        isValid = false;
                    }
                    break;
                case 'workingHours':
                    if (!value) {
                        showError('workingHours', 'Giờ làm việc là bắt buộc.');
                        isValid = false;
                    } else if (value.length < 5 || value.length > 100) {
                        showError('workingHours', 'Giờ làm việc phải từ 5 đến 100 ký tự.');
                        isValid = false;
                    } else if (!allowedChars.test(value)) {
                        showError('workingHours', 'Giờ làm việc chỉ được chứa chữ, số, khoảng trắng, dấu phẩy, gạch ngang, dấu chấm hoặc dấu hai chấm.');
                        isValid = false;
                    }
                    break;
                case 'description':
                    if (value.length > 1000) {
                        showError('description', 'Mô tả không được vượt quá 1000 ký tự.');
                        isValid = false;
                    } else if (value && !allowedChars.test(value)) {
                        showError('description', 'Mô tả chỉ được chứa chữ, số, khoảng trắng, dấu phẩy, gạch ngang, dấu chấm hoặc dấu hai chấm.');
                        isValid = false;
                    }
                    break;
                case 'logo':
                    const logo = document.getElementById('logo').files[0];
                    if (logo) {
                        const validTypes = ['image/png', 'image/jpeg', 'image/jpg'];
                        if (!validTypes.includes(logo.type)) {
                            showError('logo', 'Chỉ chấp nhận file PNG, JPG hoặc JPEG.');
                            isValid = false;
                        } else if (logo.size > 5 * 1024 * 1024) {
                            showError('logo', 'Kích thước file phải nhỏ hơn 5MB.');
                            isValid = false;
                        }
                    }
                    break;
                case 'googleMap':
                    if (!value) {
                        showError('googleMap', 'URL Google Maps là bắt buộc.');
                        isValid = false;
                    } else if (!googleMapRegex.test(value)) {
                        showError('googleMap', 'URL Google Maps không hợp lệ. Phải bắt đầu bằng https://www.google.com/maps/.');
                        isValid = false;
                    }
                    break;
            }
            return isValid;
        }

        function validateForm() {
            let isValid = true;
            const fields = ['name', 'address', 'phone', 'email', 'website', 'workingHours', 'description', 'logo', 'googleMap'];
            fields.forEach(fieldId => {
                if (!validateField(fieldId)) {
                    isValid = false;
                }
            });
            return isValid;
        }

        function showError(fieldId, message) {
            const field = document.getElementById(fieldId);
            const errorElement = document.getElementById(fieldId + 'Error');
            errorElement.textContent = message;
            errorElement.classList.add('show');
            field.classList.add('is-invalid');
        }

        function clearError(fieldId) {
            const errorElement = document.getElementById(fieldId + 'Error');
            const field = document.getElementById(fieldId);
            errorElement.textContent = '';
            errorElement.classList.remove('show');
            field.classList.remove('is-invalid');
        }

        function clearErrors() {
            const errorElements = document.querySelectorAll('.error-text');
            const invalidFields = document.querySelectorAll('.is-invalid');
            errorElements.forEach(el => {
                el.textContent = '';
                el.classList.remove('show');
            });
            invalidFields.forEach(field => field.classList.remove('is-invalid'));
        }
    </script>
</body>
</html>