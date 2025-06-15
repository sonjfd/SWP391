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
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />

        <!-- Swiper JS -->
        <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/tiny-slider.css"/>
        <!-- Css -->
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />

    </head>
    <style>

       
        .hero-section p {
            color: #e0e0e0;
            font-size: 1rem;
            max-width: 700px;
            margin: 0 auto;
        }

        /* Thẻ card bác sĩ */
        .card.border-0.shadow-sm.h-100.rounded-3.overflow-hidden {
            transition: transform 0.3s ease;
            border-radius: 20px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.08);
            background: #fff;
        }

        .card.border-0.shadow-sm.h-100.rounded-3.overflow-hidden:hover {
            transform: translateY(-5px);
        }

        /* Ảnh bác sĩ */
        .card .card-img-top {
            height: 220px;
            object-fit: cover;
            border-bottom: 1px solid #f1f1f1;
        }

        /* Tên bác sĩ */
        .card .card-title {
            font-size: 1.05rem;
            font-weight: 600;
            color: #212529;
            margin-bottom: 0.4rem;
        }

        /* Chuyên môn + kinh nghiệm */
        .card .text-muted.small {
            font-size: 0.85rem;
            color: #666;
        }

        /* Nút đặt lịch */
        .btn.btn-green {
            background: linear-gradient(to right, #38b000, #008000);
            border: none;
            border-radius: 30px;
            padding: 10px 16px;
            font-size: 0.95rem;
            font-weight: 600;
            color: #fff;
            transition: background 0.3s ease;
        }

        .btn.btn-green:hover {
            background: linear-gradient(to right, #008000, #38b000);
            color: #fff;
        }

        h4.title {
            color: #1e3a8a; /* Xanh navy đậm – chuyên nghiệp */
            font-weight: 700;
            font-size: 1.8rem;
            letter-spacing: 0.3px;
        }

        p.text-muted {
            color: #64748b; /* Xanh dương nhạt ghi – nhẹ nhàng */
            font-size: 1rem;
            font-style: italic;
        }



    </style>


    <body>
        <%@include file="../layout/Header.jsp" %>
        <c:set var="cl" value="${sessionScope.clinicInfo}"></c:set>
            <!-- Start Hero -->
            <section class="hero-section d-flex align-items-center"
                     style="min-height: 30vh; background: linear-gradient(135deg, #0d47a1, #1976d2);"
                     >

                <div class="container text-center py-4">
                    <div class="row justify-content-center">
                        <div class="col-lg-8">
                            <img src="${pageContext.request.contextPath}/${cl.logo}" height="100" class="mb-3 shadow-sm bg-white rounded-circle p-2 border" alt="Logo Phòng Khám">
                        <h1 class="fw-bold text-dark mb-3 fs-3" style="color: #fff">
                            Gặp Gỡ Bác Sĩ Thú Y Tốt Nhất
                        </h1>
                        <p >
                            Đội ngũ bác sĩ thú y giàu kinh nghiệm, sẵn sàng hỗ trợ thú cưng của bạn kịp thời với các dịch vụ khám, điều trị và tư vấn chuyên nghiệp.
                        </p>

                    </div>
                </div>
            </div>
        </section>
        <!-- End Hero -->

        <!-- Slider Section -->
        <section class="section pt-5" >
            <div class="container">
                <div class="slider-wrapper shadow rounded-4 overflow-hidden">
                    <div id="slider-banner-bootstrap" class="carousel slide" data-bs-ride="carousel" data-bs-interval="4000">
                        <ol class="carousel-indicators">
                            <c:forEach var="slider" items="${sliders}" varStatus="status">
                                <li data-bs-target="#slider-banner-bootstrap" data-bs-slide-to="${status.index}" class="${status.first ? 'active' : ''}"></li>
                                </c:forEach>
                        </ol>
                        <div class="carousel-inner">
                            <c:forEach var="slider" items="${sliders}" varStatus="status">
                                <div class="carousel-item ${status.first ? 'active' : ''}">
                                    <a href="${slider.link}" <c:if test="${empty slider.link}">onclick="return false;"</c:if>>
                                        <img src="${pageContext.request.contextPath}/${slider.imageUrl}" class="d-block w-100" style="max-height:450px; object-fit:cover;">
                                    </a>
                                </div>
                            </c:forEach>
                        </div>
                        <a class="carousel-control-prev" href="#slider-banner-bootstrap" role="button" data-bs-slide="prev">
                            <span class="carousel-control-prev-icon bg-dark bg-opacity-50 rounded-circle p-2"></span>
                            <span class="visually-hidden">Previous</span>
                        </a>
                        <a class="carousel-control-next" href="#slider-banner-bootstrap" role="button" data-bs-slide="next">
                            <span class="carousel-control-next-icon bg-dark bg-opacity-50 rounded-circle p-2"></span>
                            <span class="visually-hidden">Next</span>
                        </a>
                    </div>
                </div>
            </div>
        </section>
        <!-- End Slider -->

        <div class="container">
            <div class="text-center mb-4">
                <h4 class="title text-primary fw-bold">Dành cho mọi loài thú cưng</h4>
                <p class="text-muted">Chăm sóc và điều trị cho mọi loài thú cưng phổ biến.</p>
            </div>

            <div class="swiper mySwiper-species">
                <div class="swiper-wrapper">
                    <c:forEach var="species" items="${speciesList}">
                        <div class="swiper-slide" style="max-width:280px;">
                            <div class="card border-0 shadow-sm h-100 rounded-3 overflow-hidden">
                                <img src="${pageContext.request.contextPath}/assets/images/species/${species.name}.png" class="card-img-top" style="height:220px; object-fit:cover;" alt="${species.name}">
                                <div class="card-body">
                                    <h6 class="card-title fw-bold text-dark text-uppercase">${species.name}</h6>
                                    <p class="card-text text-muted small">
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



            <!-- Doctors Section -->
            <section class="section py-5" id="doctors" >
                <div class="container">
                    <div class="section-title text-center mb-5">
                        <h4 class="title">Đội ngũ bác sĩ</h4>
                        <p class="text-muted">Bác sĩ giàu kinh nghiệm và tận tâm tại Pet24H.</p>
                    </div>
                    <div class="d-flex gap-4 overflow-auto flex-nowrap">
                        <c:forEach var="doctor" items="${doctors}">
                            <div style="min-width: 280px;">
                                <div class="card border-0 shadow-sm h-100 rounded-3 overflow-hidden d-flex flex-column">
                                    <img src="${pageContext.request.contextPath}/${doctor.user.avatar}" class="card-img-top" style="height:220px; object-fit:cover;" alt="${doctor.user.fullName}">
                                    <div class="card-body d-flex flex-column">
                                        <h6 class="card-title fw-bold text-dark">${doctor.user.fullName}</h6>
                                        <p class="text-muted small">${doctor.specialty}</p>
                                        <p class="text-muted small mb-3">${doctor.yearsOfExperience} năm kinh nghiệm</p>
                                        <a href="booking-by-doctor?doctorId=${doctor.user.id}" class="btn btn-green mt-auto w-100">Xem lịch & Đặt lịch</a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </section>
            <!-- End Doctors Section -->


            <!-- Testimonials -->
            <section class="section py-5">
                <div class="container">
                    <div class="section-title text-center mb-4">
                        <h4 class="title">Khách hàng nói gì?</h4>
                        <p>Chia sẻ của khách hàng giúp Pet24H hoàn thiện hơn mỗi ngày!</p>
                    </div>
                    <div class="swiper mySwiper">
                        <div class="swiper-wrapper">
                            <c:forEach var="rate" items="${listRate}">
                                <div class="swiper-slide">
                                    <div class="testimonial-item text-center p-4 shadow rounded bg-light">
                                        <i class="fa-solid fa-quote-left quote-icon mb-2"></i>
                                        <p>${rate.comment}</p>
                                        <div class="customer-info mt-3">
                                            <img src="${pageContext.request.contextPath}/assets/images/default_user.png" class="rounded-circle mb-2" width="60" height="60">
                                            <h5 class="customer-name">${rate.user.fullName}</h5>
                                            <span class="customer-role">Chủ nuôi</span>
                                            <div class="rating-stars mt-2">
                                                <c:forEach begin="1" end="${rate.satisfaction_level}" var="i">
                                                    <i class="fa fa-star text-warning"></i>
                                                </c:forEach>
                                                <c:forEach begin="${rate.satisfaction_level+1}" end="5" var="i">
                                                    <i class="fa-regular fa-star text-warning"></i>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                    </div>
                </div>
            </section>

            <div class="swiper mySwiper-blogs">
                <div class="section-title text-center mb-4">
                    <h4 class="title">Tin nổi bật</h4>

                </div>
                <div class="swiper-wrapper">
                    <c:forEach var="blog" items="${blogs}" begin="0" end="7">
                        <div class="swiper-slide" style="max-width: 280px;">
                            <div class="card border-0 shadow-sm rounded-4 h-100 blog-card position-relative">
                                <img src="${pageContext.request.contextPath}/${blog.image}" class="card-img-top" style="height:170px; object-fit:cover;" alt="${blog.title}">
                                <div class="card-body d-flex flex-column">
                                    <h6 class="card-title fw-semibold text-dark">${blog.title}</h6>
                                    <p class="text-muted small mb-2">
                                        ${blog.author.fullName} • <fmt:formatDate value="${blog.publishedAt}" pattern="dd/MM/yyyy"/>
                                    </p>
                                    <a href="blog-detail?id=${blog.id}" class="mt-auto text-decoration-none text-primary small fw-bold">
                                        Đọc tiếp <i class="ri-arrow-right-line align-middle"></i>
                                    </a>
                                </div>
                                <span class="badge bg-danger position-absolute top-0 end-0 m-2">Mới</span>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>


        </div>
    </div>





    <%@include file="../layout/Footer.jsp" %>
    <script>
        const swiper = new Swiper(".mySwiper-species", {
            slidesPerView: 1.2,
            spaceBetween: 20,
            loop: true,
            autoplay: {
                delay: 2500,
                disableOnInteraction: false
            },
            breakpoints: {
                576: {slidesPerView: 2.2},
                768: {slidesPerView: 3.2},
                992: {slidesPerView: 4}
            }
        });

        const swiperBlogs = new Swiper(".mySwiper-blogs", {
            loop: true,
            autoplay: {
                delay: 3500,
                disableOnInteraction: false
            },
            spaceBetween: 20,
            slidesPerView: 1.2,
            breakpoints: {
                576: {slidesPerView: 2.2},
                768: {slidesPerView: 3.2},
                992: {slidesPerView: 4}
            }
        });
    </script>






    <!-- javascript -->
    <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>

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
