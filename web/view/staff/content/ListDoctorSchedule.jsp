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
        <title>Quản lí lịch làm việc của bác sĩ</title>
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


            /* Form Xoá + Tạo lịch nằm song song */
            .form-delete-schedule {
                display: flex;
                justify-content: space-between;
                align-items: flex-end;
                flex-wrap: wrap;
                gap: 12px;
                margin-bottom: 16px;
            }

            /* Form Xoá trong dòng đó */
            .form-delete-schedule form {
                display: flex;
                flex-wrap: wrap;
                align-items: flex-end;
                gap: 12px;
            }

        </style>

    </head>
    <body>
        <%@ include file="../layout/Header.jsp" %>






        <div class="container-fluid bg-light">
            <div class="layout-specing">

                <div class="row">
                    <!-- Form lọc bác sĩ -->
                    <form method="get" action="staff-list-work-schedule" class="row g-2 mb-3 compact-form" onsubmit="return validateFilter();">
                        <div class="col-md-3">
                            <label for="doctorId" class="form-label">Bác sĩ</label>
                            <select id="doctorId" name="doctorId" class="form-select form-select-sm">
                                <option value="">Tất cả</option>
                                <c:forEach var="doctor" items="${doctorList}">
                                    <c:if test="${doctor.user.status==1}">
                                        <option value="${doctor.user.id}" ${doctor.user.id == doctorId ? "selected" : ""}>
                                            ${doctor.user.fullName}
                                        </option>
                                    </c:if>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="col-md-2">
                            <label for="month" class="form-label">Tháng</label>
                            <select id="month" name="month" class="form-select form-select-sm">
                                <option value="">Tất cả</option>
                                <c:forEach var="m" begin="1" end="12">
                                    <option value="${m}" ${m == month ? "selected" : ""}>${m}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="col-md-3">
                            <label for="shiftId" class="form-label">Ca làm việc</label>
                            <select id="shiftId" name="shiftId" class="form-select form-select-sm">
                                <option value="">Tất cả</option>
                                <c:forEach var="shift" items="${shiftList}">
                                    <option value="${shift.id}" ${shift.id == shiftId ? "selected" : ""}>
                                        ${shift.name} (${shift.start_time} - ${shift.end_time})
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="col-md-2 align-self-end">
                            <button type="submit" class="btn btn-primary btn-sm w-100">Lọc</button>
                        </div>
                    </form>

                    <!-- Form Xoá + Tạo lịch -->
                    <div class="form-delete-schedule">

                        <!-- Form Xoá -->
                        <form method="post" action="staff-delete-work-bymonth" class="compact-form mb-0" onsubmit="return validateDelete();">
                            <div class="d-flex flex-wrap align-items-end gap-2">
                                <div>
                                    <label for="deleteDoctorId" class="form-label">Bác sĩ</label>
                                    <select id="deleteDoctorId" name="doctorId" class="form-select ">
                                        <option value=""> Chọn bác sĩ </option>
                                        <c:forEach var="doctor" items="${doctorList}">
                                            <c:if test="${doctor.user.status == 1}">
                                                <option value="${doctor.user.id}" ${doctor.user.id == doctorId ? "selected" : ""}>
                                                    ${doctor.user.fullName}
                                                </option>
                                            </c:if>
                                        </c:forEach>

                                    </select>
                                </div>

                                <div>
                                    <label for="deleteMonth" class="form-label">Tháng</label>
                                    <select id="deleteMonth" name="month" class="form-select ">
                                        <option value=""> Chọn tháng </option>
                                        <c:forEach var="m" begin="1" end="12">
                                            <option value="${m}">Tháng ${m}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div>
                                    <button type="submit" name="action" value="delete" class="btn btn-danger btn-sm">
                                        Xoá
                                    </button>
                                </div>
                            </div>
                        </form>

                        <!-- Nút Tạo lịch bên phải -->
                        <a href="staff-add-schedule" class="btn btn-primary btn-sm">
                            <i class="bi bi-person-plus"></i> Tạo Lịch
                        </a>

                    </div>




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

                    <c:if test="${param.msg == 'deleted'}">
                        <script>
                            alert("Xoá lịch làm việc thành công!");
                        </script>
                    </c:if>

                    <c:if test="${param.msg == 'none'}">
                        <script>alert("Bác sĩ không có lịch làm việc trong tháng này!");</script>
                    </c:if>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger" role="alert">
                            ${error}
                        </div>
                    </c:if>

                    <table class="table table-striped ">
                        <thead class="bg-primary text-white" >
                            <tr>

                                <th scope="col">Số thứ tự</th> 
                                <th scope="col">Ảnh</th>
                                <th scope="col ">Họ và tên</th>
                                <th scope="col-5" class="text-center">Email</th>
                                <th scope="col">Số điện thoại</th>
                                <th scope="col">Ngày làm việc</th>
                                <th scope="col">Ca làm việc</th>
                                <th scope="col">Thời gian làm việc</th>
                                <th scope="col-3 " class="text-center">Hoạt động</th>

                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${listshedules}" var="s" varStatus="loop">
                                <tr>
                                    <td>${offset + loop.index + 1}</td>
                                    <td><img src="${s.doctor.user.avatar}" alt="Avatar" style="width:40px; height:40px; border-radius:50%;">
                                    </td>
                                    <td>${s.doctor.user.fullName}</td>
                                    <td>${s.doctor.user.email}</td>
                                    <td>${s.doctor.user.phoneNumber}</td>
                                    <td>${s.workDate}</td>
                                    <td>${s.shift.name}</td>
                                    <td>${s.shift.start_time} - ${s.shift.end_time}</td>


                                    <td>

                                        <div class="action-buttons">

                                            <button type="button"
                                                    class="btn btn-success btn-sm"
                                                    onclick="window.location.href = 'staff-update-work-schedule?id=${s.id}&workDate=${s.workDate}&shifid=${s.shift.id}'"
                                                    title="Cập nhật lịch làm việc">
                                                <i class="bi bi-pencil-square"></i>
                                            </button>

                                            <button type="button"
                                                    class="btn btn-danger btn-sm"
                                                    onclick="if (confirm('Bạn có chắc chắn muốn xóa lịch làm việc này không?'))
                                                                window.location.href = 'staff-delete-work-schedule?id=${s.doctor.user.id}&datework=${s.workDate}'"
                                                    title="Xoá lịch làm việc">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </div>


                                    </td>
                                </tr>

                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
            <c:if test="${totalPages > 0}">
                <nav aria-label="Page navigation">
                    <ul class="pagination justify-content-center">
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link" 
                               href="staff-list-work-schedule?page=${currentPage - 1}&doctorId=${doctorId}&month=${month}&shiftId=${shiftId}" 
                               tabindex="-1">Trước</a>
                        </li>

                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link" 
                                   href="staff-list-work-schedule?page=${i}&doctorId=${doctorId}&month=${month}&shiftId=${shiftId}">
                                    ${i}
                                </a>
                            </li>
                        </c:forEach>

                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link" 
                               href="staff-list-work-schedule?page=${currentPage + 1}&doctorId=${doctorId}&month=${month}&shiftId=${shiftId}">
                                Sau
                            </a>
                        </li>
                    </ul>
                </nav>
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
                function validateDelete() {
                    var doctorId = document.getElementById('deleteDoctorId').value;
                    var month = document.getElementById('deleteMonth').value;
                    if (!doctorId) {
                        alert('Vui lòng chọn bác sĩ');
                        return false;
                    }
                    if (!month) {
                        alert('Vui lòng chọn tháng');
                        return false;
                    }
                    return true;
                }

            </script>



            <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>

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