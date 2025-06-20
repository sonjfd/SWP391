<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Lịch làm việc bác sĩ</title>
        <!-- Bootstrap 5 CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap -->
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- Select2 -->
        <link href="${pageContext.request.contextPath}/assets/css/select2.min.css" rel="stylesheet" />
        <!-- Date picker -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/flatpickr.min.css">
        <link href="${pageContext.request.contextPath}/assets/css/jquery.timepicker.min.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- Css -->
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <style>
            .avatar {
                width: 40px;
                height: 40px;
                object-fit: cover;
            }
            .table thead th {
                background-color: #f8f9fa;
            }
            .bg-soft-primary {
                background-color: #cfe2ff;
                color: #084298;
                font-weight: 500;
            }
        </style>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .table thead th {
                background-color: #e9f2ff;
                color: #084298;
                font-weight: 600;
                text-transform: uppercase;
            }

            .table th,
            .table td {
                vertical-align: middle;
                padding: 1rem 0.75rem;
                border-color: #dee2e6;
            }

            .table th.bg-light {
                background-color: #f8f9fa !important;
                font-weight: 500;
                color: #495057;
            }

            .badge {
                font-size: 0.9rem;
                padding: 0.5em 0.8em;
                border-radius: 1rem;
            }

            .badge.bg-success {
                background-color: #198754 !important;
            }

            .badge.bg-secondary {
                background-color: #adb5bd !important;
            }

            h4.mb-0 {
                font-weight: 600;
                color: #0d6efd;
            }

            .btn-outline-primary {
                border-radius: 20px;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            .btn-outline-primary:hover {
                background-color: #0d6efd;
                color: #fff;
            }

            .layout-specing {
                padding: 30px 20px;
            }

            .table-responsive {
                border-radius: 12px;
                overflow: hidden;
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.05);
            }

            .calendar-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }

            .calendar-header form {
                margin: 0;
            }

            th strong {
                font-size: 1rem;
                color: #084298;
            }
        </style>

    </head>
    <body class="bg-light">
        <%@include file="../layout/Header.jsp"%>
        <div class="container-fluid bg-light">
            <div class="layout-specing">
                <div class="row justify-content-center">


                    <c:set value="${sessionScope.doctor}" var="doctor"></c:set>





                       
                            <div class="calendar-header">
                                <form action="doctor-schedule" method="get">
                                    <input type="hidden" name="offset" value="${param.offset - 1}" />
                                <button class="btn btn-outline-primary" type="submit">← Tuần trước</button>
                            </form>
                            <h4 class="mb-0">Lịch làm việc trong tuần</h4>
                            <form action="doctor-schedule" method="get">
                                <input type="hidden" name="offset" value="${param.offset + 1}" />
                                <button class="btn btn-outline-primary" type="submit">Tuần sau →</button>
                            </form>
                        </div>

                    



                    <div class="table-responsive shadow rounded bg-white">
                        <table class="table table-bordered align-middle text-center mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th style="min-width: 120px;">Time Table</th>
                                        <c:forEach var="day" items="${weekDates}">
                                        <th style="min-width: 180px;">
                                            <fmt:formatDate value="${day}" pattern="EEEE" var="dayName"/>
                                            <strong>${dayName}</strong><br>
                                            <fmt:formatDate value="${day}" pattern="yyyy-MM-dd"/>
                                        </th>
                                    </c:forEach>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="shift" items="${shiftList}">
                                    <tr>
                                        <th class="bg-light">
                                            <div>
                                                ${shift.name} <br>
                                                <small class="text-muted">${shift.start_time} - ${shift.end_time}</small>
                                            </div>
                                        </th>
                                        <c:forEach var="day" items="${weekDates}" varStatus="loop">
                                            <c:set var="curDate" value="${weekDates[loop.index]}" />
                                            <c:set var="found" value="${null}" />
                                            <c:forEach var="sch" items="${schedules}">
                                                <c:if test="${sch.shift.id == shift.id and sch.workDate eq curDate}">
                                                    <c:set var="found" value="${sch}" />
                                                </c:if>
                                            </c:forEach>

                                            <td>


                                                <div class="d-flex align-items-center justify-content-center">
                                                    <c:choose>
                                                        <c:when test="${not empty found and found.isAvailable == 1}">
                                                            <span class="badge bg-success">Làm việc</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-secondary">Nghỉ</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </td>




                                    <form action="doctor-time-table" method="post">
                                        <input type="hidden" name="doctorId" value="${found.doctor.user.id}"/>
                                        <input type="hidden" name="date" value="${curDate}"/>
                                        <input type="hidden" name="shiftId" value="${shift.id}"/>
                                    </form>


                                </c:forEach>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>

                    </div>
                </div>
            </div>
        </div>


        <!-- Bootstrap JS (optional) -->
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <!-- Select2 -->
        <script src="${pageContext.request.contextPath}/assets/js/select2.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/select2.init.js"></script>
        <!-- Datepicker -->
        <script src="${pageContext.request.contextPath}/assets/js/flatpickr.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/flatpickr.init.js"></script>
        <!-- Datepicker -->
        <script src="${pageContext.request.contextPath}/assets/js/jquery.timepicker.min.js"></script> 
        <script src="${pageContext.request.contextPath}/assets/js/timepicker.init.js"></script> 
        <!-- Icons -->
        <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>

    </body>
</html>
