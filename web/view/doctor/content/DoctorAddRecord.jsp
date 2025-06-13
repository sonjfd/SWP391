<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <title>Ghi chép khám bệnh</title>
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico.png">
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/assets/css/remixicon.css" rel="stylesheet" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" id="theme-opt" />
    </head>

    <body>
        <%@include file="../../home/layout/Header.jsp" %>




        <section class="bg-dashboard">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-xl-3 col-lg-3 col-md-4 col-12">
                        <div class="rounded shadow overflow-hidden sticky-bar">
                            <ul class="list-unstyled sidebar-nav mb-0">
                                <li class="navbar-item"><a href="doctor-dashboard" class="navbar-link"><i class="ri-dashboard-line navbar-icon"></i> Bảng điều khiển</a></li>
                                <li class="navbar-item"><a href="doctor-assigned-appointment" class="navbar-link"><i class="ri-calendar-check-line navbar-icon"></i> Lịch hẹn</a></li>
                                <li class="navbar-item"><a href="doctor-record-examination" class="navbar-link active"><i class="ri-file-line navbar-icon"></i> Ghi chép khám bệnh</a></li>
                                <li class="navbar-item"><a href="doctor-upload-test-result" class="navbar-link"><i class="ri-upload-line navbar-icon"></i> Tải kết quả xét nghiệm</a></li>
                                <li class="navbar-item"><a href="doctor-pet-medical-history" class="navbar-link"><i class="ri-history-line navbar-icon"></i> Lịch sử y tế thú cưng</a></li>
                                <li class="navbar-item"><a href="doctor-profile-setting" class="navbar-link"><i class="ri-user-settings-line navbar-icon"></i> Cài đặt hồ sơ</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-xl-9 col-lg-9 col-md-8">
                        <div class="rounded shadow">
                            <div class="p-4 border-bottom">
                                <h5 class="mb-0">Ghi chép khám bệnh mới</h5>
                            </div>
                            <div class="p-4">
                                <form action="doctor-add-record" method="post" enctype="multipart/form-data">
                                    <div class="mb-3">
                                        <label class="form-label">Thú cưng</label>
                                        <select name="petId" class="form-control" required>
                                            <c:forEach var="pet" items="${pets}">
                                                <option value="${pet.id}">${pet.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Chẩn đoán</label>
                                        <textarea name="diagnosis" class="form-control" required></textarea>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Điều trị</label>
                                        <textarea name="treatment" class="form-control"></textarea>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Ngày tái khám</label>
                                        <input type="date" name="reExamDate" class="form-control">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Tệp đính kèm (PDF/ảnh)</label>
                                        <input type="file" name="attachment" class="form-control" accept=".pdf,image/*">
                                    </div>
                                    <button type="submit" class="btn btn-primary">Lưu hồ sơ</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>


        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
    </body>

</html>
