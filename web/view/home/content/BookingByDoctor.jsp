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

            /* Container tổng */
            .container {
                max-width: 900px;
                margin: 0 auto;
                padding: 20px;
            }

            /* Tiêu đề */
            h2.text-center {
                font-weight: 700;
                color: #2c3e50;
                margin-bottom: 40px;
                font-size: 2.2rem;
                letter-spacing: 1px;
            }

            /* Thông tin bác sĩ bên trái */
            .col-md-4.text-center {
                background: #f8f9fa;
                border-radius: 12px;
                padding: 25px 20px;
                box-shadow: 0 0 15px rgb(0 0 0 / 0.05);
                margin-bottom: 30px;
            }

            .col-md-4.text-center img {
                border: 4px solid #17a2b8;
                transition: transform 0.3s ease;
            }

            .col-md-4.text-center img:hover {
                transform: scale(1.1);
            }

            .col-md-4.text-center h4 {
                margin-top: 15px;
                font-weight: 600;
                color: #34495e;
            }

            .col-md-4.text-center p {
                font-size: 0.9rem;
                color: #555;
                line-height: 1.4;
                margin-bottom: 12px;
            }

            /* Tiểu sử */
            .col-md-4.text-center p:last-child {
                font-style: italic;
                color: #666;
            }

            /* Form đặt lịch bên phải */
            .col-md-8 {
                background: #ffffff;
                padding: 30px 25px;
                border-radius: 12px;
                box-shadow: 0 8px 25px rgb(0 0 0 / 0.07);
                margin-bottom: 30px;
            }

            /* Label cho form */
            .form-label {
                font-weight: 600;
                color: #2c3e50;
                margin-bottom: 6px;
                display: block;
                font-size: 1rem;
            }

            /* Input, textarea, select */
            .form-control, .form-select {
                border: 1.5px solid #ced4da;
                border-radius: 8px;
                padding: 10px 12px;
                font-size: 1rem;
                transition: border-color 0.3s ease;
            }

            .form-control:focus, .form-select:focus {
                border-color: #17a2b8;
                box-shadow: 0 0 8px rgb(23 162 184 / 0.4);
                outline: none;
            }

            /* Slot container */
            #slotContainer {
                min-height: 40px;
            }

            /* Slot buttons */
            #slotContainer button {
                cursor: pointer;
                border-radius: 8px;
                padding: 8px 14px;
                font-weight: 500;
                border: 1.8px solid #17a2b8;
                background-color: transparent;
                color: #17a2b8;
                transition: all 0.25s ease;
                user-select: none;
            }

            #slotContainer button:hover {
                background-color: #17a2b8;
                color: #fff;
                box-shadow: 0 4px 12px rgb(23 162 184 / 0.6);
            }

            #slotContainer button.active {
                background-color: #117a8b;
                color: #fff;
                border-color: #117a8b;
                box-shadow: 0 4px 15px rgb(17 122 139 / 0.8);
            }

            /* Radio button style */
            .form-check-label {
                font-weight: 500;
                color: #2c3e50;
                user-select: none;
            }

            /* Submit button */
            button.btn-success {
                background-color: #17a2b8;
                border-color: #17a2b8;
                font-weight: 600;
                padding: 10px 25px;
                border-radius: 10px;
                font-size: 1.1rem;
                transition: background-color 0.3s ease, box-shadow 0.3s ease;
            }

            button.btn-success:hover {
                background-color: #117a8b;
                border-color: #117a8b;
                box-shadow: 0 6px 18px rgb(17 122 139 / 0.7);
            }

            /* Responsive: giảm padding cho màn nhỏ */
            @media (max-width: 768px) {
                .container {
                    padding: 15px;
                }

                .col-md-4.text-center, .col-md-8 {
                    margin-bottom: 25px;
                }
            }


        </style>
    </head>
    <body>
        <%@include file="../layout/Header.jsp" %>


        <section class="section">


            <div class="container ">
                <h2 class="text-center mb-4">Đặt lịch khám bệnh với bác sĩ</h2>

                <div class="row">
                    <!-- Thông tin bác sĩ -->
                    <div class="col-md-4 text-center">
                        <img src="${pageContext.request.contextPath}/${doctor.user.avatar}" alt="${doctor.user.fullName}"
                             class="rounded-circle mb-3" style="width:150px; height:150px; object-fit:cover;">
                        <h4>${doctor.user.fullName}</h4>
                        <p><strong>Chuyên ngành:</strong> ${doctor.specialty}</p>
                        <p><strong>Chứng chỉ:</strong> ${doctor.certificates}</p>
                        <p><strong>Bằng cấp:</strong> ${doctor.qualifications}</p>
                        <p><strong>Kinh nghiệm:</strong> ${doctor.yearsOfExperience} năm</p>
                        <p><strong>Tiểu sử:</strong></p>
                        <p>${doctor.biography}</p>
                    </div>

                    <!-- Form đặt lịch -->
                    <div class="col-md-8">
                        <form id="bookingForm" method="post" action="submitBooking">

                            <!-- Ngày khám -->
                            <div class="mb-3">
                                <label for="appointmentDate" class="form-label">Chọn ngày khám:</label>
                                <input type="date" id="appointmentDate" name="appointmentDate" class="form-control" 
                                       min="${todayStr}" required />
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
                                    <input type="text" name="phoneNumber" class="form-control" value="${sessionScope.user.phoneNumber}" />
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

                            <!-- Submit -->
                            <div class="text-end">
                                <button type="submit" class="btn btn-success">Xác nhận đặt lịch</button>
                            </div>

                        </form>
                    </div>
                </div>

                <script>
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

