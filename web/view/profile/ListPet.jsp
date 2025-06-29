<%-- 
    Document   : ListPet
    Created on : May 26, 2025, 11:13:20 AM
    Author     : Admin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

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
            .filter-container {
                display: flex;
                align-items: center;
                gap: 10px;
                flex-wrap: wrap;
                margin-bottom: 15px;
                background: #fff;
                padding: 15px;
                border-radius: 8px;
                box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            }

            .filter-container input[type="text"],
            .filter-container select,
            .filter-container button {
                height: 38px;
                padding: 6px 12px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            .filter-container input[type="text"],
            .filter-container select {
                min-width: 200px;
            }

            .filter-container button {
                background-color: #28a745;
                color: #fff;
                border: none;
            }

            .filter-container button:hover {
                background-color: #218838;
            }

            .filter-container .btn-search {
                background-color: #007bff;
            }

            .filter-container .btn-search:hover {
                background-color: #0056b3;
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
                        <form method="get" action="customer-viewlistpet" class="search-filter-form">
                            <div class="filter-container">
                                <input type="text" name="search" placeholder="Tìm theo tên thú cưng" value="${param.search}">

                                <label for="status">Lọc theo trạng thái:</label>
                                <select name="status" id="status">
                                    <option value="">-- Tất cả --</option>
                                    <option value="active" ${param.status == 'active' ? 'selected' : ''}>Hoạt động</option>
                                    <option value="inactive" ${param.status == 'inactive' ? 'selected' : ''}>Không hoạt động</option>
                                    <option value="lost" ${param.status == 'lost' ? 'selected' : ''}>Đã mất</option>
                                    <option value="deceased" ${param.status == 'deceased' ? 'selected' : ''}>Đã thất lạc</option>
                                </select>

                                <button type="submit" class="btn-search">Tìm kiếm</button>

                                <a href="customer-addpet" class="btn btn-success">+ Thêm mới</a>
                            </div>
                        </form>


                        <table class="table table-striped ">
                            <thead>
                                <tr>
                                    <th>STT</th>
                                    <th>Mã</th>
                                    <th>Tên Pet</th>
                                    <th>Giới Tính</th>
                                    <th>Ảnh</th>
                                    <th>Loài</th>
                                    <th>Trạng Thái</th>
                                    <th>Hành Động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${listpet}" var="pet" varStatus="status">
                                    <tr>
                                        <td>${status.index+1}</td>
                                        <td>${pet.pet_code}</td>
                                        <td>${pet.name}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${pet.gender == 'Đực'}">Đực</c:when>
                                                <c:when test="${pet.gender == 'Cái'}">Cái</c:when>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <img src="${pet.avatar}" alt="pet" width="100px" height="80px" />
                                        </td>
                                        <td>${pet.breed.specie.name}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${pet.status == 'active'}">Hoạt động</c:when>
                                                <c:when test="${pet.status == 'inactive'}">Không hoạt động</c:when>
                                                <c:when test="${pet.status == 'lost'}">Đã chết</c:when>
                                                <c:when test="${pet.status == 'deceased'}">Đã thất lạc</c:when>

                                            </c:choose>
                                        </td>

                                        <td>

                                            <button type="button" class="btn btn-info" 
                                                    data-bs-toggle="modal" data-bs-target="#detailPetModal${pet.id}">
                                                <i class="fa-solid fa-circle-info"></i>
                                            </button>


                                            <a href="customer-updatepet?petID=${pet.id}" class="btn btn-warning">
                                                <i class="fa-solid fa-pen-to-square"></i>
                                            </a>


                                            <form action="customer-deletepet" method="post" style="display:inline;" 
                                                  onsubmit="return confirm('Bạn có chắc muốn xóa pet này không?');">
                                                <input type="hidden" name="id" value="${pet.id}" />
                                                <button type="submit" class="btn btn-danger ">
                                                    <i class="fa-solid fa-trash"></i>
                                                </button>
                                            </form>
                                        </td>

                                    </tr>


                                    <!-- Modal Chi tiết -->
                                <div class="modal fade" id="detailPetModal${pet.id}" tabindex="-1" aria-labelledby="detailPetModalLabel${pet.id}" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered modal-lg">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="detailPetModalLabel${pet.id}">Thông tin chi tiết Pet</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                                            </div>
                                            <div class="modal-body">
                                                <div class="row">
                                                    <div class="col-md-4 text-center">
                                                        <img src="${pet.avatar}" alt="Pet" 
                                                             class="img-fluid rounded mb-3" 
                                                             style="max-width: 100%;
                                                             height: auto;" />
                                                    </div>

                                                    <div class="col-md-8">

                                                        <p><strong>Mã:</strong> ${pet.pet_code}</p>
                                                        <p><strong>Tên:</strong> ${pet.name}</p>
                                                        <p><strong>Giới tính:</strong>
                                                            <c:choose>
                                                                <c:when test="${pet.gender == 'Đực'}">Đực</c:when>
                                                                <c:when test="${pet.gender == 'Cái'}">Cái</c:when>
                                                            </c:choose>
                                                        </p>
                                                        <p><strong>Ngày sinh:</strong> ${pet.birthDate}</p>
                                                        <p><strong>Loại:</strong> ${pet.breed.specie.name}</p>
                                                        <p><strong>Giống:</strong> ${pet.breed.name}</p>
                                                        <p><strong>Trạng thái:</strong>
                                                            <c:choose>
                                                                <c:when test="${pet.status == 'active'}">Hoạt động</c:when>
                                                                <c:when test="${pet.status == 'inactive'}">Không hoạt động</c:when>
                                                                <c:when test="${pet.status == 'lost'}">Đã thất lạc</c:when>
                                                                <c:when test="${pet.status == 'deceased'}">Đã qua đời</c:when>
                                                            </c:choose>
                                                        </p>

                                                        <p><strong>Mô tả:</strong> ${pet.description}</p>
                                                        <p><strong>Ngày tạo:</strong> ${pet.createDate}</p>
                                                        <p><strong>Ngày cập nhật:</strong> ${pet.updateDate}</p>
                                                    </div>
                                                </div>
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
                        <c:if test="${totalPages > 1}">
                            <nav aria-label="Page navigation example">
                                <ul class="pagination justify-content-center">

                                    <c:if test="${currentPage > 1}">
                                        <li class="page-item">
                                            <a class="page-link" href="customer-viewlistpet?page=${currentPage - 1}&search=${petName}&status=${status}">Trước</a>
                                        </li>
                                    </c:if>

                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                            <a class="page-link" href="customer-viewlistpet?page=${i}&search=${petName}&status=${status}">${i}</a>
                                        </li>
                                    </c:forEach>

                                    <c:if test="${currentPage < totalPages}">
                                        <li class="page-item">
                                            <a class="page-link" href="customer-viewlistpet?page=${currentPage + 1}&search=${petName}&status=${status}">Sau</a>
                                        </li>
                                    </c:if>

                                </ul>
                            </nav>
                        </c:if>

                        <p type="text" name="id" style="color: red"  >${requestScope.Message}</p>






                    </div><!--end row-->
                </div><!-- End -->
            </section><!--end section-->

        </div>


        <!-- javascript -->
        <script>
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


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

        <!-- Icons -->
        <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
    </body>

</html>
