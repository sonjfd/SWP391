z<%-- 
    Document   : UserProfile
    Created on : May 21, 2025, 9:18:11 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
    

    <head>
        <meta charset="utf-8" />
        <title>Trang cá nhân</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
        <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
        <meta name="author" content="Shreethemes" />
        <meta name="email" content="support@shreethemes.in" />
        <meta name="website" content="https://shreethemes.in" />
        <meta name="Version" content="v1.2.0" />
       
        <!-- Bootstrap -->

        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- Css -->
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

        <style>
            body {
                margin: 0;
                padding: 0;
            }
            footer {
                margin-bottom: 0;
            }
            .bg-dashboard {
                margin-bottom: 0;
                padding-bottom: 0;
            }
            html, body {
                height: 100%;
            }
            .error-message{
                color: red;
            }
            .img-fluid{
                max-height: 500px;
                max-width: 500px;

            }
            .position-relative {
                position: relative;
            }

            .toggle-password {
                position: absolute;
                top: 50%;
                right: 12px;
                transform: translateY(-50%);
                cursor: pointer;
                color: #666;
            }

            .password-rules small {
                display: block;
                font-size: 0.85rem;
                margin-top: 4px;
            }

            .form-control {
                position: relative;
            }
            .form-control-icon {
                position: absolute;
                right: 15px;
                top: 50%;
                transform: translateY(-50%);
                cursor: pointer;
            }


        </style>

    </head>

    <body>


        <c:if test="${not empty sessionScope.SuccessMessage}">
            <script>alert('${sessionScope.SuccessMessage}');</script>
            <c:remove var="SuccessMessage" scope="session"/>
        </c:if>

        <c:if test="${not empty sessionScope.FailMessage}">
            <script>alert('${sessionScope.FailMessage}');</script>
            <c:remove var="FailMessage" scope="session"/>
        </c:if>

        <%@include file="../../home/layout/Header.jsp" %>

        <section class="bg-dashboard">
            <div class="container">
                <c:set var="staff" value="${sessionScope.staff}" />
                <div class="row justify-content-center">
                    <!-- Sidebar -->
                    <div class="col-xl-4 col-lg-4 col-md-5 col-12">
                        <div class="rounded shadow overflow-hidden sticky-bar">
                            <div class="card border-0">
                                <img src="${staff.avatar}" class="img-fluid" alt="">
                            </div>
                            <div class="text-center avatar-profile margin-nagative mt-n5 position-relative pb-4 border-bottom">
                                <img src="${staff.avatar}" class="rounded-circle shadow-md avatar avatar-md-md" alt="">
                                <h5 class="mt-3 mb-1">${staff.fullName}</h5>
                            </div>
                            <ul class="list-unstyled sidebar-nav mb-0">
                                <li class="navbar-item"><a href="staff-list-pet-and-owner" class="navbar-link"><i class="ri-calendar-check-line navbar-icon"></i>Bảng Điều Khiển</a></li>
                                
                            </ul>
                        </div>
                    </div>

                    <!-- Content -->
                    <div class="col-xl-8 col-lg-8 col-md-7 mt-4 pt-2 mt-sm-0 pt-sm-0">
                        <!-- Cập nhật thông tin -->
                        <div class="rounded shadow mt-4">
                            <div class="p-4 border-bottom"><h5>Thông tin khách hàng</h5></div>
                            <form id="updateUserForm" action="staff-profile-setting" method="post" enctype="multipart/form-data">
                                <div class="p-4 border-bottom">
                                    <div class="row align-items-center">
                                        <div class="col-lg-2 col-md-4">
                                            <img src="${staff.avatar}" id="avatarPreview" class="avatar avatar-md-md rounded-pill shadow mx-auto d-block" alt="Ảnh đại diện">
                                        </div>
                                        <div class="col-lg-5 col-md-8 text-center text-md-start mt-4 mt-sm-0">
                                            <h5>Ảnh đại diện</h5>
                                            <p class="text-muted mb-0">Chọn ảnh vuông ≥ 256x256 (.jpg, .png)</p>
                                        </div>
                                        <div class="col-lg-5 col-md-12 text-lg-end text-center mt-4 mt-lg-0">
                                            <input type="file" class="form-control w-100" name="avatar" id="avatar" accept=".jpg,.jpeg,.png" onchange="previewAvatar(event)">
                                            <div id="fileName" class="mt-1 text-success"></div>
                                            <div id="fileError" class="mt-1 text-danger"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="p-4">
                                    <div class="row">
                                        <input type="hidden" name="id" value="${staff.id}">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Họ tên</label>
                                            <input name="fullName" type="text" id="fullName" class="form-control" value="${staff.fullName}" placeholder="Họ tên">
                                            <div class="error-message"></div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Email</label>
                                            <input name="email" type="email" id="email" class="form-control" value="${staff.email}" placeholder="Email">
                                            <div class="error-message"></div>
                                            <c:if test="${not empty requestScope.wrongemail}">
                                                <p class="text-danger">${requestScope.wrongemail}</p>
                                            </c:if>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Số điện thoại</label>
                                            <input name="phone" type="text" id="phone" class="form-control" value="${staff.phoneNumber}" placeholder="Số điện thoại">
                                            <div class="error-message"></div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Địa chỉ</label>
                                            <input name="address" type="text" id="address" class="form-control" value="${staff.address}" placeholder="Địa chỉ">
                                            <div class="error-message"></div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12 text-end">
                                            <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>

                        <!-- Đổi mật khẩu -->
                        <div class="rounded shadow mt-4">
                            <div class="p-4 border-bottom"><h5>Đổi mật khẩu</h5></div>
                            <div class="p-4">
                                <form action="staff-changepass" method="post" onsubmit="return validateChangePass()">
                                    <div class="mb-3">
                                        <label class="form-label">Mật khẩu cũ</label>
                                        <div class="position-relative">
                                            <input type="password" id="oldPassword" name="oldPassword" class="form-control pe-5" required>
                                            <i class="bi bi-eye-slash position-absolute top-50 translate-middle-y" style="right: 15px; cursor: pointer;" onclick="togglePassword('oldPassword', this)"></i>
                                        </div>
                                        <c:if test="${not empty requestScope.errorOldPass}">
                                            <p class="text-danger">${requestScope.errorOldPass}</p>
                                        </c:if>
                                        <small id="oldPasswordError" class="text-danger"></small>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Mật khẩu mới</label>
                                        <div class="position-relative">
                                            <input type="password" id="newPassword" name="newPassword" class="form-control pe-5" onkeyup="checkPasswordStrength()" required>
                                            <i class="bi bi-eye-slash position-absolute top-50 translate-middle-y" style="right: 15px; cursor: pointer;" onclick="togglePassword('newPassword', this)"></i>
                                        </div>
                                        <div id="passwordRules" class="mt-2">
                                            <small id="lengthRule" class="text-danger">• 8-20 ký tự</small><br>
                                            <small id="uppercaseRule" class="text-danger">• Ít nhất 1 chữ hoa</small><br>
                                            <small id="lowercaseRule" class="text-danger">• Ít nhất 1 chữ thường</small><br>
                                            <small id="numberRule" class="text-danger">• Ít nhất 1 số</small><br>
                                            <small id="specialRule" class="text-danger">• Ít nhất 1 ký tự đặc biệt</small>
                                        </div>
                                        <small id="newPasswordError" class="text-danger"></small>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Nhập lại mật khẩu mới</label>
                                        <div class="position-relative">
                                            <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" required>
                                            <i class="bi bi-eye-slash position-absolute top-50 end-0 translate-middle-y me-3" style="cursor: pointer;" onclick="togglePassword('confirmPassword', this)"></i>
                                        </div>
                                        <small id="confirmPasswordError" class="text-danger"></small>
                                    </div>

                                    <button type="submit" class="btn btn-primary w-100">Đổi mật khẩu</button>
                                </form>
                            </div>
                        </div>
                    </div> <!-- End Content -->
                </div> <!-- End Row -->
            </div> <!-- End Container -->
        </section>



        <!-- javascript -->
        <script>
            function previewAvatar(event) {
                const input = event.target;
                const preview = document.getElementById('avatarPreview');
                if (input.files && input.files[0]) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        preview.src = e.target.result;
                    }
                    reader.readAsDataURL(input.files[0]);
                }
            }
            function checkPasswordStrength() {
                let password = document.getElementById("newPassword").value;

                let lengthCheck = password.length >= 8 && password.length <= 20;
                let uppercaseCheck = /[A-Z]/.test(password);
                let lowercaseCheck = /[a-z]/.test(password);
                let numberCheck = /[0-9]/.test(password);
                let specialCheck = /[\W_]/.test(password);

                document.getElementById("lengthRule").className = lengthCheck ? "text-success" : "text-danger";
                document.getElementById("uppercaseRule").className = uppercaseCheck ? "text-success" : "text-danger";
                document.getElementById("lowercaseRule").className = lowercaseCheck ? "text-success" : "text-danger";
                document.getElementById("numberRule").className = numberCheck ? "text-success" : "text-danger";
                document.getElementById("specialRule").className = specialCheck ? "text-success" : "text-danger";
            }

            function validateChangePass() {
                let oldPassword = document.getElementById("oldPassword").value.trim();
                let newPassword = document.getElementById("newPassword").value.trim();
                let confirmPassword = document.getElementById("confirmPassword").value.trim();

                // Các phần hiển thị lỗi riêng
                let oldPasswordError = document.getElementById("oldPasswordError");
                let newPasswordError = document.getElementById("newPasswordError");
                let confirmPasswordError = document.getElementById("confirmPasswordError");

                // Reset lỗi cũ
                oldPasswordError.innerHTML = "";
                newPasswordError.innerHTML = "";
                confirmPasswordError.innerHTML = "";

                let isValid = true;

                // Old Password: kiểm tra độ dài
                if (oldPassword.length < 8 || oldPassword.length > 20) {
                    oldPasswordError.innerHTML = "Mật khẩu cũ phải từ 8 đến 20 ký tự.";
                    isValid = false;
                }

                // New Password: kiểm tra độ mạnh
                let lengthCheck = newPassword.length >= 8 && newPassword.length <= 20;
                let uppercaseCheck = /[A-Z]/.test(newPassword);
                let lowercaseCheck = /[a-z]/.test(newPassword);
                let numberCheck = /[0-9]/.test(newPassword);
                let specialCheck = /[\W_]/.test(newPassword);

                if (!lengthCheck || !uppercaseCheck || !lowercaseCheck || !numberCheck || !specialCheck) {
                    if (!lengthCheck)
                        newPasswordError.innerHTML += "• Từ 8 đến 20 ký tự.<br>";
                    if (!uppercaseCheck)
                        newPasswordError.innerHTML += "• Ít nhất 1 chữ hoa.<br>";
                    if (!lowercaseCheck)
                        newPasswordError.innerHTML += "• Ít nhất 1 chữ thường.<br>";
                    if (!numberCheck)
                        newPasswordError.innerHTML += "• Ít nhất 1 số.<br>";
                    if (!specialCheck)
                        newPasswordError.innerHTML += "• Ít nhất 1 ký tự đặc biệt.<br>";
                    isValid = false;
                }

                // New Password không trùng với Old Password
                if (newPassword === oldPassword && newPassword.length > 0) {
                    newPasswordError.innerHTML += "• Mật khẩu mới không được trùng mật khẩu cũ.<br>";
                    isValid = false;
                }

                // Confirm Password: kiểm tra độ dài và trùng khớp
                if (confirmPassword.length < 8 || confirmPassword.length > 20) {
                    confirmPasswordError.innerHTML += "•Mật khẩu phải từ 8 đến 20 ký tự.<br>";
                    isValid = false;
                }
                if (newPassword !== confirmPassword) {
                    confirmPasswordError.innerHTML += "• Mật khẩu xác nhận không khớp.<br>";
                    isValid = false;
                }

                return isValid;
            }




            function togglePassword(inputId, iconId) {
                let input = document.getElementById(inputId);
                let icon = document.getElementById(iconId);

                if (input.type === "password") {
                    input.type = "text";
                    icon.classList.remove("bi-eye-slash");
                    icon.classList.add("bi-eye");
                } else {
                    input.type = "password";
                    icon.classList.remove("bi-eye");
                    icon.classList.add("bi-eye-slash");
                }
            }

