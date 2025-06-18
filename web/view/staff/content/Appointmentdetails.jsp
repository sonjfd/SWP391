<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Chi tiết lịch hẹn</title>
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f4f4f9;
                font-family: 'Arial', sans-serif;
            }

            .container {
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                padding: 20px;
                margin-top: 30px;
            }

            h2 {
                font-size: 1.8rem;
                color: #007bff;
                font-weight: 600;
            }

            .card {
                border-radius: 8px;
                margin-bottom: 20px;
                transition: all 0.3s ease-in-out;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
                height: 100%;
            }

            .card-header {
                background-color: #007bff;
                color: white;
                font-weight: 600;
                border-top-left-radius: 8px;
                border-top-right-radius: 8px;
            }

            .card-body {
                padding: 20px;
                flex-grow: 1;
            }

            .card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.15);
            }

            .img-fluid {
                border-radius: 50%;
                max-width: 150px;
                object-fit: cover;
                margin-bottom: 20px;
            }

            .btn-outline-primary {
                font-weight: 500;
                border-radius: 30px;
                padding: 8px 20px;
                margin-top: 20px;
            }

            .form-select {
                background-color: #f8f9fa;
                border-radius: 8px;
                border: 1px solid #ccc;
            }

            .form-select:focus {
                box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
            }

            .select-title {
                font-size: 1.1rem;
                color: #555;
                font-weight: 500;
            }

            .text-primary {
                color: #0056b3 !important;
            }

            /* Căn chỉnh thông tin thú cưng, chủ sở hữu và bác sĩ ngang hàng */
            .info-section {
                display: flex;
                flex-wrap: wrap;
                justify-content: space-between;
            }

            .info-section .col-md-4 {
                margin-bottom: 20px;
                flex: 0 0 32%;
            }

            /* Căn giữa thông tin lịch hẹn */
            .appointment-info {
                margin-top: 30px;
                text-align: center; /* Căn giữa chữ */
            }

            .appointment-info .card-header {
                text-align: center; /* Căn giữa tiêu đề card */
            }

            .info-section .card {
                display: flex;
                flex-direction: column;
                justify-content: space-between;
                height: 100%;
            }
            .appointment-info {
                text-align: center;  /* Căn giữa văn bản trong thẻ p */
                margin-bottom: 15px;  /* Khoảng cách dưới mỗi thẻ p */
            }

            .appointment-info select {
                width: 200px;  /* Điều chỉnh chiều rộng của thẻ select */
                padding: 5px;  /* Thêm khoảng cách bên trong */
                font-size: 14px;  /* Giảm kích thước chữ trong select */
                margin: 0 auto;  /* Căn giữa select */
                display: block;  /* Biến select thành block để sử dụng margin auto */
            }

            .appointment-info strong {
                display: block;  /* Đảm bảo strong là phần tử khối để tách biệt với select */
                margin-bottom: 5px;  /* Khoảng cách giữa strong và select */
            }

            .card-body {
                padding: 20px;
            }

            .appointment-info {
                display: flex;
                justify-content: space-between; /* Chia đều 3 cột */
                margin-bottom: 20px;  /* Thêm khoảng cách dưới mỗi cặp */
            }

            .appointment-info p {
                width: 32%;  /* Mỗi cột chiếm khoảng 1/3 chiều rộng */
                text-align: center; /* Căn giữa nội dung */
            }

            .appointment-info select {
                width: 100%; /* Đảm bảo thẻ select chiếm hết chiều rộng của thẻ p */
                padding: 5px;
                font-size: 14px;
                margin-top: 5px; /* Thêm khoảng cách giữa select và label */
            }

            .appointment-info strong {
                display: block; /* Đảm bảo strong không nằm cùng dòng với select */
                margin-bottom: 5px; /* Khoảng cách giữa strong và select */
            }



        </style>
    </head>
    <body>

        <div class="container mt-5">
            <h2 class="text-primary text-center mb-5" >Thông tin chi tiết lịch hẹn</h2>

            <!-- Thông tin thú cưng, chủ sở hữu và bác sĩ căn ngang -->
            <div class="info-section">
                <!-- Thông tin thú cưng -->
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-header">Thông tin thú cưng</div>
                        <div class="card-body">
                            <img src="${pageContext.request.contextPath}/${appointment.pet.avatar}" alt="Ảnh thú cưng" class="img-fluid rounded mb-3">
                            <p><strong>Mã thú cưng:</strong> ${appointment.pet.pet_code}</p>
                            <p><strong>Tên:</strong> ${appointment.pet.name}</p>
                            <p><strong>Ngày sinh:</strong> <fmt:formatDate value="${appointment.pet.birthDate}" pattern="dd/MM/yyyy"/></p>
                            <p><strong>Giống loài:</strong> ${appointment.pet.breed.name} (Loài: ${appointment.pet.breed.specie.name})</p>
                            <p><strong>Giới tính:</strong> ${appointment.pet.gender == 'male' ? 'Đực' : 'Cái'}</p>
                        </div>
                    </div>
                </div>

                <!-- Thông tin chủ sở hữu -->
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-header">Thông tin chủ sở hữu</div>
                        <div class="card-body">
                            <img src="${pageContext.request.contextPath}/${appointment.user.avatar}" alt="Ảnh chủ sở hữu" class="img-fluid rounded mb-3">
                            <p><strong>Họ và tên:</strong> ${appointment.user.fullName}</p>
                            <p><strong>Tên đăng nhập:</strong> ${appointment.user.userName}</p>
                            <p><strong>Email:</strong> ${appointment.user.email}</p>
                            <p><strong>Số điện thoại:</strong> ${appointment.user.phoneNumber}</p>
                            <p><strong>Địa chỉ:</strong> ${appointment.user.address}</p>
                        </div>
                    </div>
                </div>

                <!-- Thông tin bác sĩ -->
                <c:if test="${not empty appointment.doctor}">
                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-header">Thông tin bác sĩ</div>
                            <div class="card-body">
                                <img src="${pageContext.request.contextPath}/${appointment.doctor.user.avatar}" alt="Ảnh bác sĩ" class="img-fluid rounded mb-3">
                                <p><strong>Họ và tên:</strong> ${appointment.doctor.user.fullName}</p>
                                <p><strong>Chuyên khoa:</strong> ${appointment.doctor.specialty}</p>
                                <p><strong>Chứng chỉ:</strong> ${appointment.doctor.certificates}</p>
                                <p><strong>Bằng cấp:</strong> ${appointment.doctor.qualifications}</p>
                                <p><strong>Kinh nghiệm:</strong> ${appointment.doctor.yearsOfExperience} năm</p>
                                <p><strong>Tiểu sử:</strong> ${appointment.doctor.biography}</p>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>

            <!-- Thông tin lịch hẹn ở dưới cùng -->
            <div class="card appointment-info">
                <div class="card-header">Thông tin lịch hẹn</div>
                <div class="card-body">
                    <div class="appointment-info">
                        <p><strong>Ngày khám:</strong> <fmt:formatDate value="${appointment.appointmentDate}" pattern="dd/MM/yyyy"/></p>
                        <p><strong>Trạng thái lịch hẹn:</strong>
                            <select class="form-select" disabled>
                                <option value="completed" ${appointment.status == 'completed' ? 'selected' : ''}>Đặt lịch thành công</option>
                                <option value="canceled" ${appointment.status == 'canceled' ? 'selected' : ''}>Đã huỷ</option>
                            </select>
                        </p>
                    </div>

                    <div class="appointment-info">
                        <p><strong>Ca khám:</strong> ${appointment.startTime} - ${appointment.endTime}</p>
                        <p><strong>Trạng thái thanh toán:</strong>
                            <select class="form-select" disabled>
                                <option value="unpaid" ${appointment.paymentStatus == 'unpaid' ? 'selected' : ''}>Chưa thanh toán</option>
                                <option value="paid" ${appointment.paymentStatus == 'paid' ? 'selected' : ''}>Đã thanh toán</option>
                            </select>
                        </p>
                    </div>

                    <div class="appointment-info">
                        <p><strong>Ghi chú:</strong>
                            <c:choose>
                                <c:when test="${not empty appointment.note}">${appointment.note}</c:when>
                                <c:otherwise>Khách hàng không để lại ghi chú</c:otherwise>
                            </c:choose>
                        </p>
                        <p><strong>Phương thức thanh toán:</strong>
                            <select class="form-select" disabled>
                                <option value="cash" ${appointment.paymentMethod == 'cash' ? 'selected' : ''}>Thanh toán trực tiếp</option>
                                <option value="online" ${appointment.paymentMethod == 'online' ? 'selected' : ''}>Thanh toán online</option>
                            </select>
                        </p>
                    </div>


                </div>



            </div>
            <a href="list-appointment" class="btn btn-outline-primary">Quay lại danh sách</a>
            <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
