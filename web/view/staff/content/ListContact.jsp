<%-- 
    Document   : ListContact
    Created on : May 22, 2025, 11:01:00 PM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Trang tư vấn liên hệ</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
        <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
        <meta name="author" content="Shreethemes" />
        <meta name="email" content="support@shreethemes.in" />
        <meta name="website" content="${pageContext.request.contextPath}/index.html" />
        <meta name="Version" content="v1.2.0" />
     
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
            .layout-specing {
                padding: 30px 20px;
            }

            /* Input & select form */
            form input[type="text"],
            form select {
                padding: 8px 12px;
                border: 1px solid #ced4da;
                outline: none;
                transition: all 0.2s ease-in-out;
                font-size: 14px;
                background-color: #fff;
            }

            form input[type="text"]:focus,
            form select:focus {
                border-color: #1976d2;
                box-shadow: 0 0 0 2px rgba(25, 118, 210, 0.2);
            }

            .btn-primary {
                background-color: #1976d2;
                border-color: #1976d2;
                font-size: 14px;
                padding: 6px 14px;
            }

            .btn-primary:hover {
                background-color: #1565c0;
                border-color: #1565c0;
            }

            /* Table */
            .table {
                margin-top: 20px;
                background-color: #fff;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            }

            .table th {
                background-color: #1976d2;
                color: #fff;
                font-weight: 600;
                vertical-align: middle;
            }

            .table td {
                vertical-align: middle;
                font-size: 14px;
            }

            .table-striped > tbody > tr:nth-of-type(odd) {
                background-color: #f9f9f9;
            }

            .table tbody tr:hover {
                background-color: #f1faff;
            }

          
            .form-select {
                font-size: 14px;
                padding: 6px 10px;
                border-radius: 6px;
            }


        </style>

    </head>
    <body>
        <%@ include file="../layout/Header.jsp" %>



        <div class="container-fluid bg-light">
            <div class="layout-specing">



                <div class="row">
                    <form class="d-flex mb-5 col-4" action="staff-search-contact" method="get" >
                        <input type="text" name="name" style="border-radius: 10px " placeholder="Tìm theo Họ và Tên" value="${param.searchName != null ? param.searchName : ''}">
                        <button type="submit" style="border-radius: 10px " class="btn btn-sm btn-primary ms-2">Tìm</button>
                    </form>

                    <form action="staff-filter-contact-status" method="get" class="mb-1 mt-1 col-8">
                        <label for="status">Chọn trạng thái:</label>
                        <select name="status" id="status"  style="border-radius: 10px ">
                            <option value="" ${requestScope.status ==null || requestScope.status=='' ? 'selected' :''}>Tất cả</option> 
                            <option value="pending" ${requestScope.status =='pending' ? 'selected' : ''}>Chờ xử lý</option>
                            <option value="in-progress" ${requestScope.status =='in-progress' ? 'selected' : ''}>Đang xử lý</option>
                            <option value="done" ${requestScope.status =='done' ? 'selected' : ''}>Đã xử lý </option>
                        </select>
                        <button type="submit" class="btn btn-sm btn-primary ms-2"  style="border-radius: 10px ">Lọc</button>
                    </form></div>


                <table class="table table-striped ">
                    <thead class="bg-primary text-white" >
                        <tr>
                            <th scope="col ">Số thứ tự</th>
                            <th scope="col ">Họ và tên</th>
                            <th scope="col">Email</th>
                            <th scope="col">Số điện thoại</th>
                            <th scope="col-5">Lời nhắn của khách hàng</th>
                            <th scope="col">Ngày liên hệ</th>
                            <th scope="col">Trạng thái</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${listContact}" var="c" varStatus="loop">
                            <tr>
                                <td>${loop.index + 1}</td>
                                <td>${c.name}</td>
                                <td>${c.email}</td>
                                <td>${c.phone}</td>
                                <td>${c.message}</td>
                                <td>${c.createdAt}</td>
                                <td>
                                    <select class="form-select" onchange="updateStatus('${c.id}', this.value)">
                                        <option   value="pending"  ${c.status == 'pending' ? 'selected' : ''}>Chờ xử lý</option>
                                        <option   value="in-progress" ${c.status == 'in-progress' ? 'selected' : ''}>Đang xử lý</option>
                                        <option    value="done" ${c.status == 'done' ? 'selected' : ''}>Đã xử lý</option>
                                    </select>

                                </td>
                            </tr>

                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <c:if test="${not empty listContact}">
            <nav aria-label="Page navigation">
                <ul class="pagination justify-content-center">
                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link" href="staff-contact?page=${currentPage - 1}">Trước</a>
                    </li>

                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                            <a class="page-link" href="staff-contact?page=${i}">${i}</a>
                        </li>
                    </c:forEach>

                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link" href="staff-contact?page=${currentPage + 1}">Sau</a>
                    </li>
                </ul>
            </nav>
        </c:if>

        <c:if test="${empty listContact}">
            <p class="text-center text-danger mt-3">Không có phản hồi nào.</p>
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
                var url = "staff-update-contact-status?id=" + id + "&status=" + status;
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