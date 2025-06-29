<%-- 
    Document   : ListMedicalHistory
    Created on : Jun 9, 2025, 3:57:11 AM
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
            body {
                margin: 0;
                padding: 0;
                font-family: 'Segoe UI', sans-serif;
                background-color: #f5f7fa;
            }

            table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0;
                margin-top: 20px;
                background-color: #fff;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
                border-radius: 12px;
                overflow: hidden;
            }

            thead {
                background-color: #007bff;
                color: white;
            }

            th, td {
                padding: 12px 16px;
                text-align: center;
                border-bottom: 1px solid #dee2e6;
            }

            tbody tr:hover {
                background-color: #f1f1f1;
            }

            th:first-child, td:first-child {
                border-left: none;
            }

            th:last-child, td:last-child {
                border-right: none;
            }

            img {
                border-radius: 8px;
                object-fit: cover;
            }

            .canle {
                display: flex;
                justify-content: space-between;
                flex-wrap: wrap;
                align-items: center;
                margin-bottom: 20px;
                gap: 10px;
            }

            .create-btn {
                padding: 10px 20px;
                background-color: #28a745;
                color: white;
                text-decoration: none;
                border-radius: 6px;
                font-weight: bold;
                transition: background-color 0.3s;
            }

            .create-btn:hover {
                background-color: #218838;
            }

            .search-form, .filter-form {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .search-form input[type="text"],
            .form-select {
                padding: 8px 12px;
                border: 1px solid #ccc;
                border-radius: 6px;
                font-size: 14px;
                outline: none;
            }

            .search-form input[type="text"]:focus {
                border-color: #007bff;
            }

            .search-form button {
                padding: 8px 16px;
                background-color: #007bff;
                color: white;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .search-form button:hover {
                background-color: #0056b3;
            }

            .btn {
                padding: 6px 12px;
                border-radius: 6px;
                font-size: 14px;
                color: white;
                transition: background-color 0.3s ease;
                margin: 0 2px;
            }

            .btn-info {
                background-color: #17a2b8;
                border: none;
            }

            .btn-info:hover {
                background-color: #138496;
            }

            .btn-warning {
                background-color: #ffc107;
                border: none;
                color: #212529;
            }

            .btn-warning:hover {
                background-color: #e0a800;
            }

            .btn-danger {
                background-color: #dc3545;
                border: none;
            }

            .btn-danger:hover {
                background-color: #c82333;
            }

            .form-label {
                font-weight: 500;
                margin: 0;
                white-space: nowrap;
                color: #333;
            }

            .modal-content {
                border-radius: 10px;
            }

            .modal-header {
                background-color: #007bff;
                color: white;
                border-bottom: none;
            }

            .modal-footer {
                border-top: none;
            }

            .img-fluid {
                max-height: 300px;
                border-radius: 10px;
            }

            p {
                margin-bottom: 8px;
            }

            footer {
                margin-top: 20px;
            }
            .canle {
                display: flex;
                flex-wrap: wrap;
                align-items: center;
                justify-content: space-between;
                gap: 12px;
                margin-bottom: 20px;
                background-color: #fff;
                padding: 16px 20px;
                border-radius: 12px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            }

            .search-form,
            .filter-form {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .search-form input[type="text"],
            .filter-form .form-select {
                padding: 8px 14px;
                border: 1px solid #ccc;
                border-radius: 6px;
                font-size: 14px;
                outline: none;
                transition: border-color 0.2s, box-shadow 0.2s;
                background-color: #f8f9fa;
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

            .create-btn {
                padding: 10px 20px;
                background-color: #28a745;
                color: white;
                border-radius: 6px;
                text-decoration: none;
                font-weight: 600;
                box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
                transition: background-color 0.3s ease;
            }

            .create-btn:hover {
                background-color: #218838;
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
                                <img src="${user.avatar}" class="img-fluid" alt="">
                            </div>
                            <div class="text-center avatar-profile margin-nagative mt-n5 position-relative pb-4 border-bottom">
                                <img src="${user.avatar}" class="rounded-circle shadow-md avatar avatar-md-md" alt="">
                                <h5 class="mt-3 mb-1">${user.fullName}</h5>

                            </div>
                            <ul class="list-unstyled sidebar-nav mb-0">
                                <li class="navbar-item"><a href="customer-viewappointment" class="navbar-link"><i class="ri-calendar-check-line align-middle navbar-icon"></i> Danh sách cuộc hẹn</a></li>
                                <li class="navbar-item"><a href="customer-viewmedicalhistory" class="navbar-link"><i class="ri-timer-line align-middle navbar-icon"></i>Lịch sử khám bệnh</a></li>
                                <li class="navbar-item"><a href="customer-viewlistpet" class="navbar-link"><i class="ri-bear-smile-line align-middle navbar-icon"></i> Danh sách thú cưng</a></li>
                                <li class="navbar-item"><a href="customer-updateuserinformation" class="navbar-link"><i class="ri-user-settings-line align-middle navbar-icon"></i> Cài đặt thông tin cá nhân</a></li>
                                <li class="navbar-item"><a href="customer-chat" class="navbar-link"><i class="ri-chat-voice-line align-middle navbar-icon"></i> Chat với nhân viên hỗ trợ</a></li>
                            </ul>

                        </div>
                    </div><!--end col-->

                    <div class=" col-9">

                        <!-- Start -->
                        <div class="d-flex align-items-center mb-3 flex-wrap gap-2">
                            <form method="get" action="customer-viewmedicalhistory" class="d-flex align-items-center flex-wrap gap-2">
                                <input type="text" name="search" value="${petName}" class="form-control" placeholder="Tìm theo tên pet" style="width: 200px;">

                                <label class="form-label mb-0">Tái khám từ:</label>
                                <input type="date" name="datefrom" value="${fromDate}" class="form-control" style="width: 160px;">

                                <label class="form-label mb-0">Đến:</label>
                                <input type="date" name="dateto" value="${toDate}" class="form-control" style="width: 160px;">

                                <button type="submit" class="btn btn-primary">Lọc</button>
                            </form>
                        </div>

                        <table class="table table-striped text-center">
                            <thead class="table-primary">
                                <tr>
                                    <th>STT</th>
                                    <th>Mã</th>
                                    <th>Tên Pet</th>
                                    <th>Chuẩn đoán</th>
                                    <th>Điều trị</th>
                                    <th>Tái khám</th>
                                    <th>Bác sĩ</th>
                                    <th>Ngày tạo</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${ListPetsMedical}" var="medical" varStatus="status">
                                    <tr>
                                        <td>${(currentPage - 1) * 5 + status.index + 1}</td>
                                        <td>${medical.pet.pet_code}</td>
                                        <td>${medical.pet.name}</td>
                                        <td>${medical.diagnosis}</td>
                                        <td>${medical.treatment}</td>
                                        <td>${medical.reExamDate}</td>
                                        <td>${medical.doctor.user.fullName}</td>
                                        <td><fmt:formatDate value="${medical.createdAt}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                        <td>
                                            <button type="button" class="btn btn-info btn-sm" data-bs-toggle="modal" data-bs-target="#detailMedicalRecord${medical.id}">
                                                <i class="fa-solid fa-circle-info"></i>
                                            </button>
                                        </td>
                                    </tr>

                                    <!-- Modal Chi tiết -->
                                <div class="modal fade" id="detailMedicalRecord${medical.id}" tabindex="-1" aria-labelledby="detailMedicalRecordLabel${medical.id}" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered modal-lg">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="detailMedicalRecordLabel${medical.id}">Chi tiết lịch sử khám</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                                            </div>
                                            <div class="modal-body">
                                                <div class="row">
                                                    <div class="col-md-4 text-center">
                                                        <img src="${medical.pet.avatar}" alt="Pet" class="img-fluid rounded mb-3" style="max-width: 100%; height: auto;">
                                                    </div>
                                                    <div class="col-md-8">
                                                        <p><strong>Mã:</strong> ${medical.pet.pet_code}</p>
                                                        <p><strong>Tên:</strong> ${medical.pet.name}</p>
                                                        <p><strong>Chuẩn đoán:</strong> ${medical.diagnosis}</p>
                                                        <p><strong>Điều trị:</strong> ${medical.treatment}</p>
                                                        <p><strong>Ngày tái khám:</strong> ${medical.reExamDate}</p>
                                                        <p><strong>Bác sĩ:</strong> ${medical.doctor.user.fullName}</p>
                                                        <p><strong>Ngày tạo:</strong> <fmt:formatDate value="${medical.createdAt}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
                                                        <p><strong>Ngày cập nhật:</strong> <fmt:formatDate value="${medical.updatedAt}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
                                                    </div>
                                                </div>

                                                <hr>
                                                <h6 class="mt-3">Tệp đính kèm:</h6>
                                                <c:if test="${empty medical.files}">
                                                    <p>Không có tệp đính kèm.</p>
                                                </c:if>
                                                <c:forEach var="file" items="${medical.files}">
                                                    <div class="mb-2">
                                                        <c:choose>
                                                            <c:when test="${file.fileUrl.endsWith('.jpg') || file.fileUrl.endsWith('.png') || file.fileUrl.endsWith('.jpeg') || file.fileUrl.endsWith('.gif')}">
                                                                <a href="${file.fileUrl}" download target="_blank">
                                                                    <img src="${file.fileUrl}" alt="${file.fileName}" style="max-width: 100px; max-height: 100px; border-radius: 5px; margin-right: 10px;">
                                                                    <span>${file.fileName}</span>
                                                                </a>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <a href="${file.fileUrl}" download target="_blank">
                                                                    <i class="fas fa-file-alt"></i> ${file.fileName}
                                                                </a>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                            </tbody>
                        </table>

                        <!-- Phân trang -->
                        <nav aria-label="Page navigation">
                            <ul class="pagination justify-content-center">
                                <c:forEach var="i" begin="1" end="${totalPages}">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link"
                                           href="customer-viewmedicalhistory?page=${i}&search=${petName}&datefrom=${fromDate}&dateto=${toDate}">
                                            ${i}
                                        </a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </nav>

                        <p type="text" name="id" style="color: red"  >${requestScope.Message}</p>

                    </div><!--end row-->
                </div><!-- End -->
            </section><!--end section-->

        </div>




        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

        <!-- Icons -->
        <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
    </body>

</html>
