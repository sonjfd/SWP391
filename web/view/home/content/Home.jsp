<%-- 
    Document   : home
    Created on : May 19, 2025, 10:23:09 PM
    Author     : Dell
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
        <meta name="website" content="../../../index.html" />
        <meta name="Version" content="v1.2.0" />
        <!-- favicon -->
        <link rel="shortcut icon" href="../../../assets/images/favicon.ico.png">
        <!-- Bootstrap -->
        <link href="../../../assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="../../../assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="../../../assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- SLIDER -->
        <link rel="stylesheet" href="../../../assets/css/tiny-slider.css"/>
        <!-- Css -->
        <link href="../../../assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />

    </head>

   
        
        
        <body>
            <%@include file="../layout/Header.jsp" %>

        <!-- Start Hero -->
        <section class="bg-half-170 pb-0 d-table w-100">
            <div class="container">
                <div class="row mt-5 mt-sm-0 align-items-center">
                    <div class="col-md-6">
                        <div class="heading-title">
                            <h4 class="heading mb-3">Find Best Doctor</h4>
                            <p class="para-desc text-muted mb-0">Great doctor if you need your family member to get immediate assistance, emergency treatment or a simple consultation.</p>
                        </div>
                        <div class="subcribe-form mt-4">
                            <form class="ms-0" style="max-width: 550px;">
                                <div class="mb-2">
                                    <input type="text" id="name" name="name" class="border bg-white rounded-pill" required="" placeholder="Doctor name...">
                                    <button type="submit" class="btn btn-pills btn-primary"><i class="ri-search-line align-middle me-1"></i> Search</button>
                                </div>
                                <div class="row">
                                    <div class="col-12">
                                        <p class="text-muted mb-0"><b>Note:</b> Please search best doctors here,</p>
                                    </div><!--end col-->
                                </div><!--end row-->
                            </form>
                        </div>
                    </div><!--end col-->

                    <div class="col-md-6 mt-4 pt-2 mt-sm-0 pt-sm-0">
                        <img src="../assets/images/hero.png" class="img-fluid" alt="">
                    </div><!--end col-->
                </div><!--end row-->
            </div><!--end container-->
        </section><!--end section-->
        <!-- End Hero -->

        <!-- Partners start -->
        <section class="py-4 bg-light">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-2 col-md-2 col-6 text-center py-4">
                        <img src="../assets/images/client/amazon.png" class="avatar avatar-client" alt="">
                    </div><!--end col-->

                    <div class="col-lg-2 col-md-2 col-6 text-center py-4">
                        <img src="../assets/images/client/google.png" class="avatar avatar-client" alt="">
                    </div><!--end col-->
                    
                    <div class="col-lg-2 col-md-2 col-6 text-center py-4">
                        <img src="../assets/images/client/lenovo.png" class="avatar avatar-client" alt="">
                    </div><!--end col-->
                    
                    <div class="col-lg-2 col-md-2 col-6 text-center py-4">
                        <img src="../assets/images/client/paypal.png" class="avatar avatar-client" alt="">
                    </div><!--end col-->
                    
                    <div class="col-lg-2 col-md-2 col-6 text-center py-4">
                        <img src="../assets/images/client/shopify.png" class="avatar avatar-client" alt="">
                    </div><!--end col-->
                    
                    <div class="col-lg-2 col-md-2 col-6 text-center py-4">
                        <img src="../assets/images/client/spotify.png" class="avatar avatar-client" alt="">
                    </div><!--end col-->
                </div><!--end row-->
            </div><!--end container-->
        </section><!--end section-->
        <!-- Partners End -->

        <!-- Start -->
        <section class="section">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-12">
                        <div class="section-title text-center mb-4 pb-2">
                            <h4 class="title mb-4">Explore By Categories</h4>
                            <p class="text-muted mx-auto para-desc mb-0">Great doctor if you need your family member to get effective immediate assistance, emergency treatment or a simple consultation.</p>
                        </div>
                    </div><!--end col-->
                </div><!--end row-->

                <div class="row justify-content-center">
                    <div class="col-xl col-md-4 col-12 mt-4 pt-2">
                        <div class="card features feature-primary border-0 p-4 rounded-md shadow">
                            <div class="icon text-center rounded-lg">
                                <i class="uil uil-user-md h3 mb-0"></i>
                            </div>
                            <div class="card-body p-0 mt-3">
                                <a href="departments.html" class="title text-dark h5">Doctors</a>
                                <p class="text-muted mt-3">Due to its wide spread use as filler text</p>
                                <a href="departments.html" class="link">Find here <i class="ri-arrow-right-line align-middle"></i></a>
                            </div>
                        </div>
                    </div><!--end col-->
                    
                    <div class="col-xl col-md-4 col-12 mt-4 pt-2">
                        <div class="card features feature-primary border-0 p-4 rounded-md shadow">
                            <div class="icon text-center rounded-lg">
                                <i class="uil uil-capsule h3 mb-0"></i>
                            </div>
                            <div class="card-body p-0 mt-3">
                                <a href="departments.html" class="title text-dark h5">Clinics</a>
                                <p class="text-muted mt-3">Due to its wide spread use as filler text</p>
                                <a href="departments.html" class="link">Find here <i class="ri-arrow-right-line align-middle"></i></a>
                            </div>
                        </div>
                    </div><!--end col-->

                    <div class="col-xl col-md-4 col-12 mt-4 pt-2">
                        <div class="card features feature-primary border-0 p-4 rounded-md shadow">
                            <div class="icon text-center rounded-lg">
                                <i class="uil uil-microscope h3 mb-0"></i>
                            </div>
                            <div class="card-body p-0 mt-3">
                                <a href="departments.html" class="title text-dark h5">Labs</a>
                                <p class="text-muted mt-3">Due to its wide spread use as filler text</p>
                                <a href="departments.html" class="link">Find here <i class="ri-arrow-right-line align-middle"></i></a>
                            </div>
                        </div>
                    </div><!--end col-->

                    <div class="col-xl col-md-4 col-12 mt-4 pt-2">
                        <div class="card features feature-primary border-0 p-4 rounded-md shadow">
                            <div class="icon text-center rounded-lg">
                                <i class="uil uil-ambulance h3 mb-0"></i>
                            </div>
                            <div class="card-body p-0 mt-3">
                                <a href="departments.html" class="title text-dark h5">Emergency</a>
                                <p class="text-muted mt-3">Due to its wide spread use as filler text</p>
                                <a href="departments.html" class="link">Find here <i class="ri-arrow-right-line align-middle"></i></a>
                            </div>
                        </div>
                    </div><!--end col-->

                    <div class="col-xl col-md-4 col-12 mt-4 pt-2">
                        <div class="card features feature-primary border-0 p-4 rounded-md shadow">
                            <div class="icon text-center rounded-lg">
                                <i class="uil uil-shield-plus h3 mb-0"></i>
                            </div>
                            <div class="card-body p-0 mt-3">
                                <a href="departments.html" class="title text-dark h5">Insurance</a>
                                <p class="text-muted mt-3">Due to its wide spread use as filler text</p>
                                <a href="departments.html" class="link">Find here <i class="ri-arrow-right-line align-middle"></i></a>
                            </div>
                        </div>
                    </div><!--end col-->
                </div><!--end row-->
            </div><!--end container-->

            <div class="container mt-100 mt-60">
                <div class="row align-items-center">
                    <div class="col-lg-7 col-md-6">
                        <div class="section-title me-lg-5">
                            <span class="badge badge-pill badge-soft-primary">About Doctris</span>
                            <h4 class="title mt-3 mb-4">Good Services And Better <br> Health By Our Specialists</h4>
                            <p class="para-desc text-muted">Great doctor if you need your family member to get effective immediate assistance, emergency treatment or a simple consultation.</p>
                            <p class="para-desc text-muted">The most well-known dummy text is the 'Lorem Ipsum', which is said to have originated in the 16th century. Lorem Ipsum is composed in a pseudo-Latin language which more or less corresponds to 'proper' Latin. It contains a series of real Latin words.</p>
                            <div class="mt-4">
                                <a href="aboutus.html" class="btn btn-soft-primary">Read More</a>
                            </div>
                        </div>
                    </div><!--end col-->

                    <div class="col-lg-5 col-md-6 mt-4 pt-2 mt-sm-0 pt-sm-0">
                        <div class="position-relative">
                            <img src="../assets/images/about/about-2.png" class="img-fluid" alt="">
                            <div class="play-icon">
                                <a href="#" data-bs-toggle="modal" data-bs-target="#watchvideomodal" class="play-btn video-play-icon">
                                    <i class="mdi mdi-play text-primary rounded-circle bg-white title-bg-dark shadow"></i>
                                </a>
                            </div>
                        </div>
                    </div><!--end col-->
                </div><!--end row-->
            </div><!--end container-->
        </section><!--end section-->
        <!-- End -->

        <!-- Cta Start -->
        <section class="section" style="background: url('../assets/images/cta.jpg') center center;">
            <div class="bg-overlay bg-overlay-dark" style="opacity: 0.3;"></div>
            <div class="container">
                <div class="row">
                    <div class="col-lg-5 offset-lg-7 col-md-7 offset-md-5">
                        <div class="features feature-bg-primary d-flex bg-white p-4 rounded-md shadow position-relative overflow-hidden">
                            <i class="uil uil-briefcase icons h2 mb-0 text-primary"></i>
                            <div class="ms-3">
                                <h5 class="titles">Our Mission</h5>
                                <p class="text-muted para mb-0">The most well-known dummy text is the 'Lorem Ipsum', which is said to have originated in the 16th century.</p>
                            </div>
                            <div class="big-icon">
                                <i class="uil uil-briefcase"></i>
                            </div>
                        </div>

                        <div class="features feature-bg-primary d-flex bg-white p-4 rounded-md shadow position-relative overflow-hidden mt-4">
                            <i class="uil uil-airplay icons h2 mb-0 text-primary"></i>
                            <div class="ms-3">
                                <h5 class="titles">Our Vision</h5>
                                <p class="text-muted para mb-0">The most well-known dummy text is the 'Lorem Ipsum', which is said to have originated in the 16th century.</p>
                            </div>
                            <div class="big-icon">
                                <i class="uil uil-airplay"></i>
                            </div>
                        </div>

                        <div class="features feature-bg-primary d-flex bg-white p-4 rounded-md shadow position-relative overflow-hidden mt-4">
                            <i class="uil uil-flip-v icons h2 mb-0 text-primary"></i>
                            <div class="ms-3">
                                <h5 class="titles">Who We Are ?</h5>
                                <p class="text-muted para mb-0">The most well-known dummy text is the 'Lorem Ipsum', which is said to have originated in the 16th century.</p>
                            </div>
                            <div class="big-icon">
                                <i class="uil uil-flip-v"></i>
                            </div>
                        </div>
                    </div><!--end col-->
                </div><!--end row-->
            </div><!--end container-->
        </section><!--end section-->
        <!-- Cta End -->

        <!-- Start -->
        <section class="section">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-12">
                        <div class="section-title text-center mb-4 pb-2">
                            <span class="badge badge-pill badge-soft-primary">Find Doctors</span>
                            <h4 class="title mt-3 mb-4">Find Your Specialists</h4>
                            <p class="text-muted mx-auto para-desc mb-0">Great doctor if you need your family member to get effective immediate assistance, emergency treatment or a simple consultation.</p>
                        </div>
                    </div><!--end col-->
                </div><!--end row-->

                <div class="row align-items-center">
                    <div class="col-xl-3 col-lg-3 col-md-6 mt-4 pt-2">
                        <div class="card team border-0 rounded shadow overflow-hidden">
                            <div class="team-person position-relative overflow-hidden">
                                <img src="../assets/images/doctors/01.jpg" class="img-fluid" alt="">
                                <ul class="list-unstyled team-like">
                                    <li><a href="javascript:void(0)" class="btn btn-icon btn-pills btn-soft-danger"><i data-feather="heart" class="icons"></i></a></li>
                                </ul>
                            </div>
                            <div class="card-body">
                                <a href="doctor-team-two.html" class="title text-dark h5 d-block mb-0">Calvin Carlo</a>
                                <small class="text-muted speciality">Eye Care</small>
                                <div class="d-flex justify-content-between align-items-center mt-2">
                                    <ul class="list-unstyled mb-0">
                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                    </ul>
                                    <p class="text-muted mb-0">5 Star</p>
                                </div>
                                <ul class="list-unstyled mt-2 mb-0">
                                    <li class="d-flex">
                                        <i class="ri-map-pin-line text-primary align-middle"></i>
                                        <small class="text-muted ms-2">63, PG Shustoke, UK</small>
                                    </li>
                                    <li class="d-flex mt-2">
                                        <i class="ri-time-line text-primary align-middle"></i>
                                        <small class="text-muted ms-2">Mon: 2:00PM - 6:00PM</small>
                                    </li>
                                    <li class="d-flex mt-2">
                                        <i class="ri-money-dollar-circle-line text-primary align-middle"></i>
                                        <small class="text-muted ms-2">$ 75 USD / Visit</small>
                                    </li>
                                </ul>
                                <ul class="list-unstyled mt-2 mb-0">
                                    <li class="list-inline-item"><a href="javascript:void(0)" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="facebook" class="icons"></i></a></li>
                                    <li class="mt-2 list-inline-item"><a href="javascript:void(0)" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="linkedin" class="icons"></i></a></li>
                                    <li class="mt-2 list-inline-item"><a href="javascript:void(0)" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="github" class="icons"></i></a></li>
                                    <li class="mt-2 list-inline-item"><a href="javascript:void(0)" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="twitter" class="icons"></i></a></li>
                                </ul>
                            </div>
                        </div>
                    </div><!--end col-->
                    
                    <div class="col-xl-3 col-lg-3 col-md-6 mt-4 pt-2">
                        <div class="card team border-0 rounded shadow overflow-hidden">
                            <div class="team-person position-relative overflow-hidden">
                                <img src="../assets/images/doctors/02.jpg" class="img-fluid" alt="">
                                <ul class="list-unstyled team-like">
                                    <li><a href="javascript:void(0)" class="btn btn-icon btn-pills btn-soft-danger"><i data-feather="heart" class="icons"></i></a></li>
                                </ul>
                            </div>
                            <div class="card-body">
                                <a href="doctor-team-two.html" class="title text-dark h5 d-block mb-0">Cristino Murphy</a>
                                <small class="text-muted speciality">M.B.B.S, Gynecologist</small>
                                <div class="d-flex justify-content-between align-items-center mt-2">
                                    <ul class="list-unstyled mb-0">
                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                    </ul>
                                    <p class="text-muted mb-0">5 Star</p>
                                </div>
                                <ul class="list-unstyled mt-2 mb-0">
                                    <li class="d-flex">
                                        <i class="ri-map-pin-line text-primary align-middle"></i>
                                        <small class="text-muted ms-2">63, PG Shustoke, UK</small>
                                    </li>
                                    <li class="d-flex mt-2">
                                        <i class="ri-time-line text-primary align-middle"></i>
                                        <small class="text-muted ms-2">Mon: 2:00PM - 6:00PM</small>
                                    </li>
                                    <li class="d-flex mt-2">
                                        <i class="ri-money-dollar-circle-line text-primary align-middle"></i>
                                        <small class="text-muted ms-2">$ 75 USD / Visit</small>
                                    </li>
                                </ul>
                                <ul class="list-unstyled mt-2 mb-0">
                                    <li class="list-inline-item"><a href="javascript:void(0)" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="facebook" class="icons"></i></a></li>
                                    <li class="mt-2 list-inline-item"><a href="javascript:void(0)" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="linkedin" class="icons"></i></a></li>
                                    <li class="mt-2 list-inline-item"><a href="javascript:void(0)" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="github" class="icons"></i></a></li>
                                    <li class="mt-2 list-inline-item"><a href="javascript:void(0)" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="twitter" class="icons"></i></a></li>
                                </ul>
                            </div>
                        </div>
                    </div><!--end col-->
                    
                    <div class="col-xl-3 col-lg-3 col-md-6 mt-4 pt-2">
                        <div class="card team border-0 rounded shadow overflow-hidden">
                            <div class="team-person position-relative overflow-hidden">
                                <img src="../assets/images/doctors/03.jpg" class="img-fluid" alt="">
                                <ul class="list-unstyled team-like">
                                    <li><a href="javascript:void(0)" class="btn btn-icon btn-pills btn-soft-danger"><i data-feather="heart" class="icons"></i></a></li>
                                </ul>
                            </div>
                            <div class="card-body">
                                <a href="doctor-team-two.html" class="title text-dark h5 d-block mb-0">Alia Reddy</a>
                                <small class="text-muted speciality">M.B.B.S, Psychotherapist</small>
                                <div class="d-flex justify-content-between align-items-center mt-2">
                                    <ul class="list-unstyled mb-0">
                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                    </ul>
                                    <p class="text-muted mb-0">5 Star</p>
                                </div>
                                <ul class="list-unstyled mt-2 mb-0">
                                    <li class="d-flex">
                                        <i class="ri-map-pin-line text-primary align-middle"></i>
                                        <small class="text-muted ms-2">63, PG Shustoke, UK</small>
                                    </li>
                                    <li class="d-flex mt-2">
                                        <i class="ri-time-line text-primary align-middle"></i>
                                        <small class="text-muted ms-2">Mon: 2:00PM - 6:00PM</small>
                                    </li>
                                    <li class="d-flex mt-2">
                                        <i class="ri-money-dollar-circle-line text-primary align-middle"></i>
                                        <small class="text-muted ms-2">$ 75 USD / Visit</small>
                                    </li>
                                </ul>
                                <ul class="list-unstyled mt-2 mb-0">
                                    <li class="list-inline-item"><a href="javascript:void(0)" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="facebook" class="icons"></i></a></li>
                                    <li class="mt-2 list-inline-item"><a href="javascript:void(0)" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="linkedin" class="icons"></i></a></li>
                                    <li class="mt-2 list-inline-item"><a href="javascript:void(0)" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="github" class="icons"></i></a></li>
                                    <li class="mt-2 list-inline-item"><a href="javascript:void(0)" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="twitter" class="icons"></i></a></li>
                                </ul>
                            </div>
                        </div>
                    </div><!--end col-->
                    
                    <div class="col-xl-3 col-lg-3 col-md-6 mt-4 pt-2">
                        <div class="card team border-0 rounded shadow overflow-hidden">
                            <div class="team-person position-relative overflow-hidden">
                                <img src="../assets/images/doctors/04.jpg" class="img-fluid" alt="">
                                <ul class="list-unstyled team-like">
                                    <li><a href="javascript:void(0)" class="btn btn-icon btn-pills btn-soft-danger"><i data-feather="heart" class="icons"></i></a></li>
                                </ul>
                            </div>
                            <div class="card-body">
                                <a href="doctor-team-two.html" class="title text-dark h5 d-block mb-0">Toni Kovar</a>
                                <small class="text-muted speciality">M.B.B.S, Orthopedic</small>
                                <div class="d-flex justify-content-between align-items-center mt-2">
                                    <ul class="list-unstyled mb-0">
                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                    </ul>
                                    <p class="text-muted mb-0">5 Star</p>
                                </div>
                                <ul class="list-unstyled mt-2 mb-0">
                                    <li class="d-flex">
                                        <i class="ri-map-pin-line text-primary align-middle"></i>
                                        <small class="text-muted ms-2">63, PG Shustoke, UK</small>
                                    </li>
                                    <li class="d-flex mt-2">
                                        <i class="ri-time-line text-primary align-middle"></i>
                                        <small class="text-muted ms-2">Mon: 2:00PM - 6:00PM</small>
                                    </li>
                                    <li class="d-flex mt-2">
                                        <i class="ri-money-dollar-circle-line text-primary align-middle"></i>
                                        <small class="text-muted ms-2">$ 75 USD / Visit</small>
                                    </li>
                                </ul>
                                <ul class="list-unstyled mt-2 mb-0">
                                    <li class="list-inline-item"><a href="javascript:void(0)" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="facebook" class="icons"></i></a></li>
                                    <li class="mt-2 list-inline-item"><a href="javascript:void(0)" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="linkedin" class="icons"></i></a></li>
                                    <li class="mt-2 list-inline-item"><a href="javascript:void(0)" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="github" class="icons"></i></a></li>
                                    <li class="mt-2 list-inline-item"><a href="javascript:void(0)" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="twitter" class="icons"></i></a></li>
                                </ul>
                            </div>
                        </div>
                    </div><!--end col-->

                    <div class="col-xl-3 col-lg-3 col-md-6 mt-4 pt-2">
                        <div class="card team border-0 rounded shadow overflow-hidden">
                            <div class="team-person position-relative overflow-hidden">
                                <img src="../assets/images/doctors/05.jpg" class="img-fluid" alt="">
                                <ul class="list-unstyled team-like">
                                    <li><a href="javascript:void(0)" class="btn btn-icon btn-pills btn-soft-danger"><i data-feather="heart" class="icons"></i></a></li>
                                </ul>
                            </div>
                            <div class="card-body">
                                <a href="doctor-team-two.html" class="title text-dark h5 d-block mb-0">Jessica McFarlane</a>
                                <small class="text-muted speciality">M.B.B.S, Dentist</small>
                                <div class="d-flex justify-content-between align-items-center mt-2">
                                    <ul class="list-unstyled mb-0">
                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                    </ul>
                                    <p class="text-muted mb-0">5 Star</p>
                                </div>
                                <ul class="list-unstyled mt-2 mb-0">
                                    <li class="d-flex">
                                        <i class="ri-map-pin-line text-primary align-middle"></i>
                                        <small class="text-muted ms-2">63, PG Shustoke, UK</small>
                                    </li>
                                    <li class="d-flex mt-2">
                                        <i class="ri-time-line text-primary align-middle"></i>
                                        <small class="text-muted ms-2">Mon: 2:00PM - 6:00PM</small>
                                    </li>
                                    <li class="d-flex mt-2">
                                        <i class="ri-money-dollar-circle-line text-primary align-middle"></i>
                                        <small class="text-muted ms-2">$ 75 USD / Visit</small>
                                    </li>
                                </ul>
                                <ul class="list-unstyled mt-2 mb-0">
                                    <li class="list-inline-item"><a href="javascript:void(0)" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="facebook" class="icons"></i></a></li>
                                    <li class="mt-2 list-inline-item"><a href="javascript:void(0)" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="linkedin" class="icons"></i></a></li>
                                    <li class="mt-2 list-inline-item"><a href="javascript:void(0)" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="github" class="icons"></i></a></li>
                                    <li class="mt-2 list-inline-item"><a href="javascript:void(0)" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="twitter" class="icons"></i></a></li>
                                </ul>
                            </div>
                        </div>
                    </div><!--end col-->
                    
                    <div class="col-xl-3 col-lg-3 col-md-6 mt-4 pt-2">
                        <div class="card team border-0 rounded shadow overflow-hidden">
                            <div class="team-person position-relative overflow-hidden">
                                <img src="../assets/images/doctors/06.jpg" class="img-fluid" alt="">
                                <ul class="list-unstyled team-like">
                                    <li><a href="javascript:void(0)" class="btn btn-icon btn-pills btn-soft-danger"><i data-feather="heart" class="icons"></i></a></li>
                                </ul>
                            </div>
                            <div class="card-body">
                                <a href="doctor-team-two.html" class="title text-dark h5 d-block mb-0">Elsie Sherman</a>
                                <small class="text-muted speciality">M.B.B.S, Gastrologist</small>
                                <div class="d-flex justify-content-between align-items-center mt-2">
                                    <ul class="list-unstyled mb-0">
                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                    </ul>
                                    <p class="text-muted mb-0">5 Star</p>
                                </div>
                                <ul class="list-unstyled mt-2 mb-0">
                                    <li class="d-flex">
                                        <i class="ri-map-pin-line text-primary align-middle"></i>
                                        <small class="text-muted ms-2">63, PG Shustoke, UK</small>
                                    </li>
                                    <li class="d-flex mt-2">
                                        <i class="ri-time-line text-primary align-middle"></i>
                                        <small class="text-muted ms-2">Mon: 2:00PM - 6:00PM</small>
                                    </li>
                                    <li class="d-flex mt-2">
                                        <i class="ri-money-dollar-circle-line text-primary align-middle"></i>
                                        <small class="text-muted ms-2">$ 75 USD / Visit</small>
                                    </li>
                                </ul>
                                <ul class="list-unstyled mt-2 mb-0">
                                    <li class="list-inline-item"><a href="javascript:void(0)" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="facebook" class="icons"></i></a></li>
                                    <li class="mt-2 list-inline-item"><a href="javascript:void(0)" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="linkedin" class="icons"></i></a></li>
                                    <li class="mt-2 list-inline-item"><a href="javascript:void(0)" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="github" class="icons"></i></a></li>
                                    <li class="mt-2 list-inline-item"><a href="javascript:void(0)" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="twitter" class="icons"></i></a></li>
                                </ul>
                            </div>
                        </div>
                    </div><!--end col-->
                    
                    <div class="col-xl-3 col-lg-3 col-md-6 mt-4 pt-2">
                        <div class="card team border-0 rounded shadow overflow-hidden">
                            <div class="team-person position-relative overflow-hidden">
                                <img src="../assets/images/doctors/07.jpg" class="img-fluid" alt="">
                                <ul class="list-unstyled team-like">
                                    <li><a href="javascript:void(0)" class="btn btn-icon btn-pills btn-soft-danger"><i data-feather="heart" class="icons"></i></a></li>
                                </ul>
                            </div>
                            <div class="card-body">
                                <a href="doctor-team-two.html" class="title text-dark h5 d-block mb-0">Bertha Magers</a>
                                <small class="text-muted speciality">M.B.B.S, Urologist</small>
                                <div class="d-flex justify-content-between align-items-center mt-2">
                                    <ul class="list-unstyled mb-0">
                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                    </ul>
                                    <p class="text-muted mb-0">5 Star</p>
                                </div>
                                <ul class="list-unstyled mt-2 mb-0">
                                    <li class="d-flex">
                                        <i class="ri-map-pin-line text-primary align-middle"></i>
                                        <small class="text-muted ms-2">63, PG Shustoke, UK</small>
                                    </li>
                                    <li class="d-flex mt-2">
                                        <i class="ri-time-line text-primary align-middle"></i>
                                        <small class="text-muted ms-2">Mon: 2:00PM - 6:00PM</small>
                                    </li>
                                    <li class="d-flex mt-2">
                                        <i class="ri-money-dollar-circle-line text-primary align-middle"></i>
                                        <small class="text-muted ms-2">$ 75 USD / Visit</small>
                                    </li>
                                </ul>
                                <ul class="list-unstyled mt-2 mb-0">
                                    <li class="list-inline-item"><a href="javascript:void(0)" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="facebook" class="icons"></i></a></li>
                                    <li class="mt-2 list-inline-item"><a href="javascript:void(0)" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="linkedin" class="icons"></i></a></li>
                                    <li class="mt-2 list-inline-item"><a href="javascript:void(0)" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="github" class="icons"></i></a></li>
                                    <li class="mt-2 list-inline-item"><a href="javascript:void(0)" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="twitter" class="icons"></i></a></li>
                                </ul>
                            </div>
                        </div>
                    </div><!--end col-->
                    
                    <div class="col-xl-3 col-lg-3 col-md-6 mt-4 pt-2">
                        <div class="card team border-0 rounded shadow overflow-hidden">
                            <div class="team-person position-relative overflow-hidden">
                                <img src="../assets/images/doctors/08.jpg" class="img-fluid" alt="">
                                <ul class="list-unstyled team-like">
                                    <li><a href="javascript:void(0)" class="btn btn-icon btn-pills btn-soft-danger"><i data-feather="heart" class="icons"></i></a></li>
                                </ul>
                            </div>
                            <div class="card-body">
                                <a href="doctor-team-two.html" class="title text-dark h5 d-block mb-0">Louis Batey</a>
                                <small class="text-muted speciality">M.B.B.S, Neurologist</small>
                                <div class="d-flex justify-content-between align-items-center mt-2">
                                    <ul class="list-unstyled mb-0">
                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                    </ul>
                                    <p class="text-muted mb-0">5 Star</p>
                                </div>
                                <ul class="list-unstyled mt-2 mb-0">
                                    <li class="d-flex">
                                        <i class="ri-map-pin-line text-primary align-middle"></i>
                                        <small class="text-muted ms-2">63, PG Shustoke, UK</small>
                                    </li>
                                    <li class="d-flex mt-2">
                                        <i class="ri-time-line text-primary align-middle"></i>
                                        <small class="text-muted ms-2">Mon: 2:00PM - 6:00PM</small>
                                    </li>
                                    <li class="d-flex mt-2">
                                        <i class="ri-money-dollar-circle-line text-primary align-middle"></i>
                                        <small class="text-muted ms-2">$ 75 USD / Visit</small>
                                    </li>
                                </ul>
                                <ul class="list-unstyled mt-2 mb-0">
                                    <li class="list-inline-item"><a href="javascript:void(0)" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="facebook" class="icons"></i></a></li>
                                    <li class="mt-2 list-inline-item"><a href="javascript:void(0)" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="linkedin" class="icons"></i></a></li>
                                    <li class="mt-2 list-inline-item"><a href="javascript:void(0)" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="github" class="icons"></i></a></li>
                                    <li class="mt-2 list-inline-item"><a href="javascript:void(0)" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="twitter" class="icons"></i></a></li>
                                </ul>
                            </div>
                        </div>
                    </div><!--end col-->
                </div><!--end row-->
            </div><!--end container-->

            <div class="container mt-100 mt-60">
                <div class="row align-items-center">
                    <div class="col-md-6 col-12">
                        <div class="me-lg-5">
                            <img src="../assets/images/svg/vaccine-development-amico.svg" class="img-fluid" alt="">
                        </div>
                    </div><!--end col-->
                    
                    <div class="col-md-6 col-12 mt-4 mt-sm-0 pt-2 pt-sm-0">
                        <div class="accordion" id="accordionExample">
                            <div class="accordion-item border rounded">
                                <h2 class="accordion-header" id="headingOne">
                                    <button class="accordion-button border-0 bg-light" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne"
                                        aria-expanded="true" aria-controls="collapseOne">
                                        How does it work ?
                                    </button>
                                </h2>
                                <div id="collapseOne" class="accordion-collapse border-0 collapse show" aria-labelledby="headingOne"
                                    data-bs-parent="#accordionExample">
                                    <div class="accordion-body text-muted">
                                        There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form.
                                    </div>
                                </div>
                            </div>
                            
                            <div class="accordion-item border rounded mt-2">
                                <h2 class="accordion-header" id="headingTwo">
                                    <button class="accordion-button border-0 bg-light collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo"
                                        aria-expanded="false" aria-controls="collapseTwo">
                                        Do I need a designer to use Doctris ?
                                    </button>
                                </h2>
                                <div id="collapseTwo" class="accordion-collapse border-0 collapse" aria-labelledby="headingTwo"
                                    data-bs-parent="#accordionExample">
                                    <div class="accordion-body text-muted">
                                        There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form.
                                    </div>
                                </div>
                            </div>

                            <div class="accordion-item border rounded mt-2">
                                <h2 class="accordion-header" id="headingThree">
                                    <button class="accordion-button border-0 bg-light collapsed" type="button" data-bs-toggle="collapse"
                                        data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                        What do I need to do to start selling ?
                                    </button>
                                </h2>
                                <div id="collapseThree" class="accordion-collapse border-0 collapse" aria-labelledby="headingThree"
                                    data-bs-parent="#accordionExample">
                                    <div class="accordion-body text-muted">
                                        There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form.
                                    </div>
                                </div>
                            </div>

                            <div class="accordion-item border rounded mt-2">
                                <h2 class="accordion-header" id="headingFour">
                                    <button class="accordion-button border-0 bg-light collapsed" type="button" data-bs-toggle="collapse"
                                        data-bs-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
                                        What happens when I receive an order ?
                                    </button>
                                </h2>
                                <div id="collapseFour" class="accordion-collapse border-0 collapse" aria-labelledby="headingFour"
                                    data-bs-parent="#accordionExample">
                                    <div class="accordion-body text-muted">
                                        There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form.
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div><!--end col-->
                </div><!--end row-->

                <div class="row mt-4 pt-2 justify-content-center">
                    <div class="col-12 text-center">
                        <div class="section-title">
                            <h4 class="title mb-4">Have Question ? Get in touch!</h4>
                            <p class="text-muted para-desc mx-auto">Great doctor if you need your family member to get effective immediate assistance, emergency treatment or a simple consultation.</p>
                            <a href="contact.html" class="btn btn-primary mt-4"><i class="mdi mdi-phone"></i> Contact us</a>
                        </div>
                    </div><!--end col-->
                </div><!--end row-->
            </div><!--end container-->
        </section><!--end section-->
        <!-- End -->

        <%@include file="../layout/Footer.jsp" %>

        
        <!-- javascript -->
        <script src="../../../assets/js/bootstrap.bundle.min.js"></script>
        <!-- SLIDER -->
        <script src="../../../assets/js/tiny-slider.js"></script>
        <script src="../../../assets/js/tiny-slider-init.js"></script>
        <!-- Counter -->
        <script src="../../../assets/js/counter.init.js"></script>
        <!-- Icons -->
        <script src="../../../assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="../../../assets/js/app.js"></script>
    </body>
</html>