// Hàm kiểm tra email hợp lệ
            // Hàm kiểm tra email hợp lệ
            function isValidEmail(email) {
                return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
            }

// Hàm kiểm tra full name hợp lệ
            function isValidFullname(fullname) {
                return /^[\p{L} ]{3,}$/u.test(fullname.trim());
            }

// Hàm kiểm tra số điện thoại hợp lệ
            function isValidPhoneNumber(phone) {
                return /^0\d{9}$/.test(phone);
            }

// Hàm hiển thị lỗi
            function showError(inputId, message) {
                const inputElement = document.getElementById(inputId);
                const errorElement = inputElement ? inputElement.nextElementSibling : null;
                if (errorElement && errorElement.classList.contains('error-message')) {
                    errorElement.textContent = message;
                    errorElement.style.display = message ? 'block' : 'none';
                }
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

// Hàm kiểm tra họ tên
            function validateFullName() {
                const fullNameInput = document.getElementById('fullName');
                const fullName = fullNameInput.value.trim();
                if (!fullName) {
                    showError('fullName', 'Họ và tên không được để trống!');
                    return false;
                } else if (!isValidFullname(fullName)) {
                    showError('fullName', 'Họ và tên chỉ chứa chữ cái và khoảng trắng, tối thiểu 3 ký tự!');
                    return false;
                }
                showError('fullName', '');
                return true;
            }

// Hàm kiểm tra số điện thoại
            function validatePhoneNumber() {
                const phoneInput = document.getElementById('phone');
                const phone = phoneInput.value.trim();
                if (!phone) {
                    showError('phone', 'Số điện thoại không được để trống!');
                    return false;
                } else if (!isValidPhoneNumber(phone)) {
                    showError('phone', 'Số điện thoại phải bắt đầu bằng 0 và có đúng 10 số!');
                    return false;
                }
                showError('phone', '');
                return true;
            }

// Hàm kiểm tra địa chỉ (tùy bạn muốn bắt buộc hay không)
            function validateAddress() {
                const addressInput = document.getElementById('address');
                const address = addressInput.value.trim();
                if (!address) {
                    showError('address', 'Địa chỉ không được để trống!');
                    return false;
                }
                showError('address', '');
                return true;
            }

// Hàm kiểm tra toàn bộ form khi submit
            function validateForm() {
                const isFullNameValid = validateFullName();
                const isEmailValid = validateEmail();
                const isPhoneValid = validatePhoneNumber();
                const isAddressValid = validateAddress();
                return isFullNameValid && isEmailValid && isPhoneValid && isAddressValid;
            }

// Gắn sự kiện blur cho từng input
            document.addEventListener('DOMContentLoaded', function () {
                const inputs = [
                    {id: 'fullName', validate: validateFullName},
                    {id: 'email', validate: validateEmail},
                    {id: 'phone', validate: validatePhoneNumber},
                    {id: 'address', validate: validateAddress}
                ];

                inputs.forEach(({ id, validate }) => {
                    const input = document.getElementById(id);
                    if (input) {
                        input.addEventListener('blur', validate);
                }
                });

                // Sự kiện submit form
                const form = document.getElementById('updateUserForm');
                form.addEventListener('submit', function (e) {
                    if (!validateForm()) {
                        e.preventDefault();
                    }
                });
            });


            document.getElementById("avatar").addEventListener("change", function () {
                var fileInput = this;
                var fileNameDisplay = document.getElementById("fileName");
                var fileErrorDisplay = document.getElementById("fileError");

                // Clear old messages
                fileNameDisplay.textContent = "";
                fileErrorDisplay.textContent = "";

                if (fileInput.files.length > 0) {
                    var file = fileInput.files[0];
                    fileNameDisplay.textContent = "Đã chọn: " + file.name;

                    if (file.size > 1048576) {
                        fileErrorDisplay.textContent = "Ảnh phải nhỏ hơn 1MB!";
                    }
                }
            });

            document.getElementById("updateUserForm").addEventListener("submit", function (e) {
                var fileInput = document.getElementById("avatar");
                var fileErrorDisplay = document.getElementById("fileError");

                // Nếu có file và bị lỗi kích thước thì chặn submit
                if (fileInput.files.length > 0 && fileInput.files[0].size > 1048576) {
                    e.preventDefault();
                    fileErrorDisplay.textContent = "Ảnh phải nhỏ hơn 1MB!";
                }
            });

        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>


        <!-- Icons -->
        <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
    </body>

</html>
