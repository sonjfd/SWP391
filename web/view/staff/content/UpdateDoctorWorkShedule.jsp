<%-- 
    Document   : UpdateDoctorWorkShedule
    Created on : May 27, 2025, 1:15:59 AM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cập nhật lịch làm việc của bác sĩ</title>
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

    </head>
    <body>
        <%@ include file="../layout/Header.jsp" %>
        <div class="container-fluid bg-light">
            <div class="layout-specing">

                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>

                <form id="updateScheduleForm" action="staff-update-work-schedule" method="post" class="p-4 border rounded shadow-sm">

                    <input type="hidden" name="schedule_id" value="${DoctorSchedule.id}" />

                    <div class="mb-3">
                        <label for="doctorName" class="form-label">Tên bác sĩ</label>
                        <input type="text" class="form-control" id="doctorName"
                               value="${DoctorSchedule.doctor.user.fullName}" readonly>
                    </div>

                    <div class="mb-3">
                        <label for="doctorEmail" class="form-label">Email</label>
                        <input type="email" class="form-control" id="doctorEmail"
                               value="${DoctorSchedule.doctor.user.email}" readonly>
                    </div>



                    <div class="mb-3">
                        <label for="workDate" class="form-label">Ngày làm việc</label>
                        <input type="date" class="form-control" id="workDate" name="work_date"
                               value="${DoctorSchedule.workDate}" required>
                    </div>

                    <div class="mb-3">
                        <label for="shiftId" class="form-label">Ca làm việc</label>
                        <select class="form-select" id="shiftId" name="shift_id" required>
                            <option value="">Chọn ca làm việc</option>
                            <c:forEach items="${shift}" var="s">
                                <option value="${s.id}"
                                        <c:if test="${s.id == DoctorSchedule.shift.id}">selected</c:if>>
                                    ${s.name} (${s.start_time} - ${s.end_time})
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="d-flex justify-content-between mt-4">
                        <a href="staff-list-work-schedule" class="btn btn-secondary">
                            <i class="bi bi-arrow-left-circle"></i> Quay lại
                        </a>

                        <button type="submit" class="btn btn-primary">
                            Cập nhật lịch làm việc
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <script>
            document.getElementById('updateScheduleForm').addEventListener('submit', function (event) {
                const workDateInput = document.getElementById('workDate');
                const selectedDate = new Date(workDateInput.value);
                const today = new Date();

                today.setHours(0, 0, 0, 0);
                selectedDate.setHours(0, 0, 0, 0);

                if (selectedDate < today) {
                    alert('Ngày làm việc không được chọn ngày trong quá khứ!');
                    workDateInput.focus();
                    event.preventDefault();
                }
            });
        </script>


     
    </body>
</html>
