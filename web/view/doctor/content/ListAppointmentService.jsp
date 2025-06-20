<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản Lý Dịch Vụ Lịch Hẹn</title>
        <!-- Các liên kết đến CSS và JS tương tự như mã ban đầu của bạn -->
        <!-- Bootstrap -->
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- simplebar -->
        <link href="${pageContext.request.contextPath}/assets/css/simplebar.css" rel="stylesheet" type="text/css" />
        <!-- Select2 -->
        <link href="${pageContext.request.contextPath}/assets/css/select2.min.css" rel="stylesheet" />
        <!-- Icons -->
        <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
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
            /* Thêm màu cho trạng thái đã hủy */
            .badge.bg-danger {
                background-color: #dc3545 !important; /* Màu đỏ */
                color: white;
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
        </style>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    </head>
    <body>
        <%@ include file="../layout/Header.jsp" %>

        <div class="container-fluid bg-light">
            <div class="layout-specing">
                <h4 class="mb-3">Danh sách Dịch vụ Lịch Hẹn</h4>

                <!-- Bộ lọc trạng thái và ngày -->
                <div class="d-flex justify-content-between align-items-center flex-wrap mb-4 gap-2">
                    <form id="filterForm" action="list-appointment-service" method="get" class="d-flex flex-wrap align-items-center gap-2 mb-0">
                        <!-- Trạng thái -->
                        <c:set var="selectedStatus" value="${param.status}" />

                        <select class="form-select form-select-sm" style="width: auto;" id="statusFilter" name="status">
                            <option value="" <c:if test="${empty selectedStatus}">selected</c:if>>Trạng thái</option>
                            <option value="pending" <c:if test="${selectedStatus == 'pending'}">selected</c:if>>Đang chờ</option>
                            <option value="completed" <c:if test="${selectedStatus == 'completed'}">selected</c:if>>Hoàn thành</option>
                            <option value="canceled" <c:if test="${selectedStatus == 'canceled'}">selected</c:if>>Đã hủy</option>
                            </select>

                            <!-- Từ ngày đến ngày -->
                            <input type="date" class="form-control form-control-sm" style="width: auto;" id="startDate" name="startDate" value="${param.startDate}" />
                        <input type="date" class="form-control form-control-sm" style="width: auto;" id="endDate" name="endDate" value="${param.endDate}" />


                        <button type="submit" class="btn btn-secondary btn-sm">
                            <i class="bi bi-funnel-fill"></i> Lọc
                        </button>
                    </form>

                    <!-- Nút thêm mới lịch hẹn -->
                    <a href="add-appointment-service" class="btn btn-primary btn-sm">
                        <i class="bi bi-plus-circle"></i> Thêm dịch vụ mới
                    </a>
                </div>

                <table class="table table-striped">
                    <thead class="bg-primary text-white">
                        <tr>
                            <th scope="col">STT</th>
                            <th scope="col">Tên thú cưng</th>
                            <th scope="col">Chủ sở hữu</th>
                            <th scope="col">Ngày khám</th>
                            <th scope="col">Ca khám</th>
                            <th scope="col">Trạng thái</th>
                            <th scope="col">Giá dịch vụ</th>
                            <th scope="col">Hoạt động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="appService" items="${appointmentServices}" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td>${appService.appointment.pet.name}</td>
                                <td>${appService.appointment.user.fullName}</td>
                                <td><fmt:formatDate value="${appService.appointment.appointmentDate}" pattern="dd/MM/yyyy" /></td>
                                <td>${appService.appointment.startTime} - ${appService.appointment.endTime}</td>
                                <td>
                                    <select class="form-select" onchange="updateStatus('${appService.id}', this.value)">
                                        <option   value="pending"  ${appService.status == 'pending' ? 'selected class="badge bg-warning"' : 'class="badge bg-warning"'}>Chờ xử lý</option>
                                        <option   value="completed" ${appService.status == 'completed' ? 'selected class="badge bg-success"' : 'class="badge bg-success"'}>Đã hoàn thành</option>
                                        <option    value="canceled" ${appService.status == 'canceled' ? 'selected class="badge bg-danger"' : 'class="badge bg-danger"'}>Đã hủy</option>
                                    </select>
                                    
                                </td>

                                <td>${appService.price} VNĐ</td>
                                <td>
                                    <div class="action-buttons">
                                        <button type="button" class="btn btn-info" data-bs-toggle="modal" data-bs-target="#detailModal-${appService.id}" title="Xem chi tiết">
                                            <i class="bi bi-info-circle"></i>
                                        </button>
                                        <button type="button" class="btn btn-info" data-bs-toggle="modal" data-bs-target="#updateStatusModal-${appService.id}" title="Cập nhật trạng thái">
                                            <i class="bi bi-pencil-square"></i> 
                                        </button>



                                        <button type="button" class="btn btn-danger" onclick="deleteAppointmentService('${appService.id}')" title="Xóa dịch vụ">
                                            <i class="bi bi-trash"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <!-- Phân trang -->
                <div class="d-flex justify-content-center">
                    <ul class="pagination">
                        <c:if test="${currentPage > 1}">
                            <li class="page-item"><a class="page-link" href="?page=${currentPage - 1}&status=${param.status}&startDate=${param.startDate}&endDate=${param.endDate}">Previous</a></li>
                            </c:if>

                        <c:forEach begin="1" end="${totalPages}" var="page">
                            <li class="page-item ${page == currentPage ? 'active' : ''}">
                                <a class="page-link" href="?page=${page}&status=${param.status}&startDate=${param.startDate}&endDate=${param.endDate}">${page}</a>
                            </li>
                        </c:forEach>

                        <c:if test="${currentPage < totalPages}">
                            <li class="page-item"><a class="page-link" href="?page=${currentPage + 1}&status=${param.status}&startDate=${param.startDate}&endDate=${param.endDate}">Next</a></li>
                            </c:if>

                    </ul>
                </div>

                <!-- Modal chi tiết dịch vụ -->
                <c:forEach var="appService" items="${appointmentServices}">
                    <div class="modal fade" id="detailModal-${appService.id}" tabindex="-1" aria-labelledby="detailModalLabel-${appService.id}" aria-hidden="true">
                        <div class="modal-dialog modal-lg modal-dialog-scrollable">
                            <div class="modal-content">
                                <div class="modal-header bg-primary text-white">
                                    <h5 class="modal-title" id="detailModalLabel-${appService.id}">Thông tin chi tiết dịch vụ</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <h5>Thông tin thú cưng</h5>
                                    <p><strong>Pet code:</strong> ${appService.appointment.pet.pet_code}</p>
                                    <p><strong>Tên:</strong> ${appService.appointment.pet.name}</p>
                                    <p><strong>Giống loài:</strong> ${appService.appointment.pet.breed.name}</p>
                                    <p><strong>Giới tính:</strong> ${appService.appointment.pet.gender}</p>
                                    <p><strong>Mô tả:</strong> ${appService.appointment.pet.description}</p>
                                    <hr/>
                                    <h5>Thông tin chủ sở hữu</h5>
                                    <p><strong>Tên chủ sở hữu:</strong> ${appService.appointment.user.fullName}</p>
                                    <p><strong>Email:</strong> ${appService.appointment.user.email}</p>
                                    <p><strong>Số điện thoại:</strong> ${appService.appointment.user.phoneNumber}</p>
                                    <hr/>
                                    <h5>Thông tin bác sĩ</h5>
                                    <p><strong>Bác sĩ:</strong> ${appService.appointment.doctor.user.fullName}</p>
                                    <hr/>
                                    <h5>Thông tin lịch hẹn</h5>
                                    <p><strong>Ngày khám:</strong> <fmt:formatDate value="${appService.appointment.appointmentDate}" pattern="dd/MM/yyyy" /></p>
                                    <p><strong>Ca khám:</strong> ${appService.appointment.startTime} - ${appService.appointment.endTime}</p>
                                    <p><strong>Dịch vụ:</strong> ${appService.service.name}</p>
                                    <p><strong>Trạng thái dịch vụ:</strong> ${appService.status}</p>
                                    <p><strong>Giá dịch vụ:</strong> ${appService.price} VNĐ</p>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                </div>
                            </div>
                        </div>
                    </div>
                                
                                 <div class="modal fade" id="updateStatusModal-${appService.id}" tabindex="-1" aria-labelledby="updateStatusModalLabel-${appService.id}" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="updateStatusModalLabel-${appService.id}">Cập nhật trạng thái</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form action="update-status-appointment-service" method="post">
                                    <input type="hidden" name="appointmentServiceId" value="${appService.id}" />
                                    <div class="mb-3">
                                        <label for="status" class="form-label">Chọn trạng thái</label>
                                        <select class="form-select" name="status" required>
                                            <option value="pending" ${appService.status == 'pending' ? 'selected' : ''}>Đang chờ</option>
                                            <option value="completed" ${appService.status == 'completed' ? 'selected' : ''}>Hoàn thành</option>
                                            <option value="canceled" ${appService.status == 'canceled' ? 'selected' : ''}>Đã hủy</option>
                                        </select>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="submit" class="btn btn-primary">Cập nhật</button>
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                </c:forEach>

               


            </div>
        </div>
        <c:if test="${not empty statusMessage}">
    <div class="alert alert-${statusType}">
        ${statusMessage}
    </div>
</c:if>

<!--       Modal thong bao-->
        <div class="modal fade" id="statusModal" tabindex="-1" aria-labelledby="statusModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="statusModalLabel">Thông báo</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                    </div>
                    <div class="modal-body" id="statusModalMessage">

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Đóng</button>
                    </div>
                </div>
            </div>
        </div>


        <script>
            function updateStatus(id, status) {
                var url = "update-status-appointment-service?id=" + id + "&status=" + status;
                window.location.href = url;
            }

function getParam() {
                const param = new URLSearchParams(window.location.search);
                return param.get('success');
            }

            const success = getParam();

            if (success === 'true' || success === 'false') {
                var statusModal = new bootstrap.Modal(document.getElementById('statusModal'));
                var messageElem = document.getElementById('statusModalMessage');

                if (success === 'true') {
                    messageElem.textContent = 'Đã cập nhật trạng thái thành công';
                } else {
                    messageElem.textContent = 'Cập nhật thất bại! Vui lòng thử lại';
                }

                statusModal.show();
                if (history.replaceState) {
                    const url = new URL(window.location.href);
                    url.searchParams.delete('success');
                    window.history.replaceState(null, '', url.pathname + url.search);
                }
            }


        </script>


        <script>
            function updateAppointmentService(id) {
                window.location.href = 'update-appointment-service?id=' + encodeURIComponent(id);
            }

            function deleteAppointmentService(id) {
                if (confirm('Bạn có chắc chắn muốn xóa dịch vụ này?')) {
                    window.location.href = 'delete-appointment-service?id=' + encodeURIComponent(id);
                }
            }
        </script>
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
    <!-- simplebar -->
    <script src="${pageContext.request.contextPath}/assets/js/simplebar.min.js"></script>
    <!-- Chart -->
    <!-- Icons -->
    <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
    <!-- Main Js -->
    <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
</body>
</html>
