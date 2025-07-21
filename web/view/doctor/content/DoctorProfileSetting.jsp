<%-- 
    Document   : DoctorProfileSetting
    Created on : May 27, 2025, 6:56:33 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Pet24h - Trang cá nhân của bác sĩ</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
         <!-- Bootstrap -->
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
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
        
        <!--CDN-->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

        
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






        <%@include file="../layout/Header.jsp" %>
        <div class="container-fluid bg-light">
    <div class="layout-specing">
                <div class="row justify-content-center">
                    <c:if test="${not empty sessionScope.alertMessage}">
                        <script>
                            alert("${sessionScope.alertMessage}"); // Hiển thị thông báo
                            // Xóa thông báo khỏi session sau khi hiển thị
                            <c:remove var="alertMessage" scope="session"/>
                            <c:remove var="alertType" scope="session"/><!-- Xóa alertType khỏi session -->
                        </script>
                    </c:if>
                        <c:if test="${not empty sessionScope.SuccessMessage}">
                        <script>
                            alert("${sessionScope.SuccessMessage}"); // Hiển thị thông báo
                            // Xóa thông báo khỏi session sau khi hiển thị
                            <c:remove var="SuccessMessage" scope="session"/>
                        </script>
                    </c:if>
                    <c:set value="${sessionScope.doctor}" var="doctor"></c:set>
            
                        

                <!-- Main Content -->
                

                            <div class="rounded shadow">
                                <div class="p-4 border-bottom">
                                    <h5 class="mb-0">Thông tin bác sĩ</h5>
                                </div>
                                <form id="doctorProfileForm" action="doctor-profile-setting" method="post" enctype="multipart/form-data">
                                    <div class="p-4 border-bottom">
                                        <div class="row align-items-center">
                                            <div class="col-lg-2 col-md-4">
                                                <img src="${doctor.user.avatar}" id="avatarPreview" class="avatar avatar-md-md rounded-pill shadow mx-auto d-block" alt="">
                                        </div>
                                        <div class="col-lg-5 col-md-8 text-center text-md-start mt-4 mt-sm-0">
                                            <h5>Ảnh đại diện</h5>
                                            <p class="text-muted mb-0">Chọn ảnh vuông tối thiểu 256x256 (.jpg, .png)</p>
                                        </div>
                                        <div class="col-lg-5 col-md-12 text-lg-end text-center mt-4 mt-lg-0">
                                            
                                            <input type="file" class="form-control d-inline-block w-100" name="avatar" id="avatarInput" accept=".jpg,.jpeg,.png" onchange="previewAvatar(event)">
                                        <div id="fileName" class="mt-1 text-success"></div>
                                            <div id="fileError" class="mt-1 text-danger"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="p-4">
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Họ tên</label>
                                            <input name="fullName" type="text" class="form-control" value="${doctor.user.fullName}" placeholder="Họ tên" required maxlength="50">
                                            <div class="error-message"></div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Email</label>
                                            <input name="email" type="email" class="form-control" value="${doctor.user.email}" placeholder="Email" readonly maxlength="100">
                                            <div class="error-message"></div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Số điện thoại</label>
                                            <input name="phone" type="text" class="form-control" value="${doctor.user.phoneNumber}" placeholder="Số điện thoại" maxlength="10">
                                            <div class="error-message"></div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Địa chỉ</label>
                                            <input name="address" type="text" class="form-control" value="${doctor.user.address}" placeholder="Địa chỉ" maxlength="100">
                                            <div class="error-message"></div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Chuyên khoa</label>
                                            <input name="specialty" type="text" class="form-control" value="${doctor.specialty}" placeholder="Chuyên khoa" maxlength="50">
                                            <div class="error-message"></div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Bằng cấp</label>
                                            <input name="qualifications" type="text" class="form-control" value="${doctor.qualifications}" placeholder="Bằng cấp" maxlength="50">
                                            <div class="error-message"></div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Chứng chỉ</label>
                                            <input name="certificates" type="text" class="form-control" value="${doctor.certificates}" placeholder="Chứng chỉ" maxlength="50">
                                            <div class="error-message"></div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Số năm kinh nghiệm</label>
                                            <input name="yearsOfExperience" type="number" min="0" max="99" class="form-control" value="${doctor.yearsOfExperience}" placeholder="Năm kinh nghiệm">
                                            <div class="error-message"></div>
                                        </div>
                                        <div class="col-md-12 mb-3">
                                            <label class="form-label">Tiểu sử giới thiệu</label>
                                            <textarea name="biography" rows="4" class="form-control" placeholder="Giới thiệu bản thân" maxlength="500">${doctor.biography}</textarea>
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

                                            <div id="password" class="rounded shadow mt-4">
                            <div class="p-4 border-bottom">
                                <h5 class="mb-0">Đổi mật khẩu:</h5>
                            </div>

                            <div class="p-4">
                                <form action="change-password" method="post" onsubmit="return validateChangePass()">
                                    <!-- Old Password -->
                                    <div class="mb-3 position-relative">
                                        <label class="form-label">Mật khẩu cũ</label>
                                        <div class="position-relative">
                                            <input type="password" id="oldPassword" name="oldPassword" class="form-control pe-5" required>
                                            <i class="bi bi-eye-slash position-absolute top-50 translate-middle-y" style="right: 15px; cursor: pointer;" id="toggleOldPass" onclick="togglePassword('oldPassword', 'toggleOldPass')"></i>
                                        </div>
                                        <p type="text" name="id" style="color: red"  >${requestScope.errorOldPass}</p>
                                        <small id="oldPasswordError" class="text-danger"></small>
                                    </div>

                                    <!-- New Password -->
                                    <div class="mb-3 position-relative">
                                        <label class="form-label">Mật khẩu mới</label>
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


                                    <button type="submit" class="btn btn-primary w-100">Đổi mật khẩu</button>
                                </form>
                            </div>

                        </div>






                </div>
            </div>
        </div>













                                
                                    <script>
