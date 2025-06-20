<%-- 
    Document   : ResetPassword
    Created on : Jun 8, 2025, 11:54:30 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />

        <title>Doctris - Doctor Appointment Booking System</title>

        <title>Hệ Thống Khám Thú Cưng</title>

        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
        <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
        <meta name="author" content="Shreethemes" />
        <meta name="email" content="support@shreethemes.in" />
        <meta name="website" content="https://shreethemes.in" />
        <meta name="Version" content="v1.2.0" />
        <!-- favicon -->
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico.png">
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
        <section class="bg-home d-flex  align-items-center" style="background: #87CEFA url('${pageContext.request.contextPath}/assets/images/bg/bg-lines-one.png') center;">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-5 col-md-8">

                        <div class="card login-page  shadow mt-4 rounded border-0" style="background-color: #CAE1FF;">
                            <div class="card-body">
                                <h4 class="text-center">Cấp lại mật khẩu</h4>  
                                <form class="login-form mt-4" method="post" action="resetPassword">
                                    <div class="row">
                                        <div class="mb-3">
                                            <label class="form-label">Email <span class="text-danger">*</span></label>
                                            <div class="input-group">
                                                    <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                                            <!-- Hiển thị email, không cho sửa -->
                                            <input type="email"
                                                   class="form-control"
                                                   id="email"
                                                   name="email"
                                                   value="${email}"    <!-- tự động điền giá trị từ servlet -->
                                            </div>
                                        </div>

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

                                        <div class="col-lg-12">
                                            <div class="d-grid">
                                                <button class="btn btn-primary">Cấp lại</button>
                                            </div>
                                        </div>
                                        
                                    </div>
                                </form>
                                <p class="text-danger text-center">${mess}</p>
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


            // Hiển thị lỗi
            function showError(inputId, message) {
                const errorElement = document.getElementById(inputId + 'Error');
                if (errorElement) {
                    errorElement.textContent = message;
                    errorElement.style.display = message ? 'block' : 'none';
                }
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

            // Kiểm tra password ≥ 6 ký tự, trong đấy có ít nhất 1 chữ hoa, thường, ký tự đặc biệt, số
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
                return  validateEmail()
                        && validatePassword()
                        && validateRePassword()

            }

            // Gắn sự kiện blur khi trang tải
            document.addEventListener('DOMContentLoaded', function () {
                const inputs = [

                    {id: 'email', validate: validateEmail},
                    {id: 'password', validate: validatePassword},
                    {id: 'repassword', validate: validateRePassword},
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
                                !validateEmail() ||
                                !validatePassword() ||
                                !validateRePassword()


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

