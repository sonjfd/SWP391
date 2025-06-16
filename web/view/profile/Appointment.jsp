<%-- 
    Document   : Appointment
    Created on : Jun 10, 2025, 12:03:05 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
    <c:if test="${not empty sessionScope.user}">

    </c:if>

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
        <!-- Icons -->
        <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- Css -->
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

        <style>
            /* Tổng thể bảng */
            .table {
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 4px 15px rgba(0,0,0,0.08);
                background-color: #fff;
                font-size: 14px;
            }

            /* Header bảng */
            .table thead th {
                background-color: #007bff !important;
                color: #fff !important;
                font-weight: 600;
                padding: 12px 15px;
                text-align: center;
            }
            img {
                border-radius: 8px;
                object-fit: cover;
            }
            .img-fluid {
                max-height: 300px;
                border-radius: 10px;
            }
            /* Dòng bảng */
            .table tbody td {
                vertical-align: middle;
                padding: 12px 15px;
            }

            /* Màu dòng chẵn/lẻ */
            .table-striped tbody tr:nth-of-type(odd) {
                background-color: #f9fbfc;
            }
            .table-striped tbody tr:nth-of-type(even) {
                background-color: #ffffff;
            }

            /* Hover dòng */
            .table-striped tbody tr:hover {
                background-color: #eaf4ff;
                transition: all 0.3s ease;
            }

            /* Badge */
            .badge {
                display: inline-block;
                font-size: 12px;
                padding: 6px 12px;
                border-radius: 20px;
                font-weight: 500;
            }

            /* Nút nhỏ */
            .btn-sm {
                font-size: 13px;
                padding: 6px 12px;
                border-radius: 8px;
            }

            /* Căn giữa cột hoạt động */
            td:last-child {
                text-align: center;
            }

            /* Hover nút */
            .btn-info:hover {
                background-color: #138496 !important;
                border-color: #117a8b !important;
            }
            .btn-danger:hover {
                background-color: #dc3545 !important;
                border-color: #c82333 !important;
            }
            .btn-success:hover {
                background-color: #218838 !important;
                border-color: #1e7e34 !important;
            }
            .action-buttons {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 6px;
                flex-wrap: nowrap; /* CHỐT không cho xuống dòng */
            }

            .action-buttons .btn {
                padding: 6px 10px;
                font-size: 14px;
                border-radius: 6px;
                display: inline-flex; /* QUAN TRỌNG, giúp giữ inline */
                align-items: center;
                justify-content: center;
                width: auto !important; /* ép không full width */
                min-width: 36px; /* nhỏ gọn */
            }
            .table td{
                text-align: center;
            }


            /* Responsive table đẹp hơn trên mobile */
            @media (max-width: 768px) {
                .table thead {
                    display: none;
                }

                .table, .table tbody, .table tr, .table td {
                    display: block;
                    width: 100%;
                }

                .table tr {
                    margin-bottom: 15px;
                    border-radius: 10px;
                    box-shadow: 0 2px 8px rgba(0,0,0,0.05);
                    background-color: #fff;
                    padding: 10px;
                }

                .table td {
                    text-align: right;
                    padding-left: 50%;
                    position: relative;
                }

                .table td::before {
                    content: attr(data-label);
                    position: absolute;
                    left: 15px;
                    width: 50%;
                    padding-left: 15px;
                    font-weight: 600;
                    text-align: left;
                }
                td {
                    text-align: center;
                }

            }
            .search-form input[type="text"]:focus,
            .filter-form .form-select {
                padding: 8px 14px;
                padding-right: 32px; /* 👈 Thêm dòng này để tránh đè lên icon */
                border: 1px solid #ccc;
                border-radius: 6px;
                font-size: 14px;
                outline: none;
                background-color: #f8f9fa;
                appearance: none; /* Optional: remove default browser style */
                background-image: url('data:image/svg+xml;utf8,<svg fill="%23333" height="20" viewBox="0 0 24 24" width="20" xmlns="http://www.w3.org/2000/svg"><path d="M7 10l5 5 5-5z"/></svg>');
                background-repeat: no-repeat;
                background-position: right 10px center;
                background-size: 16px;
            }


            .search-form button {
                padding: 8px 16px;
                background-color: #007bff;
                color: white;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-weight: 500;
                transition: background-color 0.3s;
            }

            .search-form button:hover {
                background-color: #0056b3;
            }
            /* Form tìm kiếm & lọc */
            .search-form input[type="text"],
            #filterForm input[type="date"],
            .filter-form .form-select {
                padding: 6px 12px;
                border: 1px solid #ccc;
                border-radius: 8px;
                font-size: 14px;
                outline: none;
                background-color: #f9fbfc;
                transition: border-color 0.3s;
            }

            .search-form input[type="text"]:focus,
            #filterForm input[type="date"]:focus,
            .filter-form .form-select:focus {
                border-color: #007bff;
            }

            /* Nút */
            .search-form button,
            #filterForm button,
            .filter-form button {
                padding: 8px 16px;
                background-color: #007bff;
                color: white;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                font-weight: 500;
                transition: background-color 0.3s, box-shadow 0.2s;
            }

            .search-form button:hover,
            #filterForm button:hover,
            .filter-form button:hover {
                background-color: #0056b3;
                box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            }

            /* Label chữ 'Từ', 'Đến' đẹp và đồng bộ */
            #filterForm span {
                font-weight: 600;
                font-size: 14px;
            }

            /* Dropdown filter */
            .filter-form .form-select {
                background-color: #f9fbfc;
                padding-right: 36px;
                background-image: url('data:image/svg+xml;utf8,<svg fill="%23333" height="20" viewBox="0 0 24 24" width="20" xmlns="http://www.w3.org/2000/svg"><path d="M7 10l5 5 5-5z"/></svg>');
                background-repeat: no-repeat;
                background-position: right 10px center;
                background-size: 16px;
            }

            /* Responsive nút gọn trên mobile */
            @media (max-width: 768px) {
                .search-form button,
                #filterForm button,
                .filter-form button {
                    padding: 6px 12px;
                    font-size: 13px;
                }
            }
            .action-button {
                padding: 6px 12px;
                border-radius: 8px;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                font-size: 14px;
                gap: 4px;
            }

            .action-button i {
                font-size: 16px;
            }

            .btn-info, .btn-danger, .btn-warning {
                color: #fff;
                border: none;
            }

            .btn-warning {
                background-color: #ffc107;
            }
            .custom-modal {
                border-radius: 15px;
            }

            #starRating .star {
                font-size: 30px;
                color: #ccc;
                cursor: pointer;
                transition: color 0.3s;
            }

            #starRating .star.selected {
                color: #ffc107;
            }

            .star {
                font-size: 24px;
                color: #ccc;
                cursor: pointer;
            }

            .star.selected {
                color: #ffc107;
            }



        </style>
    </head>

    <body>
        <c:if test="${not empty sessionScope.SuccessMessage}">
            <script>
                alert('${sessionScope.SuccessMessage}');
            </script>
            <c:remove var="SuccessMessage" scope="session"/>
        </c:if>

        <c:if test="${not empty sessionScope.FailMessage}">
            <script>
                alert('${sessionScope.FailMessage}');
            </script>
            <c:remove var="FailMessage" scope="session"/>
        </c:if>


        <!-- Navbar STart -->
        <%@include file="../home/layout/Header.jsp" %>
        <!-- Navbar End -->
        <div>

            <section class="bg-dashboard">

                <div class="row">
                    <div class=" col-3">
                        <div class="rounded shadow overflow-hidden sticky-bar">
                            <div class="card border-0">
                                <img src="${pageContext.request.contextPath}/${user.avatar}" class="img-fluid" alt="">
                            </div>
                            <div class="text-center avatar-profile margin-nagative mt-n5 position-relative pb-4 border-bottom">
                                <img src="${pageContext.request.contextPath}/${user.avatar}" class="rounded-circle shadow-md avatar avatar-md-md" alt="">
                                <h5 class="mt-3 mb-1">${user.fullName}</h5>
                            </div>
                            <ul class="list-unstyled sidebar-nav mb-0">
                                <li class="navbar-item"><a href="viewappointment" class="navbar-link"><i class="ri-calendar-check-line align-middle navbar-icon"></i>Danh sách cuộc hẹn</a></li>
                                <li class="navbar-item"><a href="viewmedicalhistory" class="navbar-link"><i class="ri-timer-line align-middle navbar-icon"></i>Lịch sử khám bệnh</a></li>
                                <li class="navbar-item"><a href="viewlistpet" class="navbar-link"><i class="ri-bear-smile-line align-middle navbar-icon"></i> Danh sách thú cưng</a></li>
                                <li class="navbar-item"><a href="viewuserinformation" class="navbar-link"><i class="ri-user-settings-line align-middle navbar-icon"></i> Cài đặt thông tin cá nhân</a></li>
                                <li class="navbar-item"><a href="doctor-chat.html" class="navbar-link"><i class="ri-chat-voice-line align-middle navbar-icon"></i> Trò chuyện</a></li>
                            </ul>
                        </div>
                    </div><!--end col-->

                    <div class=" col-9">
                        <h4 class="mb-3">Danh sách cuộc hẹn</h4>
                        <div class="d-flex justify-content-between align-items-center flex-wrap mb-4 gap-2">
                            <form method="post" action="searchapp" class="search-form">
                                <input type="text" name="search" value="${param.search}" placeholder="Tìm theo tên">
                                <button type="submit" >Tìm kiếm</button>
                            </form>
                            <form id="filterForm" action="filterappbydate" method="post" class="d-flex flex-wrap align-items-center gap-2 mb-0" >
                                <span>Từ:</span>
                                <input type="date" class="form-control form-control-sm" style="width: auto;" id="dateFFilter" name="datefrom"
                                       value="${param.datefrom}"/>
                                <span>Đến:</span>
                                <input type="date" class="form-control form-control-sm" style="width: auto;" id="dateTFilter" name="dateto"
                                       value="${param.dateto}"/>
                                <button type="submit" class="btn btn-secondary btn-sm">
                                    <i class="bi bi-funnel-fill"></i> Lọc
                                </button>
                            </form>
                            <form method="get" action="filterappointment" class="filter-form" style="margin-right: 20px">
                                <div class="filter-inline">
                                    <label for="status" class="form-label">Lọc theo trạng thái:</label>
                                    <select id="status" name="status" class="form-select" onchange="this.form.submit()">
                                        <option value="" ${status == null || status == '' ? 'selected' : ''}>-- Tất cả --</option>
                                        <option value="canceled" ${status == 'canceled' ? 'selected' : ''}>Đã hủy</option>
                                        <option value="completed" ${status == 'completed' ? 'selected' : ''}>Đã đặt</option>
                                    </select>

                                </div>
                            </form>
                        </div>
                        <table class="table table-striped">
                            <thead class="bg-primary text-white">
                                <tr>
                                    <th scope="col">STT</th>
                                    <th scope="col">Tên thú cưng</th>

                                    <th scope="col">Ngày khám</th>
                                    <th scope="col">Ca khám</th>
                                    <th scope="col">Bác sĩ khám</th>
                                    <th scope="col">Trạng thái</th> 
                                    <th scope="col">Thanh toán</th> 
                                    <th scope="col">Phương Thức</th> 
                                    <th scope="col">Hoạt động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="app" items="${appointments}" varStatus="status">
                                    <tr>
                                        <td>${status.index + 1}</td> 
                                        <td>${app.pet.name}</td> 

                                        <td><fmt:formatDate value="${app.appointmentDate}" pattern="dd/MM/yyyy"/></td>
                                        <td>${app.startTime} - ${app.endTime}</td>
                                        <td>${app.doctor.user.fullName}</td>
                                        <!-- Trạng thái -->
                                        <td>
                                            <c:choose>
                                                <c:when test="${app.status == 'completed'}">
                                                    <span class="badge bg-success">Đã đặt</span>
                                                </c:when>
                                                <c:when test="${app.status == 'pending'}">
                                                    <span class="badge bg-warning text-dark">Đang xử lí</span>
                                                </c:when>
                                                <c:when test="${app.status == 'canceled'}">
                                                    <span class="badge bg-danger">Đã huỷ</span>
                                                </c:when>

                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${app.paymentStatus == 'unpaid'}">
                                                    <span class="badge bg-warning text-dark">Chưa thanh toán</span>
                                                </c:when>

                                                <c:when test="${app.paymentStatus == 'paid'}">
                                                    <span class="badge bg-success">Đã thanh toán</span>
                                                </c:when>

                                            </c:choose>
                                        </td>
                                        <!-- Phương thức thanh toán -->
                                        <td>
                                            <c:choose>
                                                <c:when test="${app.paymentMethod == 'cash'}">
                                                    <span class="badge bg-primary">Tiền mặt</span>
                                                </c:when>

                                                <c:when test="${app.paymentMethod == 'online'}">
                                                    <span class="badge bg-info text-dark">Trực tuyến</span>
                                                </c:when>

                                            </c:choose>
                                        </td>
                                        <td>
                                            <div class="action-buttons">
                                                <button type="button" class="btn btn-info action-button" data-bs-toggle="modal" data-bs-target="#detailModal-${app.id}" title="Xem chi tiết">
                                                    <i class="fa-solid fa-circle-info"></i>
                                                </button>

                                                <c:if test="${app.status == 'completed'}">
                                                    <fmt:formatDate value="${app.appointmentDate}" pattern="yyyy-MM-dd" var="formattedDate" />

                                                    <form class="cancel-form" 
                                                          data-app-time="${formattedDate}" 
                                                          data-start-time="${app.startTime}" 
                                                          data-app-id="${app.id}" 
                                                          action="cancelbooking" method="post" 
                                                          onsubmit="return checkTimeBeforeCancel(this)">

                                                        <input type="hidden" name="id" value="${app.id}" />
                                                        <button type="submit" class="btn btn-danger btn-sm">Huỷ</button>
                                                    </form>



                                                    <button type="button"
                                                            class="btn btn-warning action-button"
                                                            title="Đánh giá dịch vụ"
                                                            data-bs-toggle="modal"
                                                            data-bs-target="#rateModal"
                                                            data-id="${app.id}"
                                                            data-apptime="<fmt:formatDate value='${app.appointmentDate}' pattern='yyyy-MM-dd' />"
                                                            data-starttime="${app.startTime}">
                                                        <i class="fa-regular fa-star"></i> Rate
                                                    </button>
                                                </c:if>


                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>

                            </tbody>
                        </table>
                        <p type="text" name="id" style="color: red"  >${requestScope.Message}</p>

                        <c:forEach var="app" items="${appointments}">
                            <div class="modal fade" id="detailModal-${app.id}" tabindex="-1" aria-labelledby="detailModalLabel-${app.id}" aria-hidden="true">
                                <div class="modal-dialog modal-lg modal-dialog-scrollable">
                                    <div class="modal-content">
                                        <div class="modal-header bg-primary text-white">
                                            <h5 class="modal-title" id="detailModalLabel-${app.id}">Thông tin chi tiết lịch hẹn</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">

                                            <!-- Thông tin Pet -->
                                            <h5>Thông tin thú cưng</h5>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <img src="${pageContext.request.contextPath}/${app.pet.avatar}" alt="Ảnh thú cưng" class="img-fluid rounded">
                                                </div>
                                                <div class="col-md-8">
                                                    <p><strong>Mã thú cưng:</strong> ${app.pet.pet_code}</p>
                                                    <p><strong>Tên:</strong> ${app.pet.name}</p>
                                                    <p><strong>Ngày sinh:</strong> <fmt:formatDate value="${app.pet.birthDate}" pattern="dd/MM/yyyy"/></p>
                                                    <p><strong>Giống loài:</strong> ${app.pet.breed.name} (Loài: ${app.pet.breed.specie.name})</p>
                                                    <p><strong>Giới tính:</strong> ${app.pet.gender}</p>
                                                    <p><strong>Mô tả:</strong> ${app.pet.description}</p>
                                                    <p><strong>Trạng thái thú cưng:</strong> ${app.pet.status}</p>
                                                </div>
                                            </div>

                                            <hr/>
                                            <!-- Thông tin Bác sĩ -->
                                            <h5>Thông tin bác sĩ</h5>
                                            <c:choose>
                                                <c:when test="${not empty app.doctor}">
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <img src="${pageContext.request.contextPath}/${app.doctor.user.avatar}" alt="Ảnh bác sĩ" class="img-fluid rounded">
                                                        </div>
                                                        <div class="col-md-8">
                                                            <p><strong>Họ và tên:</strong> ${app.doctor.user.fullName}</p>
                                                            <p><strong>Chuyên khoa:</strong> ${app.doctor.specialty}</p>
                                                            <p><strong>Chứng chỉ:</strong> ${app.doctor.certificates}</p>
                                                            <p><strong>Bằng cấp:</strong> ${app.doctor.qualifications}</p>
                                                            <p><strong>Kinh nghiệm:</strong> ${app.doctor.yearsOfExperience} năm</p>
                                                            <p><strong>Tiểu sử:</strong> ${app.doctor.biography}</p>
                                                        </div>
                                                    </div>
                                                </c:when>

                                            </c:choose>

                                            <hr/>

                                            <h5>Thông tin lịch hẹn</h5>
                                            <p><strong>Ngày khám:</strong> <fmt:formatDate value="${app.appointmentDate}" pattern="dd/MM/yyyy"/></p>
                                            <p><strong>Ca khám:</strong> ${app.startTime} - ${app.endTime}</p>
                                            <p><strong>Ghi chú:</strong> 
                                                <c:choose>
                                                    <c:when test="${not empty app.note}">
                                                        ${app.note}
                                                    </c:when>
                                                    <c:otherwise>
                                                        Khách hàng không để lại ghi chú
                                                    </c:otherwise>
                                                </c:choose>
                                            </p>

                                            <p><strong>Trạng thái lịch hẹn:</strong>
                                                <select class="form-select" disabled>

                                                    <option value="completed" ${app.status == 'completed' ? 'selected' : ''}>Đặt lịch thành công</option>
                                                    <option value="canceled" ${app.status == 'canceled' ? 'selected' : ''}>Đã huỷ</option>
                                                </select>
                                            </p>

                                            <p><strong>Trạng thái thanh toán:</strong>
                                                <select class="form-select" disabled>
                                                    <option value="unpaid" ${app.paymentStatus == 'unpaid' ? 'selected' : ''}>Chưa thanh toán</option>
                                                    <option value="paid" ${app.paymentStatus == 'paid' ? 'selected' : ''}>Đã thanh toán</option>
                                                </select>
                                            </p>

                                            <p><strong>Phương thức thanh toán:</strong>
                                                <select class="form-select" disabled>
                                                    <option value="cash" ${app.paymentMethod == 'cash' ? 'selected' : ''}>Thanh toán trực tiếp</option>
                                                    <option value="online" ${app.paymentMethod == 'online' ? 'selected' : ''}>Thanh toán online</option>
                                                </select>
                                            </p>

                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal fade" id="rateModal" tabindex="-1" aria-labelledby="rateModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <form action="rateservice" method="post">
                                        <div class="modal-content custom-modal">
                                            <div class="modal-header">
                                                <h5 class="modal-title">Đánh giá dịch vụ</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                            </div>

                                            <div class="modal-body">
                                                <input type="hidden" name="id" id="ratingAppId" />
                                                <input type="hidden" name="appTime" id="ratingAppTime" />
                                                <input type="hidden" name="startTime" id="ratingStartTime" />

                                                <div class="mb-3 text-center">
                                                    <label class="form-label mb-2">Mức độ hài lòng</label>
                                                    <div id="starRating">
                                                        <i class="fa-regular fa-star star" data-value="1" title="Rất tệ"></i>
                                                        <i class="fa-regular fa-star star" data-value="2" title="Không hài lòng"></i>
                                                        <i class="fa-regular fa-star star" data-value="3" title="Bình thường"></i>
                                                        <i class="fa-regular fa-star star" data-value="4" title="Hài lòng"></i>
                                                        <i class="fa-regular fa-star star" data-value="5" title="Rất hài lòng"></i>
                                                    </div>
                                                    <input type="hidden" name="satisfaction_level" id="satisfactionLevel" required>

                                                    <input type="hidden" name="satisfaction_level" id="satisfactionLevel" required>
                                                </div>


                                                <div class="mb-3">
                                                    <label for="comment" class="form-label">Nhận xét</label>
                                                    <textarea class="form-control" name="comment" rows="3" placeholder="Nhận xét về dịch vụ..."></textarea>
                                                </div>

                                                <input type="hidden" name="status" value="active" />
                                            </div>

                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                                <button type="submit" class="btn btn-primary">Gửi đánh giá</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div><!--end row-->
            </section><!--end section-->
        </div><!-- End -->




        <script>
            function checkTimeBeforeCancel(form) {
                const appDateStr = form.dataset.appTime;     // ví dụ: "2025-06-17"
                const startTimeStr = form.dataset.startTime; // ví dụ: "08:00"

                if (!appDateStr || !startTimeStr) {
                    alert("Thiếu dữ liệu thời gian.");
                    return false;
                }

                const [year, month, day] = appDateStr.split('-').map(Number); // tháng -1 do JS tính từ 0
                const [hour, minute] = startTimeStr.split(':').map(Number);

                const appointmentTime = new Date(year, month - 1, day, hour, minute);
                const now = new Date();

                console.log("📅 Ngày khám:", appointmentTime.toString());
                console.log("⏱️ Giờ hiện tại:", now.toString());

                const diffInMs = appointmentTime.getTime() - now.getTime();
                const diffInMinutes = diffInMs / (1000 * 60);

                if (diffInMinutes < 0) {
                    alert("Không thể huỷ lịch đã qua.");
                    return false;
                }

                if (diffInMinutes < 30) {
                    alert("Không thể huỷ lịch nếu còn dưới 30 phút trước giờ khám.");
                    return false;
                }

                return confirm("Bạn có muốn gửi yêu cầu huỷ lịch khám?");
            }



            document.addEventListener("DOMContentLoaded", function () {
                const rateModal = document.getElementById("rateModal");
                const stars = document.querySelectorAll("#starRating .star");
                const satisfactionInput = document.getElementById("satisfactionLevel");
                const commentInput = document.querySelector('textarea[name="comment"]');

                // Khi mở modal
                rateModal.addEventListener("show.bs.modal", function (event) {
                    const button = event.relatedTarget;
                    const appointmentId = button.getAttribute("data-id");

                    // Reset sao và comment
                    stars.forEach(s => s.classList.remove("selected"));
                    satisfactionInput.value = "";
                    commentInput.value = "";

                    // Load rating qua ajax
                    fetch("getratingbyappointmentid?id=" + appointmentId)
                            .then(response => response.json())
                            .then(data => {
                                if (data.satisfaction) {
                                    // Chọn đúng số sao theo giá trị 1-5
                                    stars.forEach(star => {
                                        if (star.getAttribute("data-value") <= data.satisfaction) {
                                            star.classList.add("selected");
                                        }
                                    });
                                    satisfactionInput.value = data.satisfaction;
                                }
                                if (data.comment) {
                                    commentInput.value = data.comment;
                                }
                            });

                    // Set hidden input
                    document.getElementById("ratingAppId").value = appointmentId;
                    document.getElementById("ratingAppTime").value = button.getAttribute("data-apptime");
                    document.getElementById("ratingStartTime").value = button.getAttribute("data-starttime");
                });

                // Click chọn sao
                stars.forEach((star, index) => {
                    star.addEventListener("click", () => {
                        // Reset hết sao
                        stars.forEach(s => s.classList.remove("selected"));
                        // Tô sáng các sao từ 0 đến index
                        for (let i = 0; i <= index; i++) {
                            stars[i].classList.add("selected");
                        }
                        satisfactionInput.value = star.getAttribute("data-value");
                    });
                });
            });


            // Tự động ẩn thông báo sau 5 giây
            setTimeout(function () {
                const successAlert = document.getElementById('successAlert');
                const failAlert = document.getElementById('failAlert');
                if (successAlert) {
                    successAlert.style.display = 'none';
                }
                if (failAlert) {
                    failAlert.style.display = 'none';
                }
            }, 8000);
        </script>

        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>


        <!-- Icons -->
        <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
    </body>

</html>
