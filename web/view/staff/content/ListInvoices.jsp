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



                <h4 class="mb-3">Danh sách hoá đơn</h4>




                <form method="get" action="list-invoice-service" class="row g-2 mb-3 align-items-end">
                    <div class="col-auto">

                        <input type="date" class="form-control" id="filterDate" name="searchDate"
                               value="${param.searchDate}" />
                    </div>
                    <div class="col-auto">
                        <button type="submit" class="btn btn-primary">Lọc</button>
                    </div>
                </form>



                <table class="table table-striped">
                    <thead class="bg-primary text-white">
                        <tr>
                            <th scope="col">STT</th>
                            <th scope="col">Tên thú cưng</th>
                            <th scope="col">Chủ sở hữu</th>
                            <th scope="col">Ngày khám</th>
                            <th scope="col">Ca khám</th>
                            <th scope="col">Bác sĩ khám</th>


                            <th scope="col">Hoạt động</th>
                        </tr>
                    </thead>
                    <tbody>

                        <c:forEach var="invoice" items="${invoices}" varStatus="status">
                            <tr>
                                <td>${offset + status.index + 1}</td>
                                <td>${invoice.appointment.pet.name}</td>
                                <td>
                                    ${invoice.appointment.user.fullName}<br>
                                    <small>${invoice.appointment.user.phoneNumber}</small>
                                </td>
                                <td><fmt:formatDate value="${invoice.appointment.appointmentDate}" pattern="dd/MM/yyyy"/></td>

                                <td>
                                    ${invoice.appointment.startTime} - ${invoice.appointment.endTime}
                                </td>


                                <td>${invoice.appointment.doctor.user.fullName}</td>
                                <td>
                                    <button class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#invoiceModal-${invoice.id}">
                                        In hóa đơn
                                    </button>

                                </td>
                            </tr>
                        </c:forEach>

                    </tbody>

                </table>

                <c:if test="${totalPages > 0}">
                    <nav aria-label="Page navigation">
                        <ul class="pagination justify-content-center">
                            <!-- Trước -->
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link"
                                   href="list-invoice-service?page=${currentPage - 1}&searchDate=${searchDate}">Trước</a>
                            </li>

                            <!-- Các trang -->
                            <c:forEach var="i" begin="1" end="${totalPages}">
                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                    <a class="page-link"
                                       href="list-invoice-service?page=${i}&searchDate=${searchDate}">${i}</a>
                                </li>
                            </c:forEach>

                            <!-- Sau -->
                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link"
                                   href="list-invoice-service?page=${currentPage + 1}&searchDate=${searchDate}">Sau</a>
                            </li>
                        </ul>
                    </nav>
                </c:if>



                <c:forEach var="invoice" items="${invoices}" varStatus="status">
                    <div class="modal fade" id="invoiceModal-${invoice.id}" tabindex="-1" aria-labelledby="invoiceModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-xl">
                            <div class="modal-content" id="printArea-${invoice.id}">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="invoiceModalLabel">Phiếu Khám Bệnh</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>

                                <div class="modal-body print-section">
                                    <style>
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
                                                padding: 20px;
                                                background: #fff;
                                                font-family: 'Arial', sans-serif;
                                                font-size: 14px;
                                                color: #000;
                                                line-height: 1.5;
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
                                        .print-section h4 {
                                            text-align: center;
                                            font-size: 16px;
                                            text-transform: uppercase;
                                            margin: 20px 0;
                                        }
                                        .print-section .table-info {
                                            width: 100%;
                                            margin-bottom: 16px;
                                            border-collapse: collapse;
                                        }
                                        .print-section .table-info td,
                                        .print-section .table-info th {
                                            padding: 6px 8px;
                                            text-align: left;
                                            vertical-align: top;
                                            border: none;
                                        }
                                        .print-section .table-info th {
                                            width: 20%;
                                            font-weight: bold;
                                            white-space: nowrap;
                                        }
                                        .print-section .table-service {
                                            width: 100%;
                                            border-collapse: collapse;
                                            margin-top: 20px;
                                        }
                                        .print-section .table-service th,
                                        .print-section .table-service td {
                                            border: 1px solid #000;
                                            padding: 8px 10px;
                                            text-align: center;
                                        }
                                        .print-section .table-service th {
                                            background-color: transparent;
                                            font-weight: bold;
                                        }
                                        .print-section .note-section {
                                            font-style: italic;
                                            margin-top: 20px;
                                        }
                                        .print-section .signature-section {
                                            margin-top: 60px;
                                            display: flex;
                                            justify-content: space-around;
                                            text-align: center;
                                            font-size: 13px;
                                        }
                                        .print-section .signature-section .col {
                                            width: 40%;
                                        }
                                        .print-section .signature-section em {
                                            display: block;
                                            margin-top: 6px;
                                            font-style: italic;
                                            font-size: 12px;
                                        }
                                    </style>

                                    <div class="text-center mb-3">
                                        <c:if test="${not empty ClinicInfo.logo}">
                                            <img src="${pageContext.request.contextPath}${ClinicInfo.logo}" alt="Logo" height="80">
                                        </c:if>
                                        <h4 class="fw-bold">${ClinicInfo.name}</h4>
                                        <div>Địa chỉ: ${ClinicInfo.address}</div>
                                        <div>Điện thoại: ${ClinicInfo.phone} - Email: ${ClinicInfo.email}</div>
                                        <c:if test="${not empty ClinicInfo.website}">
                                            <div>Website: ${ClinicInfo.website}</div>
                                        </c:if>
                                        <hr>
                                    </div>

                                    <!-- Thông tin khách + thú cưng -->
                                    <table class="table-info">
                                        <tr>
                                            <th>Tên khách hàng:</th>
                                            <td>${invoice.appointment.user.fullName}</td>
                                            <th>Tên thú cưng:</th>
                                            <td>${invoice.appointment.pet.name}</td>
                                        </tr>
                                        <tr>
                                            <th>Điện thoại:</th>
                                            <td>${invoice.appointment.user.phoneNumber}</td>
                                            <th>Mã thú:</th>
                                            <td>${invoice.appointment.pet.pet_code}</td>
                                        </tr>
                                        <tr>
                                            <th>Địa chỉ:</th>
                                            <td colspan="3">${invoice.appointment.user.address}</td>
                                        </tr>
                                        <tr>
                                            <th>Loài:</th>
                                            <td>${invoice.appointment.pet.breed.specie.name}</td>
                                            <th>Giống:</th>
                                            <td>${invoice.appointment.pet.breed.name}</td>
                                        </tr>
                                    </table>

                                    <!-- Thông tin bác sĩ -->
                                    <table class="table-info">
                                        <tr>
                                            <th>Bác sĩ khám:</th>
                                            <td colspan="3">${invoice.appointment.doctor.user.fullName}</td>
                                        </tr>
                                        <tr>
                                            <th>Ngày khám:</th>
                                            <td><fmt:formatDate value="${invoice.appointment.appointmentDate}" pattern="dd/MM/yyyy"/></td>
                                            <th>Giờ khám:</th>
                                            <td>${invoice.appointment.startTime} - ${invoice.appointment.endTime}</td>
                                        </tr>
                                        <tr>
                                            <th>Ghi chú:</th>
                                            <td colspan="3">${invoice.appointment.note}</td>
                                        </tr>
                                    </table>

                                    <!-- Bảng dịch vụ -->
                                    <table class="table-service">
                                        <thead>
                                            <tr>
                                                <th>STT</th>
                                                <th>Dịch vụ</th>
                                                <th>Đơn giá</th>
                                                <th>Số lượng</th>
                                                <th>Thành tiền</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="sv" items="${invoice.services}" varStatus="loop">
                                                <tr>
                                                    <td>${loop.index + 1}</td>
                                                    <td>${sv.name}</td>
                                                    <td><fmt:formatNumber value="${sv.price}" type="number" groupingUsed="true"/> VNĐ</td>
                                                    <td>${sv.quantity}</td>
                                                    <td><fmt:formatNumber value="${sv.total}" type="number" groupingUsed="true"/> VNĐ</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                        <tfoot>
                                            <tr>
                                                <td colspan="4" style="text-align: right; font-weight: bold;">Tổng cộng:</td>
                                                <td><fmt:formatNumber value="${invoice.totalAmount}" /> VNĐ</td>
                                            </tr>
                                        </tfoot>
                                    </table>

                                    <!-- Ghi chú -->
                                    <div class="note-section mt-3">
                                        <strong>Ghi chú:</strong>
                                        <p>- Vui lòng thanh toán trước khi sử dụng dịch vụ.</p>
                                    </div>

                                    <!-- Ký tên -->
                                    <div class="signature-section mt-5">
                                        <div class="col">Khách hàng<br><em>(Ký, ghi rõ họ tên)</em></div>
                                        <div class="col">Kế toán<br><em>(Ký, ghi rõ họ tên)</em></div>
                                    </div>
                                </div>

                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                    <button type="button" class="btn btn-primary" onclick="printDiv('printArea-${invoice.id}')">
                                        <i class="bi bi-printer"></i> In phiếu
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>





                <script>
                    function printDiv(divId) {
                        const printContent = document.getElementById(divId).innerHTML;

                        const printWindow = window.open('', '', 'width=900,height=1200');
                        printWindow.document.write('<html><head><title>In hóa đơn</title>');
                        printWindow.document.write('</head><body>');
                        printWindow.document.write('<div class="print-section">');
                        printWindow.document.write(printContent);
                        printWindow.document.write('</div>');
                        printWindow.document.write('</body></html>');

                        printWindow.document.close();
                        printWindow.focus();

                        setTimeout(() => {
                            printWindow.print();
                            printWindow.close();
                        }, 500);
                    }
                </script>


            </div>
        </div>

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
