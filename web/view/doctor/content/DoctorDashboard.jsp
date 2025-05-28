<%-- 
    Document   : DoctorDashboard
    Created on : May 27, 2025, 6:50:18 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

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
        <!-- SLIDER -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/tiny-slider.css"/>
        <!-- Icons -->
        <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- Css -->
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />

    </head>

    <body>


        <%@include file="../../home/layout/Header.jsp" %>

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
                                    <li class="navbar-item"><a href="doctor-dashboard" class="navbar-link"><i class="ri-dashboard-line align-middle navbar-icon"></i> Bảng điều khiển</a></li>
                                    <li class="navbar-item"><a href="doctor-assigned-appointment" class="navbar-link"><i class="ri-calendar-check-line align-middle navbar-icon"></i> Lịch hẹn</a></li>
                                    <li class="navbar-item"><a href="doctor-record-examination" class="navbar-link"><i class="ri-file-line align-middle navbar-icon"></i> Ghi chép khám bệnh</a></li>
                                    <li class="navbar-item"><a href="doctor-upload-test-result" class="navbar-link"><i class="ri-upload-line align-middle navbar-icon"></i> Tải kết quả xét nghiệm</a></li>
                                    <li class="navbar-item"><a href="doctor-pet-medical-history" class="navbar-link"><i class="ri-history-line align-middle navbar-icon"></i> Lịch sử y tế thú cưng</a></li>
                                    <li class="navbar-item"><a href="doctor-profile-setting" class="navbar-link"><i class="ri-user-settings-line align-middle navbar-icon"></i> Cài đặt hồ sơ</a></li>

                                </ul>
                            </div>
                        
                    </div><!--end col-->

                    <div class="col-xl-9 col-lg-8 col-md-7 mt-4 mt-sm-0">
                        <h5 class="mb-0">Dashboard</h5>
                        <div class="row">
                            <div class="col-xl-3 col-lg-6 mt-4">
                                <div class="card shadow border-0 p-4">
                                    <div class="d-flex justify-content-between mb-3">
                                        <h6 class="align-items-center mb-0">Appointment <span class="badge badge-pill badge-soft-primary ms-1">+15%</span></h6>
                                        <p class="mb-0 text-muted">220+ Week</p>
                                    </div>
                                    <div id="chart-1"></div>
                                </div>
                            </div><!--end col-->

                            <div class="col-xl-3 col-lg-6 mt-4">
                                <div class="card shadow border-0 p-4">
                                    <div class="d-flex justify-content-between mb-3">
                                        <h6 class="align-items-center mb-0">Patients <span class="badge badge-pill badge-soft-success ms-1">+20%</span></h6>
                                        <p class="mb-0 text-muted">220+ Week</p>
                                    </div>
                                    <div id="chart-2"></div>
                                </div>
                            </div><!--end col-->

                            <div class="col-xl-3 col-lg-6 mt-4">
                                <div class="card shadow border-0 p-4">
                                    <div class="d-flex justify-content-between mb-3">
                                        <h6 class="align-items-center mb-0">Urgent <span class="badge badge-pill badge-soft-warning ms-1">+5%</span></h6>
                                        <p class="mb-0 text-muted">220+ Week</p>
                                    </div>
                                    <div id="chart-3"></div>
                                </div>
                            </div><!--end col-->

                            <div class="col-xl-3 col-lg-6 mt-4">
                                <div class="card shadow border-0 p-4">
                                    <div class="d-flex justify-content-between mb-3">
                                        <h6 class="align-items-center mb-0">Canceled <span class="badge badge-pill badge-soft-danger ms-1">-5%</span></h6>
                                        <p class="mb-0 text-muted">220+ Week</p>
                                    </div>
                                    <div id="chart-4"></div>
                                </div>
                            </div><!--end col-->
                        </div><!--end row-->

                        <div class="row">
                            <div class="col-xl-4 col-lg-6 mt-4">
                                <div class="card border-0 shadow rounded">
                                    <div class="d-flex justify-content-between p-4 border-bottom">
                                        <h6 class="mb-0"><i class="uil uil-calender text-primary me-1 h5"></i> Latest Appointment</h6>
                                        <h6 class="text-muted mb-0">55 Patients</h6>
                                    </div>

                                    <ul class="list-unstyled mb-0 p-4">
                                        <li>
                                            <a href="javascript:void(0)">
                                                <div class="d-flex align-items-center justify-content-between">
                                                    <div class="d-inline-flex">
                                                        <img src="${pageContext.request.contextPath}/assets/images/client/01.jpg" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                                        <div class="ms-3">
                                                            <h6 class="text-dark mb-0 d-block">Calvin Carlo</h6>
                                                            <small class="text-muted">Booking on 27th Nov, 2020</small>
                                                        </div>
                                                    </div>
                                                    <i class="uil uil-arrow-right h4 text-dark"></i>
                                                </div>
                                            </a>
                                        </li>

                                        <li class="mt-4">
                                            <a href="javascript:void(0)">
                                                <div class="d-flex align-items-center justify-content-between">
                                                    <div class="d-inline-flex">
                                                        <img src="${pageContext.request.contextPath}/assets/images/client/02.jpg" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                                        <div class="ms-3">
                                                            <h6 class="text-dark mb-0 d-block">Joya Khan</h6>
                                                            <small class="text-muted">Booking on 27th Nov, 2020</small>
                                                        </div>
                                                    </div>
                                                    <i class="uil uil-arrow-right h4 text-dark"></i>
                                                </div>
                                            </a>
                                        </li>

                                        <li class="mt-4">
                                            <a href="javascript:void(0)">
                                                <div class="d-flex align-items-center justify-content-between">
                                                    <div class="d-inline-flex">
                                                        <img src="${pageContext.request.contextPath}/assets/images/client/03.jpg" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                                        <div class="ms-3">
                                                            <h6 class="text-dark mb-0 d-block">Amelia Muli</h6>
                                                            <small class="text-muted">Booking on 27th Nov, 2020</small>
                                                        </div>
                                                    </div>
                                                    <i class="uil uil-arrow-right h4 text-dark"></i>
                                                </div>
                                            </a>
                                        </li>

                                        <li class="mt-4">
                                            <a href="javascript:void(0)">
                                                <div class="d-flex align-items-center justify-content-between">
                                                    <div class="d-inline-flex">
                                                        <img src="${pageContext.request.contextPath}/assets/images/client/04.jpg" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                                        <div class="ms-3">
                                                            <h6 class="text-dark mb-0 d-block">Nik Ronaldo</h6>
                                                            <small class="text-muted">Booking on 27th Nov, 2020</small>
                                                        </div>
                                                    </div>
                                                    <i class="uil uil-arrow-right h4 text-dark"></i>
                                                </div>
                                            </a>
                                        </li>

                                        <li class="mt-4">
                                            <a href="javascript:void(0)">
                                                <div class="d-flex align-items-center justify-content-between">
                                                    <div class="d-inline-flex">
                                                        <img src="${pageContext.request.contextPath}/assets/images/client/05.jpg" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                                        <div class="ms-3">
                                                            <h6 class="text-dark mb-0 d-block">Crista Joseph</h6>
                                                            <small class="text-muted">Booking on 27th Nov, 2020</small>
                                                        </div>
                                                    </div>
                                                    <i class="uil uil-arrow-right h4 text-dark"></i>
                                                </div>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div><!--end col-->

                            <div class="col-xl-4 col-lg-6 mt-4">
                                <div class="card border-0 shadow rounded">
                                    <div class="d-flex justify-content-between p-4 border-bottom">
                                        <h6 class="mb-0"><i class="uil uil-calendar-alt text-primary me-1 h5"></i> Upcoming Appointment</h6>
                                        <h6 class="text-muted mb-0">55 Patients</h6>
                                    </div>

                                    <ul class="list-unstyled mb-0 p-4">
                                        <li>
                                            <a href="javascript:void(0)">
                                                <div class="d-flex align-items-center justify-content-between">
                                                    <div class="d-inline-flex">
                                                        <img src="${pageContext.request.contextPath}/assets/images/client/06.jpg" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                                        <div class="ms-3">
                                                            <h6 class="text-dark mb-0 d-block">Cristino Murphy</h6>
                                                            <small class="text-muted">Booking on 27th Nov, 2020</small>
                                                        </div>
                                                    </div>
                                                    <i class="uil uil-arrow-right h4 text-dark"></i>
                                                </div>
                                            </a>
                                        </li>

                                        <li class="mt-4">
                                            <a href="javascript:void(0)">
                                                <div class="d-flex align-items-center justify-content-between">
                                                    <div class="d-inline-flex">
                                                        <img src="${pageContext.request.contextPath}/assets/images/client/07.jpg" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                                        <div class="ms-3">
                                                            <h6 class="text-dark mb-0 d-block">Nick Jons</h6>
                                                            <small class="text-muted">Booking on 27th Nov, 2020</small>
                                                        </div>
                                                    </div>
                                                    <i class="uil uil-arrow-right h4 text-dark"></i>
                                                </div>
                                            </a>
                                        </li>

                                        <li class="mt-4">
                                            <a href="javascript:void(0)">
                                                <div class="d-flex align-items-center justify-content-between">
                                                    <div class="d-inline-flex">
                                                        <img src="${pageContext.request.contextPath}/assets/images/client/08.jpg" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                                        <div class="ms-3">
                                                            <h6 class="text-dark mb-0 d-block">Alex Dirio</h6>
                                                            <small class="text-muted">Booking on 27th Nov, 2020</small>
                                                        </div>
                                                    </div>
                                                    <i class="uil uil-arrow-right h4 text-dark"></i>
                                                </div>
                                            </a>
                                        </li>

                                        <li class="mt-4">
                                            <a href="javascript:void(0)">
                                                <div class="d-flex align-items-center justify-content-between">
                                                    <div class="d-inline-flex">
                                                        <img src="${pageContext.request.contextPath}/assets/images/client/09.jpg" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                                        <div class="ms-3">
                                                            <h6 class="text-dark mb-0 d-block">Vrunda Koli</h6>
                                                            <small class="text-muted">Booking on 27th Nov, 2020</small>
                                                        </div>
                                                    </div>
                                                    <i class="uil uil-arrow-right h4 text-dark"></i>
                                                </div>
                                            </a>
                                        </li>

                                        <li class="mt-4">
                                            <a href="javascript:void(0)">
                                                <div class="d-flex align-items-center justify-content-between">
                                                    <div class="d-inline-flex">
                                                        <img src="${pageContext.request.contextPath}/assets/images/client/10.jpg" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                                        <div class="ms-3">
                                                            <h6 class="text-dark mb-0 d-block">Aisha Low</h6>
                                                            <small class="text-muted">Booking on 27th Nov, 2020</small>
                                                        </div>
                                                    </div>
                                                    <i class="uil uil-arrow-right h4 text-dark"></i>
                                                </div>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div><!--end col-->

                            <div class="col-xl-4 col-lg-12 mt-4">
                                <div class="card border-0 shadow rounded">
                                    <div class="p-4 border-bottom">
                                        <h6 class="mb-0">Patient's Review</h6>
                                    </div>

                                    <div class="p-4">
                                        <div class="client-review-slider">
                                            <div class="tiny-slide">
                                                <p class="text-muted fst-italic">" It seems that only melodies in order to have a 'ready-made' text to sing with the melody of the originalthe 'Lorem Ipsum', which is said to have originated century. "</p>

                                                <div class="d-inline-flex align-items-center">
                                                    <img src="${pageContext.request.contextPath}/assets/images/client/01.jpg" class="img-fluid avatar avatar-small rounded-circle mx-auto shadow my-3" alt="">
                                                    <div class="ms-3">
                                                        <ul class="list-unstyled d-block mb-0">
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                        </ul>
                                                        <h6 class="text-primary">- Thomas Israel <small class="text-muted">C.E.O</small></h6>
                                                    </div>
                                                </div>
                                            </div><!--end customer testi-->

                                            <div class="tiny-slide">
                                                <p class="text-muted fst-italic">" The advantage of its writing melodies in order to have a 'ready-made' text to sing with the melody and the to itself or distract the viewer's attention from the layout. "</p>

                                                <div class="d-inline-flex align-items-center">
                                                    <img src="${pageContext.request.contextPath}/assets/images/client/02.jpg" class="img-fluid avatar avatar-small rounded-circle mx-auto shadow my-3" alt="">
                                                    <div class="ms-3">
                                                        <ul class="list-unstyled d-block mb-0">
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                        </ul>
                                                        <h6 class="text-primary">- Carl Oliver <small class="text-muted">P.A</small></h6>
                                                    </div>
                                                </div>
                                            </div><!--end customer testi-->

                                            <div class="tiny-slide">
                                                <p class="text-muted fst-italic">" There is now an in order to have a 'ready-made' text to sing with the melody alternatives to the classic Lorem Ipsum texts are amusing. "</p>

                                                <div class="d-inline-flex align-items-center">
                                                    <img src="${pageContext.request.contextPath}/assets/images/client/03.jpg" class="img-fluid avatar avatar-small rounded-circle mx-auto shadow my-3" alt="">
                                                    <div class="ms-3">
                                                        <ul class="list-unstyled d-block mb-0">
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                        </ul>
                                                        <h6 class="text-primary">- Barbara McIntosh <small class="text-muted">M.D</small></h6>
                                                    </div>
                                                </div>
                                            </div><!--end customer testi-->

                                            <div class="tiny-slide">
                                                <p class="text-muted fst-italic">" According to most sources in order to have a 'ready-made' text to sing with the melody the origin of the text by compiling all the instances. "</p>

                                                <div class="d-inline-flex align-items-center">
                                                    <img src="${pageContext.request.contextPath}/assets/images/client/04.jpg" class="img-fluid avatar avatar-small rounded-circle mx-auto shadow my-3" alt="">
                                                    <div class="ms-3">
                                                        <ul class="list-unstyled d-block mb-0">
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                        </ul>
                                                        <h6 class="text-primary">- Christa Smith <small class="text-muted">Manager</small></h6>
                                                    </div>
                                                </div>
                                            </div><!--end customer testi-->

                                            <div class="tiny-slide">
                                                <p class="text-muted fst-italic">" It seems that only in order to have a 'ready-made' text to sing with the melody 'Lorem Ipsum', which is said to have originated 16th century. "</p>

                                                <div class="d-inline-flex align-items-center">
                                                    <img src="${pageContext.request.contextPath}/assets/images/client/05.jpg" class="img-fluid avatar avatar-small rounded-circle mx-auto shadow my-3" alt="">
                                                    <div class="ms-3">
                                                        <ul class="list-unstyled d-block mb-0">
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                        </ul>
                                                        <h6 class="text-primary">- Dean Tolle <small class="text-muted">Developer</small></h6>
                                                    </div>
                                                </div>
                                            </div><!--end customer testi-->

                                            <div class="tiny-slide">
                                                <p class="text-muted fst-italic">" It seems that only lyrics when writing melodies in order to have a 'ready-made' text to sing with the melody of time certain letters were added or deleted at the text. "</p>

                                                <div class="d-inline-flex align-items-center">
                                                    <img src="${pageContext.request.contextPath}/assets/images/client/06.jpg" class="img-fluid avatar avatar-small rounded-circle mx-auto shadow my-3" alt="">
                                                    <div class="ms-3">
                                                        <ul class="list-unstyled d-block mb-0">
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                        </ul>
                                                        <h6 class="text-primary">- Jill Webb <small class="text-muted">Designer</small></h6>
                                                    </div>
                                                </div>
                                            </div><!--end customer testi-->
                                        </div><!--end carousel-->

                                        <div class="row justify-content-center mt-3">
                                            <div class="col-md col-6 text-center pt-3">
                                                <img src="${pageContext.request.contextPath}/assets/images/client/amazon.png" class="avatar avatar-client" alt="">
                                            </div><!--end col-->

                                            <div class="col-md col-6 text-center pt-3">
                                                <img src="${pageContext.request.contextPath}/assets/images/client/google.png" class="avatar avatar-client" alt="">
                                            </div><!--end col-->

                                            <div class="col-md col-6 text-center pt-3">
                                                <img src="${pageContext.request.contextPath}/assets/images/client/lenovo.png" class="avatar avatar-client" alt="">
                                            </div><!--end col-->

                                            <div class="col-md col-6 text-center pt-3">
                                                <img src="${pageContext.request.contextPath}/assets/images/client/paypal.png" class="avatar avatar-client" alt="">
                                            </div><!--end col-->
                                        </div><!--end row-->
                                    </div>
                                </div>
                            </div><!--end col-->
                        </div><!--end row-->

                        <div class="row">
                            <div class="col-xl-3 col-md-6 mt-4">
                                <div class="card features feature-primary text-center border-0 p-4 rounded shadow">
                                    <div class="icon text-center rounded-lg mx-auto">
                                        <i class="uil uil-message align-middle h3 mb-0"></i>
                                    </div>
                                    <div class="card-body p-0 mt-3">
                                        <a href="javascript:void(0)" class="title text-dark h5">New Messages</a>
                                        <p class="text-muted my-2">Due to its wide spread use as filler text</p>
                                        <a href="javascript:void(0)" class="link">Read more <i class="ri-arrow-right-line align-middle"></i></a>
                                    </div>
                                </div>
                            </div><!--end col-->

                            <div class="col-xl-3 col-md-6 mt-4">
                                <div class="card features feature-primary text-center border-0 p-4 rounded shadow">
                                    <div class="icon text-center rounded-lg mx-auto">
                                        <i class="uil uil-envelope-star align-middle h3 mb-0"></i>
                                    </div>
                                    <div class="card-body p-0 mt-3">
                                        <a href="javascript:void(0)" class="title text-dark h5">Latest Proposals</a>
                                        <p class="text-muted my-2">Due to its wide spread use as filler text</p>
                                        <a href="javascript:void(0)" class="link">View more <i class="ri-arrow-right-line align-middle"></i></a>
                                    </div>
                                </div>
                            </div><!--end col-->

                            <div class="col-xl-3 col-md-6 mt-4">
                                <div class="card features feature-primary text-center border-0 p-4 rounded shadow">
                                    <div class="icon text-center rounded-lg mx-auto">
                                        <i class="uil uil-hourglass align-middle h3 mb-0"></i>
                                    </div>
                                    <div class="card-body p-0 mt-3">
                                        <a href="javascript:void(0)" class="title text-dark h5">Package Expiry</a>
                                        <p class="text-muted my-2">Due to its wide spread use as filler text</p>
                                        <a href="javascript:void(0)" class="link">Check here <i class="ri-arrow-right-line align-middle"></i></a>
                                    </div>
                                </div>
                            </div><!--end col-->

                            <div class="col-xl-3 col-md-6 mt-4">
                                <div class="card features feature-primary text-center border-0 p-4 rounded shadow">
                                    <div class="icon text-center rounded-lg mx-auto">
                                        <i class="uil uil-heart align-middle h3 mb-0"></i>
                                    </div>
                                    <div class="card-body p-0 mt-3">
                                        <a href="javascript:void(0)" class="title text-dark h5">Saved Items</a>
                                        <p class="text-muted my-2">Due to its wide spread use as filler text</p>
                                        <a href="javascript:void(0)" class="link">View items <i class="ri-arrow-right-line align-middle"></i></a>
                                    </div>
                                </div>
                            </div><!--end col-->
                        </div><!--end row-->
                    </div><!--end col-->
                </div><!--end row-->
            </div><!--end container-->
        </section><!--end section-->
        <!-- End Hero -->



        <!-- Back to top -->
        <a href="#" onclick="topFunction()" id="back-to-top" class="btn btn-icon btn-pills btn-primary back-to-top"><i data-feather="arrow-up" class="icons"></i></a>
        <!-- Back to top -->





        <!-- javascript -->
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <!-- SLIDER -->
        <script src="${pageContext.request.contextPath}/assets/js/tiny-slider.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/tiny-slider-init.js"></script>
        <!-- Chart -->
        <script src="${pageContext.request.contextPath}/assets/js/apexcharts.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/areachart.init.js"></script>
        <!-- Icons -->
        <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
    </body>

</html>
