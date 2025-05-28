    <%-- 
    Document   : home
    Created on : May 19, 2025, 10:23:09 PM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>PET24H - Hệ thống đặt lịch phòng khám thú cưng</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
        <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
        <meta name="author" content="Shreethemes" />
        <meta name="email" content="support@shreethemes.in" />
        <meta name="website" content="${pageContext.request.contextPath}/index.html" />
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
        <section class="bg-half-170 pb-0 d-table w-100">
            <div class="container mt-4">
                <div class="slider-wrapper">
                    <div id="slider-banner-bootstrap" class="carousel slide" data-bs-ride="carousel" data-bs-interval="4000">
                        <!-- Indicators -->
                        <ol class="carousel-indicators">
                            <c:forEach var="slider" items="${sliders}" varStatus="status">
                                <li data-bs-target="#slider-banner-bootstrap" data-bs-slide-to="${status.index}" class="${status.first ? 'active' : ''}"></li>
                                </c:forEach>
                        </ol>
                        <!-- Slides -->
                        <div class="carousel-inner">
                            <c:forEach var="slider" items="${sliders}" varStatus="status">
                                <div class="carousel-item ${status.first ? 'active' : ''}">
                                    <a href="${slider.link}" <c:if test="${empty slider.link}">onclick="return false;"</c:if>>
                                        <img src="${pageContext.request.contextPath}/${slider.imageUrl}" class="d-block w-100 rounded" style="max-height:410px;object-fit:cover;" alt="${slider.title}">
                                        <c:if test="${not empty slider.title or not empty slider.description}">
                                            <div class="carousel-caption d-none d-md-block" style="background: rgba(0,0,0,0.5); border-radius: 8px;">
                                                <c:if test="${not empty slider.title}"><h5>${slider.title}</h5></c:if>
                                                <c:if test="${not empty slider.description}"><p>${slider.description}</p></c:if>
                                                </div>
                                        </c:if>
                                    </a>
                                </div>
                            </c:forEach>
                        </div>
                        <!-- Controls -->
                        <a class="carousel-control-prev" href="#slider-banner-bootstrap" role="button" data-bs-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Previous</span>
                        </a>
                        <a class="carousel-control-next" href="#slider-banner-bootstrap" role="button" data-bs-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Next</span>
                        </a>
                    </div>
                </div>
            </div>
        </section>
        <!-- End Hero -->

        <!-- Partners Start -->
        <section class="py-4 bg-light">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-2 col-md-2 col-6 text-center py-4">
                        <img src="${pageContext.request.contextPath}/assets/images/client/amazon.png" class="avatar avatar-client" alt="">
                    </div><!--end col-->
                    <div class="col-lg-2 col-md-2 col-6 text-center py-4">
                        <img src="${pageContext.request.contextPath}/assets/images/client/google.png" class="avatar avatar-client" alt="">
                    </div><!--end col-->
                    <div class="col-lg-2 col-md-2 col-6 text-center py-4">
                        <img src="${pageContext.request.contextPath}/assets/images/client/lenovo.png" class="avatar avatar-client" alt="">
                    </div><!--end col-->
                    <div class="col-lg-2 col-md-2 col-6 text-center py-4">
                        <img src="${pageContext.request.contextPath}/assets/images/client/paypal.png" class="avatar avatar-client" alt="">
                    </div><!--end col-->
                    <div class="col-lg-2 col-md-2 col-6 text-center py-4">
                        <img src="${pageContext.request.contextPath}/assets/images/client/shopify.png" class="avatar avatar-client" alt="">
                    </div><!--end col-->
                    <div class="col-lg-2 col-md-2 col-6 text-center py-4">
                        <img src="${pageContext.request.contextPath}/assets/images/client/spotify.png" class="avatar avatar-client" alt="">
                    </div><!--end col-->
                </div><!--end row-->
            </div><!--end container-->
        </section><!--end section-->
        <!-- Partners End -->

        <!-- DANH MỤC THÚ CƯNG Start -->
        <section class="section">
            <div class="container">
                <div class="section-title text-center mb-5">
                    <h4 class="title mb-3">Dành cho mọi loài thú cưng</h4>
                    <p class="text-muted">Phòng khám Pet24H chuyên chăm sóc và điều trị cho mọi loài thú cưng phổ biến nhất.</p>
                </div>
                <div class="row justify-content-center">
                    <c:forEach var="species" items="${speciesList}">
                        <div class="col-md-4 col-6 mb-4 text-center">
                            <div class="card border-0 shadow-sm py-4 px-2 h-100 d-flex justify-content-center align-items-center">
                                <img src="${pageContext.request.contextPath}/assets/images/species/${species.name}.png"
                                     alt="${species.name}" class="mb-3" style="max-width:80px;max-height:80px;">
                                <h6 class="mb-1">${species.name}</h6>
                                <div class="small text-muted">
                                    <c:forEach var="breed" items="${species.breeds}" varStatus="status">
                                        <span>${breed.name}</span><c:if test="${!status.last}">, </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>
        <!-- DANH MỤC THÚ CƯNG End -->

        <!-- ĐỘI NGŨ BÁC SĨ Start -->
        <section class="section">
            <div class="container">
                <div class="section-title text-center mb-5">
                    <h4 class="title mb-3">Đội ngũ bác sĩ</h4>
                    <p class="text-muted">Đội ngũ bác sĩ giàu kinh nghiệm và tận tâm của Pet24H.</p>
                </div>
                <div class="row">
                    <c:forEach var="doctor" items="${doctors}">
                        <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
                            <div class="card border-0 shadow text-center h-100">
                                <img src="${pageContext.request.contextPath}/${doctor.user.avatar}" 
                                     alt="${doctor.user.fullName}" 
                                     class="card-img-top mx-auto mt-3 rounded-circle" 
                                     style="width:100px;height:100px;object-fit:cover;">
                                <div class="card-body">
                                    <h6 class="card-title">${doctor.user.fullName}</h6>
                                    <div class="text-muted small">${doctor.specialty}</div>
                                    <div class="text-muted small mb-2">${doctor.yearsOfExperience} năm kinh nghiệm</div>
                                    <a href="homedoctorschedule?doctorId=${doctor.user.id}" 
                                       class="btn btn-outline-success btn-sm">
                                        Xem lịch & Đặt lịch
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>
        <!-- ĐỘI NGŨ BÁC SĨ End -->

        <!-- BLOG / TIN TỨC MỚI NHẤT Start -->
        <section class="section bg-light">
            <div class="container">
                <div class="section-title text-center mb-5">
                    <h4 class="title mb-3">Tin tức & Chia sẻ</h4>
                    <p class="text-muted">Cập nhật tin mới, kinh nghiệm chăm sóc thú cưng & ưu đãi.</p>
                </div>
                <div class="row">
                    <!-- Loop through the blogs -->
                    <c:forEach var="blog" items="${blogs}" begin="1" end="9">
                        <div class="col-md-4 mb-4">
                            <div class="card h-100 border-0 shadow rounded">
                                <div class="card-body">
                                    <h5 class="card-title">${blog.title}</h5>
                                    <div class="small text-muted mb-2">
                                        ${blog.author} - <fmt:formatDate value="${blog.publishedAt}" pattern="dd/MM/yyyy"/>
                                    </div>
                                    <div class="card-text text-muted" style="min-height:70px">
                                        ${fn:substring(blog.content,0,90)}...
                                    </div>
                                    <a href="blog-detail?id=${blog.id}" class="btn btn-link p-0 mt-2">
                                        Đọc tiếp <i class="ri-arrow-right-line"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <div class="text-center mt-4">
                    <a href="homeblog" class="btn btn-primary">Xem tất cả tin tức</a>
                </div>
            </div>
        </section>
        <!-- BLOG / TIN TỨC MỚI NHẤT End -->

