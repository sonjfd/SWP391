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

            #bookingForm {
                background-color: #fff;
                border: 1px solid #0d6efd;
                border-radius: 8px;
                padding: 25px;
                max-width: 600px;
                margin: auto;

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

            #slotContainer {
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
                margin-top: 10px;
            }

            .slot-btn {
                min-width: 100px;
                padding: 8px 12px;
                font-size: 14px;
            }

            .slot-btn.active {
                background-color: #0d6efd;
                color: white;
                border: 1px solid #0d6efd;
            }

            .slot-btn.disabled {
                pointer-events: none;
                opacity: 0.5;
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
                                <input type="text" class="form-control" value="${sessionScope.user.phoneNumber}"  />
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

                    document.getElementById('petSelect').addEventListener('change', function () {
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
