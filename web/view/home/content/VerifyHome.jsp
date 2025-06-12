<%-- 
    Document   : Verify
    Created on : Jun 12, 2025, 6:07:20 AM
    Author     : Dell
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
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
                <a href="login" class="btn btn-custom mt-4">Quay lại trang đăng nhập</a>
            </div>
        </div>

    </body>
</html>
