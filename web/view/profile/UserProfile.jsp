<%-- 
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
        <title>Doctris - Doctor Appointment Booking System</title>
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
        </style>

    </head>

    <body>


        <!-- Navbar STart -->
        <%@include file="../home/layout/Header.jsp" %>
        <!-- Navbar End -->
<c:set var="user" value="${sessionScope.user}"/>
        <!-- Start -->
        <section class="bg-dashboard">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-xl-4 col-lg-4 col-md-5 col-12">
                        <div class="rounded shadow overflow-hidden sticky-bar">
                            <div class="card border-0">
                                <img src="${pageContext.request.contextPath}/assets/images/doctors/profile-bg.jpg" class="img-fluid" alt="">
                            </div>

                            <div class="text-center avatar-profile margin-nagative mt-n5 position-relative pb-4 border-bottom">
                                <img src="${pageContext.request.contextPath}/${user.avatar}" class="rounded-circle shadow-md avatar avatar-md-md" alt="">
                                <h5 class="mt-3 mb-1">${user.fullName}</h5>

                            </div>

                            <ul class="list-unstyled sidebar-nav mb-0">
                                <li class="navbar-item"><a href="doctor-appointment.html" class="navbar-link"><i class="ri-calendar-check-line align-middle navbar-icon"></i> Lịch hẹn</a></li>
                                <li class="navbar-item"><a href="doctor-schedule.html" class="navbar-link"><i class="ri-timer-line align-middle navbar-icon"></i>Lịch sử khám bệnh</a></li>
                                <li class="navbar-item"><a href="viewlistpet?id=${user.id}" class="navbar-link"><i class="ri-bear-smile-line align-middle navbar-icon"></i> Danh sách thú cưng</a></li>
                                <li class="navbar-item"><a href="viewuserinformation?id=${user.id}" class="navbar-link"><i class="ri-user-settings-line align-middle navbar-icon"></i> Cài đặt thông tin cá nhân</a></li>
                                <li class="navbar-item"><a href="doctor-chat.html" class="navbar-link"><i class="ri-chat-voice-line align-middle navbar-icon"></i> Trò chuyện</a></li>
                            </ul>
                        </div>
                    </div><!--end col-->

                    <div class="col-xl-8 col-lg-8 col-md-7 mt-4 pt-2 mt-sm-0 pt-sm-0">
                        <!--                        <h5 class="mb-0 pb-2">Schedule Timing</h5>-->
                        <div class="rounded shadow mt-4">
                            <div class="p-4 border-bottom">
                                <h5 class="mb-0">Personal Information :</h5>
                            </div>
                            <c:if test="${not empty sessionScope.SuccessMessage}">
                                <div class="alert alert-success" id="successAlert">${sessionScope.SuccessMessage}</div>
                                <c:remove var="SuccessMessage" scope="session"/>
                            </c:if>

                            <c:if test="${not empty sessionScope.FailMessage}">
                                <div class="alert alert-danger" id="failAlert">${sessionScope.FailMessage}</div>
                                <c:remove var="FailMessage" scope="session"/>
                            </c:if>
                            <div class="p-4">
                                <form id="updateUserForm" action="updateuserinformation" method="post" enctype="multipart/form-data">
                                    <div class="row">
                                        <div class="col-md-8">
                                         

                                            <div class="mb-3">
                                                <label class="form-label">Tên:</label>
                                                <input name="fullName" id="fullName" type="text" class="form-control" value="${user.fullName}">
                                                <span id="fullNameError" class="text-danger"></span>
                                            </div>

                                            <div class="mb-3">
                                                <label class="form-label">E-mail:</label>
                                                <input name="email" id="email" type="email" class="form-control" value="${user.email}">
                                                <span id="emailError" class="text-danger"></span>
                                            </div>

                                            <div class="mb-3">
                                                <label class="form-label">Số điện thoại:</label>
                                                <input name="phoneNumber" id="phoneNumber" type="text" class="form-control" value="${user.phoneNumber}">
                                                <span id="phoneNumberError" class="text-danger"></span>
                                            </div>

                                            <div class="mb-3">
                                                <label class="form-label">Địa chỉ:</label>
                                                <input name="address" id="address" type="text" class="form-control" value="${user.address}">
                                            </div>

                                            <div class="mb-3">
                                                <input type="submit" class="btn btn-primary" value="Lưu">
                                            </div>
                                        </div>

                                        <!-- Avatar -->
                                        <div class="col-md-4 text-center">
                                            <div class="mb-3">
                                                <img src="${pageContext.request.contextPath}/${user.avatar}" alt="Ảnh đại diện"
                                                     class="img-thumbnail rounded-circle" style="width:150px; height:150px; object-fit:cover;">
                                            </div>
                                            <div class="mb-3">
                                                <input type="file" name="avatar" id="avatar" class="form-control">
                                                <small id="fileName" class="text-muted d-block mt-1"></small>
                                                <small id="fileError" class="text-danger d-block mt-1"></small>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>

                    </div><!--end container-->
                    </section><!--end section-->
                    <!-- End -->
                    <!-- Offcanvas Start -->
                    <div class="offcanvas bg-white offcanvas-top" tabindex="-1" id="offcanvasTop">
                        <div class="offcanvas-body d-flex align-items-center align-items-center">
                            <div class="container">
                                <div class="row">
                                    <div class="col">
                                        <div class="text-center">
                                            <h4>Search now.....</h4>
                                            <div class="subcribe-form mt-4">
                                                <form>
                                                    <div class="mb-0">
                                                        <input type="text" id="help" name="name" class="border bg-white rounded-pill" required="" placeholder="Search">
                                                        <button type="submit" class="btn btn-pills btn-primary">Search</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div><!--end col-->
                                </div><!--end row-->
                            </div><!--end container-->
                        </div>
                    </div>
                    <!-- Offcanvas End -->

                    <!-- Offcanvas Start -->
                    <div class="offcanvas offcanvas-end bg-white shadow" tabindex="-1" id="offcanvasRight" aria-labelledby="offcanvasRightLabel">
                        <div class="offcanvas-header p-4 border-bottom">
                            <h5 id="offcanvasRightLabel" class="mb-0">
                                <img src="${pageContext.request.contextPath}/assets/images/logo-dark.png" height="24" class="light-version" alt="">
                                <img src="${pageContext.request.contextPath}/assets/images/logo-light.png" height="24" class="dark-version" alt="">
                            </h5>
                            <button type="button" class="btn-close d-flex align-items-center text-dark" data-bs-dismiss="offcanvas" aria-label="Close"><i class="uil uil-times fs-4"></i></button>
                        </div>
                        <div class="offcanvas-body p-4 px-md-5">
                            <div class="row">
                                <div class="col-12">
                                    <!-- Style switcher -->
                                    <div id="style-switcher">
                                        <div>
                                            <ul class="text-center list-unstyled mb-0">
                                                <li class="d-grid"><a href="javascript:void(0)" class="rtl-version t-rtl-light" onclick="setTheme('style-rtl')"><img src="${pageContext.request.contextPath}/assets/images/layouts/landing-light-rtl.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">RTL Version</span></a></li>
                                                <li class="d-grid"><a href="javascript:void(0)" class="ltr-version t-ltr-light" onclick="setTheme('style')"><img src="${pageContext.request.contextPath}/assets/images/layouts/landing-light.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">LTR Version</span></a></li>
                                                <li class="d-grid"><a href="javascript:void(0)" class="dark-rtl-version t-rtl-dark" onclick="setTheme('style-dark-rtl')"><img src="${pageContext.request.contextPath}/assets/images/layouts/landing-dark-rtl.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">RTL Version</span></a></li>
                                                <li class="d-grid"><a href="javascript:void(0)" class="dark-ltr-version t-ltr-dark" onclick="setTheme('style-dark')"><img src="${pageContext.request.contextPath}/assets/images/layouts/landing-dark.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">LTR Version</span></a></li>
                                                <li class="d-grid"><a href="javascript:void(0)" class="dark-version t-dark mt-4" onclick="setTheme('style-dark')"><img src="${pageContext.request.contextPath}/assets/images/layouts/landing-dark.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Dark Version</span></a></li>
                                                <li class="d-grid"><a href="javascript:void(0)" class="light-version t-light mt-4" onclick="setTheme('style')"><img src="${pageContext.request.contextPath}/assets/images/layouts/landing-light.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Light Version</span></a></li>
                                                <li class="d-grid"><a href="../admin/#" target="_blank" class="mt-4"><img src="${pageContext.request.contextPath}/assets/images/layouts/light-dash.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Admin Dashboard</span></a></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <!-- end Style switcher -->
                                </div><!--end col-->
                            </div><!--end row-->
                        </div>

                        <div class="offcanvas-footer p-4 border-top text-center">
                            <ul class="list-unstyled social-icon mb-0">
                                <li class="list-inline-item mb-0"><a href="https://1.envato.market/doctris-template" target="_blank" class="rounded"><i class="uil uil-shopping-cart align-middle" title="Buy Now"></i></a></li>
                                <li class="list-inline-item mb-0"><a href="https://dribbble.com/shreethemes" target="_blank" class="rounded"><i class="uil uil-dribbble align-middle" title="dribbble"></i></a></li>
                                <li class="list-inline-item mb-0"><a href="https://www.facebook.com/shreethemes" target="_blank" class="rounded"><i class="uil uil-facebook-f align-middle" title="facebook"></i></a></li>
                                <li class="list-inline-item mb-0"><a href="https://www.instagram.com/shreethemes/" target="_blank" class="rounded"><i class="uil uil-instagram align-middle" title="instagram"></i></a></li>
                                <li class="list-inline-item mb-0"><a href="https://twitter.com/shreethemes" target="_blank" class="rounded"><i class="uil uil-twitter align-middle" title="twitter"></i></a></li>
                                <li class="list-inline-item mb-0"><a href="mailto:support@shreethemes.in" class="rounded"><i class="uil uil-envelope align-middle" title="email"></i></a></li>
                                <li class="list-inline-item mb-0"><a href="../#" target="_blank" class="rounded"><i class="uil uil-globe align-middle" title="website"></i></a></li>
                            </ul><!--end icon-->
                        </div>
                    </div>
                    <!-- Offcanvas End -->

                    <!-- javascript -->
                    <script>
