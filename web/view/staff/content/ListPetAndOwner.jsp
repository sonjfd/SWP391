<%-- 
    Document   : ListPetAndOwner
    Created on : Jun 8, 2025, 3:40:24 PM
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
            /* Bố cục toàn form */
            .layout-specing {
                padding: 30px;
            }

            /* Tiêu đề */
            h4 {
                font-weight: 700;
                color: #333;
                border-bottom: 2px solid #007bff;
                padding-bottom: 10px;
                margin-bottom: 20px;
            }

            /* Table chính */
            .table {
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 4px 10px rgba(0,0,0,0.05);
            }

            .table thead th {
                font-weight: 600;
                letter-spacing: 0.5px;
                font-size: 15px;
            }

            /* Các hàng của table */
            .table-striped tbody tr:nth-of-type(odd) {
                background-color: #f9f9f9;
            }

            .table-striped tbody tr:hover {
                background-color: #f1f9ff;
                transition: background-color 0.3s;
            }

            /* Badge trạng thái */
            .badge {
                font-size: 13px;
                padding: 5px 10px;
                border-radius: 12px;
            }

            /* Nút hành động */
            .btn-sm {
                margin-right: 5px;
                font-size: 13px;
                padding: 6px 12px;
                border-radius: 6px;
            }

            .btn-info {
                background-color: #17a2b8;
                border-color: #17a2b8;
            }

            .btn-warning {
                background-color: #ffc107;
                border-color: #ffc107;
                color: #212529;
            }

            /* Modal */
            .modal-content {
                border-radius: 12px;
                overflow: hidden;
                box-shadow: 0 8px 20px rgba(0,0,0,0.1);
            }

            .modal-header {
                padding: 15px 20px;
                font-size: 16px;
                font-weight: 600;
            }

            /* Ảnh avatar */
            .img-fluid.rounded-circle {
                border: 4px solid #f0f0f0;
                padding: 4px;
                background-color: white;
            }

            /* Table nhỏ trong modal */
            .modal-body .table-sm th {
                width: 35%;
                color: #555;
                font-weight: 600;
                padding: 8px 5px;
            }

            .modal-body .table-sm td {
                padding: 8px 5px;
                color: #333;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .modal-dialog {
                    margin: 1rem;
                }
            }

        </style>

    </head>
    <body>
        <%@ include file="../layout/Header.jsp" %>



        <div class="container-fluid bg-light">
            <div class="layout-specing">



                <h4 class="mb-4">Danh sách thú cưng và chủ sở hữu</h4>

                <div class="d-flex gap-3 mb-3 flex-wrap" style="max-width: 700px;">
                    <!-- Form lọc chủ -->
                    <form method="get" action="list-pet-and-owner" class="flex-grow-0" style="min-width: 250px;">
                        <label for="ownerFilter" class="form-label fw-semibold">Chủ sở hữu:</label>
                        <div class="d-flex gap-2">
                            <select name="ownerId" id="ownerFilter" class="form-select form-select-sm" style="flex-grow: 1;">
                                <option value="">-- Tất cả --</option>
                                <c:forEach items="${listuser}" var="u">
                                    <option value="${u.id}" ${param.ownerId == u.id ? 'selected' : ''}>
                                        ${u.fullName}
                                    </option>
                                </c:forEach>
                            </select>
                            <button type="submit" class="btn btn-primary btn-sm">Lọc</button>
                        </div>
                    </form>


                </div>



                <table class="table table-striped">
                    <thead class="bg-primary text-white">
                        <tr>
                            <th scope="col">STT</th>
                            <th scope="col">Tên thú cưng</th>
                            <th scope="col">Giống </th>

                            <th scope="col">Chủ sở hữu</th>

                            <th scope="col">Trạng thái</th>
                            <th class="col">Xem chi tiết</th>
                            <th scope="col">Đổi chủ</th>


                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${listpet}" var="p" varStatus="loop">
                            <tr>
                                <td>${loop.index + 1}</td>
                                <td>${p.name}</td>
                                <td>${p.breed.name}</td> 
                                <td>${p.user.fullName} (${p.user.email})</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${p.status == 'active'}">
                                            <span class="badge bg-success">Hoạt động</span>
                                        </c:when>
                                        <c:when test="${p.status == 'inactive'}">
                                            <span class="badge bg-secondary">Không hoạt động</span>
                                        </c:when>
                                        <c:when test="${p.status == 'lost'}">
                                            <span class="badge bg-warning text-dark">Đã thất lạc</span>
                                        </c:when>
                                        <c:when test="${p.status == 'deceased'}">
                                            <span class="badge bg-danger">Đã chết</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-dark">Không rõ</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>

                                    <button type="button" class="btn btn-info btn-sm" data-bs-toggle="modal" data-bs-target="#petModal-${p.id}">
                                        <i class="bi bi-eye"></i> 
                                    </button>

                                    <button type="button" class="btn btn-info btn-sm" data-bs-toggle="modal" data-bs-target="#historyModal-${p.id}">
                                        <i class="bi bi-journal-medical"></i>
                                    </button>



                                </td>
                                <td>
                                    <select class="form-select form-select-sm" style="width: 160px;"
                                            onchange="changeOwner('${p.id}', this.value)">
                                        <c:forEach items="${listuser}" var="u">
                                            <option value="${u.id}" ${u.id eq p.user.id ? 'selected' :''}>
                                                ${u.fullName}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </td>

                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <c:if test="${totalPages > 0}">
            <nav aria-label="Page navigation">
                <ul class="pagination justify-content-center">
                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link" href="list-pet-and-owner?page=${currentPage - 1}&ownerId=${selectedOwnerId}">Trước</a>
                    </li>

                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                            <a class="page-link" href="list-pet-and-owner?page=${i}&ownerId=${selectedOwnerId}">${i}</a>
                        </li>
                    </c:forEach>

                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link" href="list-pet-and-owner?page=${currentPage + 1}&ownerId=${selectedOwnerId}">Sau</a>
                    </li>
                </ul>
            </nav>
        </c:if>




        <c:forEach items="${listpet}" var="p">
            <div class="modal fade" id="historyModal-${p.id}" tabindex="-1" aria-labelledby="historyModalLabel-${p.id}" aria-hidden="true">
                <div class="modal-dialog modal-lg modal-dialog-scrollable">
                    <div class="modal-content">
                        <div class="modal-header bg-info text-white">
                            <h5 class="modal-title" id="historyModalLabel-${p.id}">Lịch sử khám bệnh - Thú Cưng: ${p.name}</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Đóng"></button>
                        </div>
                        <div class="modal-body">
                            <c:if test="${not empty p.medicalRecords}">
                                <c:forEach items="${p.medicalRecords}" var="mr">
                                    <div class="card mb-3 shadow-sm">
                                        <div class="card-header bg-light fw-semibold">
                                            Ngày khám: <fmt:formatDate value="${mr.appointment.appointmentDate}" pattern="dd/MM/yyyy HH:mm" />
                                        </div>
                                        <div class="card-body">
                                            <p><strong>Bác sĩ:</strong> ${mr.doctor.user.fullName} </p>
                                            <p><strong>Chẩn đoán:</strong> ${mr.diagnosis}</p>
                                            <p><strong>Điều trị:</strong> ${mr.treatment}</p>
                                            <p><strong>Ngày tái khám:</strong> 
                                                <c:choose>
                                                    <c:when test="${not empty mr.reExamDate}">
                                                        <fmt:formatDate value="${mr.reExamDate}" pattern="dd/MM/yyyy" />
                                                    </c:when>
                                                    <c:otherwise>Không có</c:otherwise>
                                                </c:choose>
                                            </p>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:if>
                            <c:if test="${empty p.medicalRecords}">
                                <div class="alert alert-warning text-center">
                                    Không có lịch sử khám bệnh nào cho thú cưng này.
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>



        <c:forEach items="${listpet}" var="p">
            <div class="modal fade" id="petModal-${p.id}" tabindex="-1" aria-labelledby="modalLabel-${p.id}" aria-hidden="true">
                <div class="modal-dialog modal-lg modal-dialog-scrollable">
                    <div class="modal-content">
                        <div class="modal-header bg-primary text-white">
                            <h5 class="modal-title" id="modalLabel-${p.id}">Chi tiết thú cưng & chủ sở hữu</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Đóng"></button>
                        </div>
                        <div class="modal-body">
                            <div class="row">

                                <div class="col-md-6">
                                    <h6 class="fw-bold text-center">Thú cưng</h6>
                                    <div class="text-center mb-3">
                                        <img src="${pageContext.request.contextPath}${p.avatar}" 
                                             alt="Ảnh thú cưng" class="img-fluid rounded-circle shadow" style="max-height: 180px;">
                                    </div>
                                    <table class="table table-sm table-borderless">
                                        <tr><th>Tên:</th><td>${p.name}</td></tr>
                                        <tr><th>Loài</th><td>${p.breed.specie.name  }</td></tr>
                                        <tr><th>Giống:</th><td>${p.breed.name}</td></tr>
                                        <tr><th>Giới tính:</th><td><c:out value="${p.gender}" /></td></tr>
                                        <tr><th>Trạng thái:</th>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${p.status == 'active'}">Hoạt động</c:when>
                                                    <c:when test="${p.status == 'inactive'}">Không hoạt động</c:when>
                                                    <c:when test="${p.status == 'lost'}">Đã thất lạc</c:when>
                                                    <c:when test="${p.status == 'deceased'}">Đã chết</c:when>
                                                    <c:otherwise>Không rõ</c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                        <tr><th>Mô tả:</th><td>${p.description}</td></tr>
                                    </table>
                                </div>


                                <div class="col-md-6">
                                    <h6 class="fw-bold text-center"> Chủ sở hữu</h6>
                                    <div class="text-center mb-3">
                                        <img src="${pageContext.request.contextPath}${p.user.avatar}" 
                                             alt="Ảnh chủ" class="img-fluid rounded-circle shadow" style="max-height: 160px;">
                                    </div>
                                    <table class="table table-sm table-borderless">
                                        <tr><th>Họ tên:</th><td>${p.user.fullName}</td></tr>
                                        <tr><th>Email:</th><td>${p.user.email}</td></tr>
                                        <tr><th>Điện thoại:</th><td>${p.user.phoneNumber}</td></tr>
                                        <tr><th>Địa chỉ:</th><td>${p.user.address}</td></tr>
                                    </table>
                                </div>

                            </div> 
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>




        <script>
            function changeOwner(petId, newOwnerId) {

                if (!newOwnerId)
                    return;

                var url = "change-pet-owner?petId=" + petId + "&newOwnerId=" + newOwnerId;

                window.location.href = url;
            }


            function getParam() {
                const param = new URLSearchParams(window.location.search);
                return param.get('success');
            }

            const success = getParam();

            if (success === 'true' || success === 'false') {


                if (success === 'true') {
                    alert('Đổi chủ thành công');
                } else {
                    alert('Đổi chủ thất bại');
                }

                statusModal.show();
                if (history.replaceState) {
                    const url = new URL(window.location.href);
                    url.searchParams.delete('success');
                    window.history.replaceState(null, '', url.pathname + url.search);
                }
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