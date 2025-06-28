<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico.png">
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/tiny-slider.css"/>
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

        <style>
            .pet-hero-solid {
                background-color: #0047AB;
                padding: 80px 0 40px;
                text-align: center;
            }
            .hero-heading {
                font-size: 36px;
                font-weight: 700;
                color: #fff;
            }
            .breadcrumb-text {
                font-size: 15px;
                color: #fff;
            }
            .featured-img {
                width: 100%;
                height: 340px;
                object-fit: cover;
                border-radius: 16px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.06);
            }
            .featured-title {
                font-size: 24px;
                font-weight: 700;
                color: #333;
                padding: 0;
                border-radius: 0;
                display: block;
            }
            .btn-green {
                background-color: #4CAF50;
                color: white;
                padding: 10px 24px;
                border-radius: 30px;
                font-weight: 600;
                text-decoration: none;
                transition: background 0.2s ease;
                display: inline-block;
            }
            .btn-green:hover {
                background-color: #43a047;
            }
            .news-img {
                width: 100%;
                height: 150px;
                object-fit: cover;
                border-radius: 12px;
                transition: transform 0.2s ease;
            }
            .news-card {
                background-color: #003366;
                color: white;
                border-radius: 12px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
                transition: 0.3s;
            }
            .news-card:hover {
                transform: translateY(-4px);
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
            }
            .news-card h6,
            .news-card p,
            .news-card a {
                color: white !important;
            }
            .news-card a.text-orange {
                color: #FFB74D !important;
            }
            .text-orange {
                color: #FF6A00;
            }
            .text-blue {
                color: #0030FF;
            }
            @media (max-width: 768px) {
                .news-img {
                    height: 130px;
                }
            }
        </style>
    </head>
    <body>
        <%@include file="../layout/Header.jsp" %>
        <section class="pet-hero-solid" style="margin-top: 100px">
            <div class="container text-center">
                <h2 class="hero-heading">Tin tức</h2>
                <p class="breadcrumb-text">Trang chủ / Tin tức</p>
            </div>
        </section>
        
        <c:choose>
            <c:when test="${not empty blogs}">
                <section class="featured-news container py-5">
                    <div class="row align-items-center gx-5">
                        <div class="col-md-6">
                            <img src="${pageContext.request.contextPath}/${blogs[0].image}" class="featured-img img-fluid rounded-4 shadow-sm" alt="Main blog image">
                        </div>
                        <div class="col-md-6">
                            <p class="text-orange small mb-1">
                                <fmt:formatDate value="${blogs[0].publishedAt}" pattern="dd/MM/yyyy"/>
                            </p>
                            <h3 class="featured-title">${blogs[0].title}</h3>
                            <p class="text-muted mt-3">${fn:substring(blogs[0].content, 0, 240)}...</p>
                            <a href="blog-detail?id=${blogs[0].id}" class="btn-green mt-2">Xem thêm <span>&#8594;</span></a>
                        </div>
                    </div>
                </section>
            </c:when>
            <c:otherwise>
                <p class="text-center text-muted py-5">Không có bài blog nào.</p>
            </c:otherwise>
        </c:choose>
        <section class="container pb-5">
            <h4 class="text-blue fw-bold mb-4">TIN MỚI</h4>
            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-4">
                <c:forEach var="blog" items="${blogs}" varStatus="loop" begin="1">
                    <div class="col">
                        <div class="news-card p-3 h-100">
                            <img src="${pageContext.request.contextPath}/${blog.image}" class="news-img mb-2" alt="Blog Image">
                            <p class="text-muted small mb-1">BẢN TIN BỆNH VIỆN</p>
                            <p class="text-orange small mb-1">
                                <fmt:formatDate value="${blog.publishedAt}" pattern="dd/MM/yyyy" />
                            </p>
                            <h6 class="fw-bold mb-1">${blog.title}</h6>
                            <p class="text-muted small mb-2">${fn:substring(blog.content, 0, 100)}...</p>
                            <a href="blog-detail?id=${blog.id}" class="text-orange small">Xem thêm →</a>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div class="row mt-5">
                <div class="col-12">
                    <h6 class="mb-3">CÁC THẺ ĐỀ XUẤT</h6>
                    <div class="d-flex flex-wrap gap-2 mb-4">
                        <c:forEach var="tag" items="${allTags}">
                            <a href="homeblog?tag=${tag.id}" class="badge bg-light text-dark me-2 mb-2 ${selectedTag == tag.id ? 'border border-primary' : ''}">
                                ${tag.name}
                            </a>
                        </c:forEach>
                    </div>
                </div>

            </div>
        </section>

        <div class="col-12">
            <nav class="mt-4">
                <ul class="pagination justify-content-center">
                    <li class="page-item ${index == 1 ? 'disabled' : ''}">
                        <a class="page-link" href="homeblog?index=${index - 1}&tag=${selectedTag}">Prev</a>
                    </li>
                    <c:forEach var="i" begin="1" end="${endP}">
                        <li class="page-item ${index == i ? 'active' : ''}">
                            <a class="page-link" href="homeblog?index=${i}&tag=${selectedTag}">${i}</a>
                        </li>
                    </c:forEach>
                    <li class="page-item ${index == endP ? 'disabled' : ''}">
                        <a class="page-link" href="homeblog?index=${index + 1}&tag=${selectedTag}">Next</a>
                    </li>
                </ul>
            </nav>
        </div>

        <a href="#" onclick="topFunction()" id="back-to-top" class="btn btn-icon btn-pills btn-primary back-to-top"><i data-feather="arrow-up" class="icons"></i></a>
            <%@include file="../layout/Footer.jsp" %>
        <script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/tiny-slider.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/tiny-slider-init.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
    </body>