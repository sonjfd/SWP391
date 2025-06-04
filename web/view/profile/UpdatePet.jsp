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
            .img-fluid{
                max-height: 500px;
                max-width: 400px;
            }
            .form-top {
                display: flex;
                flex-wrap: wrap;
                gap: 20px;
            }

            .form-column {
                flex: 1;
                min-width: 250px;
            }
            .form-top-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 20px 30px;
                align-items: center;
            }

            .form-top-grid div {
                display: flex;
                flex-direction: column;
            }


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

                        <h3 class="mb-4">Cập nhật thông tin thú cưng:</h3>
                        <c:set var="pet" value="${requestScope.pet}"/>

                        <form id="updateForm" action="updatepet" method="post" enctype="multipart/form-data">

                            <input type="hidden" name="petId" value="${pet.id}"/>
                            <div class="form-top-grid">
                                <div>
                                    <label for="name" class="form-label">Tên:</label>
                                    <input type="text" class="form-control" id="name" name="name" value="${pet.name}" required>
                                </div>

                                <div>
                                    <label for="gender" class="form-label">Giới tính:</label>
                                    <select class="form-select" id="gender" name="gender">
                                        <option value="Đực" ${pet.gender == 'Đực' ? 'selected' : ''}>Đực</option>
                                        <option value="Cái" ${pet.gender == 'Cái' ? 'selected' : ''}>Cái</option>
                                    </select>
                                </div>


                                <div>
                                    <label for="birthDate" class="form-label">Ngày sinh:</label>
                                    <input type="date" id="birthDate" name="dateOfBirth" class="form-control" value="${pet.birthDate}">
                                    <small id="birthDateError" class="text-danger" style="display:none;">Ngày sinh không hợp lệ!</small>
                                </div>
                                <div class="form-group">
                                    <label for="specie" class="form-label">Loài:</label>
                                    <select class="form-select" id="specie" name="specie_id" required>
                                        <option value="">Chọn Loài</option>
                                        <c:forEach items="${specieList}" var="specie">
                                            <option value="${specie.id}" <c:if test="${specie.id == pet.breed.specie.id}">selected</c:if>>
                                                ${specie.name}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label for="breed" class="form-label">Giống:</label>
                                    <select class="form-select" id="breed" name="breed_id" required>
                                        <option value="">Chọn Giống</option>
                                        <c:forEach items="${breedList}" var="breed">
                                            <option value="${breed.id}" <c:if test="${breed.id == pet.breed.id}">selected</c:if>>
                                                ${breed.name}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>


                                <div>
                                    <label for="status" class="form-label">Trạng thái:</label>
                                    <select id="status" name="status" class="form-select">
                                        <option value="active" ${pet.status == 'active' ? 'selected' : ''}>Hoạt động</option>
                                        <option value="inactive" ${pet.status == 'inactive' ? 'selected' : ''}>Không hoạt động</option>
                                        <option value="lost" ${pet.status == 'lost' ? 'selected' : ''}>Đã chết</option>
                                        <option value="deceased" ${pet.status == 'deceased' ? 'selected' : ''}>Đã thất lạc</option>
                                    </select>
                                </div>
                            </div>


                            <div class="mb-3">
                                <label for="description" class="form-label">Mô tả:</label>
                                <textarea class="form-control" id="description" name="description" rows="4" required>${pet.description}</textarea>
                            </div>


                            <div class="mb-3">
                                <label class="form-label">Ảnh hiện tại:</label><br>
                                <img src="${pageContext.request.contextPath}/${pet.avatar}" alt="Pet Avatar" width="150" height="150" class="rounded mb-2" >
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
               
                document.getElementById("updateForm").addEventListener("submit", function (event) {
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
                $(document).ready(function () {
                    $('#speciesSelect').on('change', function () {
                        var speciesId = $(this).val();
                        if (speciesId) {
                            $.ajax({
                                url: 'getBreeds', // Servlet nhận speciesId và trả danh sách breed
                                type: 'GET',
                                data: {speciesId: speciesId},
                                success: function (data) {
                                    $('#breedSelect').empty();
                                    $('#breedSelect').append('<option value="">Chọn giống</option>');
                                    data.forEach(function (breed) {
                                        $('#breedSelect').append('<option value="' + breed.id + '">' + breed.name + '</option>');
                                    });
                                },
                                error: function () {
                                    alert('Không tải được giống!');
                                }
                            });
                        } else {
                            $('#breedSelect').empty();
                            $('#breedSelect').append('<option value="">Chọn giống</option>');
                        }
                    });
                });

        </script>

        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

        <!-- Icons -->
        <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
    </body>

</html>
