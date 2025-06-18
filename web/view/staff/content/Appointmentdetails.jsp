<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Chi tiết lịch hẹn</title>
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>

        <div class="container mt-5">
            <h2 class="text-primary text-center mb-5">Thông tin chi tiết lịch hẹn</h2>

            <!-- Thông tin thú cưng, chủ sở hữu và bác sĩ căn ngang -->
            <div class="row">
                <!-- Thông tin thú cưng -->
                <div class="col-md-4 mb-4 d-flex">
                    <div class="card w-100 d-flex flex-column" style="min-height: 100%;">
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
                <div class="col-md-4 mb-4 d-flex">
                    <div class="card w-100 d-flex flex-column" style="min-height: 100%;">
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
                    <div class="col-md-4 mb-4 d-flex">
                        <div class="card w-100 d-flex flex-column" style="min-height: 100%;">
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
            <div class="card appointment-info mb-5">
                <div class="card-header">Thông tin lịch hẹn</div>
                <div class="card-body">
                    <div class="appointment-info mb-3">
                        <p><strong>Ngày khám:</strong> <fmt:formatDate value="${appointment.appointmentDate}" pattern="dd/MM/yyyy"/></p>
                        <p><strong>Trạng thái lịch hẹn:</strong>
                            <select class="form-select" disabled>
                                <option value="completed" ${appointment.status == 'completed' ? 'selected' : ''}>Đặt lịch thành công</option>
                                <option value="canceled" ${appointment.status == 'canceled' ? 'selected' : ''}>Đã huỷ</option>
                            </select>
                        </p>
                    </div>

                    <div class="appointment-info mb-3">
                        <p><strong>Ca khám:</strong> ${appointment.startTime} - ${appointment.endTime}</p>
                        <p><strong>Trạng thái thanh toán:</strong>
                            <select class="form-select" disabled>
                                <option value="unpaid" ${appointment.paymentStatus == 'unpaid' ? 'selected' : ''}>Chưa thanh toán</option>
                                <option value="paid" ${appointment.paymentStatus == 'paid' ? 'selected' : ''}>Đã thanh toán</option>
                            </select>
                        </p>
                    </div>

                    <div class="appointment-info mb-3">
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

            <a href="staff-list-appointment" class="btn btn-outline-primary">Quay lại danh sách</a>
        </div>

        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