<!--         TESTIMONIALS Start 
        <section class="section">
            <div class="container">
                <div class="section-title text-center mb-5">
                    <h4 class="title mb-3">Khách hàng nói gì về Pet24H?</h4>
                </div>
                <div class="row justify-content-center">
                    <div class="col-md-8">
                        <div id="testimonialCarousel" class="carousel slide" data-bs-ride="carousel">
                            <div class="carousel-inner">
                                <div class="carousel-item active text-center">
                                    <img src="${pageContext.request.contextPath}/assets/images/customers/customer1.jpg" class="rounded-circle mb-3" width="80">
                                    <blockquote class="blockquote">
                                        <p>Pet24H chăm sóc cho bé mèo nhà mình rất tận tâm, bác sĩ nhiệt tình và chuyên môn cao.</p>
                                        <footer class="blockquote-footer">Nguyễn Thị A, chủ nhân của Mimi</footer>
                                    </blockquote>
                                </div>
                                <div class="carousel-item text-center">
                                    <img src="${pageContext.request.contextPath}/assets/images/customers/customer2.jpg" class="rounded-circle mb-3" width="80">
                                    <blockquote class="blockquote">
                                        <p>Dịch vụ khám và tiêm phòng rất nhanh, giá cả hợp lý. Bé cún nhà mình không còn sợ đi khám nữa!</p>
                                        <footer class="blockquote-footer">Trần Văn B, chủ nhân của GâuGâu</footer>
                                    </blockquote>
                                </div>
                                 Thêm các feedback khác 
                            </div>
                            <button class="carousel-control-prev" type="button" data-bs-target="#testimonialCarousel" data-bs-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Trước</span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#testimonialCarousel" data-bs-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Sau</span>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </section>-->
        <!-- TESTIMONIALS End -->


        <%@include file="../layout/Footer.jsp" %>


        <!-- javascript -->
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <!-- SLIDER -->
        <script src="${pageContext.request.contextPath}/assets/js/tiny-slider.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/tiny-slider-init.js"></script>
        <!-- Counter -->
        <script src="${pageContext.request.contextPath}/assets/js/counter.init.js"></script>
        <!-- Icons -->
        <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
    </body>
</html>
