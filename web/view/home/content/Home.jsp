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
        <style>

            .slider-wrapper {
                border-radius: 16px;
                overflow: hidden;
                box-shadow: 0 6px 20px rgba(0,0,0,0.08);
            }

            .carousel-indicators li {
                width: 10px;
                height: 10px;
                border-radius: 50%;
                background-color: #fff;
                opacity: 0.6;
                margin: 0 5px;
            }

            .carousel-indicators .active {
                opacity: 1;
                background-color: #4CAF50; /* Xanh Pet24h hoặc chọn màu thương hiệu */
            }

            .carousel-caption {
                background: rgba(0,0,0,0.5);
                border-radius: 8px;
                padding: 12px 16px;
            }

            .carousel-control-prev-icon,
            .carousel-control-next-icon {
                background-size: 50% 50%;
            }

            .card {
                border-radius: 12px;
                transition: all 0.3s ease;
                box-shadow: 0 2px 8px rgba(0,0,0,0.06);
            }

            .card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 20px rgba(0,0,0,0.10);
            }

            .card-img-top {
                border-top-left-radius: 12px;
                border-top-right-radius: 12px;
            }

            .card-title {
                font-size: 16px;
                font-weight: 700;
                color: #1d1d1d;
            }

            .btn-green {
                background-color: #4CAF50; /* màu xanh Pet24h */
                color: white;
                padding: 8px 16px;
                border-radius: 30px;
                font-weight: 600;
                font-size: 14px;
                text-decoration: none;
                display: inline-block;
                transition: background-color 0.2s ease;
                border: none;
            }

            .btn-green:hover {
                background-color: #43a047;
            }
            /* Optional để bài nổi bật đẹp hơn */
            .bg-opacity-90 {
                background-color: rgba(255, 255, 255, 0.9) !important;
            }


        </style>

    </head>




    <body>
        <%@include file="../layout/Header.jsp" %>




        <!-- Start Hero -->
        <section class="section pt-0 " style="margin-top: 100px ">
            <div class="container mt-4 " >
                <div class="slider-wrapper shadow rounded-4 overflow-hidden">
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
                                        <img src="${pageContext.request.contextPath}/${slider.imageUrl}" 
                                             class="d-block w-100" 
                                             style="max-height:450px; object-fit:cover;" 
                                             >


                                    </a>
                                </div>
                            </c:forEach>
                        </div>

                        <!-- Controls -->
                        <a class="carousel-control-prev" href="#slider-banner-bootstrap" role="button" data-bs-slide="prev">
                            <span class="carousel-control-prev-icon bg-dark bg-opacity-50 rounded-circle p-2" aria-hidden="true"></span>
                            <span class="visually-hidden">Previous</span>
                        </a>
                        <a class="carousel-control-next" href="#slider-banner-bootstrap" role="button" data-bs-slide="next">
                            <span class="carousel-control-next-icon bg-dark bg-opacity-50 rounded-circle p-2" aria-hidden="true"></span>
                            <span class="visually-hidden">Next</span>
                        </a>
                    </div>
                </div>
            </div>
        </section>

        <!-- End Hero -->



        <!-- DANH MỤC THÚ CƯNG Start -->
        <section class="section bg-light">
            <div class="container">
                <div <section class="section bg-light pt-5 pb-5">

                    <h4 class="title mb-3">Dành cho mọi loài thú cưng</h4>
                    <p class="text-muted">Phòng khám Pet24H chuyên chăm sóc và điều trị cho mọi loài thú cưng phổ biến nhất.</p>
                </div>

                <div class="row g-4">
                    <c:forEach var="species" items="${speciesList}">
                        <div class="col-md-4 col-sm-6">
                            <div class="card border-0 shadow-sm h-100 rounded-3 overflow-hidden">
                                <!-- Ảnh top -->
                                <img src="${pageContext.request.contextPath}/assets/images/species/${species.name}.png"
                                     alt="${species.name}" 
                                     class="card-img-top" 
                                     style="height:220px; object-fit:cover;">

                                <!-- Nội dung -->
                                <div class="card-body">
                                    <h6 class="card-title mb-2 fw-bold text-dark text-uppercase" style="font-size: 15px;">
                                        ${species.name}
                                    </h6>
                                    <p class="card-text text-muted small" style="font-size: 14px; line-height: 1.5;">
                                        <c:forEach var="breed" items="${species.breeds}" varStatus="status">
                                            <span>${breed.name}</span><c:if test="${!status.last}">, </c:if>
                                        </c:forEach>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>
        <!-- DANH MỤC THÚ CƯNG End -->


        <!-- ĐỘI NGŨ BÁC SĨ Start -->
        <section class="section bg-light">
            <div class="container">
                <div class="section-title text-center mb-5">
                    <h4 class="title mb-3">Đội ngũ bác sĩ</h4>
                    <p class="text-muted">Đội ngũ bác sĩ giàu kinh nghiệm và tận tâm của Pet24H.</p>
                </div>

                <div class="row g-4">
                    <c:forEach var="doctor" items="${doctors}">
                        <div class="col-lg-3 col-md-4 col-sm-6">
                            <div class="card border-0 shadow-sm h-100 rounded-3 overflow-hidden d-flex flex-column">
                                <!-- Ảnh top -->
                                <img src="${pageContext.request.contextPath}/${doctor.user.avatar}" 
                                     alt="${doctor.user.fullName}" 
                                     class="card-img-top" 
                                     style="height:220px; object-fit:cover;">

                                <!-- Nội dung -->
                                <div class="card-body d-flex flex-column">
                                    <h6 class="card-title mb-2 fw-bold text-dark" style="font-size: 16px;">
                                        ${doctor.user.fullName}
                                    </h6>
                                    <p class="text-muted small mb-1" style="font-size: 14px;">
                                        ${doctor.specialty}
                                    </p>
                                    <p class="text-muted small mb-2" style="font-size: 14px;">
                                        ${doctor.yearsOfExperience} năm kinh nghiệm
                                    </p>

                                    <!-- Nút -->
                                    <a href="booking-by-doctor?doctorId=${doctor.user.id}" 
                                       class="btn btn-green mt-auto w-100">
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
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h4 class="title mb-0">Tin tức</h4>
                    <a href="homeblog" class="text-primary fw-bold">Xem tất cả &gt;</a>
                </div>

                <div class="row g-4">
                    <!-- BÀI VIẾT NỔI BẬT BÊN TRÁI -->
                    <div class="col-lg-6">
                        <c:if test="${not empty blogs}">
                            <div class="position-relative rounded-4 overflow-hidden shadow-sm">
                                <img src="${pageContext.request.contextPath}/${blogs[0].image}" 
                                     alt="${blogs[0].title}" 
                                     class="img-fluid w-100" style="height:340px; object-fit:cover;">

                                <!-- Overlay title -->
                                <div class="position-absolute bottom-0 start-0 w-100 p-3 bg-white bg-opacity-90">
                                    <h6 class="fw-bold text-dark mb-1" style="font-size: 16px;">
                                        ${blogs[0].title}
                                    </h6>
                                    <p class="text-muted small mb-2" style="font-size: 14px; line-height: 1.4;">
                                        ${fn:substring(blogs[0].content, 0, 120)}...
                                    </p>
                                    <div class="text-muted small">
                                        <fmt:formatDate value="${blogs[0].publishedAt}" pattern="dd/MM/yyyy"/>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </div>

                    <!-- DANH SÁCH CÁC BÀI VIẾT NHỎ BÊN PHẢI -->
                    <div class="col-lg-6">
                        <div class="d-flex flex-column gap-3">
                            <c:forEach var="blog" items="${blogs}" begin="1" end="4">
                                <div class="d-flex gap-3 border-bottom pb-3">
                                    <img src="${pageContext.request.contextPath}/${blog.image}" 
                                         alt="${blog.title}" 
                                         style="width: 120px; height: 80px; object-fit: cover; border-radius: 8px; flex-shrink: 0;">

                                    <div class="flex-grow-1">
                                        <h6 class="fw-bold mb-1 text-dark" style="font-size: 15px;">
                                            ${blog.title}
                                        </h6>
                                        <p class="text-muted small mb-1" style="font-size: 13px;">
                                            ${fn:substring(blog.content, 0, 80)}...
                                        </p>
                                        <div class="text-muted small" style="font-size: 12px;">
                                            <fmt:formatDate value="${blog.publishedAt}" pattern="dd/MM/yyyy"/>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- BLOG / TIN TỨC MỚI NHẤT End -->



        <%@include file="../layout/Footer.jsp" %>

        <script>


<!-- javascript -->
               <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
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
