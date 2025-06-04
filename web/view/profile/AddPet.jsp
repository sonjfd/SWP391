<%-- 
    Document   : ListPet
    Created on : May 26, 2025, 11:13:20 AM
    Author     : Admin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
    <c:if test="${not empty sessionScope.user}">

    </c:if>

    <head>
        <meta charset="utf-8" />
        <title>Doctris - Doctor Appointment Booking System</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
        <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
        <meta name="author" content="Shreethemes" />
        <meta name="email" content="support@shreethemes.in" />
        <meta name="website" content="https://shreethemes.in" />
        <meta name="Version" content="v1.2.0" />
        <!-- favicon -->
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico.png">
        <!-- Bootstrap -->

        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- Css -->
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

        <style>
            body {
                margin: 0;
                padding: 0;
            }
            footer {
                margin-bottom: 0;
            }
            .bg-dashboard {
                margin-bottom: 0;
                padding-bottom: 0;
            }
            html, body {
                height: 100%;
            }
            table, th, td {
                border: 1px solid black;
                border-collapse: collapse;
            }

            th, td {
                padding: 8px;
                text-align: center;
            }
            .canle{
                display: flex;
                justify-content: space-around;
            }
            .create-btn {
                display: inline-block;
                padding: 10px 20px;
                background-color: #4CAF50;
                color: white;
                text-decoration: none;
                border-radius: 4px;
                margin-bottom: 20px;
            }
            .search-form {
                display: flex;
                gap: 8px;
                margin-bottom: 20px;
            }

            .search-form input[type="text"] {
                padding: 8px 12px;
                border: 1px solid #ccc;
                border-radius: 6px;
                outline: none;
                transition: border-color 0.3s;
            }

            .search-form input[type="text"]:focus {
                border-color: #007bff;
            }

            .search-form button {
                padding: 8px 16px;
                background-color: #007bff;
                color: white;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .search-form button:hover {
                background-color: #0056b3;
            }
            .img-fluid{
                max-height: 500px;
                max-width: 400px;


            </style>

        </head>

        <body>
            <c:if test="${not empty sessionScope.SuccessMessage}">
                <script>
                    alert('${sessionScope.SuccessMessage}');
                </script>
                <c:remove var="SuccessMessage" scope="session"/>
            </c:if>

            <c:if test="${not empty sessionScope.FailMessage}">
                <script>
                    alert('${sessionScope.FailMessage}');
                </script>
                <c:remove var="FailMessage" scope="session"/>
            </c:if>


            <!-- Navbar STart -->
            <%@include file="../home/layout/Header.jsp" %>
            <!-- Navbar End -->
            <div class="container">
                <section class="bg-dashboard">
                    <div class="row">
                        <div class=" col-3">
                            <div class="rounded shadow overflow-hidden sticky-bar">
                                <div class="card border-0">
                                    <img src="${pageContext.request.contextPath}/${user.avatar}" class="img-fluid" alt="">
                                </div>
                                <div class="text-center avatar-profile margin-nagative mt-n5 position-relative pb-4 border-bottom">
                                    <img src="${pageContext.request.contextPath}/${user.avatar}" class="rounded-circle shadow-md avatar avatar-md-md" alt="">
                                    <h5 class="mt-3 mb-1">${user.fullName}</h5>

                                </div>
                                <ul class="list-unstyled sidebar-nav mb-0">
                                    <li class="navbar-item"><a href="doctor-appointment.html" class="navbar-link"><i class="ri-calendar-check-line align-middle navbar-icon"></i> Lịch hẹn</a></li>
                                    <li class="navbar-item"><a href="doctor-schedule.html" class="navbar-link"><i class="ri-timer-line align-middle navbar-icon"></i>Lịch sử khám bệnh</a></li>
                                    <li class="navbar-item"><a href="viewlistpet" class="navbar-link"><i class="ri-bear-smile-line align-middle navbar-icon"></i> Danh sách thú cưng</a></li>
                                    <li class="navbar-item"><a href="viewuserinformation" class="navbar-link"><i class="ri-user-settings-line align-middle navbar-icon"></i> Cài đặt thông tin cá nhân</a></li>
                                    <li class="navbar-item"><a href="doctor-chat.html" class="navbar-link"><i class="ri-chat-voice-line align-middle navbar-icon"></i> Trò chuyện</a></li>
                                </ul>
                            </div>
                        </div><!--end col-->

                        <div class=" col-9">
                            <form id="addPetForm" action="addpet" method="post" enctype="multipart/form-data">
                                <div class="form-group">
                                    <input type="hidden" name="id" value="${user.id}"/>
                                    <label for="name">Tên Pet:</label>
                                    <input type="text" id="name" name="name" class="form-control" required >
                                    <span id="nameError" class="text-danger"></span>
                                </div>

                                <div class="form-group">
                                    <label for="gender">Giới tính:</label>
                                    <select id="gender" name="gender" class="form-select" required>
                                        <option value="">-- Chọn --</option>
                                        <option value="Đực">Đực</option>
                                        <option value="Cái">Cái</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="specie">Loài:</label>
                                    <select class="form-select" id="specie" name="specie_id" required>
                                        <option value="">Chọn Loài</option>
                                        <c:forEach items="${specieList}" var="specie">
                                            <option value="${specie.id}"
                                                    <c:if test="${specie.id == pet.breed.specie.id}">selected</c:if>>
                                                ${specie.name}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="breed">Giống:</label>
                                    <select class="form-select" id="breed" name="breed_id" required>
                                        <option value="">Chọn Giống</option>
                                        <c:forEach items="${breedList}" var="breed">
                                            <option value="${breed.id}"
                                                    <c:if test="${breed.id == pet.breed.id}">selected</c:if>>
                                                ${breed.name}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>



                                <div class="form-group">
                                    <label for="birthDate">Ngày sinh:</label>
                                    <input type="date" id="birthDate" name="birthDate" class="form-control">
                                    <small id="birthDateError" class="text-danger" style="display:none;">Ngày sinh không hợp lệ!</small>
                                </div>


                                <div class="form-group">
                                    <label for="status">Trạng thái:</label>
                                    <select id="status" name="status" class="form-select" required>
                                        <option value="">--Chọn--</option>
                                        <option value="active">Hoạt động</option>
                                        <option value="inactive">Không hoạt động</option>
                                        <option value="lost">Đã chết</option>
                                        <option value="deceased">Đã thất lạc</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label for="description">Mô tả:</label>
                                    <textarea id="description" name="description" rows="3" class="form-control" required></textarea>
                                </div>

                                <div class="form-group">
                                    <label for="avatar">Ảnh Pet:</label>
                                    <input type="file" class="form-control-file" id="avatar" name="avatar"/>
                                    <small id="fileName" class="text-muted d-block mt-1"></small>
                                    <small id="fileError" class="text-danger d-block mt-1"></small>
                                </div>

                                <button type="submit" class="btn btn-primary">Thêm Pet</button>
                                <a href="viewlistpet" class="btn btn-secondary" style="margin-left: 5px">Hủy</a>
                                </form>
                            </div><!--end row-->
                        </div><!-- End -->
                    </section><!--end section-->

                </div>

                <!-- javascript -->
                <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

                <script>

                                        $(document).ready(function () {
                                            $("#specie").change(function () {
                                                var specieId = $(this).val();
                                                if (specieId) {
                                                    $.ajax({
                                                        url: "getbreedsbyspecie?specieId=" + specieId,
                                                        method: "GET",
                                                        dataType: "json",
                                                        success: function (data) {
                                                            var breedSelect = $("#breed");
                                                            breedSelect.empty();
                                                            breedSelect.append('<option value="">-- Chọn giống --</option>');
                                                            $.each(data, function (index, breed) {
                                                                breedSelect.append('<option value="' + breed.id + '">' + breed.name + '</option>');
                                                            });
                                                        },
                                                        error: function (xhr, status, error) {
                                                            console.error("Lỗi khi load breed list:", error);
                                                        }
                                                    });
                                                } else {
                                                    $("#breed").empty().append('<option value="">-- Chọn giống --</option>');
                                                }
                                            });
                                        });
                                        document.getElementById("birthDate").addEventListener("change", function () {
                                            const birthDateInput = document.getElementById("birthDate");
                                            const birthDateError = document.getElementById("birthDateError");
                                            const birthDateValue = new Date(birthDateInput.value);
                                            const today = new Date();

                                            // Clear time phần giờ phút giây
                                            birthDateValue.setHours(0, 0, 0, 0);
                                            today.setHours(0, 0, 0, 0);

                                            if (birthDateInput.value && birthDateValue >= today) {
                                                birthDateError.style.display = "block";
                                            } else {
                                                birthDateError.style.display = "none";
                                            }
                                        });
                                       
// Đồng thời giữ lại check khi submit
                                        document.getElementById("addPetForm").addEventListener("submit", function (event) {
                                            const birthDateInput = document.getElementById("birthDate");
                                            const birthDateError = document.getElementById("birthDateError");
                                            const birthDateValue = new Date(birthDateInput.value);
                                            const today = new Date();

                                            birthDateValue.setHours(0, 0, 0, 0);
                                            today.setHours(0, 0, 0, 0);

                                            if (birthDateInput.value && birthDateValue >= today) {
                                                event.preventDefault();
                                                birthDateError.style.display = "block";
                                            } else {
                                                birthDateError.style.display = "none";
                                            }
                                        });


                                        // Hàm kiểm tra email hợp lệ
                                        function isValidEmail(email) {
                                            return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
                                        }

                                        // Hàm kiểm tra username hợp lệ
                                        function isValidUsername(username) {
                                            return /^[a-zA-Z0-9_]{3,}$/.test(username);
                                        }
                                        // hàm kiểm tra Name hợp lệ                       
                                        function isValidName(name) {
                                            return /^[a-zA-Z0-9_]{2,}$/.test(name);
                                        }

                                        // Hàm kiểm tra số điện thoại hợp lệ
                                        function isValidPhoneNumber(phone) {
                                            return /^0\d{9}$/.test(phone); // bắt đầu bằng 0, đủ 10 số
                                        }

                                        // Hàm hiển thị lỗi
                                        function showError(inputId, message) {
                                            const errorElement = document.getElementById(inputId + 'Error');
                                            if (errorElement) {
                                                errorElement.textContent = message;
                                                errorElement.style.display = message ? 'block' : 'none';
                                            }
                                        }

                                        // Hàm kiểm tra username
                                        function validateUsername() {
                                            const usernameInput = document.getElementById('userName');
                                            const username = usernameInput.value.trim();
                                            if (!username) {
                                                showError('userName', 'Tên đăng nhập không được để trống!');
                                                return false;
                                            } else if (!isValidUsername(username)) {
                                                showError('userName', 'Tên đăng nhập phải có ít nhất 3 ký tự!');
                                                return false;
                                            }
                                            showError('userName', '');
                                            return true;
                                        }

                                        // Hàm kiểm tra email
                                        function validateEmail() {
                                            const emailInput = document.getElementById('email');
                                            const email = emailInput.value.trim();
                                            if (!email) {
                                                showError('email', 'Email không được để trống!');
                                                return false;
                                            } else if (!isValidEmail(email)) {
                                                showError('email', 'Email không hợp lệ!');
                                                return false;
                                            }
                                            showError('email', '');
                                            return true;
                                        }

                                        // Hàm kiểm tra  name
                                        function validateName() {
                                            const fullNameInput = document.getElementById('name');
                                            const fullName = fullNameInput.value.trim();

                                            if (!fullName) {
                                                showError('fullName', 'Tên thú cưng không được để trống!');
                                                return false;
                                            } else if (!isValidFullname(fullName)) {
                                                showError('fullName', 'Tên thú cưng phải có ít nhất 2 ký tự!');
                                                return false;
                                            }

                                            showError('fullName', '');
                                            return true;
                                        }


                                        // Hàm kiểm tra phone number
                                        function validatePhoneNumber() {
                                            const phoneInput = document.getElementById('phoneNumber');
                                            const phone = phoneInput.value.trim();
                                            if (!phone) {
                                                showError('phoneNumber', 'Số điện thoại không được để trống!');
                                                return false;
                                            } else if (!isValidPhoneNumber(phone)) {
                                                showError('phoneNumber', 'Số điện thoại phải bắt đầu bằng 0 và có đúng 10 số!');
                                                return false;
                                            }
                                            showError('phoneNumber', '');
                                            return true;
                                        }

                                        // Hàm kiểm tra toàn bộ biểu mẫu khi submit
                                        function validateForm() {
                                            const isUsernameValid = validateUsername();
                                            const isEmailValid = validateEmail();
                                            const isFullNameValid = validateFullName();
                                            const isPhoneNumberValid = validatePhoneNumber();
                                            return isUsernameValid && isEmailValid && isFullNameValid && isPhoneNumberValid;
                                        }

                                        // Gắn sự kiện blur khi trang tải
                                        document.addEventListener('DOMContentLoaded', function () {
                                            const inputs = [
                                                {id: 'userName', validate: validateUsername},
                                                {id: 'email', validate: validateEmail},
                                                {id: 'fullName', validate: validateFullName},
                                                {id: 'phoneNumber', validate: validatePhoneNumber}
                                            ];

                                            inputs.forEach(({ id, validate }) => {
                                                const input = document.getElementById(id);
                                                if (input) {
                                                    input.addEventListener('blur', () => {
                                                        console.log(`Blur event triggered for ${id}`); // Debugging
                                                        validate();
                                                    });
                                                } else {
                                                    console.error(`Element with ID ${id} not found`);
                                            }
                                            });

                                            // Gắn sự kiện change cho role_id (nếu cần)
                                            const roleSelect = document.getElementById('role_id');
                                            if (roleSelect) {
                                                roleSelect.addEventListener('change', toggleDoctorFields);
                                            }
                                        });

                                        // Hàm toggleDoctorFields (giữ nguyên nếu vẫn cần)
                                        function toggleDoctorFields() {
                                            const roleId = document.getElementById('role_id').value;
                                            const doctorFields = document.querySelector('.doctor-fields');
                                            if (doctorFields) {
                                                doctorFields.style.display = roleId === '3' ? 'block' : 'none';
                                            }
                                        }

                                        document.getElementById("avatar").addEventListener("change", function () {
                                            var fileInput = this;
                                            var fileNameDisplay = document.getElementById("fileName");
                                            var fileErrorDisplay = document.getElementById("fileError");

                                            // Clear old messages
                                            fileNameDisplay.textContent = "";
                                            fileErrorDisplay.textContent = "";

                                            if (fileInput.files.length > 0) {
                                                var file = fileInput.files[0];
                                                fileNameDisplay.textContent = "Đã chọn: " + file.name;

                                                if (file.size > 1048576) {
                                                    fileErrorDisplay.textContent = "Ảnh phải nhỏ hơn 1MB!";
                                                }
                                            }
                                        });

                                        document.getElementById("updateUserForm").addEventListener("submit", function (e) {
                                            var fileInput = document.getElementById("avatar");
                                            var fileErrorDisplay = document.getElementById("fileError");

                                            // Nếu có file và bị lỗi kích thước thì chặn submit
                                            if (fileInput.files.length > 0 && fileInput.files[0].size > 1048576) {
                                                e.preventDefault();
                                                fileErrorDisplay.textContent = "Ảnh phải nhỏ hơn 1MB!";
                                            }
                                        });

                                        // Tự động ẩn thông báo sau 5 giây
                                        setTimeout(function () {
                                            const successAlert = document.getElementById('successAlert');
                                            const failAlert = document.getElementById('failAlert');
                                            if (successAlert) {
                                                successAlert.style.display = 'none';
                                            }
                                            if (failAlert) {
                                                failAlert.style.display = 'none';
                                            }
                                        }, 8000);


                </script>

                <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

                <!-- Icons -->
                <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
                <!-- Main Js -->
                <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
            </body>

        </html>
