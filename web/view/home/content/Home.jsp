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
        <title>Trang chủ</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
        <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
        <meta name="author" content="Shreethemes" />
        <meta name="email" content="support@shreethemes.in" />
        <meta name="website" content="${pageContext.request.contextPath}/index.html" />
        <meta name="Version" content="v1.2.0" />
        <!-- favicon -->
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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">


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


        .card .card-img-top {
            height: 220px;
            object-fit: cover;
            border-bottom: 1px solid #f1f1f1;
        }


        .card .card-title {
            font-size: 1.05rem;
            font-weight: 600;
            color: #212529;
            margin-bottom: 0.4rem;
        }


        .card .text-muted.small {
            font-size: 0.85rem;
            color: #666;
        }


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
            color: #1e3a8a;
            font-weight: 700;
            font-size: 1.8rem;
            letter-spacing: 0.3px;
        }

        p.text-muted {
            color: #64748b;
            font-size: 1rem;
            font-style: italic;
        }

        .chat-ai-btn {
            position: fixed;
            bottom: 24px;
            right: 24px;
            z-index: 1050;
            width: 56px;
            height: 56px;
            border: none;
            background: transparent;
            padding: 0;
            cursor: pointer;
        }

        .chat-ai-icon {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 50%;
        }

        .chat-window {
            position: fixed;
            bottom: 24px;
            right: 24px;
            z-index: 1040;
            width: 320px;
            height: 420px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            display: flex;
            flex-direction: column;
            overflow: hidden;
        }

        .chat-header {
            padding: 10px;
            background: #007bff;
            color: white;
            font-weight: bold;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .close-chat-btn {
            background: none;
            border: none;
            color: white;
            font-size: 20px;
            cursor: pointer;
        }

        #chatWindow {
            display: flex;
            flex-direction: column;
            height: 400px;
            width: 300px;
        }

        #chatContent {
            flex: 1;
            overflow-y: auto;
            padding: 10px;
        }


        .message {
            margin-bottom: 10px;
            display: flex;
            align-items: flex-start;
        }

        .message.user {
            justify-content: flex-end;
        }

        .message.ai {
            justify-content: flex-start;
        }

        .message-bubble {
            max-width: 80%;
            display: flex;
            align-items: center;
            gap: 8px;
            background-color: #f1f1f1;
            padding: 10px 14px;
            border-radius: 16px;
            word-wrap: break-word;
        }

        .message.user .message-bubble {
            background-color: #007bff;
            color: white;
            border-bottom-right-radius: 0;
        }

        .message.ai .message-bubble {
            background-color: #e9ecef;
            color: #333;
            border-bottom-left-radius: 0;
        }

        .avatar {
            width: 24px;
            height: 24px;
            border-radius: 50%;
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
                            <img src="${cl.logo}" height="100" class="mb-3 shadow-sm bg-white rounded-circle p-2 border" alt="Logo Phòng Khám">
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
                                        <img src="${slider.imageUrl}" class="d-block w-100" style="max-height:450px; object-fit:cover;">
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
                                <img src="${species.imageUrl}" class="card-img-top" style="height:220px; object-fit:cover;" alt="${species.name}">
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
                        <p class="text-muted">Những bác sĩ nhiều kinh nghiệm nhất ở pet24h.</p>
                    </div>
                    <div class="d-flex gap-4 overflow-auto flex-nowrap">
                        <c:forEach var="doctor" items="${doctors}">

                            <div style="min-width: 280px;">
                                <div class="card border-0 shadow-sm h-100 rounded-3 overflow-hidden d-flex flex-column">
                                    <img src="${doctor.user.avatar}" class="card-img-top" style="height:220px; object-fit:cover;" alt="${doctor.user.fullName}">
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
                    <div class="swiper mySwiper-rating">
                        <div class="swiper-wrapper">
                            <c:forEach var="rate" items="${listRate}">
                                <div class="swiper-slide">
                                    <div class="testimonial-item text-center p-4 shadow rounded bg-light">
                                        <i class="fa-solid fa-quote-left quote-icon mb-2"></i>
                                        <p>${rate.comment}</p>
                                        <div class="customer-info mt-3">
                                            <img src="${rate.user.avatar}" class="rounded-circle mb-2" width="60" height="60">
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
                                <img src="${blog.image}" class="card-img-top" style="height:170px; object-fit:cover;" alt="${blog.title}">
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



    <!-- Nút AI -->
    <button id="chatAiBtn" class="chat-ai-btn" title="Trò chuyện với AI">
        <img src="${pageContext.request.contextPath}/assets/images/ai.png" alt="AI" class="chat-ai-icon">
    </button>

    <!-- Khung chat -->
    <div id="chatWindow" style="display:none; position: fixed; bottom: 24px; right: 24px; width: 300px; height: 400px; background: #fff; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.2); z-index: 1040; flex-direction: column;">
        <div style="background: #007bff; color: white; padding: 10px; font-weight: bold; border-radius: 8px 8px 0 0;">
            Trò chuyện với AI
            <button id="closeChatBtn" style="float: right; background: none; border: none; color: white;">&times;</button>
        </div>
        <div id="chatContent" class="chat-content" style="flex: 1; overflow-y: auto; padding: 10px;">

            <!-- Tin nhắn sẽ hiển thị ở đây -->
        </div>
        <!-- Nút hướng dẫn sử dụng -->
        <div style="text-align: center; padding: 4px;">
            <button id="guideBtn" style="background: transparent; border: none; color: #007bff; cursor: pointer; text-decoration: underline;">Xem hướng dẫn sử dụng</button>
        </div>

        <div style="display: flex; padding: 10px; border-top: 1px solid #ddd;">
            <input id="userInput" type="text" placeholder="Nhập tin nhắn..." style="flex: 1; padding: 8px; border: 1px solid #ccc; border-radius: 20px 0 0 20px;">
            <button id="sendMessageBtn" style="background: #007bff; color: white; border: none; padding: 0 16px; border-radius: 0 20px 20px 0;">
                <i class="bi bi-send"></i>
            </button>
        </div>
    </div>





    <!-- Modal hướng dẫn sử dụng -->
    <div class="modal fade" id="aiGuideModal" tabindex="-1" aria-labelledby="aiGuideLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-scrollable modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="aiGuideLabel">Hướng dẫn sử dụng Trợ lý AI - Pet24h</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                </div>
                <div class="modal-body" style="line-height: 1.7;">

                    <p class="mb-3">Trợ lý AI Pet24h giúp bạn đặt lịch khám, tra cứu thông tin sức khỏe thú cưng, theo dõi lịch sử khám và nhận tư vấn thú y 24/7.</p>

                    <h6>1. Tra cứu thông tin chăm sóc thú cưng</h6>
                    <ol>
                        <li>Gõ các câu hỏi như: <em>“Cách chăm sóc chó sau tiêm”, “Mèo bỏ ăn là bệnh gì?”, “Lịch tiêm phòng cho chó con”</em>.</li>
                        <li>AI sẽ phản hồi bằng thông tin tổng hợp từ kiến thức thú y đáng tin cậy.</li>
                        <li>Phù hợp khi bạn cần lời khuyên chăm sóc ban đầu trước khi quyết định đi khám.</li>
                    </ol>

                    <h6>2. Đặt lịch khám theo triệu chứng </h6>
                    <ol>
                        <li>Nhập mô tả triệu chứng, ví dụ: <em>“Chó bị tiêu chảy, bỏ ăn, mệt mỏi”</em>.</li>
                        <li>AI sẽ hỏi bạn muốn đặt lịch khám không.</li>
                        <li>Sau khi bạn đồng ý, AI sẽ hỏi tên thú cưng và ngày mong muốn.</li>
                        <li>Hệ thống tự động chọn bác sĩ đang làm việc và còn trống lịch vào ngày đó.</li>
                        <li>Bạn sẽ nhận xác nhận lịch hẹn ngay sau đó.</li>
                    </ol>

                    <h6>3. Đặt lịch với bác sĩ cụ thể </h6>
                    <ol>
                        <li>Nhập: <em>“Danh sách bác sĩ”</em> hoặc <em>“Xem bác sĩ”</em>.</li>
                        <li>AI sẽ hiển thị danh sách bác sĩ hiện tại kèm chuyên môn (nếu có).</li>
                        <li>Bạn chọn thú cưng, bác sĩ và ngày muốn khám.</li>
                        <li>Hệ thống sẽ kiểm tra lịch làm việc và slot trống của bác sĩ đó trong ngày bạn chọn.</li>
                        <li>
                            Kết quả:
                            <ul>
                                <li><strong>✔ Có slot trống:</strong> Hệ thống sẽ đặt lịch.</li>
                                <li><strong>✖ Full slot / không làm việc:</strong> AI sẽ thông báo và gợi ý chọn ngày khác.</li>
                            </ul>
                        </li>
                    </ol>

                    <h6>4. Xem lịch sử khám bệnh</h6>
                    <ol>
                        <li>Gõ: <em>“Xem lịch sử khám bệnh”</em> hoặc <em>“Lịch sử thú cưng”</em>.</li>
                        <li>Nếu bạn đã từng khám tại Pet24h và đang đăng nhập, AI sẽ liệt kê toàn bộ hồ sơ khám bao gồm:</li>
                        <ul>
                            <li>Thú cưng nào đã khám</li>
                            <li>Ngày khám, bác sĩ phụ trách</li>
                            <li>Triệu chứng, chẩn đoán và điều trị</li>
                        </ul>
                        <li>Nếu chưa có lịch sử, AI sẽ thông báo bạn chưa từng khám.</li>
                    </ol>

                    <h6>Lưu ý quan trọng:</h6>
                    <ul>
                        <li>Bạn cần <strong>đăng nhập</strong> để đặt lịch hoặc xem lịch sử khám.</li>
                        <li>Không thể chọn <strong>ngày khám trong quá khứ</strong>.</li>
                        <li>Nếu bạn <strong>chưa thêm thú cưng</strong>, vui lòng cập nhật hồ sơ trước khi đặt lịch.</li>
                        <li>AI có thể tự động xử lý theo triệu chứng hoặc yêu cầu cụ thể – bạn không cần dùng cú pháp cứng nhắc.</li>
                    </ul>

                    <p class="mt-4"><strong>Chúc bạn có trải nghiệm dễ dàng cùng trợ lý AI của Pet24h!</strong></p>

                </div>
            </div>
        </div>
    </div>




    <%@include file="../layout/Footer.jsp" %>
    <script>


        document.addEventListener("DOMContentLoaded", function () {
            const guideBtn = document.getElementById("guideBtn");
            if (guideBtn) {
                guideBtn.addEventListener("click", function () {
                    const modal = new bootstrap.Modal(document.getElementById("aiGuideModal"));
                    modal.show();
                });
            }
        });

        const swiperRate = new Swiper(".mySwiper-rating", {
            slidesPerView: 3,
            spaceBetween: 30,
            loop: true,
            navigation: {
                nextEl: ".swiper-button-next",
                prevEl: ".swiper-button-prev"
            },
            breakpoints: {
                0: {slidesPerView: 1},
                768: {slidesPerView: 2},
                992: {slidesPerView: 3}
            }
        });

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




    <script>
        const pageContextPath = "${pageContext.request.contextPath}";
        const isLoggedIn = ${not empty sessionScope.user};
    </script>
    <script src="${pageContext.request.contextPath}/assets/js/chatbot.js"></script>


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
