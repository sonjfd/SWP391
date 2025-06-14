<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Xác thực tài khoản</title>
        <!-- Bootstrap 5 CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background: #f0f2f5;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
            .verify-card {
                max-width: 500px;
                margin: 80px auto;
                padding: 30px;
                background: white;
                border-radius: 15px;
                box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            }
            .btn-custom {
                background-color: #0d6efd;
                color: white;
            }
            .btn-custom:hover {
                background-color: #084298;
            }
        </style>
    </head>
    <body>

        <div class="container">
            <div class="verify-card text-center">
                <h2 class="mb-4 text-success">Vui lòng kiểm tra email</h2>
                <p class="lead">Chúng tôi đã gửi cho bạn một email xác thực tài khoản. Hãy mở email và nhấn vào liên kết để kích hoạt tài khoản của bạn.</p>

                <!-- Hiển thị thông báo -->
                <c:if test="${not empty message}">
                    <div class="alert alert-info">${message}</div>
                </c:if>
                <c:if test="${not empty success}">
                    <div class="alert alert-success">${success}</div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>

                <!-- Nút gửi lại email xác thực -->
                <c:if test="${resendEmail}">
                    <form action="resend-verify" method="post" class="mt-3">
                        <input type="hidden" name="email" value="${email}">
                        <button type="submit" class="btn btn-outline-primary">Gửi lại email xác thực</button>
                    </form>
                </c:if>

                <a href="login" class="btn btn-custom mt-4">Quay lại trang đăng nhập</a>
            </div>
        </div>

    </body>
</html>
