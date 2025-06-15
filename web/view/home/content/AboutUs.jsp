<%-- 
    Document   : AboutUs
    Created on : May 23, 2025, 10:54:45 AM
    Author     : ASUS
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>PET24H - Về chúng tôi</title>
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
        <style>
            .container {
                max-width: 1200px;
                margin: 0 auto;
            }
            .section-title {
                text-align: left;
                margin-top: 20px;
            }
            .clinic-logo img {
                max-width: 200px;
                border-radius: 10px;
            }
            .clinic-info-content {
                padding-left: 30px;
            }
            .clinic-info-content h4 {
                font-size: 1.5rem;
            }
            .clinic-info-content p {
                font-size: 1rem;
                color: #555;
            }
            .clinic-info-map iframe {
                width: 100%;
                height: 400px;
                border: 0;
                border-radius: 8px;
            }
            .clinic-info-content .icons {
                font-size: 20px;
                color: #ff6f61; /* Màu icon */
                cursor: pointer; /* Thêm con trỏ chuột khi hover vào icon */
            }

            .clinic-info-content p {
                font-size: 1rem;
                color: #555;
                margin-bottom: 0; /* Đảm bảo không có khoảng cách dưới */
            }

        </style>

    </head>

    <body>



        <%@include file="../layout/Header.jsp" %>

        <!-- Start Hero -->
        <section class="bg-half-170 d-table w-100 " style="background: url('${pageContext.request.contextPath}/assets/images/bg/aboutus.jpg') center center;">
            <div class="bg-overlay bg-dark opacity-75 position-absolute top-0 start-0 w-100 h-100" style="z-index:0"></div>

            <div class="container">
                <div class="row mt-5 justify-content-center">
                    <div class="col-12">
                        <div class="section-title text-center">
                            <h3 class="sub-title mb-4 text-white title-dark">Về chúng tôi</h3>
                            <p class="para-desc mx-auto text-white h5">
                                Bác sĩ rất tận tâm và chuyên môn cao – lựa chọn lý tưởng khi thú cưng của bạn cần được hỗ trợ ngay lập tức, điều trị khẩn cấp hoặc đơn giản là một buổi tư vấn chăm sóc sức khỏe.
                            </p>

                            <nav aria-label="breadcrumb" class="d-inline-block mt-3">
                                <ul class="breadcrumb bg-light rounded mb-0 py-1 px-2">
                                    <li class="breadcrumb-item"><a href="index.html">PET24H</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Về chúng tôi</li>
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
        <section class="section">

            <div class="container">
                <div class="row align-items-center">
                    <!-- Phần logo và ảnh phòng khám -->
                    <div class="col-lg-5 col-md-6">
                        <div class="clinic-logo">
                            <img src="${pageContext.request.contextPath}/${clinicInfo.logo}" class="img-fluid" alt="Logo phòng khám">
                        </div>
                    </div><!--end col-->

                    <!-- Phần thông tin phòng khám -->
                    <div class="col-lg-7 col-md-6 mt-4 mt-lg-0 pt- pt-lg-0">
                        <div class="clinic-info-content">
                            <div class="section-title">
                                <span class="badge badge-pill badge-soft-primary">Về ${clinicInfo.name}</span>
                                <h4 class="title mt-3 mb-4">Dịch vụ tốt và sức khỏe thú cưng tốt hơn của các chuyên gia của chúng tôi</h4>
                                <p class="para-desc">${clinicInfo.description}</p>
                            </div>

                            <div class="mt-4">
                                <h5>Địa chỉ:</h5>
                                <!-- Sử dụng flexbox để căn chỉnh icon và địa chỉ nằm bên cạnh nhau -->
                                <div class="d-flex align-items-center">
                                    <!-- Thêm icon bản đồ, khi bấm vào sẽ mở modal chứa Google Map -->
                                    <a href="javascript:void(0);" data-bs-toggle="modal" data-bs-target="#googleMapModal" class="text-decoration-none">
                                        <i data-feather="map-pin" class="icons mr-2"></i>
                                    </a>
                                    <!-- Địa chỉ phòng khám -->
                                    <p class="mb-0">${clinicInfo.address}</p>
                                </div>

                                <h5>Giờ làm việc:</h5>
                                <p>${clinicInfo.workingHours}</p>
                            </div>
                        </div>
                    </div><!--end col-->


                </div><!--end row-->



            </div><!--end container-->
        </section>
        <section id="services" class="section">
            <div class="container mt-100 mt-60">
                <div class="row justify-content-center">
                    <div class="col-12">
                        <div class="section-title mb-4 pb-2 text-center">
                            <span class="badge badge-pill badge-soft-primary mb-3"></span>
                            <h4 class="title mb-4">Dịch vụ y tế của chúng tôi</h4>
                        </div>
                    </div><!--end col-->
                </div><!--end row-->
                <div class="row">
                    <c:forEach var="s" items="${services}">
                        <div class="col-xl-3 col-md-4 col-12 mt-4 pt-2">
                            <div class="card features feature-primary border-0 text-center py-4">
                                <div class="mb-3">
                                    <c:choose>
                                        <c:when test="${s.name eq 'Khám tổng quát'}">
                                            <i class="ri-stethoscope-line" style="font-size: 40px; color: #ff6f61"></i>
                                        </c:when>
                                        <c:when test="${s.name eq 'Tiêm phòng'}">
                                            <i class="ri-first-aid-kit-line" style="font-size: 40px; color: #ffb347"></i>
                                        </c:when>
                                        <c:when test="${s.name eq 'Tẩy giun'}">
                                            <i class="ri-capsule-line" style="font-size: 40px; color: #40c057"></i>
                                        </c:when>
                                        <c:when test="${s.name eq 'Tắm gội'}">
                                            <i class="ri-showers-line" style="font-size: 40px; color: #228be6"></i>
                                        </c:when>
                                        <c:when test="${s.name eq 'Cắt lông'}">
                                            <i class="ri-scissors-line" style="font-size: 40px; color: #b197fc"></i>
                                        </c:when>
                                        <c:when test="${s.name eq 'Khám nội soi'}">
                                            <i class="ri-microscope-line" style="font-size: 40px; color: #ff922b"></i>
                                        </c:when>
                                        <c:when test="${s.name eq 'Phẫu thuật đơn giản'}">
                                            <i class="ri-surgical-mask-line" style="font-size: 40px; color: #63e6be"></i>
                                        </c:when>
                                        <c:when test="${s.name eq 'Phẫu thuật nâng cao'}">
                                            <i class="ri-heart-pulse-line" style="font-size: 40px; color: #f03e3e"></i>
                                        </c:when>
                                        <c:when test="${s.name eq 'Spa thú cưng'}">
                                            <i class="ri-leaf-line" style="font-size: 40px; color: #7950f2"></i>
                                        </c:when>
                                        <c:when test="${s.name eq 'Tư vấn dinh dưỡng'}">
                                            <i class="ri-restaurant-line" style="font-size: 40px; color: #fab005"></i>
                                        </c:when>
                                        <c:otherwise>
                                            <i class="ri-service-line" style="font-size: 40px; color: #aaa"></i>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <h5 class="title text-dark">${s.name}</h5>
                                <p class="text-muted mt-3">${s.description}</p>
                                <p class="text-primary fw-bold mt-2">Giá: ${s.price} VNĐ</p>
                            </div>
                        </div>
                    </c:forEach>

                </div>


            </div><!--end container-->
        </section>

        <div class="container mt-100 mt-60">
            <div class="row justify-content-center">
                <div class="col-12">
                    <div class="section-title text-center mb-4 pb-2">
                        <h4 class="title mb-4">Bác sĩ</h4>
                        <p class="text-muted mx-auto para-desc mb-0">Great doctor if you need your family member to get effective immediate assistance, emergency treatment or a simple consultation.</p>
                    </div>
                </div><!--end col-->
            </div><!--end row-->

            <div class="row align-items-center">
                <!-- Lặp qua danh sách bác sĩ -->
                <c:forEach var="doctor" items="${doctors}">
                    <div class="col-xl-3 col-lg-3 col-md-6 mt-4 pt-2">
                        <div class="card team border-0 rounded shadow overflow-hidden">
                            <div class="team-img position-relative">
                                <!-- Bạn có thể sử dụng ảnh của bác sĩ hoặc một ảnh mặc định -->
                                <img src="${pageContext.request.contextPath}/assets/images/default.png" class="img-fluid" alt="">
                                <ul class="list-unstyled team-social mb-0">
                                    <li><a href="#" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="facebook" class="icons"></i></a></li>
                                    <li class="mt-2"><a href="#" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="linkedin" class="icons"></i></a></li>
                                    <li class="mt-2"><a href="#" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="github" class="icons"></i></a></li>
                                    <li class="mt-2"><a href="#" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="twitter" class="icons"></i></a></li>
                                </ul>
                            </div>
                            <div class="card-body content text-center">
                                <!-- Hiển thị tên bác sĩ -->
                                <a href="#" class="title text-dark h5 d-block mb-0">${doctor.user.fullName}</a>
                                <small class="text-muted speciality">${doctor.specialty}</small>
                            </div>
                        </div>
                    </div><!--end col-->
                </c:forEach>
            </div><!--end row-->
        </div><!--end container-->
    </section><!--end section-->
    <!-- End -->
    


