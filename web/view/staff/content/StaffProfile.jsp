<%-- 
    Document   : StaffProfile
    Created on : May 29, 2025, 7:45:41 AM
    Author     : Dell
--%>



<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Trang Staff</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
        <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
        <meta name="author" content="Shreethemes" />
        <meta name="email" content="support@shreethemes.in" />
        <meta name="website" content="https://shreethemes.in" />
        <meta name="Version" content="v1.2.0" />
        <!-- favicon -->
     
        <!-- Bootstrap -->
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- Css -->
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

        <style>
            #avatarInput {
                width: 100%;
                display: inline-block;
                border: 1px solid #ccc;
                padding: 0.375rem 0.75rem;
                border-radius: 0.25rem;
                box-sizing: border-box;
            }
            
          
            .error-message {
                color: red;
                font-size: 0.9rem;
                margin-top: 4px;
            }
        
        </style>

    </head>

    <body>






        <%@include file="../../home/layout/Header.jsp" %>
        <section class="bg-dashboard">
            <div class="container">
                <c:if test="${not empty sessionScope.alertMessage}">
                    <script>
                        alert("${sessionScope.alertMessage}"); // Hiển thị thông báo
                        // Xóa thông báo khỏi session sau khi hiển thị
                        <c:remove var="alertMessage" scope="session"/>
                        <c:remove var="alertType" scope="session"/><!-- Xóa alertType khỏi session -->
                    </script>
                </c:if>
                <c:set value="${sessionScope.staff}" var="staff"></c:set>
                    <div class="row justify-content-center">
                       
                    <div class="col-xl-8 col-lg-8 col-md-7 mt-4 pt-2 mt-sm-0 pt-sm-0">

                        <div class="rounded shadow mt-4">
                            <div class="p-4 border-bottom">
                                <h5 class="mb-0">Thông Tin Nhân Viên</h5>
                            </div>
                            <form id="staffProfileForm" action="staff-profile-setting" method="post" enctype="multipart/form-data">
                                <div class="p-4 border-bottom">
                                    <div class="row align-items-center">
                                        <div class="col-lg-2 col-md-4">
                                            <img src="${pageContext.request.contextPath}/${staff.avatar}" id="avatarPreview" class="avatar avatar-md-md rounded-pill shadow mx-auto d-block" alt="">
                                        </div>
                                        <div class="col-lg-5 col-md-8 text-center text-md-start mt-4 mt-sm-0">
                                            <h5>Ảnh đại diện</h5>
                                            <p class="text-muted mb-0">Chọn ảnh vuông tối thiểu 256x256 (.jpg, .png)</p>
                                        </div>
                                        <div class="col-lg-5 col-md-12 text-lg-end text-center mt-4 mt-lg-0">
                                            <!-- Thêm các thuộc tính CSS để chỉnh sửa giao diện input file -->
                                            <input type="file" class="form-control d-inline-block w-100" name="avatar" id="avatarInput" accept=".jpg,.jpeg,.png" onchange="previewAvatar(event)">
                                            <button type="button" class="btn btn-soft-primary ms-2" onclick="removeAvatar()">Xóa</button>
                                        </div>
                                    </div>
                                </div>
                                <div class="p-4">
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Họ tên</label>
                                            <input name="fullName" type="text" class="form-control" value="${staff.fullName}" placeholder="Họ tên" required>
                                            <div class="error-message"></div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Email</label>
                                            <input name="email" type="email" class="form-control" value="${staff.email}" placeholder="Email" readonly>
                                            <div class="error-message"></div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Số điện thoại</label>
                                            <input name="phone" type="text" class="form-control" value="${staff.phoneNumber}" placeholder="Số điện thoại">
                                            <div class="error-message"></div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Địa chỉ</label>
                                            <input name="address" type="text" class="form-control" value="${staff.address}" placeholder="Địa chỉ">
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
                                <div class="rounded shadow mt-4">
                            <div class="p-4 border-bottom">
                                <h5 class="mb-0">Đổi mật khẩu:</h5>
                            </div>

                            <div class="p-4">
                                <form action="staff-changepass" method="post" onsubmit="return validateChangePass()">
                                    <!-- Old Password -->
                                    <div class="mb-3 position-relative">
                                        <label class="form-label">Nhập mật khẩu cũ</label>
                                        <div class="position-relative">
                                            <input type="password" id="oldPassword" name="oldPassword" class="form-control pe-5" required>
                                            <i class="bi bi-eye-slash position-absolute top-50 translate-middle-y" style="right: 15px; cursor: pointer;" id="toggleOldPass" onclick="togglePassword('oldPassword', 'toggleOldPass')"></i>
                                        </div>
                                        <p type="text" name="id" style="color: red"  >${requestScope.errorOldPass}</p>

                                        <small id="oldPasswordError" class="text-danger"></small>
                                    </div>

                                    <!-- New Password -->
                                    <div class="mb-3 position-relative">
                                        <label class="form-label">Nhập mật khẩu mới</label>
                                        <div class="position-relative">
                                            <input type="password" id="newPassword" name="newPassword" class="form-control pe-5" onkeyup="checkPasswordStrength()" required>
                                            <i class="bi bi-eye-slash position-absolute top-50 translate-middle-y" style="right: 15px; cursor: pointer;" id="toggleNewPass" onclick="togglePassword('newPassword', 'toggleNewPass')"></i>
                                        </div>
                                        <div id="passwordRules" class="mt-2">
                                            <small id="lengthRule" class="text-danger">• Ít nhất 8 kí tự, nhiều nhất 20 kí tự</small><br>
                                            <small id="uppercaseRule" class="text-danger">• Ít nhất 1 kí tự in hoa</small><br>
                                            <small id="lowercaseRule" class="text-danger">• Ít nhất 1 kí tự in thường</small><br>
                                            <small id="numberRule" class="text-danger">• Ít nhất 1 số</small><br>
                                            <small id="specialRule" class="text-danger">• Ít nhất 1 kí tự đặc biệt</small>
                                        </div>
                                        <small id="newPasswordError" class="text-danger"></small>
                                    </div>

                                    <!-- Confirm New Password -->
                                    <div class="mb-3 position-relative">
                                        <label class="form-label">Nhập lại mật khẩu mới</label>
                                        <div class="position-relative">
                                            <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" required>
                                            <i class="bi bi-eye-slash position-absolute top-50 end-0 translate-middle-y me-3 cursor-pointer" id="toggleConfirmPass" style="cursor: pointer;" onclick="togglePassword('confirmPassword', 'toggleConfirmPass')"></i>
                                        </div>
                                        <small id="confirmPasswordError" class="text-danger"></small>
                                    </div>


                                    <button type="submit" class="btn btn-primary w-100">Change Password</button>
                                </form>
                            </div>

                        </div>






                    </div><!--end col-->
                </div><!--end row-->
            </div><!--end container-->
        </section><!--end section-->





                <script>
    function previewAvatar(event) {
        const input = event.target;
        const preview = document.getElementById('avatarPreview');
        if (input.files && input.files[0]) {
            const reader = new FileReader();
            reader.onload = function (e) {
                preview.src = e.target.result;
            };
            reader.readAsDataURL(input.files[0]);
        }
    }

    function removeAvatar() {
        document.getElementById('avatarInput').value = '';
        document.getElementById('avatarPreview').src = '${staff.avatar}';
    }

    const form = document.getElementById('staffProfileForm');
    const nameInput = document.querySelector('input[name="fullName"]');
    const phoneInput = document.querySelector('input[name="phone"]');
    const emailInput = document.querySelector('input[name="email"]');
    const descriptionInput = document.querySelector('textarea[name="biography"]');

    function createErrorElem(input) {
        let err = input.nextElementSibling;
        if (!err || !err.classList.contains('error-message')) {
            err = document.createElement('div');
            err.classList.add('error-message');
            input.parentNode.insertBefore(err, input.nextSibling);
        }
        return err;
    }

    function validatePhone() {
        const val = phoneInput.value.trim();
        const phonePattern = /^0\d{9}$/;
        const errElem = createErrorElem(phoneInput);
        if (!phonePattern.test(val)) {
            errElem.textContent = 'Số điện thoại phải bắt đầu bằng số 0 và có đúng 10 số.';
            return false;
        } else {
            errElem.textContent = '';
            return true;
        }
    }

    function validateEmail() {
        const val = emailInput.value.trim();
        const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        const errElem = createErrorElem(emailInput);
        if (!emailPattern.test(val)) {
            errElem.textContent = 'Email phải là địa chỉ Gmail hợp lệ, ví dụ: ten@gmail.com.';
            return false;
        } else {
            errElem.textContent = '';
            return true;
        }
    }

    function validateName() {
        const val = nameInput.value.trim();
        const errElem = createErrorElem(nameInput);
        if (val === '') {
            errElem.textContent = 'Họ và tên không được để trống.';
            return false;
        } else {
            errElem.textContent = '';
            return true;
        }
    }

   

    nameInput.addEventListener('blur', validateName);
    phoneInput.addEventListener('blur', validatePhone);
    emailInput.addEventListener('blur', validateEmail);
    

    form.addEventListener('submit', function (e) {
        const validName = validateName();
        const validPhone = validatePhone();
        const validEmail = validateEmail();
        const validDescription = validateDescription();

        if (!validName || !validPhone || !validEmail || !validDescription) {
            e.preventDefault(); 
        }
    });
    
    
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
</script>





                <!-- Icons -->
                <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
                <!-- Main Js -->
                <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
            </body>

        </html>