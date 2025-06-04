<%-- 
    Document   : Contact
    Created on : May 22, 2025, 9:24:58 PM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
            /* Nền form và border */
            #bookingForm {
                background-color: #fff;
                border: 1px solid #0d6efd;
                border-radius: 8px;
                padding: 25px;
                max-width: 600px;
                margin: auto;
                box-shadow: 0 4px 10px rgb(13 110 253 / 0.2);
            }

            /* Label màu xanh dương */
            #bookingForm label.form-label {
                color: #0d6efd;
                font-weight: 600;
            }

            /* Input, select focus viền xanh */
            #bookingForm input.form-control:focus,
            #bookingForm select.form-select:focus {
                border-color: #0d6efd;
                box-shadow: 0 0 6px #0d6efd88;
                outline: none;
            }

            /* Ca làm việc - nút chọn ca khám */
            #shiftContainer button.shift-btn {
                background-color: #cfe2ff;
                border: 1px solid #0d6efd;
                color: #0d6efd;
                border-radius: 20px;
                padding: 8px 16px;
                cursor: pointer;
                transition: background-color 0.3s, color 0.3s;
                user-select: none;
                font-weight: 600;
            }

            #shiftContainer button.shift-btn:hover {
                background-color: #0d6efd;
                color: white;
            }

            #shiftContainer button.shift-btn.selected {
                background-color: #084298;
                color: white;
                border-color: #084298;
                pointer-events: none;
            }

            /* Radio thanh toán */
            #bookingForm .form-check-label {
                color: #0d6efd;
                font-weight: 600;
            }

            /* Nút xác nhận đặt lịch */
            #submitBtn {
                background-color: #0d6efd;
                border-color: #0d6efd;
                font-weight: 700;
                padding: 10px 30px;
                transition: background-color 0.3s;
            }

            #submitBtn:disabled {
                background-color: #a5c8ff;
                border-color: #a5c8ff;
                cursor: not-allowed;
                color: #eee;
            }

            #submitBtn:not(:disabled):hover {
                background-color: #084298;
                border-color: #084298;
            }

            /* Mã QR */
            #vnpayQrContainer {
                border: 1px solid #0d6efd;
                border-radius: 8px;
                padding: 15px;
                background-color: #e7f1ff;
                text-align: center;
            }

            /* Text tiền thanh toán */
            #paymentAmountText {
                color: #0d6efd;
                font-weight: 700;
                font-size: 1.1rem;
            }

        </style>
    </head>
    <body>
        <%@include file="../layout/Header.jsp" %>


        <section class="section">


            <div class="container ">
                <h2 class="text-center my-4">Đặt lịch khám bệnh</h2>
                <form id="bookingForm">
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
                                <input type="text" class="form-control" value="${sessionScope.user.phoneNumber}" readonly />
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Địa chỉ:</label>
                                <input type="text" class="form-control" value="${sessionScope.user.address}" readonly />
                            </div>
                        </div>

                        <!-- Pet selection -->
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

                        <!-- Date selection -->
                        <div class="mb-3">
                            <label class="form-label">Ngày khám:</label>
                            <input type="date" id="appointmentDate" name="appointmentDate" class="form-control" min="${todayStr}" required />
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

                        

                        <!-- Fee alert -->
                        <div class="alert alert-info">
                            Phí khám: <strong>${fee != null ? fee : 100000}</strong> VND
                        </div>

                        <!-- Submit -->
                        <div class="text-end">
                            <button type="submit" class="btn btn-success">Xác nhận đặt lịch</button>
                        </div>
                    </div>
                </form>

                <script>
                    // Load breed/species info
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
                                }).catch((err) =>{
                                    alter(err);
                                });
                    });

                    // Load doctors by date
                    document.getElementById('appointmentDate').addEventListener('change', function () {
                        let date = this.value;
                        if (!date)
                            return;

                        fetch('get-doctors-bydate?date=' + date)
                                .then(res => res.json())
                                .then(data => {
                                    let doctorSelect = document.getElementById('doctorSelect');
                                    doctorSelect.innerHTML = '<option value="">-- Chọn bác sĩ --</option>';
                                    data.doctors.forEach(doc => {
                                        let opt = document.createElement('option');
                                        opt.value = doc.id;
                                        opt.textContent = doc.fullName;
                                        doctorSelect.appendChild(opt);
                                    });
                                }).catch((err) =>{
                                    alter(err);
                                });
                    });

                    // Load slots when doctor selected
                    document.getElementById('doctorSelect').addEventListener('change', function () {
                        let date = document.getElementById('appointmentDate').value;
                        let doctorId = this.value;
                        if (!date || !doctorId)
                            return;

                        fetch(`GetSlotsServlet?date=${date}&doctorId=${doctorId}`)
                                .then(res => res.json())
                                .then(data => {
                                    let container = document.getElementById('slotContainer');
                                    container.innerHTML = '';
                                    data.forEach(slot => {
                                        let btn = document.createElement('button');
                                        btn.type = 'button';
                                        btn.className = `btn ${slot.available ? 'btn-outline-primary' : 'btn-secondary disabled'}`;
                                        btn.disabled = !slot.available;
                                        btn.textContent = `${slot.start} - ${slot.end}`;
                                                                btn.onclick = () => {
                                                                    document.getElementById('slotStart').value = slot.start;
                                                                    document.getElementById('slotEnd').value = slot.end;
                                                                    document.querySelectorAll('#slotContainer button').forEach(b => b.classList.remove('active'));
                                                                    btn.classList.add('active');
                                                                };
                                                                container.appendChild(btn);
                                                            });
                                                        });
                                            });

                                           

                                            // Optional: submit form via AJAX
                                            document.getElementById('bookingForm').addEventListener('submit', function (e) {
                                                e.preventDefault();
                                                let formData = new FormData(this);
                                                fetch('BookAppointmentServlet', {
                                                    method: 'POST',
                                                    body: formData
                                                }).then(res => res.text())
                                                        .then(msg => alert('Đặt lịch thành công!'))
                                                        .catch(err => alert('Lỗi đặt lịch'));
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
