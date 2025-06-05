<%-- 
    Document   : Admin
    Created on : May 21, 2025, 8:24:23 PM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
        
        
        
<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f4f6f8;
        margin: 0;
        padding: 20px;
    }

    .container {
        max-width: 1000px;
        margin: auto;
        background-color: #ffffff;
        padding: 30px;
        border-radius: 12px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
    }

    h2 {
        color: #2c3e50;
        margin-bottom: 20px;
        font-size: 24px;
        font-weight: 600;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 10px;
    }

    th, td {
        padding: 12px 15px;
        border: 1px solid #e0e0e0;
        text-align: left;
    }

    th {
        background-color: #1976d2;
        color: #ffffff;
        font-weight: 600;
        font-size: 14px;
        text-transform: uppercase;
    }

    tr:nth-child(even) {
        background-color: #f9f9f9;
    }

    tr:hover {
        background-color: #f1f1f1;
    }

    .btn {
        padding: 6px 12px;
        font-size: 13px;
        border-radius: 5px;
        text-decoration: none;
        transition: 0.2s ease-in-out;
        display: inline-block;
    }

    a.update-btn {
        background-color: #d32f2f !important;
        color: white !important;
        font-weight: 500;
        padding: 6px 14px;
        border-radius: 6px;
        font-size: 14px;
        display: inline-flex;
        align-items: center;
        transition: background-color 0.2s ease, transform 0.1s ease;
    }

    a.update-btn:hover {
        background-color: #0b5ed7 !important;
        transform: scale(1.02);
        box-shadow: 0 4px 12px rgba(13, 110, 253, 0.2);
    }

    .message {
        padding: 12px 16px;
        border-radius: 6px;
        margin-bottom: 20px;
        font-size: 14px;
    }

    .message.success {
        background-color: #d4edda;
        color: #155724;
        border: 1px solid #c3e6cb;
    }

    .message.error {
        background-color: #f8d7da;
        color: #721c24;
        border: 1px solid #f5c6cb;
    }

    .layout-specing h5 {
        font-size: 20px;
        font-weight: 600;
        margin-bottom: 20px;
    }
</style>


    </head>

    <body>
        <!-- Loader -->
        <div id="preloader">
            <div id="status">
                <div class="spinner">
                    <div class="double-bounce1"></div>
                    <div class="double-bounce2"></div>
                </div>
            </div>
        </div>
        <!-- Loader -->

       

                
        <%@include file="../layout/Header.jsp" %>
                <!--sadasdasdasdas-->
                <div class="container-fluid">
                    <div class="layout-specing">
                        <h5 class="mb-0">Thông tin phòng khám</h5>

        <div class="container">
        
        <c:if test="${not empty message}">
            <p class="message ${messageType}">${message}</p>
        </c:if>
        

        <table>
            <tr>
                <th>STT</th>
                <th>Tên</th>
                <th>Mô tả</th>
                <th>Số điện thoại</th>
                <th>Email</th>
                <th>Hoạt động</th>
            </tr>
            <c:forEach var="clinic" items="${clinics}" varStatus="counter">
                <tr>
                    <td>${counter.count}</td>
                    <td>${clinic.name}</td>
                    <td>${clinic.address}</td>
                    <td>${clinic.phone}</td>
                    <td>${clinic.email}</td>
                    <td>
                        <a href="updateclinicinfo?id=${clinic.id}" class="btn update-btn">Cập nhật</a>
                    </td>
                </tr>
            </c:forEach>
        </table>

        <c:if test="${empty clinics}">
            <p>No clinics found.</p>
        </c:if>
    </div>              

                    



       
        
        
        <!-- javascript -->
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
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