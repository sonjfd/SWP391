<%-- 
    Document   : login
    Created on : May 26, 2025, 10:50:39 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Icons -->
        <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- Css -->
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />

    </head>

    <body>
         
    
         <c:if test="${not empty sessionScope.successMessage}">
            <script>
                alert("${sessionScope.successMessage}");
            </script>
            <%-- Xóa thông báo sau khi hiển thị --%>
            <% session.removeAttribute("successMessage"); %>
        </c:if>
            <div class="back-to-home rounded d-none d-sm-block">
                <a href="${pageContext.request.contextPath}/homepage" class="btn btn-icon btn-primary"><i data-feather="home" class="icons"></i></a>
            </div>
        <!-- Hero Start -->
        <section class="bg-home d-flex  align-items-center" style="background: url('${pageContext.request.contextPath}/assets/images/bg/bg-lines-one.png'); background-position: center; background-color: #87CEFA;">
            
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-5 col-md-8">

                        <div class="card login-page shadow shadow mt-5 rounded-4 border-0 px-4 py-3" style="background-color: #CAE1FF;">
                            <div class="card-body">
                                <h4 class="text-center">Đăng nhập</h4>  
                                <form action="login" method="POST" class="login-form mt-4">
                                    <div class="row">
                                        <c:if test="${not empty error}">
                                            <div class="alert alert-danger" role="alert">
                                                ${error}
                                            </div>
                                        </c:if>
                                        <div class="col-lg-12">
                                            <div class="mb-3">
                                                <label class="form-label">Tên tài khoản hoặc Email <span class="text-danger">*</span></label>
                                                <div class="input-group">
                                                    <span class="input-group-text"><i class="bi bi-person"></i></span>
                                                    <input type="text" class="form-control" placeholder="Tên tài khoản hoặc email" name="identifier" value="${savedUser != null ? savedUser : ''}" required="">
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-lg-12">
                                            <div class="mb-3">
                                                <label class="form-label">Mật khẩu <span class="text-danger">*</span></label>
                                                <div class="input-group">
                                                    <span class="input-group-text"><i class="bi bi-lock"></i></span>
                                                    <input type="password" class="form-control" id="password" placeholder="Nhập mật khẩu..." name="password" value="${savedPass != null ? savedPass : ''}" required="">
                                                    <span class="input-group-text" onclick="togglePassword()" style="cursor: pointer;">
                                                        <i class="mdi mdi-eye-off" id="eye-icon"></i>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-lg-12">
                                            <div class="d-flex justify-content-lg-end">
                                               
                                                <a href="requestPassword" class="text-dark h6 mb-0 text-decoration-underline">Quên mật khẩu ?</a>
                                            </div>
                                        </div>
                                        <div class="col-lg-12 mb-0">
                                            <div class="d-grid">
                                                <button class="btn btn-primary">Đăng nhập</button>
                                            </div>
                                        </div>

                                        <div class="col-lg-12 mt-3 text-center">
                                            <h6 class="text-muted">Hoặc</h6>
                                        </div><!--end col-->



                                        <div class="col-12 mt-3">
                                            <div class="d-grid">
                                                <a href="https://accounts.google.com/o/oauth2/auth?scope=email profile openid&redirect_uri=http://localhost:8080/SWP391/googleLogin&client_id=119187699944-nkcoopiecro3apg07543e80or1b5cpj5.apps.googleusercontent.com&response_type=code&approval_prompt=force" class="btn btn-soft-danger">
                                                    <i class="uil uil-google"></i> Google
                                                </a>

                                            </div>
                                        </div><!--end col-->

                                        <div class="col-12 text-center">
                                            <p class="mb-0 mt-3"><small class="text-dark me-2">Chưa có tài khoản ?</small> <a href="register" class="text-dark fw-bold text-decoration-underline">Đăng kí</a></p>
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
            function togglePassword() {
                const passwordField = document.getElementById("password");
                const eyeIcon = document.getElementById("eye-icon");
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
        </script>
     
        <!-- javascript -->
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <!-- Icons -->
        <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>

    </body>

</html>

