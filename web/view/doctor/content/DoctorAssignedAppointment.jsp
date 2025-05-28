<%-- 
    Document   : Admin
    Created on : May 21, 2025, 8:24:23 PM
    Author     : Dell
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
        <meta name="website" content="${pageContext.request.contextPath}/index.html" />
        <meta name="Version" content="v1.2.0" />
        <!-- favicon -->
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico.png">
        <!-- Bootstrap -->
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- Select2 -->
        <link href="${pageContext.request.contextPath}/assets/css/select2.min.css" rel="stylesheet" />
        <!-- Date picker -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/flatpickr.min.css">
        <link href="${pageContext.request.contextPath}/assets/css/jquery.timepicker.min.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- Css -->
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />

    </head>

    <body>
        <!-- Loader -->
        <div id="preloader">
            <div id="status">
                <div class="spinner">
                    <div class="double-bounce1"></div>
                    <div class="double-bounce2"></div>
                </div>
            </div>
        </div>
        <!-- Loader -->

        <!-- Navbar Start -->
        <header id="topnav" class="navigation sticky">
            <div class="container d-flex justify-content-between align-items-center">
                <!-- Logo container-->
                <div>
                    <a class="logo" href="homepage">
                        <span class="logo-light-mode">
                            <img src="${pageContext.request.contextPath}/assets/images/logo.jpg" class="l-dark" height="30" alt="">
                            <img src="${pageContext.request.contextPath}/assets/images/logo.jpg" class="l-light" height="30" alt="">
                        </span>
                        <img src="${pageContext.request.contextPath}/assets/images/logo.jpg" height="30" class="logo-dark-mode" alt="">
                        <span style="padding-left: 10px;">Pet24h</span>
                    </a>
                </div>
                <!-- End Logo container-->

                <!-- Start Mobile Toggle -->
                <div class="menu-extras">
                    <div class="menu-item">
                        <a class="navbar-toggle" id="isToggle" onclick="toggleMenu()">
                            <div class="lines">
                                <span></span>
                                <span></span>
                                <span></span>
                            </div>
                        </a>
                    </div>
                </div>
                <!-- End Mobile Toggle -->

                <!-- Start Dropdown -->






                <div id="navigation">
                    <ul class="navigation-menu nav-left">
                        <li class="<c:if test='${currentUri eq "/homepage"}'>active</c:if>">
                                <a href="homepage">Trang chủ</a></li>
                            <li class="<c:if test='${currentUri eq "/homeaboutus"}'>active</c:if>">
                                <a href="homeaboutus">Về chúng tôi</a>
                            </li>
                            <li class="<c:if test='${currentUri eq "/homeblog"}'>active</c:if>">
                                <a href="homeblog">Tin tức</a></li>
                            <li class="has-submenu parent-menu-item position-relative">
                                <a href="homeaboutus#services">Dịch vụ</a>


                                <ul class="submenu p-0" style="width: 400px;">
                                    <div class="row px-3 py-2">
                                        <!-- Chia 2 cột bằng JSTL -->
                                    <c:set var="half" value="${fn:length(services) div 2 + fn:length(services) mod 2}" />
                                    <div class="col-6">
                                        <c:forEach var="s" items="${services}" varStatus="status">
                                            <c:if test="${status.index < half}">
                                                <li style="list-style:none;">
                                                    <a href="homeaboutus#services" class="sub-menu-item">${s.name}</a>
                                                </li>
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                    <div class="col-6">
                                        <c:forEach var="s" items="${services}" varStatus="status">
                                            <c:if test="${status.index >= half}">
                                                <li style="list-style:none;">
                                                    <a href="homeaboutus#services" class="sub-menu-item">${s.name}</a>
                                                </li>
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                </div>
                            </ul>
                        </li>


                        <li><a href="home-contact" class="sub-menu-item">Liên Hệ</a></li>
                    </ul>
                </div>

                <div class="ms-auto d-flex align-items-center">
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <ul class="dropdowns list-inline mb-0">
                                <li class="list-inline-item mb-0 ms-1">
                                    <div class="dropdown dropdown-primary">
                                        <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            <img src="${pageContext.request.contextPath}/assets/images/doctors/01.jpg" class="avatar avatar-ex-small rounded-circle" alt="">
                                        </button>
                                        <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3" style="min-width: 200px;">
                                            <a class="dropdown-item d-flex align-items-center text-dark" href="doctor-profile.html">
                                                <img src="${pageContext.request.contextPath}/assets/images/doctors/01.jpg" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                                <div class="flex-1 ms-2">
                                                    <span class="d-block mb-1">${sessionScope.user.name}</span>
                                                    <small class="text-muted">${sessionScope.user.role}</small>
                                                </div>
                                            </a>
                                            <a class="dropdown-item text-dark" href="doctor-dashboard.html">
                                                <i class="uil uil-dashboard align-middle h6 me-1"></i> Dashboard
                                            </a>
                                            <a class="dropdown-item text-dark" href="doctor-profile-setting.html">
                                                <i class="uil uil-setting align-middle h6 me-1"></i> Profile Settings
                                            </a>
                                            <div class="dropdown-divider border-top"></div>
                                            <a class="dropdown-item text-dark" href="logout">
                                                <i class="uil uil-sign-out-alt align-middle h6 me-1"></i> Logout
                                            </a>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </c:when>
                        <c:otherwise>
                            <a href="login" class="btn btn-primary">Login</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

        </header>
        <!-- Start Hero -->
        <section class="bg-dashboard">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-xl-3 col-lg-4 col-md-5 col-12">
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
                                <li class="navbar-item"><a href="doctor-assigned-appointment" class="navbar-link"><i class="ri-calendar-check-line align-middle navbar-icon"></i> Lịch hẹn</a></li>
                                <li class="navbar-item"><a href="doctor-record-examination" class="navbar-link"><i class="ri-file-line align-middle navbar-icon"></i> Ghi chép khám bệnh</a></li>
                                <li class="navbar-item"><a href="doctor-upload-test-result" class="navbar-link"><i class="ri-upload-line align-middle navbar-icon"></i> Tải kết quả xét nghiệm</a></li>
                                <li class="navbar-item"><a href="doctor-pet-medical-history" class="navbar-link"><i class="ri-history-line align-middle navbar-icon"></i> Lịch sử y tế thú cưng</a></li>
                                <li class="navbar-item"><a href="doctor-profile-setting" class="navbar-link"><i class="ri-user-settings-line align-middle navbar-icon"></i> Cài đặt hồ sơ</a></li>

                            </ul>
                        </div>
                    </div><!--end col-->

                    <div class="col-xl-9 col-lg-8 col-md-7 mt-4 pt-2 mt-sm-0 pt-sm-0">
                        <div class="row">
                            <div class="col-xl-9 col-lg-6 col-md-4">
                                <h5 class="mb-0">Cuộc hẹn</h5>
                            </div><!--end col-->

                            <div class="col-xl-3 col-lg-6 col-md-8 mt-4 mt-md-0">
                                <div class="justify-content-md-end">
                                    <form>
                                        <div class="row justify-content-between align-items-center">
                                            <div class="col-sm-12 col-md-5">
                                                <div class="mb-0 position-relative">
                                                    <select class="form-control time-during select2input">
                                                        <option value="EY">Today</option>
                                                        <option value="GY">Tomorrow</option>
                                                        <option value="PS">Yesterday</option>
                                                    </select>
                                                </div>
                                            </div><!--end col-->

                                            <div class="col-sm-12 col-md-7 mt-4 mt-sm-0">
                                                <div class="d-grid">
                                                    <a href="#" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#appointmentform">Appointment</a>
                                                </div>
                                            </div><!--end col-->
                                        </div><!--end row-->
                                    </form><!--end form-->
                                </div>
                            </div><!--end col-->
                        </div><!--end row-->

                        <div class="row">
                            <div class="col-12 mt-4">
                                <div class="table-responsive bg-white shadow rounded">
                                    <table class="table mb-0 table-center">
                                        <thead>
                                            <tr>
                                                <th class="border-bottom p-3" style="min-width: 50px;">#</th>
                                                <th class="border-bottom p-3" style="min-width: 180px;">Tên Thú Cưng</th>
                                                <th class="border-bottom p-3">Tên Bác Sĩ</th>
                                                <th class="border-bottom p-3">Tên Khách Hàng</th>
                                                <th class="border-bottom p-3" style="min-width: 150px;">Ngày</th>
                                                <th class="border-bottom p-3">Giờ</th>
                                                <th class="border-bottom p-3">Trạng Thái</th>
                                                <th class="border-bottom p-3">Phí</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <!-- Lặp qua các cuộc hẹn -->
                                            <c:forEach items="${requestScope.LIST_AP}" var="a" varStatus="counter">

                                                <tr>
                                                    <td class="p-3">${counter.count}</td>
                                                    <td class="p-3">
                                                        <a href="#" class="text-dark">
                                                            <div class="d-flex align-items-center">
                                                                <img src="${pageContext.request.contextPath}/${a.pet.avatar}" class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                                                <span class="ms-2">${a.pet.name}</span>
                                                            </div>
                                                        </a>
                                                    </td>
                                                    <td class="p-3">
                                                        <a href="#" class="text-dark">
                                                            <div class="d-flex align-items-center">
                                                                <img src="../assets/images/doctors/01.jpg" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                                                <span class="ms-2">${a.doctor}</span>
                                                            </div>
                                                        </a>
                                                    </td>
                                                    <td class="p-3">${a.user}</td> <!-- Tên khách hàng -->
                                                    <td class="p-3">${a.startTime}</td>
                                                    <td class="p-3">11:00AM</td>
                                                    <td class="p-3">${a.status}</td>
                                                    <td class="p-3">$50/Patient</td>
                                                </tr>
                                                <!-- Thêm các cuộc hẹn khác tương tự -->
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>



                        <div class="row text-center">
                            <!-- PAGINATION START -->
                            <div class="col-12 mt-4">
                                <div class="d-md-flex align-items-center text-center justify-content-between">
                                    <span class="text-muted me-3">Showing 1 - 10 out of 50</span>
                                    <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                                        <li class="page-item"><a class="page-link" href="javascript:void(0)" aria-label="Previous">Prev</a></li>
                                        <li class="page-item active"><a class="page-link" href="javascript:void(0)">1</a></li>
                                        <li class="page-item"><a class="page-link" href="javascript:void(0)">2</a></li>
                                        <li class="page-item"><a class="page-link" href="javascript:void(0)">3</a></li>
                                        <li class="page-item"><a class="page-link" href="javascript:void(0)" aria-label="Next">Next</a></li>
                                    </ul>
                                </div>
                            </div><!--end col-->
                            <!-- PAGINATION END -->
                        </div><!--end row-->
                    </div><!--end col-->
                </div><!--end row-->
            </div><!--end container-->
        </section><!--end section-->
        <!-- End Hero -->

        <!-- Modal start -->
        <!-- Add New Appointment Start -->
        <div class="modal fade" id="appointmentform" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header border-bottom p-3">
                        <h5 class="modal-title" id="exampleModalLabel">Book an Appointment</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body p-3 pt-4">
                        <form>
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="mb-3">
                                        <label class="form-label">Patient Name <span class="text-danger">*</span></label>
                                        <input name="name" id="name" type="text" class="form-control" placeholder="Patient Name :">
                                    </div>
                                </div><!--end col-->

                                <div class="col-lg-4 col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">Departments</label>
                                        <select class="form-control department-name select2input">
                                            <option value="EY">Eye Care</option>
                                            <option value="GY">Gynecologist</option>
                                            <option value="PS">Psychotherapist</option>
                                            <option value="OR">Orthopedic</option>
                                            <option value="DE">Dentist</option>
                                            <option value="GA">Gastrologist</option>
                                            <option value="UR">Urologist</option>
                                            <option value="NE">Neurologist</option>
                                        </select>
                                    </div>
                                </div><!--end col-->

                                <div class="col-lg-4 col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">Doctor</label>
                                        <select class="form-control doctor-name select2input">
                                            <option value="CA">Dr. Calvin Carlo</option>
                                            <option value="CR">Dr. Cristino Murphy</option>
                                            <option value="AL">Dr. Alia Reddy</option>
                                            <option value="TO">Dr. Toni Kovar</option>
                                            <option value="JE">Dr. Jessica McFarlane</option>
                                            <option value="EL">Dr. Elsie Sherman</option>
                                            <option value="BE">Dr. Bertha Magers</option>
                                            <option value="LO">Dr. Louis Batey</option>
                                        </select>
                                    </div>
                                </div><!--end col-->

                                <div class="col-lg-4 col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">Your Email <span class="text-danger">*</span></label>
                                        <input name="email" id="email" type="email" class="form-control" placeholder="Your email :">
                                    </div> 
                                </div><!--end col-->

                                <div class="col-lg-4 col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">Your Phone <span class="text-danger">*</span></label>
                                        <input name="phone" id="phone" type="tel" class="form-control" placeholder="Your Phone :">
                                    </div> 
                                </div><!--end col-->

                                <div class="col-lg-4 col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label"> Date : </label>
                                        <input name="date" type="text" class="flatpickr flatpickr-input form-control" id="checkin-date">
                                    </div>
                                </div><!--end col-->

                                <div class="col-lg-4 col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label" for="input-time">Time : </label>
                                        <input name="time" type="text" class="form-control timepicker" id="input-time" placeholder="03:30 PM">
                                    </div> 
                                </div><!--end col-->

                                <div class="col-lg-12">
                                    <div class="mb-3">
                                        <label class="form-label">Comments <span class="text-danger">*</span></label>
                                        <textarea name="comments" id="comments" rows="4" class="form-control" placeholder="Your Message :"></textarea>
                                    </div>
                                </div><!--end col-->

                                <div class="col-lg-12">
                                    <div class="d-grid">
                                        <button type="submit" class="btn btn-primary">Book An Appointment</button>
                                    </div>
                                </div><!--end col-->
                            </div><!--end row-->
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!-- Add New Appointment End -->

        <!-- View Appintment Start -->
        <div class="modal fade" id="viewappointment" tabindex="-1" aria-labelledby="exampleModalLabel1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header border-bottom p-3">
                        <h5 class="modal-title" id="exampleModalLabel1">Appointment Detail</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body p-3 pt-4">
                        <div class="d-flex align-items-center">
                            <img src="../assets/images/client/01.jpg" class="avatar avatar-small rounded-pill" alt="">
                            <h5 class="mb-0 ms-3">Howard Tanner</h5>
                        </div>
                        <ul class="list-unstyled mb-0 d-md-flex justify-content-between mt-4">
                            <li>
                                <ul class="list-unstyled mb-0">
                                    <li class="d-flex">
                                        <h6>Age:</h6>
                                        <p class="text-muted ms-2">25 year old</p>
                                    </li>

                                    <li class="d-flex">
                                        <h6>Gender:</h6>
                                        <p class="text-muted ms-2">Male</p>
                                    </li>

                                    <li class="d-flex">
                                        <h6 class="mb-0">Department:</h6>
                                        <p class="text-muted ms-2 mb-0">Cardiology</p>
                                    </li>
                                </ul>
                            </li>
                            <li>
                                <ul class="list-unstyled mb-0">
                                    <li class="d-flex">
                                        <h6>Date:</h6>
                                        <p class="text-muted ms-2">20th Dec 2020</p>
                                    </li>

                                    <li class="d-flex">
                                        <h6>Time:</h6>
                                        <p class="text-muted ms-2">11:00 AM</p>
                                    </li>

                                    <li class="d-flex">
                                        <h6 class="mb-0">Doctor:</h6>
                                        <p class="text-muted ms-2 mb-0">Dr. Calvin Carlo</p>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <!-- View Appintment End -->

        <!-- Accept Appointment Start -->
        <div class="modal fade" id="acceptappointment" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-body py-5">
                        <div class="text-center">
                            <div class="icon d-flex align-items-center justify-content-center bg-soft-success rounded-circle mx-auto" style="height: 95px; width:95px;">
                                <span class="mb-0"><i class="uil uil-check-circle h1"></i></span>
                            </div>
                            <div class="mt-4">
                                <h4>Accept Appointment</h4>
                                <p class="para-desc mx-auto text-muted mb-0">Great doctor if you need your family member to get immediate assistance, emergency treatment.</p>
                                <div class="mt-4">
                                    <a href="#" class="btn btn-soft-success">Accept</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Accept Appointment End -->

        <!-- Cancel Appointment Start -->
        <div class="modal fade" id="cancelappointment" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-body py-5">
                        <div class="text-center">
                            <div class="icon d-flex align-items-center justify-content-center bg-soft-danger rounded-circle mx-auto" style="height: 95px; width:95px;">
                                <span class="mb-0"><i class="uil uil-times-circle h1"></i></span>
                            </div>
                            <div class="mt-4">
                                <h4>Cancel Appointment</h4>
                                <p class="para-desc mx-auto text-muted mb-0">Great doctor if you need your family member to get immediate assistance, emergency treatment.</p>
                                <div class="mt-4">
                                    <a href="#" class="btn btn-soft-danger">Cancel</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Cancel Appointment End -->
        <!-- Modal end -->



        <!-- Back to top -->
        <a href="#" onclick="topFunction()" id="back-to-top" class="btn btn-icon btn-pills btn-primary back-to-top"><i data-feather="arrow-up" class="icons"></i></a>
        <!-- Back to top -->



        <!-- Offcanvas End -->

        <!-- javascript -->
        <script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <!-- Select2 -->
        <script src="${pageContext.request.contextPath}/assets/js/select2.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/select2.init.js"></script>
        <!-- Datepicker -->
        <script src="${pageContext.request.contextPath}/assets/js/flatpickr.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/flatpickr.init.js"></script>
        <!-- Datepicker -->
        <script src="${pageContext.request.contextPath}/assets/js/jquery.timepicker.min.js"></script> 
        <script src="${pageContext.request.contextPath}/assets/js/timepicker.init.js"></script> 
        <!-- Icons -->
        <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>




    </body>

</html>