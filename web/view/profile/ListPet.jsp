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
            
           

        </style>

    </head>

    <body>
        

        <!-- Navbar STart -->
        <%@include file="../home/layout/Header.jsp" %>
        <!-- Navbar End -->
        <div class="container">
            <!-- Start -->
            <section class="bg-dashboard">
              
                    <div class="row">
                        <div class=" col-3">
                            <div class="rounded shadow overflow-hidden sticky-bar">
                                <div class="card border-0">
                                    <img src="${pageContext.request.contextPath}/assets/images/doctors/profile-bg.jpg" class="img-fluid" alt="">
                                </div>

                                <div class="text-center avatar-profile margin-nagative mt-n5 position-relative pb-4 border-bottom">
                                    <img src="${pageContext.request.contextPath}/assets/images/doctors/01.jpg" class="rounded-circle shadow-md avatar avatar-md-md" alt="">
                                    <h5 class="mt-3 mb-1">Dr. Calvin Carlo</h5>
                                    <p class="text-muted mb-0">Orthopedic</p>
                                </div>

                                <ul class="list-unstyled sidebar-nav mb-0">
                                    <li class="navbar-item"><a href="doctor-appointment.html" class="navbar-link"><i class="ri-calendar-check-line align-middle navbar-icon"></i> Appointment</a></li>
                                    <li class="navbar-item"><a href="doctor-schedule.html" class="navbar-link"><i class="ri-timer-line align-middle navbar-icon"></i> Schedule Timing</a></li>
                                    <li class="navbar-item"><a href="viewlistpet" class="navbar-link"><i class="ri-bear-smile-line align-middle navbar-icon"></i> My Pet</a></li>
                                    <li class="navbar-item"><a href="viewuserinformation" class="navbar-link"><i class="ri-user-settings-line align-middle navbar-icon"></i> Profile Settings</a></li>
                                    <li class="navbar-item"><a href="doctor-chat.html" class="navbar-link"><i class="ri-chat-voice-line align-middle navbar-icon"></i> Chat</a></li>
                                </ul>
                            </div>
                        </div><!--end col-->

                        <div class=" col-9">
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
                                            <td>${pet.status}</td>
                                            <td>
                                                <!-- Nút Cập nhật -->
                                                <button type="button" class="btn btn-warning " 
                                                        data-bs-toggle="modal" data-bs-target="#updatePetModal${pet.id}" title="Cập nhật">
                                                    <i class="fa-solid fa-pen-to-square"></i>
                                                </button>

                                                <!-- Nút Chi tiết -->
                                                <button type="button" class="btn btn-info" 
                                                        data-bs-toggle="modal" data-bs-target="#detailPetModal${pet.id}" title="Chi tiết">
                                                    <i class="fa-solid fa-circle-info"></i>
                                                </button>

                                                <!-- Nút Xóa -->
                                                <form action="deletepet" method="post" style="display:inline;" 
                                                      onsubmit="return confirm('Bạn có chắc muốn xóa pet này không?');">
                                                    <input type="hidden" name="id" value="${pet.id}" />
                                                    <button type="submit" class="btn btn-danger " title="Xóa">
                                                        <i class="fa-solid fa-trash"></i>
                                                    </button>
                                                </form>
                                            </td>

                                        </tr>
                                    <div class="modal fade" id="updatePetModal${pet.id}" tabindex="-1" aria-labelledby="updatePetModalLabel${pet.id}" aria-hidden="true">
                                        <div class="modal-dialog modal-dialog-centered">
                                            <div class="modal-content">
                                                <form action="updatepet" method="post">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="updatePetModalLabel${pet.id}">Cập nhật thông tin Pet</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <input type="hidden" name="id" value="${pet.id}" />

                                                        <div class="mb-3">
                                                            <label for="name${pet.id}" class="form-label">Tên Pet</label>
                                                            <input type="text" class="form-control" id="name${pet.id}" name="name" value="${pet.name}" required>
                                                        </div>

                                                        <div class="mb-3">
                                                            <label for="gender${pet.id}" class="form-label">Giới tính</label>
                                                            <select class="form-select" id="gender${pet.id}" name="gender" required>
                                                                <option value="Đực" ${pet.gender == 'Đực' ? 'selected' : ''}>Đực</option>
                                                                <option value="Cái" ${pet.gender == 'Cái' ? 'selected' : ''}>Cái</option>
                                                            </select>
                                                        </div>

                                                        <div class="mb-3">
                                                            <label for="status${pet.id}" class="form-label">Trạng thái</label>
                                                            <select class="form-select" id="status${pet.id}" name="status" required>
                                                                <option value="active" ${pet.status == 'active' ? 'selected' : ''}>Active</option>
                                                                <option value="inactive" ${pet.status == 'inactive' ? 'selected' : ''}>Inactive</option>
                                                                <option value="lost" ${pet.status == 'lost' ? 'selected' : ''}>Lost</option>
                                                            </select>
                                                        </div>

                                                        <div class="mb-3">
                                                            <label for="description${pet.id}" class="form-label">Mô tả</label>
                                                            <textarea class="form-control" id="description${pet.id}" name="description" rows="3">${pet.description}</textarea>
                                                        </div>

                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                                        <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
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
                                                            <p><strong>Trạng thái:</strong> ${pet.status}</p>
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




                        </div><!--end row-->
                  
            </section><!--end section-->
            <!-- End -->
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
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

        <!-- Icons -->
        <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
    </body>

</html>