// Hàm kiểm tra email hợp lệ
                        function isValidEmail(email) {
                            return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
                        }

// Hàm kiểm tra username hợp lệ
                        function isValidUsername(username) {
                            return /^[a-zA-Z0-9_]{3,}$/.test(username);
                        }
                        // hàm kiểm tra fullName hợp lệ                       
                        function isValidFullname(fullname) {
                            return /^[a-zA-Z0-9_]{3,}$/.test(fullname);
                        }

// Hàm kiểm tra số điện thoại hợp lệ
                        function isValidPhoneNumber(phone) {
                            return /^0\d{9}$/.test(phone); // bắt đầu bằng 0, đủ 10 số
                        }

// Hàm hiển thị lỗi
                        function showError(inputId, message) {
                            const errorElement = document.getElementById(inputId + 'Error');
                            if (errorElement) {
                                errorElement.textContent = message;
                                errorElement.style.display = message ? 'block' : 'none';
                            }
                        }

// Hàm kiểm tra username
                        function validateUsername() {
                            const usernameInput = document.getElementById('userName');
                            const username = usernameInput.value.trim();
                            if (!username) {
                                showError('userName', 'Tên đăng nhập không được để trống!');
                                return false;
                            } else if (!isValidUsername(username)) {
                                showError('userName', 'Tên đăng nhập phải có ít nhất 3 ký tự!');
                                return false;
                            }
                            showError('userName', '');
                            return true;
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

// Hàm kiểm tra full name
                        function validateFullName() {
                            const fullNameInput = document.getElementById('fullName');
                            const fullName = fullNameInput.value.trim();

                            if (!fullName) {
                                showError('fullName', 'Họ và tên không được để trống!');
                                return false;
                            } else if (!isValidFullname(fullName)) {
                                showError('fullName', 'Họ và tên phải có ít nhất 3 ký tự!');
                                return false;
                            }

                            showError('fullName', '');
                            return true;
                        }


// Hàm kiểm tra phone number
                        function validatePhoneNumber() {
                            const phoneInput = document.getElementById('phoneNumber');
                            const phone = phoneInput.value.trim();
                            if (!phone) {
                                showError('phoneNumber', 'Số điện thoại không được để trống!');
                                return false;
                            } else if (!isValidPhoneNumber(phone)) {
                                showError('phoneNumber', 'Số điện thoại phải bắt đầu bằng 0 và có đúng 10 số!');
                                return false;
                            }
                            showError('phoneNumber', '');
                            return true;
                        }

// Hàm kiểm tra toàn bộ biểu mẫu khi submit
                        function validateForm() {
                            const isUsernameValid = validateUsername();
                            const isEmailValid = validateEmail();
                            const isFullNameValid = validateFullName();
                            const isPhoneNumberValid = validatePhoneNumber();
                            return isUsernameValid && isEmailValid && isFullNameValid && isPhoneNumberValid;
                        }

// Gắn sự kiện blur khi trang tải
                        document.addEventListener('DOMContentLoaded', function () {
                            const inputs = [
                                {id: 'userName', validate: validateUsername},
                                {id: 'email', validate: validateEmail},
                                {id: 'fullName', validate: validateFullName},
                                {id: 'phoneNumber', validate: validatePhoneNumber}
                            ];

                            inputs.forEach(({ id, validate }) => {
                                const input = document.getElementById(id);
                                if (input) {
                                    input.addEventListener('blur', () => {
                                        console.log(`Blur event triggered for ${id}`); // Debugging
                                        validate();
                                    });
                                } else {
                                    console.error(`Element with ID ${id} not found`);
                            }
                            });

                            // Gắn sự kiện change cho role_id (nếu cần)
                            const roleSelect = document.getElementById('role_id');
                            if (roleSelect) {
                                roleSelect.addEventListener('change', toggleDoctorFields);
                            }
                        });

// Hàm toggleDoctorFields (giữ nguyên nếu vẫn cần)
                        function toggleDoctorFields() {
                            const roleId = document.getElementById('role_id').value;
                            const doctorFields = document.querySelector('.doctor-fields');
                            if (doctorFields) {
                                doctorFields.style.display = roleId === '3' ? 'block' : 'none';
                            }
                        }
                    </script>
                    <script>
                        // Tự động ẩn thông báo sau 5 giây
                        setTimeout(function () {
                            const successAlert = document.getElementById('successAlert');
                            const failAlert = document.getElementById('failAlert');
                            if (successAlert) {
                                successAlert.style.display = 'none';
                            }
                            if (failAlert) {
                                failAlert.style.display = 'none';
                            }
                        }, 8000);
                    </script>

                    <script>
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


                    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
                    <!-- Icons -->
                    <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
                    <!-- Main Js -->
                    <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
                    </body>

                    </html>
