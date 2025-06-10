<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Kết quả giao dịch</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
</head>

<body class="bg-light d-flex align-items-center justify-content-center" style="min-height: 100vh;">

    <div class="container text-center">
        <div class="card shadow p-4 border-0" style="max-width: 600px; margin: auto;">
            <!-- Ảnh minh hoạ giao dịch -->
            

            <!-- Giao dịch thành công -->
            <c:if test="${transResult}">
                <h3 class="text-success mb-3">
                    <i class="fas fa-check-circle me-2"></i> Đặt lịch thành công!
                </h3>
                <p class="fs-5">Cảm ơn bạn đã sử dụng dịch vụ của phòng khám thú cưng!</p>
                <p>Nhân viên sẽ sớm liên hệ với bạn!! </p>
                
            </c:if>

            <!-- Giao dịch thất bại -->
            <c:if test="${transResult == false}">
                <h3 class="text-danger mb-3">
                    <i class="fas fa-times-circle me-2"></i> Đặt lịch thất bại!
                </h3>
                <p class="fs-5">Rất tiếc! Quý khách vui lòng thử lại!</p>
                
            </c:if>

            <!-- Giao dịch đang xử lý -->
            <c:if test="${transResult == null}">
                <h3 class="text-warning mb-3">
                    <i class="fas fa-clock me-2"></i> Cuộc hẹn được xử lý!
                </h3>
                <p class="fs-5">Chúng tôi đã nhận được lịch hẹn, sẽ sớm liên hệ với bạn.</p>
                
            </c:if>

            <!-- Nút quay về trang chủ -->
            <div class="mt-4">
                <a href="${pageContext.request.contextPath}/homepage" class="btn btn-primary">
                    <i class="fas fa-arrow-left me-1"></i> Quay về trang chủ
                </a>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS (optional if no modal/dropdown) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
