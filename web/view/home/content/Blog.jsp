<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        <section class="py-5">
            <div class="container">
                <div class="row">
                    <!-- LEFT: Blog Posts -->
                    <div class="col-lg-8">
                        <c:forEach var="blog" items="${blogs}">
                            <div class="card mb-4 shadow-sm">
                                <div class="card-body d-flex">
                                    <div class="flex-grow-1">
                                        <h5 class="card-title"><a href="blog-detail?id=${blog.id}" class="text-dark">${blog.title}</a></h5>
                                        <p class="card-text text-muted">${fn:substring(blog.content, 0, 100)}...</p>
                                        <small class="text-muted">
                                            <i class="bi bi-clock"></i>
                                            <fmt:formatDate value="${blog.publishedAt}" pattern="dd/MM/yyyy" />
                                        </small>
                                        <div class="mt-2">
                                            <c:forEach var="tag" items="${blog.tags}">
                                                <a href="homeblog?tag=${tag.id}" class="badge bg-light text-dark border me-1">${tag.name}</a>
                                            </c:forEach>
                                        </div>
                                    </div>
                                    <img src="${pageContext.request.contextPath}/${blog.image}" class="ms-3" style="width: 120px; height: 90px; object-fit: cover;" alt="img">
                                </div>
                            </div>
                        </c:forEach>

                        <!-- Pagination -->
                        <nav class="mt-4">
                            <!-- Pagination -->
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

                    <!-- RIGHT: Tag Suggestions -->
                    <div class="col-lg-4">
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
            </div>
        </section>
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
