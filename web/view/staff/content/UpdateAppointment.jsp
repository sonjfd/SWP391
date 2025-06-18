<%-- 
    Document   : UpdateAppointment
    Created on : Jun 10, 2025, 12:42:07 AM
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
        <style>
            body {
                padding-top: 80px;
            }
            /* Custom styles for buttons */
            .btn-sm {
                padding: 8px 16px;
                font-size: 14px;
                border-radius: 6px;
            }

            .d-flex {
                display: flex;
            }

            .justify-content-between {
                justify-content: space-between;
            }

            #slotContainer {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(120px, 1fr));
                gap: 10px;
                margin-top: 15px;
            }

            #slotContainer .slot-item {
                background-color: #f8f9fa;
                padding: 10px;
                border-radius: 8px;
                text-align: center;
                border: 1px solid #ddd;
                cursor: pointer;
            }

            #slotContainer .slot-item:hover {
                background-color: #e9ecef;
                border-color: #007bff;
            }

            #slotContainer .slot-item.selected {
                background-color: #007bff;
                color: white;
            }

            #slotContainer .slot-item span {
                font-size: 14px;
                font-weight: bold;
            }

        </style>
    </head>
    <body>
        <%@ include file="../layout/Header.jsp" %>

        <div class="container mt-4 mb-10">
            <h2 class="text-center mb-4 mt-5">Cập nhật lịch hẹn</h2>

            <form action="update-appointment" method="post">

                <input type="hidden" name="id" value="${appointment.id}" />
                <input type="hidden" name="doctorId" id="doctorId" value="${appointment.doctor.user.id}" />



                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Người đặt khám:</label>
                        <input type="text" class="form-control" value="${appointment.user.fullName}" readonly />
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Tên thú cưng:</label>
                        <input type="text" class="form-control" value="${appointment.pet.name}" readonly />
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Ngày khám:</label>
                        <input type="text" class="form-control" value="${appointment.appointmentDate}" readonly />
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Ca khám:</label>
                        <input type="text" class="form-control" value="${appointment.startTime} - ${appointment.endTime}" readonly />
                    </div>
                </div>



                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="doctorSelect" class="form-label">Chọn bác sĩ:</label>
                        <select name="doctor" class="form-select" id="doctorSelect">
                            <c:forEach items="${doctors}" var="doc">
                                <option value="${doc.user.id}" <c:if test="${doc.user.id == appointment.doctor.user.id}">selected</c:if>>
                                    ${doc.user.fullName}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label for="appointmentDate" class="form-label">Ngày khám:</label>
                        <input type="date" name="appointmentTime" class="form-control" id="appointmentDate" value="${appointment.appointmentDate}" />
                    </div>
                </div>


                <div class="mb-3">
                    <label class="form-label">Chọn khung giờ khám:</label>
                    <div id="slotContainer" class="d-flex flex-wrap gap-2 mb-3"></div>
                </div>

                <input type="hidden" name="startTime" id="slotStart" value="${appointment.startTime}" />
                <input type="hidden" name="endTime" id="slotEnd" value="${appointment.endTime}" />

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="paymentStatus" class="form-label">Thanh toán:</label>
                        <select name="paymentStatus" class="form-select" id="paymentStatus">
                            <option value="unpaid" ${appointment.paymentStatus == 'unpaid' ? 'selected' : ''}>Chưa thanh toán</option>
                            <option value="paid" ${appointment.paymentStatus == 'paid' ? 'selected' : ''}>Đã thanh toán</option>
                        </select>
                    </div>
                </div>


                <div class="d-flex justify-content-between mt-4">
                    <a href="list-appointment" class="btn btn-secondary btn-sm">Quay lại</a>
                    <button type="submit" class="btn btn-primary btn-sm">Lưu thay đổi</button>
                </div>
            </form>
        </div>


        <script>
            let doctorChanged = false;
            let dateChanged = false;
            let slotSelected = false;

            const originalDoctorId = document.getElementById('doctorId').value;
            const originalDate = document.getElementById('appointmentDate').value;
            const originalStartTime = document.getElementById('slotStart').value;
            const originalEndTime = document.getElementById('slotEnd').value;

            function fetchSlots() {
                const date = document.getElementById('appointmentDate').value;
                const doctorId = document.getElementById('doctorSelect').value;
                if (!date || !doctorId)
                    return;

                const url = 'get-slot?date=' + encodeURIComponent(date) + '&doctorId=' + encodeURIComponent(doctorId);
                fetch(url)
                        .then(res => {
                            if (!res.ok)
                                throw new Error('Lỗi phản hồi từ server');
                            return res.json();
                        })
                        .then(data => {
                            const container = document.getElementById('slotContainer');
                            container.innerHTML = '';
                            let preselected = false;

                            if (data.length === 0) {
                                const msg = document.createElement('div');
                                msg.className = 'text-muted';
                                msg.textContent = 'Không có ca khám khả dụng cho ngày này.';
                                container.appendChild(msg);
                                return;
                            }

                            data.forEach(slot => {
                                console.log(slot.start);
                                console.log(slot.end);
                                const btn = document.createElement('button');
                                btn.type = 'button';
                                btn.classList.add('btn', 'slot-btn', 'me-2', 'mb-2');

                                const startTime = slot.start;
                                const endTime = slot.end;
                                btn.textContent = startTime + ' - ' + endTime;

                                if (slot.booked) {
                                    btn.classList.add('btn-secondary');
                                    btn.disabled = true;
                                    btn.style.opacity = '0.6';
                                } else {
                                    btn.classList.add('btn-outline-primary');

                                    if (startTime === originalStartTime && endTime === originalEndTime && !doctorChanged && !dateChanged) {
                                        btn.classList.add('active');
                                        slotSelected = true;
                                        preselected = true;
                                    }

                                    btn.addEventListener('click', () => {
                                        document.getElementById('slotStart').value = startTime;
                                        document.getElementById('slotEnd').value = endTime;
                                        slotSelected = true;

                                        document.querySelectorAll('.slot-btn').forEach(b => b.classList.remove('active'));
                                        btn.classList.add('active');
                                    });
                                }

                                container.appendChild(btn);
                            });

                            // Nếu khung giờ ban đầu được khớp lại → giữ selected
                            if (!preselected && !doctorChanged && !dateChanged) {
                                slotSelected = true;
                            }
                        })
                        .catch(err => {
                            alert('Lỗi khi tải lịch làm việc: ' + err.message);
                        });
            }

            document.getElementById('appointmentDate').addEventListener('change', () => {
                const newDate = document.getElementById('appointmentDate').value;
                dateChanged = newDate !== originalDate;
                slotSelected = false;
                document.getElementById('slotStart').value = '';
                document.getElementById('slotEnd').value = '';
                fetchSlots();
            });

            document.getElementById('doctorSelect').addEventListener('change', () => {
                const newDoctor = document.getElementById('doctorSelect').value;
                doctorChanged = newDoctor !== originalDoctorId;
                slotSelected = false;
                document.getElementById('slotStart').value = '';
                document.getElementById('slotEnd').value = '';
                fetchSlots();
            });

            document.querySelector('form').addEventListener('submit', function (e) {
                const needSlot = doctorChanged || dateChanged;
                const start = document.getElementById('slotStart').value;
                const end = document.getElementById('slotEnd').value;

                if ((needSlot && !slotSelected) || !start || !end) {
                    e.preventDefault();
                    alert('Vui lòng chọn khung giờ khám hợp lệ.');
                }
            });

            window.addEventListener('DOMContentLoaded', fetchSlots);
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