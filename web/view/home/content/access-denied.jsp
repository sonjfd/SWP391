<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Access Denied</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: #f8f9fa;
        }
        .denied-box {
            max-width: 600px;
            margin: 80px auto;
            background: #fff;
            padding: 40px;
            text-align: center;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .denied-box h1 {
            font-size: 3rem;
            color: #dc3545;
        }
        .denied-box p {
            font-size: 1.2rem;
            margin-top: 15px;
        }
    </style>
</head>
<body>
    <div class="denied-box">
        <h1>403</h1>
        <p><strong>${errorMessage}</strong></p>
        <a href="javascript:history.back()" class="btn btn-secondary mt-3">Quay về trang trước</a>

    </div>
</body>
</html>
