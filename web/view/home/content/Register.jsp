<%-- 
    Document   : login
    Created on : May 26, 2025, 10:50:39 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />

        <title>Đăng ký</title>

      

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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
        <!-- Css -->
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />

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

        <div class="back-to-home rounded d-none d-sm-block">
            <a href="${pageContext.request.contextPath}/homepage" class="btn btn-icon btn-primary"><i data-feather="home" class="icons"></i></a>
        </div>

        <!-- Hero Start -->
        <section class="bg-half-100 d-table w-100 "
         style="background: #87CEFA url('${pageContext.request.contextPath}/assets/images/bg/bg-lines-one.png') center center no-repeat;">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-5 col-md-8">

                        <div class="card login-page shadow mt-4 rounded border-0" style="background-color: #CAE1FF;">
                            <div class="card-body">
                                <h4 class="text-center">Đăng kí</h4>  
                                <form action="register"  method="POST" class="login-form mt-4">
                                    <div class="row">
                                        <div class="col-md-12 ">
                                            <div class="mb-3 ">                                               
                                                <label class="form-label text-center">Họ và tên<span class="text-danger">*</span></label>
                                                <div class="input-group">
                                                    <span class="input-group-text"><i class="bi bi-person"></i></span>
                                                    <input type="text" class="form-control" id="fullName" placeholder="Nhập họ và tên ..." name="name" required="">
                                                     </div>
                                                    <small id="fullNameError" class="error" style="color:red; display:none;"></small>
                                               
                                            </div>
                                        </div>

                                        <div class="col-md-12">
                                            <div class="mb-3">
                                                <label class="form-label">Email <span class="text-danger">*</span></label>
                                                <div class="input-group">
                                                    <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                                                    <input type="email" class="form-control" id="email" placeholder="Nhập Email..." name="email" required="">
                                                   </div> 
                                                    <small id="emailError" class="error" style="color:red; display:none;"></small>
                                                
                                            </div>
                                        </div>

                                        <div class="col-md-12">
                                            <div class="mb-3">
                                                <label class="form-label">Số điện thoại <span class="text-danger">*</span></label>
                                                <div class="input-group">
                                                    <span class="input-group-text"><i class="bi bi-telephone"></i></span>
                                                    <input type="number" class="form-control"  id="phone"placeholder="Nhập số điện thoại ..." name="phone" required="">
                                                   </div>
                                                    <small id="phoneError" class="error" style="color:red; display:none;"></small>
                                                
                                            </div>
                                        </div>

                                        <div class="col-md-12">
                                            <div class="mb-3">
                                                <label class="form-label">Địa chỉ <span class="text-danger">*</span></label>
                                                <div class="input-group">
                                                    <span class="input-group-text"><i class="bi bi-geo-alt"></i></span>
                                                    <input  type="Text" class="form-control" placeholder="Nhập địa chỉ ..." name="address" required="" id="address">
                                                </div>
                                                <small id="addressError" class="error" style="color:red; display:none;"></small>
                                            </div>
                                        </div>

                                        <div class="col-md-12">
                                            <div class="mb-3">
                                                <label class="form-label">Tên tài khoản<span class="text-danger">*</span></label>
                                                <div class="input-group">
                                                    <span class="input-group-text"><i class="bi bi-person"></i></span>
                                                    <input type="text" class="form-control" id="userName" placeholder="Nhập tên tài khoản ..." name="username" required="">
                                                    </div>
                                                    <small id="userNameError" class="error" style="color:red; display:none;"></small>
                                                
                                            </div>
                                        </div>   
                                        
                                        <!--sửa ở chỗ này-->
                                        <div class="col-md-12">
                                            <div class="mb-3">
                                                <label class="form-label">Mật khẩu <span class="text-danger">*</span></label>
                                                <div class="input-group">
                                                    <span class="input-group-text"><i class="bi bi-lock"></i></span>
                                                    <input type="password" class="form-control" id="password" placeholder="Nhập mật khẩu ..." name="password" required="">
                                                    <span class="input-group-text" onclick="togglePassword()" style="cursor: pointer;">
                                                        <i class="mdi mdi-eye-off" id="eye-icon1"></i>
                                                    </span>
                                                </div>
                                                <small id="passwordError" class="error" style="color:red; display:none;"></small>
                                            </div>
                                        </div>

                                        <div class="col-md-12">
                                            <div class="mb-3">
                                                <label class="form-label">Nhập lại mật khẩu <span class="text-danger">*</span></label>
                                                <div class="input-group">
                                                    <span class="input-group-text"><i class="bi bi-lock"></i></span>
                                                    <input type="password" class="form-control" id="repassword" placeholder="Nhập đúng lại mật khẩu" name="repassword" required="">
                                                    <span class="input-group-text" onclick="toggleRePassword()" style="cursor: pointer;">
                                                        <i class="mdi mdi-eye-off" id="eye-icon2"></i>
                                                    </span>
                                                </div>
                                                <small id="repasswordError" class="error" style="color:red; display:none;"></small>
                                            </div>
                                        </div>

                                        <div class="col-md-12">
                                            <div class="d-grid">
                                                <button class="btn btn-primary">Đăng kí</button>
                                            </div>
                                        </div>

                                        

                                        <!--end col-->

                                        <div class="mx-auto text-center">
                                            <p class="mb-0 mt-3"><small class="text-dark me-2">Đã có tài khoản ?</small> <a href="login" class="text-dark fw-bold text-decoration-underline">Đăng nhập</a></p>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div><!---->
                    </div> <!--end col-->
                </div><!--end row-->
            </div> <!--end container-->
        </section><!--end section-->
        <!-- Hero End -->

        <script>
           
            // Regex kiểm tra email hợp lệ
            function isValidEmail(email) {
                return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
            }

            // Regex kiểm tra username hợp lệ: ít nhất 3 ký tự, không cho nhập <script>, _
            function isValidUsername(username) {
                // Không cho phép script (để tránh XSS nguy hiểm)
                const hasScript = /<\s*script/i.test(username);
                if (hasScript)
                    return false;

                return username.length >= 3 || username.length <=20;
            }

            // Regex kiểm tra số điện thoại: 10 số bắt đầu bằng 0 hoặc +84
            function isValidPhone(phone) {
                return /^0\d{9}$/.test(phone);
            }

            // Hiển thị lỗi
            function showError(inputId, message) {
                const errorElement = document.getElementById(inputId + 'Error');
                if (errorElement) {
                    errorElement.textContent = message;
                    errorElement.style.display = message ? 'block' : 'none';
                }
            }

            // Kiểm tra username
            function validateUsername() {
                const username = document.getElementById('userName').value.trim();
                if (!username) {
                    showError('userName', 'Tên đăng nhập không được để trống!');
                    return false;
                }
                if (!isValidUsername(username)) {
                    showError('userName', 'Tên đăng nhập phải có ít nhất 3 ký tự và không vượt quá 20 ký tự!');
                    return false;
                }
                showError('userName', '');
                return true;
            }

            // Kiểm tra email
            function validateEmail() {
                const email = document.getElementById('email').value.trim();
                if (!email) {
                    showError('email', 'Email không được để trống!');
                    return false;
                }
                if (!isValidEmail(email)) {
                    showError('email', 'Email không hợp lệ!');
                    return false;
                }
                showError('email', '');
                return true;
            }

            // Kiểm tra password 8<x<20 ký tự, trong đấy có ít nhất 1 chữ hoa, thường, ký tự đặc biệt, số
            function validatePassword() {
                const password = document.getElementById('password').value.trim();

                if (!password) {
                    showError('password', 'Mật khẩu không được để trống!');
                    return false;
                }

                if (password.length > 20 || password.length < 8) {
                    showError('password', 'Mật khẩu phải có ít nhất 8 ký tự và không quá 20 ký tự!');
                    return false;
                }

                const hasUpperCase = /[A-Z]/.test(password);
                const hasLowerCase = /[a-z]/.test(password);
                const hasDigit = /[0-9]/.test(password);
                const hasSpecialChar = /[^A-Za-z0-9]/.test(password); // Ký tự đặc biệt

                if (!hasUpperCase) {
                    showError('password', 'Mật khẩu phải chứa ít nhất một chữ hoa!');
                    return false;
                }

                if (!hasLowerCase) {
                    showError('password', 'Mật khẩu phải chứa ít nhất một chữ thường!');
                    return false;
                }

                if (!hasDigit) {
                    showError('password', 'Mật khẩu phải chứa ít nhất một số!');
                    return false;
                }

                if (!hasSpecialChar) {
                    showError('password', 'Mật khẩu phải chứa ít nhất một ký tự đặc biệt!');
                    return false;
                }

                showError('password', '');
                return true;
            }

            // Hàm kiểm tra 2 mật khẩu giống nhau
            function validateRePassword() {
                const pw = document.getElementById('password').value.trim();
                const rp = document.getElementById('repassword').value.trim();

                if (!rp) {
                    showError('repassword', 'Vui lòng không để trống và nhập đúng mật khẩu ở trên!');
                    return false;
                }
                if (pw !== rp) {
                    showError('repassword', 'Mật khẩu nhập lại không khớp!');
                    return false;
                }
                showError('repassword', '');
                return true;
            }

            // Kiểm tra họ tên
            function validateFullName() {
                const fullName = document.getElementById('fullName').value.trim();

                if (!fullName) {
                    showError('fullName', 'Họ và tên không được để trống!');
                    return false;
                }

                if (fullName.length > 30) {
                    showError('fullName', 'Họ và tên không được vượt quá 30 ký tự!');
                    return false;
                }

                showError('fullName', '');
                return true;
            }

            // Kiểm tra số điện thoại
            function validatePhone() {
                const phone = document.getElementById('phone').value.trim();
                if (!phone) {
                    showError('phone', 'Số điện thoại không được để trống! ');
                    return false;
                }
                if (!isValidPhone(phone)) {
                    showError('phone', 'Số điện thoại phải bắt đầu bằng 0 và gồm đúng 10 chữ số!');
                    return false;
                }
                showError('phone', '');
                return true;
            }
            
            //Kiểm tra địa chỉ
            function validateAddress(){
                const address = document.getElementById('address').value.trim();
                
                if(!address){
                    showError('address', 'Địa chỉ không được để trống! ');
                    return false;
                }
                showError('address', '');
                return true;
            }
            // sửa ở chỗ này!!!
            function togglePassword() {
                const passwordField = document.getElementById("password");
                const eyeIcon = document.getElementById("eye-icon1");
                if (passwordField.type === "password") {
                    passwordField.type = "text";
                    eyeIcon.classList.remove("mdi-eye-off");
                    eyeIcon.classList.add("mdi-eye");
                } else {
                    passwordField.type = "password";
                    eyeIcon.classList.remove("mdi-eye");
                    eyeIcon.classList.add("mdi-eye-off");
                }
            }

            function toggleRePassword() {
                const repasswordField = document.getElementById("repassword");
                const eyeIcon = document.getElementById("eye-icon2");
                if (repasswordField.type === "password") {
                    repasswordField.type = "text";
                    eyeIcon.classList.remove("mdi-eye-off");
                    eyeIcon.classList.add("mdi-eye");
                } else {
                    repasswordField.type = "password";
                    eyeIcon.classList.remove("mdi-eye");
                    eyeIcon.classList.add("mdi-eye-off");
                }
            }



            // Kiểm tra toàn bộ form
            function validateForm() {
                return validateUsername()
                        && validateEmail()
                        && validatePassword()
                        && validateRePassword()
                        && validateFullName()
                        && validatePhone()
                &&validateAddress();
            }

            // Gắn sự kiện blur khi trang tải
            document.addEventListener('DOMContentLoaded', function () {
                const inputs = [
                    {id: 'userName', validate: validateUsername},
                    {id: 'email', validate: validateEmail},
                    {id: 'password', validate: validatePassword},
                    {id: 'repassword', validate: validateRePassword},
                    {id: 'fullName', validate: validateFullName},
                    {id: 'phone', validate: validatePhone},
                                        {id: 'address', validate: validateAddress}

                ];

                inputs.forEach(({ id, validate }) => {
                    const input = document.getElementById(id);
                    if (input) {
                        input.addEventListener('blur', validate);
                }
                });

                const form = document.querySelector('.login-form');
                if (form) {
                    form.addEventListener('submit', function (e) {
                        if (
                                !validateUsername() ||
                                !validateEmail() ||
                                !validatePassword() ||
                                !validateRePassword() ||
                                !validateFullName() ||
                                !validatePhone()||
                                !validateAddress()
                                ) {
                            e.preventDefault(); // chặn submit nếu có lỗi
                        }
                    });
                }
            });
        </script>
        <!-- javascript -->
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <!-- Icons -->
        <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>

    </body>

</html>

