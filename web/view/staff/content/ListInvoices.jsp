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




    </head>
    <body>
        <%@ include file="../layout/Header.jsp" %>



        <div class="container-fluid bg-light">
            <div class="layout-specing">



                <h4 class="mb-3">Danh sách hoá đơn</h4>




                <form method="get" action="staff-list-invoice-service" class="row g-2 mb-3 align-items-end">
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
                                   href="staff-list-invoice-service?page=${currentPage - 1}&searchDate=${searchDate}">Trước</a>
                            </li>

                            <!-- Các trang -->
                            <c:forEach var="i" begin="1" end="${totalPages}">
                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                    <a class="page-link"
                                       href="staff-list-invoice-service?page=${i}&searchDate=${searchDate}">${i}</a>
                                </li>
                            </c:forEach>

                            <!-- Sau -->
                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link"
                                   href="staff-list-invoice-service?page=${currentPage + 1}&searchDate=${searchDate}">Sau</a>
                            </li>
                        </ul>
                    </nav>
                </c:if>



                <c:forEach var="invoice" items="${invoices}" varStatus="status">
                    <div class="modal fade" id="invoiceModal-${invoice.id}" tabindex="-1" aria-labelledby="invoiceModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-xl modal-dialog-scrollable">
                            <div class="modal-content" id="printArea-${invoice.id}">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="invoiceModalLabel">Phiếu Khám Bệnh</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>

                                <div class="modal-body print-section">
                                    <!-- Clinic Info Section -->
                                    <div class="text-center mb-4">
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

                                    <!-- Customer and Pet Information Table -->
                                    <div class="container mb-4">
                                        <table class="table table-bordered">
                                            <tbody>
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
                                            </tbody>
                                        </table>
                                    </div>

                                    <!-- Doctor Information Table -->
                                    <div class="container mb-4">
                                        <table class="table table-bordered">
                                            <tbody>
                                                <tr>
                                                    <th>Bác sĩ khám:</th>
                                                    <td colspan="3">${invoice.appointment.doctor.user.fullName}</td>
                                                </tr>
                                                <tr>
                                                    <th>Ngày khám:</th>
                                                    <td><fmt:formatDate value="${invoice.appointment.appointmentDate}" pattern="dd/MM/yyyy" /></td>
                                                    <th>Giờ khám:</th>
                                                    <td>${invoice.appointment.startTime} - ${invoice.appointment.endTime}</td>
                                                </tr>
                                                <tr>
                                                    <th>Ghi chú:</th>
                                                    <td colspan="3">${invoice.appointment.note}</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>

                                    <!-- Service Table -->
                                    <div class="container mb-4">
                                        <table class="table table-bordered table-striped">
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
                                                        <td><fmt:formatNumber value="${sv.price}" type="number" groupingUsed="true" /> VNĐ</td>
                                                        <td>${sv.quantity}</td>
                                                        <td><fmt:formatNumber value="${sv.total}" type="number" groupingUsed="true" /> VNĐ</td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                            <tfoot>
                                                <tr>
                                                    <td colspan="4" class="text-end font-weight-bold">Tổng cộng:</td>
                                                    <td><fmt:formatNumber value="${invoice.totalAmount}" type="number" groupingUsed="true" /> VNĐ</td>
                                                </tr>
                                            </tfoot>
                                        </table>
                                    </div>

                                    <!-- Notes Section -->
                                    <div class="note-section mt-3">
                                        <strong>Ghi chú:</strong>
                                        <p>- Vui lòng thanh toán trước khi sử dụng dịch vụ.</p>
                                    </div>

                                    <!-- Signature Section -->
                                    <div class="row text-center mt-5">
                                        <div class="col-6">
                                            <div>Khách hàng<br><em>(Ký, ghi rõ họ tên)</em></div>
                                        </div>
                                        <div class="col-6">
                                            <div>Kế toán<br><em>(Ký, ghi rõ họ tên)</em></div>
                                        </div>
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
