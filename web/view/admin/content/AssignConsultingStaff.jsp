<%-- 
    Document   : AssignConsultingStaff
    Created on : Jun 26, 2025, 9:22:47 PM
    Author     : Admin
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>Chỉ định nhân viên tư vấn - Pet24h</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
            .badge {
                padding: 5px 10px;
                border-radius: 8px;
            }

            .img-fluid{
                max-height: 50px;
                max-width: 50px;

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
                <h5 class="mb-0">Chỉ định nhân viên đảm nhiệm tư vấn khách hàng</h5>
                <c:if test="${not empty message}">
                    <div class="${message.contains('successfully') ? 'message' : 'error'}">${message}</div>
                </c:if>

                <table class="table table-hover table-striped align-middle text-center">
                    <thead class="table-primary">
                        <tr class="headtable">
                            <th>STT</th>
                            <th>Tên nhân viên</th>
                            <th>Điện thoại</th>
                            <th>Địa chỉ</th>
                            <th>Avatar</th>
                            <th>Hành động</th>

                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="staff" items="${STAFFLIST}" varStatus="counter">
                            <tr>
                                <td>${counter.count}</td>
                                <td>${staff.fullName}</td>
                                <td>${staff.phoneNumber}</td>
                                <td>${staff.address}</td>
                                <td><img src="${staff.avatar}" class="img-fluid" alt=""></td>
                                <td>
                                    <c:set value="${requestScope.STAFFASSIGNID}" var="staffid" />

                                    <c:if test="${staff.id == staffid}">
                                        <span class="badge bg-success">Đang đảm nhiệm</span>
                                    </c:if>

                                    <c:if test="${staff.id != staffid}">
                                        <form method="post" action="admin-assignconsultingstaff" onsubmit="return confirm('Bạn có chắc muốn chỉ định nhân viên này làm tư vấn viên?');">
                                            <input type="hidden" name="staffId" value="${staff.id}" />
                                            <button type="submit" class="btn btn-primary btn-sm">Chỉ định</button>
                                        </form>

                                    </c:if>
                                </td>

                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

            </div>
        </div>

        <%@include file="../layout/Footer.jsp" %>

        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>

    </body>
</html>