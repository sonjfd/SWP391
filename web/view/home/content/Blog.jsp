<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>

        <meta charset="utf-8" />
        <title>PET24H - Tin tức</title>
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
        <!-- SLIDER -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/tiny-slider.css"/>
        <!-- Css -->
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />

    </head>
    <body>
        <%@include file="../layout/Header.jsp" %>
        <!-- Start Hero -->
        <section class="bg-half-170 d-table w-100" style="background: url('${pageContext.request.contextPath}/assets/images/bg/aboutus.jpg') center center;">
            <div class="bg-overlay bg-overlay-dark"></div>
            <div class="container">
                <div class="row mt-5 justify-content-center">
                    <div class="col-12">
                        <div class="section-title text-center">
                            <h3 class="sub-title mb-4 text-white title-dark">Tin tức</h3>
                            <p class="para-desc mx-auto text-white-50">
                                Cập nhật những thông tin mới nhất về chăm sóc thú cưng, kiến thức thú y, mẹo nuôi dưỡng và các hoạt động tại phòng khám. Đồng hành cùng bạn trên hành trình chăm sóc sức khỏe cho người bạn bốn chân của mình.
                            </p>


                            <nav aria-label="breadcrumb" class="d-inline-block mt-3">
                                <ul class="breadcrumb bg-light rounded mb-0 py-1 px-2">
                                    <li class="breadcrumb-item"><a href="homepage">Pet24h</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Tin tức</li>
                                </ul>
                            </nav>
                        </div>
                    </div><!--end col-->
                </div><!--end row-->
            </div><!--end container-->
        </section><!--end section-->
        <div class="position-relative">
            <div class="shape overflow-hidden text-white">
                <svg viewBox="0 0 2880 48" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M0 48H1437.5H2880V0H2160C1442.5 52 720 0 720 0H0V48Z" fill="currentColor"></path>
                </svg>
            </div>
        </div>
        <!-- End Hero -->

        <!-- Start -->
        <!-- Blogs Section Start -->
        <section class="section">
            <div class="container">
                <div class="row">
                    <!-- JSTL Loop for displaying blogs -->
                    <c:forEach var="blog" items="${blogs}">
                        <div class="col-lg-4 col-md-6 col-12 mb-4 pb-2">
                            <div class="card blog blog-primary border-0 shadow rounded overflow-hidden">
                                <img src="${pageContext.request.contextPath}/assets/images/Blog.png" class="img-fluid" alt="${blog.title}">
                                <div class="card-body p-4">
                                    <ul class="list-unstyled mb-2">
                                        <li class="list-inline-item text-muted small me-3">
                                            <i class="uil uil-calendar-alt text-dark h6 me-1"></i>
                                        <fmt:formatDate value="${blog.publishedAt}" pattern="dd/MM/yyyy"/>
                                        </li>
                                        <li class="list-inline-item text-muted small">
                                            <i class="uil uil-clock text-dark h6 me-1"></i>5 min read
                                        </li>
                                    </ul>
                                    <a href="blog-detail?id=${blog.id}" class="text-dark title h5">${blog.title}</a>
                                    <div class="post-meta d-flex justify-content-between mt-3">
                                        <ul class="list-unstyled mb-0">
                                            <li class="list-inline-item me-2 mb-0">
                                                <a href="#" class="text-muted like"><i class="mdi mdi-heart-outline me-1"></i>33</a>
                                            </li>
                                            <li class="list-inline-item">
                                                <a href="#" class="text-muted comments"><i class="mdi mdi-comment-outline me-1"></i>08</a>
                                            </li>
                                        </ul>
                                        <a href="blog-detail?id=${blog.id}" class="link">Read More <i class="mdi mdi-chevron-right align-middle"></i></a>
                                    </div>
                                </div>
                            </div>
                        </div><!--end col-->
                    </c:forEach>
                </div>

                <!-- Pagination Start -->
                <div class="row text-center">
                    <div class="col-12">
                        <ul class="pagination justify-content-center mb-0">

                            <!-- Prev button -->
                            <li class="page-item ${param.index == 1 || param.index == null ? 'disabled' : ''}">
                                <a class="page-link" href="homeblog?index=${param.index - 1}" aria-label="Previous">Prev</a>
                            </li>

                            <!-- Page numbers -->
                            <c:forEach var="i" begin="1" end="${requestScope.endP}">
                                <li class="page-item ${param.index == i || (param.index == null && i == 1) ? 'active' : ''}">
                                    <a class="page-link" href="homeblog?index=${i}">${i}</a>
                                </li>
                            </c:forEach>

                            <!-- Next button -->
                            <li class="page-item ${param.index >= requestScope.endP ? 'disabled' : ''}">
                                <a class="page-link" href="homeblog?index=${param.index + 1}" aria-label="Next">Next</a>
                            </li>

                        </ul><!--end pagination-->
                    </div><!--end col-->
                </div><!--end row-->
                <!-- Pagination End -->
            </div><!--end container-->
        </section><!--end section-->
        <!-- End Blogs Section -->
        <!-- End -->



        <!-- Back to top -->
        <a href="#" onclick="topFunction()" id="back-to-top" class="btn btn-icon btn-pills btn-primary back-to-top"><i data-feather="arrow-up" class="icons"></i></a>
        <!-- Back to top -->





        <%@include file="../layout/Footer.jsp" %>

        <!-- javascript -->

        <script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <!-- SLIDER -->
        <script src="${pageContext.request.contextPath}/assets/js/tiny-slider.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/tiny-slider-init.js"></script>
        <!-- Icons -->
        <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
    </body>
</html>
