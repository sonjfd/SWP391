<%-- 
    Document   : ListAppointment
    Created on : Jun 8, 2025, 8:33:32 PM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Trang Nhân Viên</title>
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
        <!-- simplebar -->
        <link href="${pageContext.request.contextPath}/assets/css/simplebar.css" rel="stylesheet" type="text/css" />
        <!-- Select2 -->
        <link href="${pageContext.request.contextPath}/assets/css/select2.min.css" rel="stylesheet" />
        <!-- Icons -->
        <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- SLIDER -->
        <link href="${pageContext.request.contextPath}/assets/css/tiny-slider.css" rel="stylesheet" />
        <!-- Css -->
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">


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
            }




            .checkin-btn {
                display: inline-block;
                padding: 8px 16px;
                border-radius: 8px;
                font-size: 10px;
                font-weight: 500;
                color: #fff;
                text-align: center;
                text-decoration: none;
                transition: background-color 0.3s ease, box-shadow 0.2s ease;
                cursor: pointer;
            }

            .checkin-btn.bg-success {
                background-color: #28a745;
            }

            .checkin-btn.bg-success:hover {
                background-color: #218838;
                box-shadow: 0 0 8px rgba(40, 167, 69, 0.6);
            }

            .checkin-btn.bg-danger {
                background-color: #dc3545;
            }

            .checkin-btn.bg-danger:hover {
                background-color: #c82333;
                box-shadow: 0 0 8px rgba(220, 53, 69, 0.6);
            }



        </style>

    </head>
    <body>
        <%@ include file="../layout/Header.jsp" %>



        <div class="container-fluid bg-light">
            <div class="layout-specing">



                <h4 class="mb-3">Danh sách lịch hẹn</h4>


                <div class="d-flex justify-content-between align-items-center flex-wrap mb-4 gap-2">


                    <form id="filterForm" action="list-appointment" method="get" class="d-flex flex-wrap align-items-center gap-2 mb-0">

                        <select class="form-select form-select-sm" style="width: auto;" id="slotFilter" name="slot">
                            <option value="">Ca làm việc</option>
                            <c:forEach items="${shifts}" var="s">
                                <option value="${s.id}" 
                                        ${s.id == selectedSlot ? "selected" : ""}>
                                    ${s.name} ${s.start_time} - ${s.end_time}
                                </option>
                            </c:forEach>
                        </select>

                        <input type="date" class="form-control form-control-sm" style="width: auto;" id="dateFilter" name="date"
                               value="${selectedDate}" />

                        <select class="form-select form-select-sm" style="width: auto;" id="doctorFilter" name="doctor">
                            <option value="">Bác sĩ</option>
                            <c:forEach items="${doctors}" var="d">
                                <option value="${d.user.id}" 
                                        ${d.user.id == selectedDoctor ? "selected" : ""}>
                                    ${d.user.fullName}
                                </option>
                            </c:forEach>
                        </select>


                        <button type="submit" class="btn btn-secondary btn-sm">
                            <i class="bi bi-funnel-fill"></i> Lọc
                        </button>
                    </form>

                    <div class="d-flex align-items-center gap-2">

                        <!-- Nút mở modal -->
                        <button type="button" class="btn btn-warning btn-sm text-dark" data-bs-toggle="modal" data-bs-target="#updateExamPriceModal">
                            <i class="bi bi-cash-coin"></i> Cập nhật giá khám
                        </button>

                        <!-- Modal -->
                        <div class="modal fade" id="updateExamPriceModal" tabindex="-1" aria-labelledby="updateExamPriceModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <form action="updatebookingprice" method="post">
                                    <input type="hidden" name="id" value="${ExaminationPrice.id}" />

                                    <div class="modal-content">
                                        <div class="modal-header bg-warning">
                                            <h5 class="modal-title" id="updateExamPriceModalLabel">Cập nhật giá khám</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                                        </div>
                                        <div class="modal-body">
                                            <div class="mb-3">
                                                <label for="currentPrice" class="form-label">Giá hiện tại:</label>
                                                <input type="text" class="form-control" name="price" id="currentPrice" value="<fmt:formatNumber value='${ExaminationPrice.price}' type='number' maxFractionDigits='0'/> " readonly>
                                            </div>
                                            <div class="mb-3">
                                                <label for="newPrice" class="form-label">Giá khám mới:</label>
                                                <input type="number" name="newPrice" id="newPrice" class="form-control" required>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="submit" class="btn btn-success">Cập nhật</button>
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>




                        <a href="add-new-booking" class="btn btn-primary btn-sm">
                            <i class="bi bi-plus-circle"></i> Thêm lịch hẹn
                        </a>


                    </div>

                </div>





                <table class="table table-striped">
                    <thead class="bg-primary text-white">
                        <tr>
                            <th scope="col">STT</th>
                            <th scope="col">Tên thú cưng</th>
                            <th scope="col">Chủ sở hữu</th>
                            <th scope="col">Ngày khám</th>
                            <th scope="col">Ca khám</th>
                            <th scope="col">Bác sĩ khám</th>
                            <th scope="col">Trạng thái</th> 
                            <th scope="col">Thanh toán</th> 
                            <th scope="col">Check in</th> 

                            <th scope="col">Hoạt động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="app" items="${appointments}" varStatus="status">
                            <tr>
                                <td>${offset + status.index + 1}</td>
                                <td>${app.pet.name}</td> 
                                <td>${app.user.fullName}</td> 
                                <td><fmt:formatDate value="${app.appointmentDate}" pattern="dd/MM/yyyy"/></td>
                                <td>${app.startTime} - ${app.endTime}</td>
                                <td>${app.doctor.user.fullName}</td>
                                <!-- Trạng thái -->
                                <td>
                                    <c:choose>

                                        <c:when test="${app.status == 'completed'}">
                                            <span class="badge bg-success">Đã Đặt</span>
                                        </c:when>

                                        <c:when test="${app.status == 'canceled'}">
                                            <span class="badge bg-danger">Đã huỷ</span>
                                        </c:when>

                                        <c:when test="${app.status == 'pending'}">
                                            <span class="badge bg-success">Đang xử lí</span>
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

                                    <a href="javascript:void(0);"
                                       class="checkin-btn ${app.chekinStatus == 'checkin' ? 'bg-success' : 'bg-danger'}"
                                       data-appointment-id="${app.id}"
                                       data-status="${app.chekinStatus}"
                                       onclick="updateCheckinStatus(this)">
                                        ${app.chekinStatus == 'checkin' ? 'Đã tới khám 👌' : 'Chưa tới khám 👆'}
                                    </a>
                                </td>
                                <td>                                  
                                    <div class="action-buttons">

                                        <button type="button" class="btn btn-info" data-bs-toggle="modal" data-bs-target="#detailModal-${app.id}" title="Xem chi tiết">
                                            <i class="bi bi-info-circle"></i>
                                        </button>

                                        <button type="button" class="btn btn-success" title="Cập nhật lịch hẹn"   onclick="window.location.href = 'update-appointment?id=${app.id}'">
                                            <i class="bi bi-pencil-square"></i>
                                        </button>
                                        <button type="button" class="btn btn-outline-dark" title="In phiếu thú cưng"
                                                data-bs-toggle="modal" data-bs-target="#printModal-${app.id}">
                                            <i class="bi bi-printer"></i>
                                        </button>

                                    </div>
                                </td>
                            </tr>
                        </c:forEach>

                    </tbody>

                </table>
                <c:if test="${totalPages > 0}">
                    <nav aria-label="Page navigation">
                        <ul class="pagination justify-content-center">

                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" 
                                   href="list-appointment?page=${currentPage - 1}&slot=${selectedSlot}&date=${selectedDate}&doctor=${selectedDoctor}" 
                                   tabindex="-1">Trước</a>
                            </li>

                            <c:forEach var="i" begin="1" end="${totalPages}">
                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                    <a class="page-link" 
                                       href="list-appointment?page=${i}&slot=${selectedSlot}&date=${selectedDate}&doctor=${selectedDoctor}">
                                        ${i}
                                    </a>
                                </li>
                            </c:forEach>

                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link" 
                                   href="list-appointment?page=${currentPage + 1}&slot=${selectedSlot}&date=${selectedDate}&doctor=${selectedDoctor}">
                                    Sau
                                </a>
                            </li>

                        </ul>
                    </nav>
                </c:if>


                <c:forEach var="app" items="${appointments}">
                    <div class="modal fade" id="printModal-${app.id}" tabindex="-1" aria-labelledby="printModal-${app.id}" aria-hidden="true">
                        <div class="modal-dialog modal-lg modal-dialog-scrollable">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Phiếu khám bệnh</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                                </div>
                                <div class="modal-body" id="printArea-${app.id}">
                                    <style>
                                        .print-section {
                                            font-family: 'Arial', sans-serif;
                                            font-size: 14px;
                                            padding: 20px;
                                            color: #000;
                                        }
                                        .print-section .header {
                                            text-align: center;
                                            margin-bottom: 25px;
                                            font-weight: bold;
                                            border-bottom: 2px solid #000;
                                            padding-bottom: 10px;
                                        }
                                        .print-section .header img {
                                            height: 60px;
                                            margin-bottom: 10px;
                                        }
                                        .print-section table {
                                            width: 100%;
                                            border-collapse: collapse;
                                            margin-bottom: 15px;
                                        }
                                        .print-section th, .print-section td {
                                            border: 1px solid #000;
                                            padding: 8px 10px;
                                            vertical-align: top;
                                        }
                                        .print-section th {
                                            background-color: #f0f0f0;
                                            width: 25%;
                                            text-align: left;
                                        }
                                        .print-section h4 {
                                            text-align: center;
                                            margin-top: 15px;
                                            font-size: 16px;
                                            text-transform: uppercase;
                                        }
                                        .signature-section {
                                            margin-top: 40px;
                                            display: flex;
                                            justify-content: space-between;
                                            font-size: 13px;
                                        }

                                        @media print {
                                            body * {
                                                visibility: hidden;
                                            }

                                            .print-section, .print-section * {
                                                visibility: visible;
                                            }

                                            .print-section {
                                                position: absolute;
                                                top: 0;
                                                left: 0;
                                                width: 100%;
                                                font-family: 'Arial', sans-serif;
                                                font-size: 14px;
                                                color: #000;
                                                padding: 20px;
                                            }
                                        }

                                        .print-section .header {
                                            text-align: center;
                                            margin-bottom: 25px;
                                            font-weight: bold;
                                            border-bottom: 2px solid #000;
                                            padding-bottom: 10px;
                                        }

                                        .print-section .header img {
                                            height: 60px;
                                            margin-bottom: 10px;
                                        }

                                        .print-section table {
                                            width: 100%;
                                            border-collapse: collapse;
                                            margin-bottom: 15px;
                                        }

                                        .print-section th, .print-section td {
                                            border: 1px solid #000;
                                            padding: 8px 10px;
                                            vertical-align: top;
                                        }

                                        .print-section th {
                                            background-color: #f0f0f0;
                                            width: 25%;
                                            text-align: left;
                                        }

                                        .print-section h4 {
                                            text-align: center;
                                            margin-top: 15px;
                                            font-size: 16px;
                                            text-transform: uppercase;
                                        }

                                        .signature-section {
                                            margin-top: 40px;
                                            display: flex;
                                            justify-content: space-between;
                                            font-size: 13px;
                                        }
                                    </style>

                                    <div class="print-section">
                                        <div class="header text-center">
                                            <c:if test="${not empty ClinicInfo.logo}">
                                                <img src="${pageContext.request.contextPath}${ClinicInfo.logo}" 
                                                     alt="Logo Phòng khám">
                                            </c:if>
                                            <div><strong>${ClinicInfo.name}</strong></div>
                                            <div>Địa chỉ: ${ClinicInfo.address}</div>
                                            <div>ĐT: ${ClinicInfo.phone} - Email: ${ClinicInfo.email}</div>
                                            <c:if test="${not empty ClinicInfo.website}">
                                                <div>Website: ${ClinicInfo.website}</div>
                                            </c:if>
                                            <c:if test="${not empty ClinicInfo.workingHours}">
                                                <div>Giờ làm việc: ${ClinicInfo.workingHours}</div>
                                            </c:if>

                                            <h4>PHIẾU KHÁM BỆNH</h4>
                                        </div>

                                        <table>
                                            <tr>
                                                <th>Giờ Khám</th>
                                                <td>${app.startTime} - ${app.endTime}</td>
                                                <th>Ngày Khám</th>
                                                <td><fmt:formatDate value="${app.appointmentDate}" pattern="dd/MM/yyyy " /></td>
                                            </tr>
                                            <tr>
                                                <th>Mã thú</th>
                                                <td>${app.pet.pet_code}</td>
                                                <th>Tên thú</th>
                                                <td>${app.pet.name}</td>
                                            </tr>

                                            <tr>
                                                <th>Loài</th>
                                                <td>${app.pet.breed.specie.name}</td>
                                                <th>Giống</th>
                                                <td>${app.pet.breed.name}</td>
                                            </tr>
                                            <tr>
                                                <th><strong>Bác sĩ khám</strong></th>
                                                <td colspan="3">${app.doctor.user.fullName}</td>
                                            </tr>
                                            <tr>
                                                <th>Ghi chú</th>
                                                <td colspan="3">${app.note != null ? app.note : ''}</td>
                                            </tr>
                                        </table>

                                        <table>
                                            <tr>
                                                <th>Khách hàng</th>
                                                <td>${app.user.fullName}</td>
                                                <th>Số điện thoại</th>
                                                <td>${app.user.phoneNumber}</td>
                                            </tr>
                                            <tr>
                                                <th>Địa chỉ</th>
                                                <td colspan="3">${app.user.address}</td>
                                            </tr>
                                        </table>

                                        <div class="signature-section">
                                            <div>Khách hàng<br/><em>(Ký, họ tên)</em></div>
                                            <div>Người tiếp nhận<br/><em>(Ký, họ tên)</em></div>
                                        </div>
                                    </div>
                                </div>

                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                    <button type="button" class="btn btn-primary" onclick="printDiv('printArea-${app.id}')">
                                        <i class="bi bi-printer"></i> In phiếu
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                </c:forEach>

                <c:forEach var="app" items="${appointments}">
                    <div class="modal fade" id="detailModal-${app.id}" tabindex="-1" aria-labelledby="detailModalLabel-${app.id}" aria-hidden="true">
                        <div class="modal-dialog modal-lg modal-dialog-scrollable">
                            <div class="modal-content">
                                <div class="modal-header bg-primary text-white">
                                    <h5 class="modal-title" id="detailModalLabel-${app.id}">Thông tin chi tiết lịch hẹn</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">


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
                                            <p><strong>Giới tính:</strong> ${app.pet.gender == 'male' ? 'Đực' : 'Cái'}</p>
                                           
                                            
                                        </div>
                                    </div>

                                    <hr/>

                                    <!-- Thông tin Chủ sở hữu (User) -->
                                    <h5>Thông tin chủ sở hữu</h5>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <img src="${pageContext.request.contextPath}/${app.user.avatar}" alt="Ảnh chủ sở hữu" class="img-fluid rounded">
                                        </div>
                                        <div class="col-md-8">
                                            <p><strong>Họ và tên:</strong> ${app.user.fullName}</p>
                                            <p><strong>Tên đăng nhập:</strong> ${app.user.userName}</p>
                                            <p><strong>Email:</strong> ${app.user.email}</p>
                                            <p><strong>Số điện thoại:</strong> ${app.user.phoneNumber}</p>
                                            <p><strong>Địa chỉ:</strong> ${app.user.address}</p>
                                            
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
                </c:forEach>


            </div>
        </div>







        <script>


            function printDiv(divId) {
                const printContents = document.getElementById(divId).innerHTML;
                const originalContents = document.body.innerHTML;

                document.body.innerHTML = printContents;
                window.print();
                document.body.innerHTML = originalContents;


                location.reload();
            }

            function updateCheckinStatus(el) {
                const appointmentId = el.dataset.appointmentId;
                const currentStatus = el.dataset.status;
                const newStatus = currentStatus === 'noshow' ? 'checkin' : 'noshow';

                const url = 'update-chekin?id=' + encodeURIComponent(appointmentId)
                        + '&status=' + encodeURIComponent(newStatus);

                fetch(url)
                        .then(response => response.text())
                        .then(result => {
                            if (result.trim() === 'success') {

                                el.dataset.status = newStatus;

                                if (newStatus === 'checkin') {
                                    el.classList.remove('bg-danger');
                                    el.classList.add('bg-success');
                                    el.innerHTML = 'Đã tới khám 👌';
                                } else {
                                    el.classList.remove('bg-success');
                                    el.classList.add('bg-danger');
                                    el.innerHTML = 'Chưa tới khám 👆';
                                }
                            } else {
                                alert('Cập nhật trạng thái thất bại!');
                            }
                        })
                        .catch(err => {
                            console.error('Lỗi:', err);
                            alert('Có lỗi xảy ra khi gửi yêu cầu.');
                        });
            }


            function getParam() {
                const param = new URLSearchParams(window.location.search);
                return param.get('success');
            }

            const success = getParam();




            if (success === '1') {
                alert('Thêm thành lịch hẹn thành công');
            }
            if (success === 'update_success') {
                alert('Cập nhật thành công');
            }

            statusModal.show();
            if (history.replaceState) {
                const url = new URL(window.location.href);
                url.searchParams.delete('success');
                window.history.replaceState(null, '', url.pathname + url.search);
            }


        </script>






        <!-- simplebar -->
        <script src="${pageContext.request.contextPath}/assets/js/simplebar.min.js"></script>
        <!-- Chart -->
        <script src="${pageContext.request.contextPath}/assets/js/apexcharts.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/columnchart.init.js"></script>
        <!-- Icons -->
        <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
    </body>
</html>
