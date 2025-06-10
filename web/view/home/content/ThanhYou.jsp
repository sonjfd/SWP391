<%-- 
    Document   : ThanhYou
    Created on : Jun 8, 2025, 12:23:26 AM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Đặt lịch thành công</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
</head>

<body class="bg-light d-flex align-items-center justify-content-center" style="min-height: 100vh;">

    <div class="container text-center">
        <div class="card shadow p-4 border-0" style="max-width: 600px; margin: auto;">
            
            <h3 class="text-success mb-3">
                <i class="fas fa-check-circle me-2"></i> Đặt lịch thành công!
            </h3>
            <p class="fs-5">Cảm ơn bạn đã tin tưởng sử dụng dịch vụ của chúng tôi.</p>
            <p class="mb-3">Chúng tôi đã gửi email xác nhận và sẽ liên hệ sớm với bạn để xác nhận cuộc hẹn.</p>

            <div class="mb-3">
                <img src="https://cdn-icons-png.flaticon.com/512/190/190411.png" alt="success" width="120" />
            </div>

            <a href="${pageContext.request.contextPath}/homepage" class="btn btn-primary">
                <i class="fas fa-arrow-left me-1"></i> Về trang chủ
            </a>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
