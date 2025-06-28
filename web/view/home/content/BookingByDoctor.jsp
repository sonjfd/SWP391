<%-- 
    Document   : BookingByDoctor
    Created on : Jun 4, 2025, 10:35:13 PM
    Author     : Dell
--%>

<%-- 
    Document   : Contact
    Created on : May 22, 2025, 9:24:58 PM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Pet24h - Liên Hệ</title>
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
        <!-- Icons -->
        <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- SLIDER -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/tiny-slider.css"/>
        <!-- Css -->
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

        <style>
            body {
                background-color: #f8f9fa; /* trắng xám dịu mắt */
                font-family: 'Segoe UI', sans-serif;
            }

            h2 {
                font-weight: 700;
                font-size: 28px;
                color: #ff6f00;
            }

            .form-label {
                font-weight: 600;
                color: #333;
            }

            .form-control,
            .form-select {
                border-radius: 6px;
                padding: 10px;
                font-size: 14px;
                border: 1px solid #ccc;
            }

            .form-control:focus,
            .form-select:focus {
                border-color: #1976d2;
                box-shadow: 0 0 0 2px rgba(25, 118, 210, 0.2);
            }

            .row {
                margin-top: 30px;
            }

            .col-md-4.text-center {
                background-color: #ffffff;
                padding: 20px;
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            }

            .col-md-8 form {
                background-color: #ffffff;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
            }

            .rounded-circle {
                border: 3px solid #1976d2;
            }

            .btn-success {
                background-color: #1976d2;
                border: none;
                padding: 10px 25px;
                font-weight: 600;
                color: white;
                border-radius: 6px;
                transition: background-color 0.3s ease;
            }

            .btn-success:hover {
                background-color: #1565c0;
            }

            .form-check-label {
                margin-left: 6px;
            }

            /* Responsive tweak */
            @media (max-width: 768px) {
                .col-md-4, .col-md-8 {
                    padding: 0;
                    margin-bottom: 20px;
                }

                .col-md-8 form {
                    padding: 20px;
                }
            }
            .doctor-card {
                background-color: #f9f9f9;
                padding: 20px;
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
                animation: fadeIn 0.6s ease-in-out;
                transition: transform 0.3s ease;
            }

            .doctor-card:hover {
                transform: translateY(-4px);
                box-shadow: 0 6px 16px rgba(0, 0, 0, 0.08);
            }

            .doctor-name {
                font-size: 22px;
                font-weight: 700;
                color: #1976d2;
                margin-bottom: 12px;
            }

            .doctor-info p {
                margin-bottom: 10px;
                font-size: 15px;
                line-height: 1.5;
                color: #333;
            }

            .doctor-info p i {
                color: #1976d2;
                margin-right: 8px;
                min-width: 20px;
                text-align: center;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
        </style>

    </head>
    <body>
        <%@include file="../layout/Header.jsp" %>


        <section class="section">

            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <c:if test="${not empty transResult}">
                <c:choose>
                    <c:when test="${transResult}">
                        <div class="alert alert-success">Thanh toán thành công! Cảm ơn bạn đã đặt lịch.</div>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-warning">Thanh toán thất bại hoặc bị hủy. Vui lòng thử lại.</div>
                    </c:otherwise>
                </c:choose>
            </c:if>

            <div class="container ">
                <h2 class="text-center mb-4">Đặt lịch khám bệnh với bác sĩ</h2>

                <div class="row">
                    <!-- Thông tin bác sĩ -->

                    <div class="col-md-4 doctor-card text-start">
                        <img src="${pageContext.request.contextPath}/${doctor.user.avatar}" alt="${doctor.user.fullName}"
                             class="rounded-circle mb-3" style="width:150px; height:150px; object-fit:cover;">
                        <h4 class="doctor-name"><i class="fas fa-user-md me-1"></i> ${doctor.user.fullName}</h4>
                        <div class="doctor-info">
                            <p><i class="fas fa-stethoscope"></i><strong>Chuyên ngành:</strong> ${doctor.specialty}</p>
                            <p><i class="fas fa-certificate"></i><strong>Chứng chỉ:</strong> ${doctor.certificates}</p>
                            <p><i class="fas fa-graduation-cap"></i><strong>Bằng cấp:</strong> ${doctor.qualifications}</p>
                            <p><i class="fas fa-briefcase-medical"></i><strong>Kinh nghiệm:</strong> ${doctor.yearsOfExperience} năm</p>
                            <p><i class="fas fa-user-edit"></i><strong>Tiểu sử:</strong></p>
                            <p>${doctor.biography}</p>
                        </div>
                    </div>


                    <!-- Form đặt lịch -->
                    <div class="col-md-8">
                        <form id="bookingForm" method="post" action="payment">

                            <!-- Ngày khám -->
                            <div class="mb-3">
                                <label for="appointmentDate" class="form-label">Chọn ngày khám:</label>
                                <input type="date" id="appointmentDate" name="appointmentDate" class="form-control" 
                                       required />
                                <div id="dateError" class="text-danger small mt-1"></div>
                            </div>

                            <!-- Ca khám (slot) -->
                            <div class="mb-3">
                                <label class="form-label">Chọn ca khám:</label>
                                <div id="slotContainer" class="d-flex flex-wrap gap-2"></div>
                                <input type="hidden" name="slotStart" id="slotStart" required />
                                <input type="hidden" name="slotEnd" id="slotEnd" required />
                            </div>

                            <!-- Thông tin người dùng -->
                            <div class="row g-3 mb-3">
                                <div class="col-md-6">
                                    <label class="form-label">Họ tên:</label>
                                    <input type="text" class="form-control" value="${sessionScope.user.fullName}" readonly />
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Email:</label>
                                    <input type="email" class="form-control" value="${sessionScope.user.email}" readonly />
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">SĐT:</label>
                                    <input type="text" name="phoneNumber" id="inputPhone"  class="form-control" value="${sessionScope.user.phoneNumber}" />
                                    <div id="phoneError" class="text-danger small mt-1"></div>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Địa chỉ:</label>
                                    <input type="text" class="form-control" value="${sessionScope.user.address}" readonly />
                                </div>
                            </div>


                            <!-- Thú cưng -->
                            <div class="mb-3">
                                <label class="form-label">Chọn thú cưng:</label>
                                <select name="petId" id="petSelect" class="form-select" required>
                                    <option value="">-- Chọn thú cưng --</option>
                                    <c:forEach var="pet" items="${pets}">
                                        <option value="${pet.id}">${pet.name}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <!-- Breed and Species -->
                            <div id="breedInfo" style="display:none;">
                                <div class="row mb-2">
                                    <div class="col-md-6">
                                        <label class="form-label">Loài:</label>
                                        <input type="text" class="form-control" id="speciesName" readonly />
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Giống:</label>
                                        <input type="text" class="form-control" id="breedName" readonly />
                                    </div>
                                </div>
                            </div>

                            <!-- Ghi chú -->
                            <div class="mb-3">
                                <label class="form-label">Nội dung khám bệnh:</label>
                                <textarea name="appointmentNote" class="form-control" rows="3"></textarea>
                            </div>
                            <div class="mb-3">
                                <div class="total-bill-box d-flex justify-content-between align-items-center p-2 rounded bg-light border-start border-4 border-primary">
                                    Phí đặt lịch khám:
                                    <span id="billText">
                                        <fmt:formatNumber value="${defaultPrice}" type="number" maxFractionDigits="0" /> VNĐ
                                    </span>
                                </div>
                                <input type="hidden" name="totalBill" id="totalBill" value="${defaultPrice}" />
                            </div>


                            <!-- Phương thức thanh toán -->
                            <div class="mb-3">
                                <label class="form-label">Phương thức thanh toán:</label>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="paymentMethod" value="pay_later" checked />
                                    <label class="form-check-label">Trả tiền sau</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="paymentMethod" value="vnpay" />
                                    <label class="form-check-label">VNPAY</label>
                                </div>
                            </div>

                            <!-- Ẩn input doctorId để gửi về backend -->
                            <input type="hidden" name="doctorId" value="${doctor.user.id}" />
                            <input type="hidden" name="totalBill" id="totalBill" value="${totalBill}" />
                            <!-- Submit -->
                            <div class="text-end">
                                <button type="submit" class="btn btn-success">Xác nhận đặt lịch</button>
                            </div>

                        </form>
                    </div>
                </div>

                <script>

                    document.getElementById("bookingForm").addEventListener("submit", function (event) {
                        const paymentMethod = document.querySelector('input[name="paymentMethod"]:checked').value;


                        if (paymentMethod === "pay_later") {
                            this.action = "booking-by-doctor";
                        } else {
                            this.action = "payment";
                        }
                    });

                    document.addEventListener("DOMContentLoaded", function () {
                        const phoneInput = document.getElementById("inputPhone");
                        const phoneError = document.getElementById("phoneError");

                        const dateInput = document.getElementById("appointmentDate");
                        const dateError = document.getElementById("dateError");

                        const form = document.getElementById("bookingForm");

                        function validatePhone() {
                            const phone = phoneInput.value.trim();
                            const regex = /^0\d{9}$/;
                            if (!regex.test(phone)) {
                                phoneError.textContent = "Số điện thoại phải bắt đầu bằng 0 và đủ 10 số.";
                                return false;
                            } else {
                                phoneError.textContent = "";
                                return true;
                            }
                        }

                        function validateDate() {
                            const selectedDate = new Date(dateInput.value);
                            const today = new Date();

                            selectedDate.setHours(0, 0, 0, 0);
                            today.setHours(0, 0, 0, 0);

                            if (selectedDate < today) {
                                dateError.textContent = "Vui lòng chọn ngày khám ơ hiện tại hoặc tương lai!";
                                return false;
                            } else {
                                dateError.textContent = "";
                                return true;
                            }
                        }


                        phoneInput.addEventListener("blur", validatePhone);
                        dateInput.addEventListener("blur", validateDate);


                        form.addEventListener("submit", function (e) {
                            const isPhoneValid = validatePhone();
                            const isDateValid = validateDate();

                            if (!isPhoneValid || !isDateValid) {
                                e.preventDefault();
                            }
                        });
                    });



                    document.getElementById("petSelect").addEventListener('change', function () {
                        let petId = this.value;
                        if (!petId)
                            return;

                        fetch('getPetInfor?petId=' + encodeURIComponent(petId))
                                .then(res => res.json())
                                .then(data => {
                                    console.log(data);
                                    document.getElementById('breedInfo').style.display = 'block';
                                    document.getElementById('speciesName').value = data.species;
                                    document.getElementById('breedName').value = data.breed;

                                })
                                .catch(err => {
                                    alert(err);
                                });
                    });

                    document.getElementById('appointmentDate').addEventListener('change', function () {
                        const date = this.value;
                        const doctorId = document.querySelector('input[name="doctorId"]').value;

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

                                    if (data.length === 0) {
                                        const msg = document.createElement('div');
                                        msg.className = 'text-muted';
                                        msg.textContent = 'Không có ca khám khả dụng cho ngày này.';
                                        container.appendChild(msg);
                                        return;
                                    }

                                    data.forEach(slot => {
                                        const btn = document.createElement('button');
                                        btn.type = 'button';
                                        btn.classList.add('btn', 'slot-btn', 'me-2', 'mb-2');
                                        const startTime = slot.start.substring(11, 16);
                                        const endTime = slot.end.substring(11, 16);
                                        btn.textContent = String(slot.start) + ' - ' + String(slot.end);

                                        if (slot.booked) {
                                            btn.classList.add('btn-secondary');
                                            btn.disabled = true;
                                            btn.style.opacity = '0.6';
                                        } else {
                                            btn.classList.add('btn-outline-primary');
                                            btn.addEventListener('click', () => {
                                                document.getElementById('slotStart').value = slot.start;
                                                document.getElementById('slotEnd').value = slot.end;

                                                document.querySelectorAll('.slot-btn').forEach(b => b.classList.remove('active'));
                                                btn.classList.add('active');
                                            });
                                        }

                                        container.appendChild(btn);
                                    });
                                })
                                .catch(err => {
                                    alert('Lỗi khi tải lịch làm việc: ' + err.message);
                                });
                    });

                </script>






            </div><!--end row-->


        </div><!--end container-->
    </section><!--end section-->





    <%@include file="../layout/Footer.jsp" %>


    <!-- javascript -->
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
    <!-- SLIDER -->
    <script src="${pageContext.request.contextPath}/assets/js/tiny-slider.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/tiny-slider-init.js"></script>
    <!-- Counter -->
    <script src="${pageContext.request.contextPath}/assets/js/counter.init.js"></script>
    <!-- Icons -->
    <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
    <!-- Main Js -->
    <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
</body>
</html>

