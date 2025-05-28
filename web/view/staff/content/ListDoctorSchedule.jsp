<%-- 
    Document   : ListDoctorSchedule
    Created on : May 26, 2025, 10:17:24 PM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản Lí Bác Sĩ</title>
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
            i[class^="ri-"] {
                font-size: 22px;
                cursor: pointer;
                margin: 0 8px;
                padding: 8px;
                border-radius: 50%;
                transition: all 0.3s ease;
                box-shadow:
                    0 0 5px rgba(0,0,0,0.1),
                    inset 0 0 10px rgba(255,255,255,0.6);
            }

            /* Thêm: gradient + glow */
            .icon-add {
                background: linear-gradient(135deg, #56ab2f, #a8e063);
                color: white;
                box-shadow:
                    0 0 8px #56ab2f,
                    0 0 20px #a8e063;
            }

            .icon-add:hover {
                filter: brightness(1.15);
                transform: scale(1.2) rotate(10deg);
                box-shadow:
                    0 0 12px #56ab2f,
                    0 0 30px #a8e063;
            }

            /* Sửa: vàng kim + bóng */
            .icon-edit {
                background: linear-gradient(135deg, #f7b733, #fceabb);
                color: #5a3e1b;
                box-shadow:
                    0 0 8px #f7b733,
                    inset 0 0 15px #fceabb;
            }

            .icon-edit:hover {
                filter: brightness(1.2);
                transform: scale(1.15) rotate(-10deg);
                box-shadow:
                    0 0 14px #f7b733,
                    inset 0 0 25px #fceabb;
            }

            /* Xoá: đỏ rực + glow */
            .icon-delete {
                background: linear-gradient(135deg, #e52d27, #b31217);
                color: white;
                box-shadow:
                    0 0 10px #e52d27,
                    0 0 25px #b31217;
            }

            .icon-delete:hover {
                filter: brightness(1.3);
                transform: scale(1.25);
                box-shadow:
                    0 0 16px #e52d27,
                    0 0 40px #b31217;
            }

        </style>

    </head>
    <body>
        <%@ include file="../layout/Header.jsp" %>




        <div class="container-fluid bg-light">
            <div class="layout-specing">

                <div class="row">

                    <div >
                        <a href="add-schedule" class="btn btn-primary">
                            <i class="bi bi-person-plus"></i> Tạo Lịch 
                        </a>
                    </div>

                    <form method="get" action="filter-doctor-schedule" class="row g-3 mb-4">

                        <div class="col-md-3">
                            <label for="doctorId" class="form-label">Bác sĩ</label>
                            <select id="doctorId" name="doctorId" class="form-select">
                                <option value="">Tất cả</option>
                                <c:forEach var="doctor" items="${doctorList}">
                                    <option value="${doctor.user.id}" ${doctor.user.id == doctorId ? "selected" : ""}>
                                        ${doctor.user.fullName}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="col-md-2">
                            <label for="month" class="form-label">Tháng</label>
                            <select id="month" name="month" class="form-select">
                                <option value="">Tất cả</option>
                                <c:forEach var="m" begin="1" end="12">
                                    <option value="${m}" ${m == month ? "selected" : ""}>${m}</option>
                                </c:forEach>
                            </select>
                        </div>



                        <div class="col-md-3">
                            <label for="shiftId" class="form-label">Ca làm việc</label>
                            <select id="shiftId" name="shiftId" class="form-select">
                                <option value="">Tất cả</option>
                                <c:forEach var="shift" items="${shiftList}">
                                    <option value="${shift.id}" ${shift.id == shiftId ? "selected" : ""}>
                                        ${shift.name} (${shift.start_time} - ${shift.end_time})
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="col-md-2 align-self-end">
                            <button type="submit" class="btn btn-primary w-100">Lọc</button>
                        </div>
                    </form>

                    <c:if test="${param.success == '1'}">
                        <script>
                            alert("Thêm lịch làm việc thành công!");
                        </script>
                    </c:if>

                    <c:if test="${param.success == '2'}">
                        <script>
                            alert("Cập nhật lịch làm việc thành công!");
                        </script>
                    </c:if>

                    <table class="table table-striped ">
                        <thead class="bg-primary text-white" >
                            <tr>
                                <th scope="col">Ảnh</th>
                                <th scope="col ">Họ Và Tên</th>
                                <th scope="col-5" class="text-center">Email</th>
                                <th scope="col">Số Điện Thoại</th>
                                <th scope="col">Ngày Làm Việc</th>
                                <th scope="col">Ca Làm Việc</th>
                                <th scope="col">Thời gian làm việc</th>
                                <th scope="col-3 " class="text-center">Hoạt Động</th>

                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${listshedules}" var="s">
                                <tr>
                                    <td><img src="${pageContext.request.contextPath}/${s.doctor.user.avatar}" alt="Avatar" style="width:40px; height:40px; border-radius:50%;">
                                    </td>
                                    <td>${s.doctor.user.fullName}</td>
                                    <td>${s.doctor.user.email}</td>
                                    <td>${s.doctor.user.phoneNumber}</td>
                                    <td>${s.workDate}</td>
                                    <td>${s.shift.name}</td>
                                    <td>${s.shift.start_time} - ${s.shift.end_time}</td>


                                    <td>

                                        <div class="action-buttons">
                                            <a href="update-work-schedule?id=${s.id}&workDate=${s.workDate}&shifid=${s.shift.id}"><i class="ri-edit-line"></i> </a>
                                            <a href="delete-work-schedule?id=${s.doctor.user.id}&datework=${s.workDate}"
                                               onclick="return confirm('Bạn có chắc chắn muốn xóa lịch làm việc này không?')"><i class="ri-delete-bin-line"></i></a>

                                        </div>
                                    </td>
                                </tr>

                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

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




            <%@include file="../layout/Footer.jsp" %>
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