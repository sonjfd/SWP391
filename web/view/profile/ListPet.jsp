<%-- 
    Document   : ListPet
    Created on : May 26, 2025, 11:13:20 AM
    Author     : Admin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

        <c:set var="user" value="${sessionScope.user}"/>

        <!-- Navbar STart -->
        <%@include file="../home/layout/Header.jsp" %>
        <!-- Navbar End -->
        <div class="container">

            <section class="bg-dashboard">

                <div class="row">
                    <div class=" col-3">
                        <div class="rounded shadow overflow-hidden sticky-bar">
                            <div class="card border-0">
                                <img src="${pageContext.request.contextPath}/assets/images/doctors/profile-bg.jpg" class="img-fluid" alt="">
                            </div>
                            <div class="text-center avatar-profile margin-nagative mt-n5 position-relative pb-4 border-bottom">
                                <img src="${pageContext.request.contextPath}/${user.avatar}" class="rounded-circle shadow-md avatar avatar-md-md" alt="">
                                <h5 class="mt-3 mb-1">${user.fullName}</h5>


                            </div>
                            <ul class="list-unstyled sidebar-nav mb-0">
                                <li class="navbar-item"><a href="doctor-appointment.html" class="navbar-link"><i class="ri-calendar-check-line align-middle navbar-icon"></i> Lịch hẹn</a></li>
                                <li class="navbar-item"><a href="doctor-schedule.html" class="navbar-link"><i class="ri-timer-line align-middle navbar-icon"></i>Lịch sử khám bệnh</a></li>
                                <li class="navbar-item"><a href="viewlistpet?id=${user.id}" class="navbar-link"><i class="ri-bear-smile-line align-middle navbar-icon"></i> Danh sách thú cưng</a></li>
                                <li class="navbar-item"><a href="viewuserinformation?id=${user.id}" class="navbar-link"><i class="ri-user-settings-line align-middle navbar-icon"></i> Cài đặt thông tin cá nhân</a></li>
                                <li class="navbar-item"><a href="doctor-chat.html" class="navbar-link"><i class="ri-chat-voice-line align-middle navbar-icon"></i> Trò chuyện</a></li>
                            </ul>
                        </div>
                    </div><!--end col-->

                    <div class=" col-9">

                        <!-- Start -->
                        <div class="canle">
                            <a href="addpet" class="create-btn">Add New Pet</a>
                            <form method="post" action="searchpet" class="search-form">
                                <input type="text" name="search" value="${search}" placeholder="Search by Name">
                                <button type="submit">Search</button>
                            </form>
                        </div>
                        <table class="table table-striped ">
                            <thead>
                                <tr>
                                    <th>Tên Pet</th>
                                    <th>Giới Tính</th>
                                    <th>Ảnh</th>
                                    <th>Giống</th>
                                    <th>Trạng Thái</th>
                                    <th>Hành Động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${listpet}" var="pet">
                                    <tr>
                                        <td>${pet.name}</td>
                                        <td>${pet.gender}</td>
                                        <td>
                                            <img src="${pageContext.request.contextPath}${pet.avatar}" alt="pet" width="50px" />
                                        </td>
                                        <td>${pet.breed.name}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${pet.status == 'active'}">Hoạt động</c:when>
                                                <c:when test="${pet.status == 'inactive'}">Không hoạt động</c:when>
                                                <c:when test="${pet.status == 'lost'}">Đã chết</c:when>

                                            </c:choose>
                                        </td>

                                        <td>
                                            <a href="updatepet?petID=${pet.id}" class="btn btn-warning">
                                                <i class="fa-solid fa-pen-to-square"></i>
                                            </a>

                                            <!-- Nút Chi tiết -->
                                            <button type="button" class="btn btn-info" 
                                                    data-bs-toggle="modal" data-bs-target="#detailPetModal${pet.id}">
                                                <i class="fa-solid fa-circle-info"></i>
                                            </button>

                                            <!-- Nút Xóa -->
                                            <form action="deletepet" method="post" style="display:inline;" 
                                                  onsubmit="return confirm('Bạn có chắc muốn xóa pet này không?');">
                                                <input type="hidden" name="id" value="${pet.id}" />
                                                <button type="submit" class="btn btn-danger ">
                                                    <i class="fa-solid fa-trash"></i>
                                                </button>
                                            </form>
                                        </td>

                                    </tr>


                                    <!-- Modal Chi tiết -->
                                <div class="modal fade" id="detailPetModal${pet.id}" tabindex="-1" aria-labelledby="detailPetModalLabel${pet.id}" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered modal-lg">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="detailPetModalLabel${pet.id}">Thông tin chi tiết Pet</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                                            </div>
                                            <div class="modal-body">
                                                <div class="row">
                                                    <div class="col-md-4 text-center">
                                                        <img src="${pageContext.request.contextPath}${pet.avatar}" alt="Pet" class="img-fluid rounded mb-3" />
                                                    </div>
                                                    <div class="col-md-8">

                                                        <p><strong>Tên:</strong> ${pet.name}</p>
                                                        <p><strong>Giới tính:</strong> ${pet.gender}</p>
                                                        <p><strong>Ngày sinh:</strong> ${pet.birthDate}</p>
                                                        <p><strong>Giống:</strong> ${pet.breed.name}</p>
                                                        <p><strong>Loại:</strong> ${pet.breed.specie.name}</p>
                                                        <p><strong>Trạng thái:</strong>
                                                            <c:choose>
                                                                <c:when test="${pet.status == 'active'}">Hoạt động</c:when>
                                                                <c:when test="${pet.status == 'inactive'}">Không hoạt động</c:when>
                                                                <c:when test="${pet.status == 'lost'}">Đã chết</c:when>
                                                            </c:choose>
                                                        </p>

                                                        <p><strong>Mô tả:</strong> ${pet.description}</p>
                                                        <p><strong>Ngày tạo:</strong> ${pet.createDate}</p>
                                                        <p><strong>Ngày cập nhật:</strong> ${pet.updateDate}</p>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                            </tbody>
                        </table>
                        <c:if test="${not empty sessionScope.SuccessMessage}">
                            <div class="alert alert-success" id="successAlert">${sessionScope.SuccessMessage}</div>
                            <c:remove var="SuccessMessage" scope="session"/>
                        </c:if>
                        <c:if test="${not empty sessionScope.SuccessMessage}">
                            <div class="alert alert-fail" id="failAlert">${sessionScope.FailMessage}</div>
                            <c:remove var="FailMessage" scope="session"/>
                        </c:if>




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
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

        <!-- Icons -->
        <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
    </body>

</html>
