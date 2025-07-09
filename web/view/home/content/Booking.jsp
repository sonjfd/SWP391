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
        <style>
            body {
                background-color: #fff9f3;
                font-family: 'Segoe UI', sans-serif;
            }

            h2 {
                font-weight: 800;
                font-size: 28px;
                color: #ff7a00;
            }

            h2 span {
                color: #000;
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
                border-color: #ff9900;
                box-shadow: 0 0 0 2px rgba(255, 165, 0, 0.2);
            }

            .btn-success {
                background-color: #00aa55;
                border: none;
                padding: 10px 25px;
                font-weight: 600;
            }

            .btn-success:hover {
                background-color: #008f47;
            }

            .booking-row {
                display: flex;
                flex-wrap: wrap;
                gap: 20px;
            }

            .booking-image {
                flex: 1 1 50%;
                max-width: 50%;
            }

            .booking-image img {
                width: 100%;
                height: auto;
                max-height: 100%;
                border-radius: 12px;
                object-fit: cover;
            }

            .booking-form {
                flex: 1 1 50%;
                max-width: 50%;
                background-color: #ffffff;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 0 12px rgba(0, 0, 0, 0.08);
            }

            .total-bill-box {
                background-color: #e3f2fd; /* Xanh lam nhạt */
                padding: 12px 16px;
                border-left: 5px solid #1976d2;
                border-radius: 6px;
                font-size: 16px;
                font-weight: 500;
                color: #333;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .total-bill-box span {
                font-weight: bold;
                color: #1976d2; /* Xanh lam đậm */
                font-size: 18px;
            }

            .btn-confirm {
                background-color: #1976d2;   /* xanh lam mạnh */
                color: #ffffff;              /* chữ trắng */
                padding: 10px 25px;
                font-weight: 600;
                border: none;
                border-radius: 6px;
                transition: background-color 0.2s ease-in-out;
                box-shadow: 0 2px 6px rgba(0, 0, 0, 0.15); /* tạo nổi khối nhẹ */
            }

            .btn-confirm:hover {
                background-color: #1565c0; /* đậm hơn khi hover */
            }



            @media (max-width: 768px) {
                .booking-row {
                    flex-direction: column;
                }

                .booking-image, .booking-form {
                    max-width: 100%;
                }
            }
        </style>


    </head>
    <body>
        <%@include file="../layout/Header.jsp" %>


        <section class="section">


            <div class="container ">


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

                <h2 class="text-center my-4">Đặt lịch khám bệnh</h2>
                <div class="container mt-4">
                    <div class="row" id="bookingRow">
                        <div class="col-md-6 booking-image">
                            <img src="https://img.tripi.vn/cdn-cgi/image/width=700,height=700/https://gcs.tripi.vn/public-tripi/tripi-feed/img/474108ZQo/anh-nen-thu-cung-chat-luong-cao-4k-cho-dien-thoai_050616397.jpg" alt="Cute cat" />
                        </div>
                        <div class="col-md-6 booking-form" id="bookingFormWrapper">
                            <form id="bookingForm" method="post" action="payment">
                                <div class="container-fluid">

                                    <!-- User info -->
                                    <div class="row mb-2">
                                        <div class="col-md-6">
                                            <label class="form-label">Họ tên:</label>
                                            <input type="text" class="form-control" value="${sessionScope.user.fullName}" readonly />
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Email:</label>
                                            <input type="email" class="form-control" value="${sessionScope.user.email}" readonly />
                                        </div>
                                    </div>
                                    <div class="row mb-2">
                                        <div class="col-md-6">
                                            <label class="form-label">SĐT:</label>
                                            <input type="text" class="form-control" id="inputPhone" value="${sessionScope.user.phoneNumber}"  name="phone"  />
                                            <div id="phoneError" class="text-danger small mt-1"></div>

                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Địa chỉ:</label>
                                            <input type="text" class="form-control" value="${sessionScope.user.address}" readonly />
                                        </div>
                                    </div>

                                    <!-- Pet selection -->
                                    <div class="mb-3">
                                        <label class="form-label">Chọn thú cưng:</label>



                                        <select name="petId" id="petSelect" class="form-select" required ${empty pets ? 'disabled' : ''}>
                                            <option value="">-- Chọn thú cưng --</option>
                                            <c:forEach var="pet" items="${pets}">
                                                <option value="${pet.id}">${pet.name}</option>
                                            </c:forEach>
                                        </select>

                                        <c:choose>
                                            <c:when test="${empty pets}">
                                                <div class="mb-2 text-danger">
                                                    Bạn chưa có thú cưng nào. Vui lòng 
                                                    <a href="customer-addpet" class="fw-bold text-primary">thêm thú cưng</a> để tiếp tục đặt lịch khám.
                                                </div>
                                            </c:when>
                                        </c:choose>
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

                                    <!-- Date selection -->
                                    <div class="mb-3">
                                        <label class="form-label">Ngày khám:</label>
                                        <input type="date" id="appointmentDate" name="appointmentDate" class="form-control"   required />
                                        <div id="dateError" class="text-danger small mt-1"></div>

                                    </div>


                                    <!-- Doctor select (populated dynamically) -->
                                    <div class="mb-3">
                                        <label class="form-label">Bác sĩ:</label>
                                        <select name="doctorId" id="doctorSelect" class="form-select" required>
                                            <option value="">-- Chọn bác sĩ --</option>
                                        </select>
                                    </div>

                                    <!-- Slot select (buttons generated dynamically) -->
                                    <div class="mb-3">
                                        <label class="form-label">Chọn ca khám:</label>
                                        <div class="d-flex flex-wrap gap-2" id="slotContainer"></div>
                                        <input type="hidden" name="slotStart" id="slotStart" required />
                                        <input type="hidden" name="slotEnd" id="slotEnd" required />
                                    </div>

                                    <!-- Appointment notes -->
                                    <div class="mb-3">
                                        <label class="form-label">Nội dung khám bệnh:</label>
                                        <textarea name="appointmentNote" class="form-control" rows="3"></textarea>
                                    </div>
                                    <div class="mb-3">
                                        <div class="total-bill-box">
                                            Phí đặt lịch khám:
                                            <span id="billText">
                                                <fmt:formatNumber value="${defaultPrice}" type="number" maxFractionDigits="0" /> VNĐ
                                            </span>


                                        </div>

                                        <input type="hidden" name="totalBill" id="totalBill" value="${defaultPrice}" />
                                        <div class="text-danger small mt-1">
                                            * Lưu ý: Phí đặt lịch sẽ không được hoàn lại nếu bạn huỷ lịch khám.
                                        </div>
                                    </div>


                                    <!-- Payment -->
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










                                    <!-- Submit -->
                                    <div class="text-end">
                                        <button type="submit" class="btn btn-confirm">Xác nhận đặt lịch</button>
                                    </div>

                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <script>


                    document.getElementById("bookingForm").addEventListener("submit", function (event) {
                        const paymentMethod = document.querySelector('input[name="paymentMethod"]:checked').value;


                        if (paymentMethod === "pay_later") {
                            this.action = "booking";
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



                    document.getElementById('petSelect').addEventListener('change', function () {
                        let petId = this.value;
                        if (!petId)
                            return;

                        fetch('getPetInfor?petId=' + petId)
                                .then(res => res.json())
                                .then(data => {
                                    document.getElementById('breedInfo').style.display = 'block';
                                    document.getElementById('speciesName').value = data.species;
                                    document.getElementById('breedName').value = data.breed;
                                }).catch((err) => {
                            alter(err);
                        });
                    });

                    document.getElementById('appointmentDate').addEventListener('change', function () {
                        let date = this.value;
                        if (!date)
                            return;

                        fetch('get-doctors-bydate?date=' + encodeURIComponent(date))
                                .then(res => res.json())
                                .then(data => {
                                    let doctorSelect = document.getElementById('doctorSelect');
                                    doctorSelect.innerHTML = '<option value="">-- Chọn bác sĩ --</option>';

                                    if (!data.doctors || data.doctors.length === 0) {
                                        let opt = document.createElement('option');
                                        opt.value = '';
                                        opt.textContent = 'Vui lòng chọn ngày khác!Bác sĩ không có lịch làm việc hôm nay.';
                                        opt.disabled = true;
                                        doctorSelect.appendChild(opt);
                                        return;
                                    }

                                    data.doctors.forEach(doc => {
                                        let opt = document.createElement('option');
                                        opt.value = doc.id;
                                        opt.textContent = doc.fullName;
                                        doctorSelect.appendChild(opt);
                                    });
                                })
                                .catch(err => {
                                    alert('Lỗi khi tải danh sách bác sĩ: ' + err);
                                });
                    });


                    document.getElementById('doctorSelect').addEventListener('change', function () {
                        const date = document.getElementById('appointmentDate').value;
                        const doctorId = this.value;
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

                                    data.forEach(slot => {
                                        console.log(slot);
                                        const btn = document.createElement('button');
                                        btn.type = 'button';
                                        btn.classList.add('btn', 'slot-btn', 'me-2', 'mb-2');

                                        if (slot.booked) {

                                            btn.classList.add('btn-secondary');
                                            btn.textContent = String(slot.start) + ' - ' + String(slot.end);
                                            btn.style.pointerEvents = 'none';
                                            btn.style.opacity = '0.6';
                                        } else {

                                            btn.classList.add('btn-outline-primary');
                                            btn.textContent = String(slot.start) + ' - ' + String(slot.end);


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