// --------- Preview avatar ----------
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



// --------- Escape HTML (anti-XSS) ----------
function escapeHtml(e, input) {
    if (e) e.preventDefault();
    const html = input.value;
    const div = document.createElement("div");
    div.innerText = html;
    input.value = div.innerHTML;
}

// --------- Validate fields -----------

const form = document.getElementById('doctorProfileForm');
    const nameInput = document.querySelector('input[name="fullName"]');
    const address = document.querySelector('input[name="address"]');
    const specialty = document.querySelector('input[name="specialty"]');
    const qualifications = document.querySelector('input[name="qualifications"]');
    const certificates = document.querySelector('input[name="certificates"]');
    const yearsOfExperience = document.querySelector('input[name="yearsOfExperience"]');
    const phoneInput = document.querySelector('input[name="phone"]');
    const emailInput = document.querySelector('input[name="email"]');
    const biography = document.querySelector('textarea[name="biography"]');
console.log(phoneInput);
    function createErrorElem(input) {
        let err = input.nextElementSibling;
        if (!err || !err.classList.contains('error-message')) {
            err = document.createElement('div');
            err.classList.add('error-message');
            input.parentNode.insertBefore(err, input.nextSibling);
        }
        return err;
    }

    function validateNotEmpty(input, message) {
        const val = input.value.trim();
        const errElem = createErrorElem(input);
        if (val === '') {
            errElem.textContent = message;
            return false;
        } else {
            errElem.textContent = '';
            return true;
        }
    }

    function validateName() {
        return validateNotEmpty(nameInput, 'Họ và tên không được để trống.');
    }

    function validatePhone() {
        const val = phoneInput.value.trim();
        const phonePattern = /^0\d{9}$/;
        const errElem = createErrorElem(phoneInput);
        
        if (val === '' && !phonePattern.test(val)) {
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
        if (val !== '' && !emailPattern.test(val)) {
            errElem.textContent = 'Email không hợp lệ.';
            return false;
        } else {
            errElem.textContent = '';
            return true;
        }
    }

    function validateYearsOfExperience() {
        const val = yearsOfExperience.value;
        const errElem = createErrorElem(yearsOfExperience);
        if (val < 0 || val > 99 || val === '') {
            errElem.textContent = 'Số năm kinh nghiệm phải nằm trong khoảng 0 - 99.';
            return false;
        } else {
            errElem.textContent = '';
            return true;
        }
    }

    function validateBiography() {
        return validateNotEmpty(biography, 'Vui lòng nhập giới thiệu.');
    }

    // Gán validate on blur
    nameInput.addEventListener('blur', validateName);
    phoneInput.addEventListener('blur', validatePhone);
    emailInput.addEventListener('blur', validateEmail);
    address.addEventListener('blur', () => validateNotEmpty(address, 'Vui lòng nhập địa chỉ.'));
    specialty.addEventListener('blur', () => validateNotEmpty(specialty, 'Vui lòng nhập chuyên khoa.'));
    qualifications.addEventListener('blur', () => validateNotEmpty(qualifications, 'Vui lòng nhập bằng cấp.'));
    certificates.addEventListener('blur', () => validateNotEmpty(certificates, 'Vui lòng nhập chứng chỉ.'));
    yearsOfExperience.addEventListener('blur', validateYearsOfExperience);
    biography.addEventListener('blur', validateBiography);

    // Validate toàn bộ khi submit + escape HTML
    form.addEventListener('submit', function (e) {
        const escapeInputs = [
            nameInput, address, specialty, qualifications, certificates, biography
        ];
        escapeInputs.forEach(function(input) {
            if (input) {
                const div = document.createElement("div");
                div.innerText = input.value;
                input.value = div.innerHTML;
            }
        });

        const valid =
    validateName() &&
    validatePhone() &&
    validateEmail() &&
    validateNotEmpty(address, 'Vui lòng nhập địa chỉ.') &&
    validateNotEmpty(specialty, 'Vui lòng nhập chuyên khoa.') &&
    validateNotEmpty(qualifications, 'Vui lòng nhập bằng cấp.') &&
    validateNotEmpty(certificates, 'Vui lòng nhập chứng chỉ.') &&
    validateYearsOfExperience() &&
    validateBiography();


        if (!valid) {
            e.preventDefault(); // chặn submit nếu có lỗi
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






document.getElementById("avatarInput").addEventListener("change", function () {
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

            form.addEventListener("submit", function (e) {
                var fileInput = document.getElementById("avatarInput");
                var fileErrorDisplay = document.getElementById("fileError");

                // Nếu có file và bị lỗi kích thước thì chặn submit
                if (fileInput.files.length > 0 && fileInput.files[0].size > 1048576) {
                    e.preventDefault();
                    fileErrorDisplay.textContent = "Ảnh phải nhỏ hơn 1MB!";
                }
            });

</script>

    <a href="#" onclick="topFunction()" id="back-to-top" class="btn btn-icon btn-pills btn-primary back-to-top"><i data-feather="arrow-up" class="icons"></i></a>
    
    
    

   <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
    <!-- Icons -->
    <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
    <!-- Main Js -->
    <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
</body>

</html>
