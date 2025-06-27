<%-- 
    Document   : AddDoctorWorkSchedule
    Created on : May 23, 2025, 10:00:33 PM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Trang Nhân Viên</title>
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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">


    </head>
    <body>
        <%@ include file="../layout/Header.jsp" %>

        <div class="container-fluid bg-light">
            <div class="layout-specing">
                <div class="container mt-4">
                    <div class="card">
                        <div class="card-header bg-primary text-white text-center">
                            <h4 class="mb-0">Tạo Lịch Làm Việc</h4>
                        </div>
                        <div class="card-body">
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    ${error}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                </div>
                            </c:if>

                            <form id="workShiftForm" action="staff-add-schedule" method="post" onsubmit="return validateForm()">
                                <div class="mb-3">
                                    <label for="doctor" class="form-label">Chọn bác sĩ</label>
                                    <select id="doctor" name="doctor_id" class="form-select">
                                        <option value="">-- Chọn bác sĩ --</option>
                                        <c:forEach var="d" items="${doctors}">
                                            <option value="${d.user.id}" ${d.user.id == doctor_id ? 'selected' : ''}>${d.user.fullName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="d-flex flex-wrap gap-3">
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="checkbox" name="day_of_week" id="monday" value="2">
                                        <label class="form-check-label" for="monday">Thứ 2</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="checkbox" name="day_of_week" id="tuesday" value="3">
                                        <label class="form-check-label" for="tuesday">Thứ 3</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="checkbox" name="day_of_week" id="wednesday" value="4">
                                        <label class="form-check-label" for="wednesday">Thứ 4</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="checkbox" name="day_of_week" id="thursday" value="5">
                                        <label class="form-check-label" for="thursday">Thứ 5</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="checkbox" name="day_of_week" id="friday" value="6">
                                        <label class="form-check-label" for="friday">Thứ 6</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="checkbox" name="day_of_week" id="saturday" value="7">
                                        <label class="form-check-label" for="saturday">Thứ 7</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="checkbox" name="day_of_week" id="sunday" value="1">
                                        <label class="form-check-label" for="sunday">Chủ nhật</label>
                                    </div>
                                </div>


                                <div class="mb-3">
                                    <label for="shift" class="form-label">Chọn ca làm việc:</label>
                                    <select id="shift" name="shift_id" class="form-select">
                                        <option value="">-- Chọn ca --</option>
                                        <c:forEach var="s" items="${shifts}">
                                            <option value="${s.id}" ${s.id == shift_id ? 'selected' : ''}>
                                                ${s.name} (${s.start_time} - ${s.end_time})
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Tạo lịch làm việc trong tháng:</label>
                                    <div class="row">
                                        <c:forEach var="i" begin="1" end="12">
                                            <div class="col-md-3 mb-2">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" name="months" id="month${i}" value="${i}">
                                                    <label class="form-check-label" for="month${i}">Tháng ${i}</label>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                                <div class="d-flex justify-content-between mt-4">
                                    <a href="staff-list-work-schedule" class="btn btn-secondary px-4">
                                        <i class="bi bi-arrow-left"></i> Quay lại
                                    </a>
                                    <button type="submit" class="btn btn-success px-4">
                                        <i class="bi bi-calendar-plus"></i> Tạo lịch làm việc
                                    </button>
                                </div>

                            </form>
                        </div>
                    </div>
                </div>





            </div>
        </div>

        <script>
            function validateForm() {
                const doctor = document.getElementById("doctor").value;
                const shifts = document.getElementById("shift").value;
                const dayOfWeekCheckboxes = document.querySelectorAll('input[name="day_of_week"]:checked');
                const monthsCheckboxes = document.querySelectorAll('input[name="months"]:checked');
                const currentMonth = new Date().getMonth() + 1; 

                if (!doctor) {
                    alert("Vui lòng chọn bác sĩ.");
                    return false;
                }

                if (dayOfWeekCheckboxes.length === 0) {
                    alert("Vui lòng chọn ít nhất 1 ngày trong tuần.");
                    return false;
                }

                if (!shifts) {
                    alert("Vui lòng chọn ca làm việc.");
                    return false;
                }

                if (monthsCheckboxes.length === 0) {
                    alert("Vui lòng chọn ít nhất 1 tháng.");
                    return false;
                }

                for (let checkbox of monthsCheckboxes) {
                    const selectedMonth = parseInt(checkbox.value, 10);
                    if (selectedMonth < currentMonth) {
                        alert("Không được chọn tháng trong quá khứ.");
                        return false;
                    }
                }

                return true; // Nếu mọi thứ hợp lệ
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