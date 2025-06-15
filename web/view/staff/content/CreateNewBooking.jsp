<%-- 
    Document   : CreateNewBooking
    Created on : Jun 9, 2025, 12:34:58 AM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                background-color: #fff9f3;
                font-family: 'Segoe UI', sans-serif;
            }

            h2 {
                font-weight: 800;
                font-size: 28px;
                color: #ff7a00;
                margin-bottom: 24px;
            }

            h2 span {
                color: #000;
            }


            .form-label {
                font-weight: 600;
                color: #333;
                margin-bottom: 6px;
                display: inline-block;
            }

            .form-control,
            .form-select {
                border-radius: 8px;
                padding: 12px 14px;
                font-size: 15px;
                border: 1px solid #ccc;
                transition: all 0.2s ease-in-out;
            }

            .form-control:focus,
            .form-select:focus {
                border-color: #ff9900;
                box-shadow: 0 0 0 3px rgba(255, 165, 0, 0.2);
            }

            textarea.form-control {
                resize: vertical;
            }

            .btn-success {
                background-color: #00aa55;
                border: none;
                padding: 10px 25px;
                font-weight: 600;
                border-radius: 8px;
                transition: background-color 0.2s ease-in-out;
            }

            .btn-success:hover {
                background-color: #008f47;
            }

            .total-bill-box {
                background-color: #e3f2fd;
                padding: 12px 16px;
                border-left: 5px solid #1976d2;
                border-radius: 8px;
                font-size: 16px;
                font-weight: 500;
                color: #333;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .total-bill-box span {
                font-weight: bold;
                color: #1976d2;
                font-size: 18px;
            }

            .btn-confirm {
                background-color: #1976d2;
                color: #ffffff;
                padding: 12px 28px;
                font-weight: 600;
                border: none;
                border-radius: 8px;
                transition: background-color 0.2s ease-in-out;
                box-shadow: 0 2px 6px rgba(0, 0, 0, 0.15);
                font-size: 16px;
            }

            .btn-confirm:hover {
                background-color: #1565c0;
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

            /* Slot chọn ca khám - làm nút đẹp */
            #slotContainer .slot-button {
                background-color: #f0f0f0;
                border: 1px solid #ccc;
                border-radius: 8px;
                padding: 10px 16px;
                font-size: 14px;
                cursor: pointer;
                transition: all 0.2s ease-in-out;
                min-width: 100px;
                text-align: center;
                user-select: none;
            }

            #slotContainer .slot-button:hover {
                background-color: #ffe0cc;
                border-color: #ff9900;
                color: #000;
            }

            #slotContainer .slot-button.active {
                background-color: #ff9900;
                color: #fff;
                border-color: #ff9900;
                font-weight: 600;
            }

            /* Radio button payment */
            .form-check-input:checked {
                background-color: #ff9900;
                border-color: #ff9900;
            }

            @media (max-width: 768px) {
                .booking-row {
                    flex-direction: column;
                }

                .booking-image,
                .booking-form {
                    max-width: 100%;
                }
            }

        </style>
    </head>
    <body>
        <%@ include file="../layout/Header.jsp" %>
        <div class="container d-flex justify-content-center ">
            <div class="booking-form-wrapper" style="width:100%; max-width: 800px; background-color: #ffffff; padding: 30px; border-radius: 12px; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08); margin-bottom: 30px;">

                <h2 class="text-center my-4 mt-5">Thêm lịch khám</h2>

                <form id="bookingForm" method="post" action="add-new-booking">

                    <!-- User info -->
                    <div class="row mb-3">
                        <div>
                            <label class="form-label">Chọn khách hàng </label>
                            <select name="userId" id="userSelect" class="form-select" required>
                                <option>Chọn khách hàng</option>
                                <c:forEach items="${users}" var="u"> 
                                    <option value="${u.id}">${u.fullName}</option>
                                </c:forEach>
                            </select>
                        </div>

                    </div>
                    <div id="userInfor1" style="display:none;">
                        <div class="row mb-2">
                            <div class="col-md-6">
                                <label class="form-label">Họ và tên:</label>
                                <input type="text" class="form-control" id="fullName" readonly />
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Email:</label>
                                <input type="text" class="form-control" id="email" readonly />
                            </div>
                        </div>
                    </div>
                    <div id="userInfor2" style="display:none;">
                        <div class="row mb-2">
                            <div class="col-md-6">
                                <label class="form-label">Số điện thoại:</label>
                                <input type="text" class="form-control" id="phone" readonly />
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Địa chỉ</label>
                                <input type="text" class="form-control" id="address" readonly />
                            </div>
                        </div>
                    </div>

                    <div class="row mb-3" id="petSelectContainer" style="display: none;">
                        <div>
                            <label class="form-label">Chọn thú cưng:</label>
                            <select name="petId" id="petSelect" class="form-select" required>

                            </select>
                        </div>


                    </div>




                    <!-- Breed and Species -->
                    <div id="breedInfo" style="display:none;">
                        <div class="row mb-3">
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
                    <div class="mb-3" >
                        <label class="form-label">Ngày khám:</label>
                        <input type="date" id="appointmentDate" name="appointmentDate" class="form-control"  required />
                        <div id="dateError" class="text-danger small mt-1"></div>
                    </div>

                    <!-- Doctor select -->
                    <div class="mb-3">
                        <label class="form-label">Bác sĩ:</label>
                        <select name="doctorId" id="doctorSelect" class="form-select" required>
                            <option value="">-- Chọn bác sĩ --</option>
                        </select>
                    </div>

                    <!-- Slot select -->
                    <div class="mb-3">
                        <label class="form-label">Chọn ca khám:</label>
                        <div class="d-flex flex-wrap gap-2" id="slotContainer">             
                        </div>
                        <input type="hidden" name="slotStart" id="slotStart" required />
                        <input type="hidden" name="slotEnd" id="slotEnd" required />
                    </div>

                    <!-- Appointment notes -->
                    <div class="mb-3">
                        <label class="form-label">Nội dung khám bệnh:</label>
                        <textarea name="appointmentNote" class="form-control" rows="3"></textarea>
                    </div>

                    <!-- Total bill -->
                    <div class="mb-3">
                        <div class="total-bill-box">
                            Phí đặt lịch khám:
                            <span id="billText">
                                <fmt:formatNumber value="${defaultPrice}" type="number" maxFractionDigits="0" /> VNĐ
                            </span>
                        </div>
                        <input type="hidden" name="totalBill" id="totalBill" value="${defaultPrice}" />
                    </div>

                    <!-- Payment -->
                    <div class="mb-3">
                        <label class="form-label">Phương thức thanh toán:</label>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="paymentMethod" value="pay_later" checked />
                            <label class="form-check-label">Thanh toán trực tiếp</label>
                        </div>

                        <div class="d-flex justify-content-between mt-4">
                            <button type="button" class="btn btn-secondary" onclick="history.back();">Quay lại</button>
                            <button type="submit" class="btn btn-confirm">Xác nhận đặt lịch</button>
                        </div>
                    </div>


                </form>
            </div>
        </div>


        <script>




            document.addEventListener("DOMContentLoaded", function () {
                const dateInput = document.getElementById("appointmentDate");
                const dateError = document.getElementById("dateError");
                const form = document.getElementById("bookingForm");
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



                dateInput.addEventListener("blur", validateDate);


                form.addEventListener("submit", function (e) {
                    const isPhoneValid = validatePhone();
                    const isDateValid = validateDate();

                    if (!isPhoneValid || !isDateValid) {
                        e.preventDefault();
                    }
                });
            });

            document.getElementById('userSelect').addEventListener('change', function () {
                let userId = this.value;

                fetch('get-user-and-pet?userId=' + encodeURIComponent(userId))
                        .then(res => res.json())
                        .then(data => {

                            document.getElementById('userInfor1').style.display = 'block';
                            document.getElementById('userInfor2').style.display = 'block';
                            document.getElementById('fullName').value = data.user.fullName;
                            document.getElementById('email').value = data.user.email;
                            document.getElementById('phone').value = data.user.phoneNumber;
                            document.getElementById('address').value = data.user.address;


                            const petSelectContainer = document.getElementById('petSelectContainer');
                            const petSelect = document.getElementById('petSelect');
                            petSelect.innerHTML = '<option value="">-- Chọn thú cưng --</option>';

                            document.getElementById('breedInfo').style.display = 'none';
                            document.getElementById('speciesName').value = '';
                            document.getElementById('breedName').value = '';


                            let noPetsMessage = document.getElementById('noPetsMessage');
                            if (!noPetsMessage) {
                                noPetsMessage = document.createElement('div');
                                noPetsMessage.id = 'noPetsMessage';
                                noPetsMessage.className = 'text-danger mt-2';
                                petSelectContainer.appendChild(noPetsMessage);
                            }


                            if (data.pets && data.pets.length > 0) {
                                petSelect.style.display = 'block';
                                noPetsMessage.style.display = 'none';
                                petSelectContainer.style.display = 'block';

                                data.pets.forEach(pet => {
                                    const option = document.createElement('option');
                                    option.value = pet.id;
                                    option.text = pet.name;
                                    petSelect.appendChild(option);
                                });

                                window.loadedPets = data.pets;
                            } else {

                                petSelect.style.display = 'none';
                                petSelectContainer.style.display = 'block';
                                noPetsMessage.textContent = 'Khách hàng này hiện chưa có thú cưng nào!';
                                noPetsMessage.style.display = 'block';
                                window.loadedPets = [];
                            }
                        });

            });



            document.getElementById('petSelect').addEventListener('change', function () {
                const selectedPetId = this.value;
                const selectedPet = window.loadedPets?.find(p => p.id === selectedPetId);

                if (selectedPet) {
                    document.getElementById('breedInfo').style.display = 'block';
                    document.getElementById('speciesName').value = selectedPet.species || '';
                    document.getElementById('breedName').value = selectedPet.breed || '';
                } else {
                    document.getElementById('breedInfo').style.display = 'none';
                    document.getElementById('speciesName').value = '';
                    document.getElementById('breedName').value = '';
                }
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

