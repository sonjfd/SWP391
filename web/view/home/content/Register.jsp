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
        <title>Pet24h - Đăng kí</title>
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
        <section class="bg-half-100 d-table w-100 bg-light" style="background: url('${pageContext.request.contextPath}/assets/images/bg/bg-lines-one.png') center;">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-5 col-md-8">
                        <img src="${pageContext.request.contextPath}/assets/images/logo-dark.png" height="24" class="mx-auto d-block" alt="">
                        <div class="card login-page bg-white shadow mt-4 rounded border-0">
                            <div class="card-body">
                                <h4 class="text-center">Đăng kí</h4>  
                                <form action="register"  method="POST" class="login-form mt-4">
                                    <div class="row">
                                        <div class="col-md-12 ">
                                            <div class="mb-3 ">                                               
                                                <label class="form-label text-center">Họ và Tên<span class="text-danger">*</span></label>
                                                <input type="text" class="form-control" id="fullName" placeholder="Nhập họ và tên ..." name="name" required="">
                                                 <small id="fullNameError" class="error" style="color:red; display:none;"></small>
                                            </div>
                                        </div>

                                        <div class="col-md-12">
                                            <div class="mb-3">
                                                <label class="form-label">Email <span class="text-danger">*</span></label>
                                                <input type="email" class="form-control" id="email" placeholder="Nhập Email..." name="email" required="">
                                                <small id="emailError" class="error" style="color:red; display:none;"></small>
                                            </div>
                                        </div>

                                        <div class="col-md-12">
                                            <div class="mb-3">
                                                <label class="form-label">Số Điện Thoại <span class="text-danger">*</span></label>
                                                <input type="number" class="form-control"  id="phone"placeholder="Nhập số điện thoại ..." name="phone" required="">
                                                 <small id="phoneError" class="error" style="color:red; display:none;"></small>
                                            </div>
                                        </div>

                                        <!--                                        <div class="col-md-12">
                                                                                    <div class="mb-3">
                                                                                        <label class="form-label">Giới tính <span class="text-danger">*</span></label><br>
                                        
                                                                                        <div class="form-check form-check-inline">
                                                                                            <input class="form-check-input" type="radio" name="gender" id="male" value="male" Checked>
                                                                                            <label class="form-check-label" for="male">Nam</label>
                                                                                        </div>
                                        
                                                                                        <div class="form-check form-check-inline">
                                                                                            <input class="form-check-input" type="radio" name="gender" id="female" value="female" >
                                                                                            <label class="form-check-label" for="female">Nữ</label>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>-->

                                        <div class="col-md-12">
                                            <div class="mb-3">
                                                <label class="form-label">Địa chỉ <span class="text-danger">*</span></label>
                                                <input type="Text" class="form-control" placeholder="Nhập địa chỉ ..." name="address" required="">
                                            </div>
                                        </div>

                                        <div class="col-md-12">
                                            <div class="mb-3">
                                                <label class="form-label">Tên tài khoản<span class="text-danger">*</span></label>
                                                <input type="text" class="form-control" id="userName" placeholder="Nhập tên tài khoản ..." name="username" required="">
                                                 <small id="userNameError" class="error" style="color:red; display:none;"></small>
                                            </div>
                                        </div>   

                                        <div class="col-md-12">
                                            <div class="mb-3">
                                                <label class="form-label">Password <span class="text-danger">*</span></label>
                                                <input type="password" class="form-control" id="password" placeholder="Nhập mật khẩu ..." name="password" required="">
                                                <small id="passwordError" class="error" style="color:red; display:none;"></small>
                                            </div>
                                        </div>

                                        <div class="col-md-12">
                                            <div class="d-grid">
                                                <button class="btn btn-primary">Đăng kí</button>
                                            </div>
                                        </div>

                                        <div class="col-lg-12 mt-3 text-center">
                                            <h6 class="text-muted">Hoặc</h6>
                                        </div>

                                        <div class="col-12 mt-3">
                                            <div class="d-grid">
                                                <a href="javascript:void(0)" class="btn btn-soft-primary"><i class="uil uil-google"></i> Google</a>
                                            </div>
                                        </div><!--end col-->

                                        <div class="mx-auto text-center">
                                            <p class="mb-0 mt-3"><small class="text-dark me-2">Đã có tài khoản ?</small> <a href="login" class="text-dark fw-bold">Đăng nhập</a></p>
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

            // Regex kiểm tra username hợp lệ: ít nhất 3 ký tự, chỉ chứa chữ, số, _
            function isValidUsername(username) {
                return /^[a-zA-Z0-9_]{3,}$/.test(username);
            }

            // Regex kiểm tra số điện thoại: 10 số bắt đầu bằng 0 hoặc +84
            function isValidPhone(phone) {
                return /^(0\d{9})$/.test(phone);
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
                    showError('userName', 'Tên đăng nhập phải có ít nhất 3 ký tự!');
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

            // Kiểm tra password ≥ 6 ký tự
            function validatePassword() {
                const password = document.getElementById('password').value.trim();
                if (!password) {
                    showError('password', 'Mật khẩu không được để trống!');
                    return false;
                }
                if (password.length < 6) {
                    showError('password', 'Mật khẩu phải có ít nhất 6 ký tự!');
                    return false;
                }
                showError('password', '');
                return true;
            }

            // Kiểm tra họ tên
            function validateFullName() {
                const fullName = document.getElementById('fullName').value.trim();
                if (!fullName) {
                    showError('fullName', 'Họ và tên không được để trống!');
                    return false;
                }
                showError('fullName', '');
                return true;
            }

            // Kiểm tra số điện thoại
            function validatePhone() {
                const phone = document.getElementById('phone').value.trim();
                if (!phone) {
                    showError('phone', 'Số điện thoại không được để trống! số bắt đầu phải là số 0');
                    return false;
                }
                if (!isValidPhone(phone)) {
                    showError('phone', 'Số điện thoại không hợp lệ!');
                    return false;
                }
                showError('phone', '');
                return true;
            }

            // Kiểm tra toàn bộ form
            function validateForm() {
                return validateUsername()
                        && validateEmail()
                        && validatePassword()
                        && validateFullName()
                        && validatePhone();
            }

            // Gắn sự kiện blur khi trang tải
            document.addEventListener('DOMContentLoaded', function () {
                const inputs = [
                    {id: 'userName', validate: validateUsername},
                    {id: 'email', validate: validateEmail},
                    {id: 'password', validate: validatePassword},
                    {id: 'fullName', validate: validateFullName},
                    {id: 'phone', validate: validatePhone}
                ];

                inputs.forEach(({ id, validate }) => {
                    const input = document.getElementById(id);
                    if (input) {
                        input.addEventListener('blur', validate);
                }
                });
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

