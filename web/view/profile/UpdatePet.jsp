<%-- 
    Document   : UpdatePet
    Created on : May 28, 2025, 3:36:48 PM
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



        </style>

    </head>

    <body>


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
                        <c:if test="${not empty sessionScope.SuccessMessage}">
                            <div class="alert alert-success" id="successAlert">${sessionScope.SuccessMessage}</div>
                            <c:remove var="SuccessMessage" scope="session"/>
                        </c:if>
                        <c:if test="${not empty sessionScope.SuccessMessage}">
                            <div class="alert alert-fail" id="failAlert">${sessionScope.FailMessage}</div>
                            <c:remove var="FailMessage" scope="session"/>
                        </c:if>
                        <h3 class="mb-4">Cập nhật thông tin Pet</h3>
                        <c:set var="pet" value="${requestScope.pet}"/>

                        <form action="updatepet" method="post" enctype="multipart/form-data">
                            <!-- Hidden ID để biết đang cập nhật pet nào -->
                            <input type="hidden" name="petId" value="${pet.id}"/>
                            <input type="hidden" name="id" value="${user.id}" />

                            <div class="mb-3">
                                <label for="name" class="form-label">Tên Pet:</label>
                                <input type="text" class="form-control" id="name" name="name" value="${pet.name}" required>
                            </div>

                            <div class="mb-3">
                                <label for="type" class="form-label">Loại Pet:</label>
                                <input type="text" class="form-control" id="type" name="type" value="${pet.breed.specie.name}" readonly>
                            </div>
                            <div class="mb-3">
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


                            <div class="mb-3">
                                <label for="gender" class="form-label">Giới tính:</label>
                                <select class="form-select" id="gender" name="gender">
                                    <option value="Male" ${pet.gender == 'Male' ? 'selected' : ''}>Đực</option>
                                    <option value="Female" ${pet.gender == 'Female' ? 'selected' : ''}>Cái</option>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label for="dateOfBirth" class="form-label">Ngày sinh:</label>
                                <input type="date" class="form-control" id="dateOfBirth" name="dateOfBirth" value="${pet.birthDate}">
                            </div>
                            <div class="mb-3">
                                <label for="status">Trạng thái:</label>
                                <select id="status" name="status" class="form-select">
                                    <option value="active" ${pet.status == 'active' ? 'selected' : ''}>Hoạt động</option>
                                    <option value="inactive" ${pet.status == 'inactive' ? 'selected' : ''}>Không hoạt động</option>
                                    <option value="lost" ${pet.status == 'lost' ? 'selected' : ''}>Đã chết</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="description" class="form-label">Mô tả:</label>
                                <textarea class="form-control" id="description" name="description" rows="4" required>${pet.description}</textarea>
                            </div>


                            <div class="mb-3">
                                <label class="form-label">Ảnh hiện tại:</label><br>
                                <img src="${pageContext.request.contextPath}/${pet.avatar}" alt="Pet Avatar" width="150" height="150" class="rounded mb-2">
                            </div>

                            <div class="mb-3">
                                <label for="avatar" class="form-label">Đổi ảnh mới (nếu có):</label>
                                <input type="file" class="form-control" id="avatar" name="avatar">
                                <small class="text-muted">Dung lượng tối đa 1MB.</small>
                                <div id="fileError" style="color:red"></div>
                            </div>

                            <div class="d-flex justify-content-between">
                                <a href="viewlistpet" class="btn btn-secondary" style="margin-bottom: 5px">Hủy</a>
                                <button type="submit" class="btn btn-primary" style="margin-bottom: 5px">Cập nhật</button>
                            </div>
                        </form>


                    </div><!--end row-->
                </div><!-- End -->
            </section><!--end section-->

        </div>
        <!-- Modal Cập Nhật -->






        <!-- Offcanvas Start -->
        <div class="offcanvas bg-white offcanvas-top" tabindex="-1" id="offcanvasTop">
            <div class="offcanvas-body d-flex align-items-center align-items-center">
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <div class="text-center">
                                <h4>Search now.....</h4>
                                <div class="subcribe-form mt-4">
                                    <form>
                                        <div class="mb-0">
                                            <input type="text" id="help" name="name" class="border bg-white rounded-pill" required="" placeholder="Search">
                                            <button type="submit" class="btn btn-pills btn-primary">Search</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div><!--end col-->
                    </div><!--end row-->
                </div><!--end container-->
            </div>
        </div>
        <!-- Offcanvas End -->

        <!-- Offcanvas Start -->
        <div class="offcanvas offcanvas-end bg-white shadow" tabindex="-1" id="offcanvasRight" aria-labelledby="offcanvasRightLabel">
            <div class="offcanvas-header p-4 border-bottom">
                <h5 id="offcanvasRightLabel" class="mb-0">
                    <img src="${pageContext.request.contextPath}/assets/images/logo-dark.png" height="24" class="light-version" alt="">
                    <img src="${pageContext.request.contextPath}/assets/images/logo-light.png" height="24" class="dark-version" alt="">
                </h5>
                <button type="button" class="btn-close d-flex align-items-center text-dark" data-bs-dismiss="offcanvas" aria-label="Close"><i class="uil uil-times fs-4"></i></button>
            </div>
            <div class="offcanvas-body p-4 px-md-5">
                <div class="row">
                    <div class="col-12">
                        <!-- Style switcher -->
                        <div id="style-switcher">
                            <div>
                                <ul class="text-center list-unstyled mb-0">
                                    <li class="d-grid"><a href="javascript:void(0)" class="rtl-version t-rtl-light" onclick="setTheme('style-rtl')"><img src="${pageContext.request.contextPath}/assets/images/layouts/landing-light-rtl.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">RTL Version</span></a></li>
                                    <li class="d-grid"><a href="javascript:void(0)" class="ltr-version t-ltr-light" onclick="setTheme('style')"><img src="${pageContext.request.contextPath}/assets/images/layouts/landing-light.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">LTR Version</span></a></li>
                                    <li class="d-grid"><a href="javascript:void(0)" class="dark-rtl-version t-rtl-dark" onclick="setTheme('style-dark-rtl')"><img src="${pageContext.request.contextPath}/assets/images/layouts/landing-dark-rtl.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">RTL Version</span></a></li>
                                    <li class="d-grid"><a href="javascript:void(0)" class="dark-ltr-version t-ltr-dark" onclick="setTheme('style-dark')"><img src="${pageContext.request.contextPath}/assets/images/layouts/landing-dark.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">LTR Version</span></a></li>
                                    <li class="d-grid"><a href="javascript:void(0)" class="dark-version t-dark mt-4" onclick="setTheme('style-dark')"><img src="${pageContext.request.contextPath}/assets/images/layouts/landing-dark.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Dark Version</span></a></li>
                                    <li class="d-grid"><a href="javascript:void(0)" class="light-version t-light mt-4" onclick="setTheme('style')"><img src="${pageContext.request.contextPath}/assets/images/layouts/landing-light.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Light Version</span></a></li>
                                    <li class="d-grid"><a href="../admin/#" target="_blank" class="mt-4"><img src="${pageContext.request.contextPath}/assets/images/layouts/light-dash.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Admin Dashboard</span></a></li>
                                </ul>
                            </div>
                        </div>
                        <!-- end Style switcher -->
                    </div><!--end col-->
                </div><!--end row-->
            </div>

            <div class="offcanvas-footer p-4 border-top text-center">
                <ul class="list-unstyled social-icon mb-0">
                    <li class="list-inline-item mb-0"><a href="https://1.envato.market/doctris-template" target="_blank" class="rounded"><i class="uil uil-shopping-cart align-middle" title="Buy Now"></i></a></li>
                    <li class="list-inline-item mb-0"><a href="https://dribbble.com/shreethemes" target="_blank" class="rounded"><i class="uil uil-dribbble align-middle" title="dribbble"></i></a></li>
                    <li class="list-inline-item mb-0"><a href="https://www.facebook.com/shreethemes" target="_blank" class="rounded"><i class="uil uil-facebook-f align-middle" title="facebook"></i></a></li>
                    <li class="list-inline-item mb-0"><a href="https://www.instagram.com/shreethemes/" target="_blank" class="rounded"><i class="uil uil-instagram align-middle" title="instagram"></i></a></li>
                    <li class="list-inline-item mb-0"><a href="https://twitter.com/shreethemes" target="_blank" class="rounded"><i class="uil uil-twitter align-middle" title="twitter"></i></a></li>
                    <li class="list-inline-item mb-0"><a href="mailto:support@shreethemes.in" class="rounded"><i class="uil uil-envelope align-middle" title="email"></i></a></li>
                    <li class="list-inline-item mb-0"><a href="../#" target="_blank" class="rounded"><i class="uil uil-globe align-middle" title="website"></i></a></li>
                </ul><!--end icon-->
            </div>
        </div>
        <!-- Offcanvas End -->

        <!-- javascript -->
        <script>
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
