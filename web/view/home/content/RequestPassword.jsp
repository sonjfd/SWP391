<%-- 
    Document   : ForgotPassword
    Created on : Jun 2, 2025, 10:57:53 AM
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
                        
                        <div class="card login-page shadow mt-4 rounded border-0" style="background-color: #CAE1FF;">
                            <div class="card-body">
                                <h4 class="text-center">Cấp lại mật khẩu</h4>  
                                <form class="login-form mt-4" action="requestPassword" method="POST">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <p class="text-muted text-center">Vui lòng nhập Email để nhận link thay đổi mật khẩu.</p>
                                            <div class="mb-3">
                                                <label class="form-label">Email<span class="text-danger">*</span></label>
                                                <div class="input-group">
                                                    <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                                                <input type="email" class="form-control" placeholder="Nhập email của bạn" name="email" required="">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-12">
                                            <div class="d-grid">
                                                <button class="btn btn-primary">Cấp lại mật khẩu</button>
                                            </div>
                                        </div>
                                        <div class="mx-auto text-center">
                                            <p class="mb-0 mt-3"><small class="text-dark me-2">Bạn đã nhớ mật khẩu ?</small> <a href="view/home/content/Login.jsp" class="text-dark h6 mb-0">Đăng nhập</a></p>
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
        
        <!-- javascript -->
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <!-- Icons -->
        <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
        
    </body>

</html>
