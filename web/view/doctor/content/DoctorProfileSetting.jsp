<%-- 
    Document   : DoctorProfileSetting
    Created on : May 27, 2025, 6:56:33 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">

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
        <style>
            #avatarInput {
                width: 100%;
                display: inline-block;
                border: 1px solid #ccc;
                padding: 0.375rem 0.75rem;
                border-radius: 0.25rem;
                box-sizing: border-box;
            }
        </style>

    </head>

    <body>






        <%@include file="../../home/layout/Header.jsp" %>
        <section class="bg-dashboard">
            <div class="container">
                <c:if test="${not empty sessionScope.alertMessage}">
                    <script>
                        alert("${sessionScope.alertMessage}"); // Hiển thị thông báo
                        // Xóa thông báo khỏi session sau khi hiển thị
                        <c:remove var="alertMessage" scope="session"/>
                        <c:remove var="alertType" scope="session"/><!-- Xóa alertType khỏi session -->
                    </script>
                </c:if>
                <c:set value="${sessionScope.doctor}" var="doctor"></c:set>
                    <div class="row justify-content-center">
                        <div class="col-xl-4 col-lg-4 col-md-5 col-12">
                            <div class="rounded shadow overflow-hidden sticky-bar">
                                <div class="card border-0">
                                    <img src="${pageContext.request.contextPath}/${doctor.user.avatar}" class="img-fluid" alt="">
                            </div>

                            <div class="text-center avatar-profile margin-nagative mt-n5 position-relative pb-4 border-bottom">
                                <img src="${pageContext.request.contextPath}/${doctor.user.avatar}" class="rounded-circle shadow-md avatar avatar-md-md" alt="">
                                <h5 class="mt-3 mb-1">${doctor.user.fullName}</h5>
                                <p class="text-muted mb-0">${doctor.specialty}</p>
                            </div>

                            <ul class="list-unstyled sidebar-nav mb-0">
                                <li class="navbar-item"><a href="doctor-dashboard" class="navbar-link"><i class="ri-dashboard-line align-middle navbar-icon"></i> Bảng điều khiển</a></li>
                                <li class="navbar-item"><a href="doctor-assigned-appointment" class="navbar-link"><i class="ri-calendar-check-line align-middle navbar-icon"></i> Lịch hẹn</a></li>
                                <li class="navbar-item"><a href="doctor-record-examination" class="navbar-link"><i class="ri-file-line align-middle navbar-icon"></i> Ghi chép khám bệnh</a></li>
                                <li class="navbar-item"><a href="doctor-upload-test-result" class="navbar-link"><i class="ri-upload-line align-middle navbar-icon"></i> Tải kết quả xét nghiệm</a></li>
                                <li class="navbar-item"><a href="doctor-pet-medical-history" class="navbar-link"><i class="ri-history-line align-middle navbar-icon"></i> Lịch sử y tế thú cưng</a></li>
                                <li class="navbar-item"><a href="doctor-profile-setting" class="navbar-link"><i class="ri-user-settings-line align-middle navbar-icon"></i> Cài đặt hồ sơ</a></li>

                            </ul>
                        </div>
                    </div><!--end col-->

                    <div class="col-xl-8 col-lg-8 col-md-7 mt-4 pt-2 mt-sm-0 pt-sm-0">

                        <div class="rounded shadow mt-4">
                            <div class="p-4 border-bottom">
                                <h5 class="mb-0">Thông tin bác sĩ</h5>
                            </div>
                            <form id="doctorProfileForm" action="doctor-profile-setting" method="post" enctype="multipart/form-data">
                                <div class="p-4 border-bottom">
                                    <div class="row align-items-center">
                                        <div class="col-lg-2 col-md-4">
                                            <img src="${pageContext.request.contextPath}/${doctor.user.avatar}" id="avatarPreview" class="avatar avatar-md-md rounded-pill shadow mx-auto d-block" alt="">
                                        </div>
                                        <div class="col-lg-5 col-md-8 text-center text-md-start mt-4 mt-sm-0">
                                            <h5>Ảnh đại diện</h5>
                                            <p class="text-muted mb-0">Chọn ảnh vuông tối thiểu 256x256 (.jpg, .png)</p>
                                        </div>
                                        <div class="col-lg-5 col-md-12 text-lg-end text-center mt-4 mt-lg-0">
                                            <!-- Thêm các thuộc tính CSS để chỉnh sửa giao diện input file -->
                                            <input type="file" class="form-control d-inline-block w-100" name="avatar" id="avatarInput" accept=".jpg,.jpeg,.png" onchange="previewAvatar(event)">
                                            <button type="button" class="btn btn-soft-primary ms-2" onclick="removeAvatar()">Xóa</button>
                                        </div>
                                    </div>
                                </div>
                                <div class="p-4">
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Họ tên</label>
                                            <input name="fullName" type="text" class="form-control" value="${doctor.user.fullName}" placeholder="Họ tên" required>
                                            <div class="error-message"></div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Email</label>
                                            <input name="email" type="email" class="form-control" value="${doctor.user.email}" placeholder="Email" readonly>
                                            <div class="error-message"></div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Số điện thoại</label>
                                            <input name="phone" type="text" class="form-control" value="${doctor.user.phoneNumber}" placeholder="Số điện thoại">
                                            <div class="error-message"></div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Địa chỉ</label>
                                            <input name="address" type="text" class="form-control" value="${doctor.user.address}" placeholder="Địa chỉ">
                                            <div class="error-message"></div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Chuyên khoa</label>
                                            <input name="specialty" type="text" class="form-control" value="${doctor.specialty}" placeholder="Chuyên khoa">
                                            <div class="error-message"></div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Bằng cấp</label>
                                            <input name="qualifications" type="text" class="form-control" value="${doctor.qualifications}" placeholder="Bằng cấp">
                                            <div class="error-message"></div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Chứng chỉ</label>
                                            <input name="certificates" type="text" class="form-control" value="${doctor.certificates}" placeholder="Chứng chỉ">
                                            <div class="error-message"></div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Số năm kinh nghiệm</label>
                                            <input name="yearsOfExperience" type="number" min="0" class="form-control" value="${doctor.yearsOfExperience}" placeholder="Năm kinh nghiệm">
                                            <div class="error-message"></div>
                                        </div>
                                        <div class="col-md-12 mb-3">
                                            <label class="form-label">Tiểu sử giới thiệu</label>
                                            <textarea name="biography" rows="4" class="form-control" placeholder="Giới thiệu bản thân">${doctor.biography}</textarea>
                                            <div class="error-message"></div>
                                        </div>

                                      
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12 text-end">
                                            <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>

                        <div class="rounded shadow mt-4">
                            <div class="p-4 border-bottom">
                                <h5 class="mb-0">Change Password :</h5>
                            </div>

                            <div class="p-4">
                                <form>
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="mb-3">
                                                <label class="form-label">Old password :</label>
                                                <input type="password" class="form-control" placeholder="Old password" required="">
                                            </div>
                                        </div><!--end col-->

                                        <div class="col-lg-12">
                                            <div class="mb-3">
                                                <label class="form-label">New password :</label>
                                                <input type="password" class="form-control" placeholder="New password" required="">
                                            </div>
                                        </div><!--end col-->

                                        <div class="col-lg-12">
                                            <div class="mb-3">
                                                <label class="form-label">Re-type New password :</label>
                                                <input type="password" class="form-control" placeholder="Re-type New password" required="">
                                            </div>
                                        </div><!--end col-->

                                        <div class="col-lg-12 mt-2 mb-0">
                                            <button class="btn btn-primary">Save password</button>
                                        </div><!--end col-->
                                    </div><!--end row-->
                                </form>
                            </div>
                        </div>






                    </div><!--end col-->
                </div><!--end row-->
            </div><!--end container-->
        </section><!--end section-->





                <script>
    function previewAvatar(event) {
        const input = event.target;
        const preview = document.getElementById('avatarPreview');
        if (input.files && input.files[0]) {
            const reader = new FileReader();
            reader.onload = function (e) {
                preview.src = e.target.result;
            }
            reader.readAsDataURL(input.files[0]);
        }
    }

    function removeAvatar() {
        document.getElementById('avatarInput').value = '';
        document.getElementById('avatarPreview').src = '${doctor.user.avatar}'; // Reset lại ảnh cũ
    }

    const form = document.getElementById('doctorProfileForm');
    const nameInput = document.querySelector('input[name="fullName"]');
    const phoneInput = document.querySelector('input[name="phone"]');
    const emailInput = document.querySelector('input[name="email"]');
    const descriptionInput = document.querySelector('textarea[name="biography"]');

    function createErrorElem(input) {
        let err = input.nextElementSibling;
        if (!err || !err.classList.contains('error-message')) {
            err = document.createElement('div');
            err.classList.add('error-message');
            input.parentNode.insertBefore(err, input.nextSibling);
        }
        return err;
    }

    function validatePhone() {
        const val = phoneInput.value.trim();
        const phonePattern = /^0\d{9}$/;
        const errElem = createErrorElem(phoneInput);
        if (!phonePattern.test(val)) {
            errElem.textContent = 'Số điện thoại phải bắt đầu bằng số 0 và có đúng 10 số.';
            return false;
        } else {
            errElem.textContent = '';
            return true;
        }
    }

    function validateEmail() {
        const val = emailInput.value.trim();
        const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        const errElem = createErrorElem(emailInput);
        if (!emailPattern.test(val)) {
            errElem.textContent = 'Email phải là địa chỉ Gmail hợp lệ, ví dụ: ten@gmail.com.';
            return false;
        } else {
            errElem.textContent = '';
            return true;
        }
    }

    function validateName() {
        const val = nameInput.value.trim();
        const errElem = createErrorElem(nameInput);
        if (val === '') {
            errElem.textContent = 'Họ và tên không được để trống.';
            return false;
        } else {
            errElem.textContent = '';
            return true;
        }
    }

    function validateDescription() {
        const val = descriptionInput.value.trim();
        const errElem = createErrorElem(descriptionInput);
        if (val === '') {
            errElem.textContent = 'Vui lòng nhập miêu tả.';
            return false;
        } else {
            errElem.textContent = '';
            return true;
        }
    }

    nameInput.addEventListener('blur', validateName);
    phoneInput.addEventListener('blur', validatePhone);
    emailInput.addEventListener('blur', validateEmail);
    descriptionInput.addEventListener('blur', validateDescription);

    form.addEventListener('submit', function (e) {
        const validName = validateName();
        const validPhone = validatePhone();
        const validEmail = validateEmail();
        const validDescription = validateDescription();

        if (!validName || !validPhone || !validEmail || !validDescription) {
            e.preventDefault(); // Ngừng gửi form nếu có lỗi
        }
    });
</script>






                     <!--End             -->



                               


        <a href="#" onclick="topFunction()" id="back-to-top" class="btn btn-icon btn-pills btn-primary back-to-top"><i data-feather="arrow-up" class="icons"></i></a>
        <!-- Back to top 



-->                <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script><!--
                <!-- Icons -->
                <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
                <!-- Main Js -->
                <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
            </body>

        </html>
