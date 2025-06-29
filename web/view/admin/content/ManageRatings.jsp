<%-- 
    Document   : ManageRatings
    Created on : Jun 18, 2025, 5:50:38 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>Quản lý đánh giá - Pet24h</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico">
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" />
        <style>

            .canle {
                display: flex;
                flex-wrap: wrap;
                align-items: center;
                gap: 100px;
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
            .headtable{
                background-color: #f8f9fa;
            }


        </style>

    </head>
    <body>
        <%@include file="../layout/Header.jsp" %>
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
        <div class="container-fluid">
            <div class="layout-specing">
                <h5 class="mb-0">Quản lý đánh giá</h5>

                <div class="search-filter-container">
                    <form method="get" action="admin-listratings" class="d-flex gap-2 mb-3">
                        <input type="text" class="form-control" placeholder="Tìm theo tên khách hàng" name="search" value="${search}">
                        <select name="status" class="form-select w-auto">
                            <option value="" ${status == null || status == '' ? 'selected' : ''}>-- Tất cả --</option>
                            <option value="posted" ${status == 'posted' ? 'selected' : ''}>Đã đăng</option>
                            <option value="hide" ${status == 'hide' ? 'selected' : ''}>Đã ẩn</option>
                        </select>
                        <button type="submit" class="btn btn-primary">Lọc</button>
                    </form>
                </div>
                <c:if test="${not empty message}">
                    <div class="${message.contains('successfully') ? 'message' : 'error'}">${message}</div>
                </c:if>

                <table class="table table-bordered text-center align-middle">
                    <thead class="table-primary">
                        <tr>
                            <th>STT</th>
                            <th>Khách hàng</th>
                            <th>Nội dung</th>
                            <th>Độ hài lòng</th>
                            <th>Trạng thái</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="rate" items="${RateList}" varStatus="counter">
                            <tr>
                                <td>${counter.index + 1 + (currentPage - 1) * 5}</td>
                                <td>${rate.user.fullName}</td>
                                <td>${rate.comment}</td>
                                <td style="color: gold; font-size: 18px;">
                                    <c:forEach begin="1" end="${rate.satisfaction_level}" var="i">
                                        ★
                                    </c:forEach>
                                </td>


                                <td>
                                    <form method="post" action="admin-listratings" class="d-flex justify-content-center">
                                        <input type="hidden" name="ratingId" value="${rate.id}">
                                        <select name="status" class="form-select w-auto me-2">
                                            <option value="posted" ${rate.status == 'posted' ? 'selected' : ''}>Đã đăng</option>
                                            <option value="hide" ${rate.status == 'hide' ? 'selected' : ''}>Đã ẩn</option>
                                        </select>
                                        <button type="submit" class="btn btn-sm btn-primary">Lưu</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty RateList}">
                            <tr><td colspan="5">Không có dữ liệu đánh giá.</td></tr>
                        </c:if>
                    </tbody>
                </table>

                <c:if test="${totalPages > 1}">
                    <nav>
                        <ul class="pagination justify-content-center">
                            <c:forEach begin="1" end="${totalPages}" var="p">
                                <li class="page-item ${p == currentPage ? 'active' : ''}">
                                    <a class="page-link"
                                       href="admin-listratings?page=${p}&search=${search}&status=${status}">${p}</a>
                                </li>
                            </c:forEach>
                        </ul>
                    </nav>
                </c:if>


            </div>
        </div>

        <%@include file="../layout/Footer.jsp" %>

        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>

    </body>
</html>