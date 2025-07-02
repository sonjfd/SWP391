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



                <h4 class="mb-3">Danh sách lịch hẹn</h4>


                <div class="d-flex justify-content-between align-items-center flex-wrap mb-4 gap-2">


                    <form id="filterForm" action="staff-list-appointment" method="get" class="d-flex flex-wrap align-items-center gap-2 mb-0">

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
                                <c:if test="${d.user.status==1}">
                                    <option value="${d.user.id}" 
                                            ${d.user.id == selectedDoctor ? "selected" : ""}>
                                        ${d.user.fullName}
                                    </option>
                                </c:if>
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
                                <form action="staff-updatebookingprice" method="post">
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
                        <a href="staff-add-new-booking" class="btn btn-primary btn-sm">
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
                            <th scope="col" style="width: 220px;">Hoạt động</th>


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

                                        <c:when test="${app.status == 'booked'}">
                                            <span class="badge bg-success">Đã Đặt</span>
                                        </c:when>

                                        <c:when test="${app.status == 'canceled'}">
                                            <span class="badge bg-danger">Đã huỷ</span>
                                        </c:when>

                                        <c:when test="${app.status == 'cancel_requested'}">
                                            <span class="badge bg-info text-white">Khách yêu cầu huỷ</span>
                                        </c:when>


                                        <c:when test="${app.status == 'completed'}">
                                            <span class="badge bg-success">Đã khám xong</span>
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

                                <td>
                                    <c:choose>
                                        <c:when test="${app.chekinStatus == 'noshow'}">
                                            <span class="badge bg-warning text-dark">Chưa tới khám</span>
                                        </c:when>
                                        <c:when test="${app.chekinStatus == 'checkin'}">
                                            <span class="badge bg-success">Đã tới khám</span>
                                        </c:when>

                                    </c:choose>
                                </td>


                                <td>
                                    <div class="d-flex gap-1">
                                        <a href="staff-appointmentdetail?id=${app.id}" class="btn btn-info btn-sm" title="Xem chi tiết">
                                            <i class="bi bi-info-circle"></i>
                                        </a>
                                        <a href="staff-update-appointment?id=${app.id}" class="btn btn-success btn-sm" title="Cập nhật lịch hẹn">
                                            <i class="bi bi-pencil-square"></i>
                                        </a>
                                        <button type="button" class="btn btn-outline-dark btn-sm" title="In phiếu thú cưng"
                                                data-bs-toggle="modal" data-bs-target="#printModal-${app.id}">
                                            <i class="bi bi-printer"></i>
                                        </button>


                                        <c:if test="${ app.chekinStatus == 'noshow'}">
                                            <form action="staff-update-chekin" method="get" style="display:inline;">
                                                <input type="hidden" name="id" value="${app.id}" />
                                                <button type="submit" class="btn btn-outline-primary btn-sm" title="Xác nhận đã tới khám">
                                                    <i class="bi bi-person-check"></i>
                                                </button>
                                            </form>
                                        </c:if>

                                        <c:if test="${app.status == 'cancel_requested'}">
                                            <form action="staff-approve-cancel-appointment" method="post" style="display:inline;">
                                                <input type="hidden" name="id" value="${app.id}" />
                                                <button type="submit" class="btn btn-outline-danger btn-sm" title="Duyệt huỷ lịch hẹn">
                                                    <i class="bi bi-x-circle"></i>
                                                </button>
                                            </form>
                                        </c:if>



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
                                   href="staff-list-appointment?page=${currentPage - 1}&slot=${selectedSlot}&date=${selectedDate}&doctor=${selectedDoctor}" 
                                   tabindex="-1">Trước</a>
                            </li>

                            <c:forEach var="i" begin="1" end="${totalPages}">
                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                    <a class="page-link" 
                                       href="staff-list-appointment?page=${i}&slot=${selectedSlot}&date=${selectedDate}&doctor=${selectedDoctor}">
                                        ${i}
                                    </a>
                                </li>
                            </c:forEach>

                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link" 
                                   href="staff-list-appointment?page=${currentPage + 1}&slot=${selectedSlot}&date=${selectedDate}&doctor=${selectedDoctor}">
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

                                    <div class="print-section">
                                        <!-- Header Section -->
                                        <div class="header text-center mb-4">
                                            <c:if test="${not empty ClinicInfo.logo}">
                                                <img src="${ClinicInfo.logo}" alt="Logo Phòng khám" class="mb-3" style="max-width: 150px;">
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

                                            <h4 class="mt-3">PHIẾU KHÁM BỆNH</h4>
                                        </div>

                                        <!-- Appointment Information Table -->
                                        <div class="container">
                                            <table class="table table-bordered mb-4">
                                                <tbody>
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
                                                </tbody>
                                            </table>

                                            <!-- Customer Information Table -->
                                            <table class="table table-bordered">
                                                <tbody>
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
                                                </tbody>
                                            </table>
                                        </div>

                                        <!-- Signature Section -->
                                        <div class="row text-center mt-4">
                                            <div class="col-6">
                                                <div>Khách hàng<br/><em>(Ký, họ tên)</em></div>
                                            </div>
                                            <div class="col-6">
                                                <div>Người tiếp nhận<br/><em>(Ký, họ tên)</em></div>
                                            </div>
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




            function getParam() {
                const param = new URLSearchParams(window.location.search);
                return param.get('success');
            }

            const success = getParam();



            if (success === '1') {
                alert(' Đã thêm lịch hẹn thành công!');
            } else if (success === 'update_success') {
                alert(' Đã cập nhật lịch hẹn thành công!');
            } else if (success === 'cancel_success') {
                alert(' Lịch hẹn đã được huỷ!');
            } else if (success === 'update_checkin') {
                alert('Checkin thành công');
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
