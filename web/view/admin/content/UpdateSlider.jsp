<%-- 
    Document   : UpdateSlide
    Created on : Jun 4, 2025
    Author     : YourName
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Cập Nhật Slide - Doctris</title>
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
        .form-group { margin-bottom: 20px; }
        label { font-weight: 600; color: #333; margin-bottom: 5px; display: block; }
        input[type="text"], textarea, select, input[type="file"] { 
            width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; font-size: 14px; }
        textarea { resize: vertical; min-height: 100px; }
        button { 
            padding: 10px 20px; background-color: #33CCFF; color: white; border: none; 
            border-radius: 4px; cursor: pointer; font-weight: 600; }
        button:hover { background-color: #29b3e6; }
        .error-text { color: #dc3545; font-size: 12px; margin-top: 5px; display: none; }
        .error-text.show { display: block; }
        .is-invalid { border-color: #dc3545 !important; }
        #errorModal .modal-content { border-radius: 8px; }
        #errorModal .modal-header { background-color: #dc3545; color: white; }
        .current-image { max-width: 200px; margin-top: 10px; border-radius: 4px; }
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
    <%@include file="../layout/Header.jsp" %>
    
    <div class="container-fluid">
        <div class="layout-specing">
            <h5 class="mb-0">Cập Nhật Slide</h5>
            <div class="row">
                <div class="col-lg-6">
                    <form id="updateSlideForm" method="post" action="updateslider" enctype="multipart/form-data">
                        <input type="hidden" name="id" value="${slide.id}">
                        <div class="form-group">
                            <label>Tiêu đề <span style="color: red;">*</span></label>
                            <input type="text" id="title" name="title" value="${slide.title}" placeholder="Nhập tiêu đề slide">
                            <div id="titleError" class="error-text"></div>
                        </div>
                        <div class="form-group">
                            <label>Mô tả</label>
                            <textarea id="description" name="description" placeholder="Nhập mô tả (tùy chọn)">${slide.description}</textarea>
                            <div id="descriptionError" class="error-text"></div>
                        </div>
                        <div class="form-group">
                            <label>Hình ảnh (JPG/PNG)</label>
                            <input type="file" id="image" name="image" accept=".jpg,.png">
                            <div id="imageError" class="error-text"></div>
                            <c:if test="${not empty slide.imageUrl}">
                                <img src="${pageContext.request.contextPath}${slide.imageUrl}" alt="Current Slide Image" class="current-image">
                            </c:if>
                        </div>
                        <div class="form-group">
                            <label>Liên kết</label>
                            <input type="text" id="link" name="link" value="${slide.link}" placeholder="/homepage">
                            <div id="linkError" class="error-text"></div>
                        </div>
                        <div class="form-group">
                            <label>Trạng thái <span style="color: red;">*</span></label>
                            <select id="isActive" name="isActive">
                                <option value="1" ${slide.isActive == 1 ? 'selected' : ''}>Hoạt động</option>
                                <option value="0" ${slide.isActive == 0 ? 'selected' : ''}>Không hoạt động</option>
                            </select>
                            <div id="isActiveError" class="error-text"></div>
                        </div>
                        <button type="submit" class="btn btn-primary">Lưu Thay Đổi</button>
                        <a href="javascript:history.back()" class="btn-custom">Quay lại</a>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap Modal for Server Errors -->
    <div class="modal fade" id="errorModal" tabindex="-1" aria-labelledby="errorModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="errorModalLabel">Lỗi</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <c:if test="${not empty param.error}">${param.error}</c:if>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                </div>
            </div>
        </div>
    </div>

    <%@include file="../layout/Footer.jsp" %>

    <!-- Javascript -->
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/simplebar.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/apexcharts.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/columnchart.init.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
    <script>
        // Escape HTML to prevent injection
        function escapeHtml(fieldId) {
            const input = document.getElementById(fieldId);
            const html = input.value;
            const div = document.createElement("div");
            div.innerText = html;
            return div.innerHTML;
        }

        // Show error message
        function showError(fieldId, message) {
            const field = document.getElementById(fieldId);
            const errorElement = document.getElementById(fieldId + 'Error');
            errorElement.textContent = message;
            errorElement.classList.add('show');
            field.classList.add('is-invalid');
        }

        // Clear error message
        function clearError(fieldId) {
            const errorElement = document.getElementById(fieldId + 'Error');
            const field = document.getElementById(fieldId);
            errorElement.textContent = '';
            errorElement.classList.remove('show');
            field.classList.remove('is-invalid');
        }

        // Validate individual field
        function validateField(fieldId) {
            clearError(fieldId);
            const allowedChars = /^[\p{L}0-9\s,-.:]+$/u;
            const linkRegex = /^\/[a-zA-Z0-9-]+$/;

            let value = fieldId !== 'image' && fieldId !== 'isActive' ? escapeHtml(fieldId).trim() : document.getElementById(fieldId).value;
            let isValid = true;

            switch (fieldId) {
                case 'title':
                    if (!value) {
                        showError('title', 'Tiêu đề là bắt buộc.');
                        isValid = false;
                    } else if (value.length < 2 || value.length > 255) {
                        showError('title', 'Tiêu đề phải từ 2 đến 255 ký tự.');
                        isValid = false;
                    } else if (!allowedChars.test(value)) {
                        showError('title', 'Tiêu đề chỉ được chứa chữ, số, khoảng trắng, dấu phẩy, gạch ngang, dấu chấm hoặc dấu hai chấm.');
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
                case 'image':
                    const image = document.getElementById('image').files[0];
                    if (image) {
                        const validTypes = ['image/png', 'image/jpeg', 'image/jpg'];
                        if (!validTypes.includes(image.type)) {
                            showError('image', 'Chỉ chấp nhận file PNG, JPG hoặc JPEG.');
                            isValid = false;
                        } else if (image.size > 5 * 1024 * 1024) {
                            showError('image', 'Kích thước file phải nhỏ hơn 5MB.');
                            isValid = false;
                        }
                    }
                    break;
                case 'link':
                    if (value && !linkRegex.test(value)) {
                        showError('link', 'URL phải bắt đầu bằng / và chỉ chứa chữ, số, hoặc gạch ngang.');
                        isValid = false;
                    }
                    break;
                case 'isActive':
                    if (!value) {
                        showError('isActive', 'Trạng thái là bắt buộc.');
                        isValid = false;
                    }
                    break;
            }
            return isValid;
        }

        // Validate all fields on form submit
        function validateForm() {
            let isValid = true;
            const fields = ['title', 'description', 'image', 'link', 'isActive'];
            fields.forEach(fieldId => {
                if (!validateField(fieldId)) {
                    isValid = false;
                }
            });
            return isValid;
        }

        // Add blur event listeners
        ['title', 'description', 'image', 'link', 'isActive'].forEach(fieldId => {
            const field = document.getElementById(fieldId);
            field.addEventListener('blur', () => validateField(fieldId));
        });

        // Form submit handler
        document.getElementById('updateSlideForm').addEventListener('submit', function(e) {
            e.preventDefault();
            let isValid = validateForm();
            if (isValid) {
                this.submit();
            } else {
                const firstInvalid = document.querySelector('.is-invalid');
                if (firstInvalid) firstInvalid.focus();
            }
        });

        // Show server error modal if error parameter exists
        <c:if test="${not empty param.error}">
            var errorModal = new bootstrap.Modal(document.getElementById('errorModal'));
            errorModal.show();
        </c:if>
    </script>
</body>
</html>