<%@include file="../layout/Footer.jsp" %>

<!-- Back to top -->
<a href="#" onclick="topFunction()" id="back-to-top" class="btn btn-icon btn-pills btn-primary back-to-top"><i data-feather="arrow-up" class="icons"></i></a>
<!-- Back to top -->

<!-- Modal để hiển thị Google Map -->
<div class="modal fade" id="googleMapModal" tabindex="-1" aria-labelledby="googleMapModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="googleMapModalLabel">Vị trí phòng khám trên Google Maps</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- Nhúng Google Map bằng iframe -->
                <iframe id="googleMapIframe" src="" width="100%" height="400" style="border: 0;" allowfullscreen="" loading="lazy"></iframe>
            </div>
        </div>
    </div>
</div>







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

<script>
    // Lắng nghe sự kiện khi modal được mở
    $('#googleMapModal').on('show.bs.modal', function (event) {
        // Lấy URL Google Map từ phần tử trong database (được truyền vào modal)
        var googleMapUrl = "${clinicInfo.googleMap}"; // lấy URL Google Map từ database

        // Cập nhật src của iframe để hiển thị bản đồ
        var modal = $(this);
        modal.find('#googleMapIframe').attr('src', googleMapUrl);
    });

    // Khi modal đóng, xóa src để ngừng tải bản đồ (tăng hiệu suất)
    $('#googleMapModal').on('hidden.bs.modal', function (event) {
        var modal = $(this);
        modal.find('#googleMapIframe').attr('src', '');
    });
</script>
</body>

</html>
