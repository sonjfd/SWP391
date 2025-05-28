<%-- 
    Document   : Admin
    Created on : May 21, 2025, 8:24:23 PM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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



        <title>Staff/Doctor Accounts</title>
        

        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 50px;
                background-color: #f4f4f4;
            }
            .container {
                max-width: 800px;
                margin: auto;
                background: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            th, td {
                padding: 10px;
                border: 1px solid #ddd;
                text-align: left;
            }
            th {
                background-color: #33CCFF;
                color: white;
            }
            tr:nth-child(even) {
                background-color: #f2f2f2;
            }
            .action-btn {
                padding: 5px 10px;
                margin-right: 5px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }
            .edit-btn {
                background-color: #2196F3;
                color: white;
            }
            .delete-btn {
                background-color: #f44336;
                color: white;
            }
            .create-btn {
                display: inline-block;
                padding: 10px 20px;
                background-color: #33CCFF;
                color: white;
                text-decoration: none;
                border-radius: 4px;
                margin-bottom: 20px;
            }
            /* Toggle Switch */
            .switch {
                position: relative;
                display: inline-block;
                width: 60px;
                height: 24px;
            } /* Tăng kích thước cho chữ */
            .switch input {
                opacity: 0;
                width: 0;
                height: 0;
            }
            .slider {
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: #ccc;
                transition: 0.4s;
                border-radius: 24px;
            }
            .slider:before {
                position: absolute;
                content: "";
                height: 20px;
                width: 20px;
                left: 2px;
                bottom: 2px;
                background-color: white;
                transition: 0.4s;
                border-radius: 50%;
            }
            input:checked + .slider {
                background-color: #4CAF50;
            } /* Xanh khi ON */
            input:checked + .slider:before {
                transform: translateX(36px);
            } /* Di chuyển nút */
            /* Chữ ON/OFF */
            .slider:after {
                content: 'OFF';
                color: white;
                position: absolute;
                right: 8px;
                top: 4px;
                font-size: 12px;
                font-weight: bold;
            }
            input:checked + .slider:after {
                content: 'ON';
                left: 8px;
                right: auto;
            }
            .message {
                padding: 10px;
                border-radius: 4px;
                margin-bottom: 15px;
            }
            .message.success {
                background-color: #dff0d8;
                color: #3c763d;
            }
            .message.error {
                background-color: #f2dede;
                color: #a94442;
            }
            .search-form {
                margin-bottom: 20px;
            }
            .search-form input[type="text"] {
                padding: 8px;
                width: 200px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }
            .search-form button {
                padding: 8px 15px;
                background-color: #33CCFF;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }
            .search-form button:hover {
                background-color: #45a049;
            }
            .canle{
                display: flex;
                justify-content: space-around;
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


        <div class="container">
            <c:if test="${not empty message}">
                <p class="message ${messageType}">${message}</p>
            </c:if>
            <h2>Staff/Doctor Accounts</h2>
            <div class="canle">
                <a href="createaccount" class="create-btn">Create New Account</a>

                <!-- Form tìm kiếm -->

                <form method="post" action="searchaccount" class="search-form">
                    <input type="text" name="search" value="${search}" placeholder="Search by Name">
                    <button type="submit">Search</button>
                </form>

            </div>

            <c:if test="${not empty message}">
                <p>${message}</p>

            </c:if>

            <table>
                <tr>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Full Name</th>
                    <th>Role</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                <c:forEach var="user" items="${users}">
                    <tr>
                        <td>${user.userName}</td>
                        <td>${user.email}</td>
                        <td>${user.fullName}</td>
                        <td>${user.role.name}</td>



                        <td>
                            <!-- Form submit cho toggle -->
                            <form method="post" action="updatestatus">
                                <input type="hidden" name="id" value="${user.id}">
                                <input type="hidden" name="status" value="${user.status == 1 ? 0 : 1}">
                                <input type="hidden" name="search" value="${search}">
                                <label class="switch">
                                    <input type="checkbox" ${user.status == 1 ? 'checked' : ''} onchange="this.form.submit()">
                                    <span class="slider"></span>
                                </label>
                            </form>
                        </td>


                        <td>
                            <a href="updateaccount?id=${user.id}" class="action-btn edit-btn">Edit</a>
                            <button class="action-btn delete-btn" onclick="confirmDelete('${user.id}')">Delete</button>
                        </td>
                    </tr>
                </c:forEach>
            </table>
                
            <c:if test="${empty users}">
                <p>No accounts found.</p>
            </c:if>



        </div>

        <script>
            function confirmDelete(id) {
                if (confirm("Are you sure you want to delete this account?")) {
                    window.location.href = "deleteaccount?id=" + id;
                }
            }
        </script>








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