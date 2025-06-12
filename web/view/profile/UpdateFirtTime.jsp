<%-- 
    Document   : UpdateFirtTime
    Created on : Jun 12, 2025, 5:43:58 AM
    Author     : Dell
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${empty sessionScope.user}">
    <c:redirect url="login.jsp"/>
</c:if>

<c:set var="user" value="${sessionScope.user}" />
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Cập nhật hồ sơ</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Custom CSS -->
        <style>
            body {
                background: linear-gradient(to right, #e0f7fa, #ffffff);
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .profile-card {
                max-width: 500px;
                margin: 60px auto;
                border-radius: 15px;
                box-shadow: 0 6px 20px rgba(0,0,0,0.1);
                background-color: #ffffff;
            }

            .card-header {
                background-color: #0077b6;
                color: white;
                border-radius: 15px 15px 0 0;
            }

            .form-label {
                font-weight: 500;
            }

            .btn-save {
                background-color: #0077b6;
                color: white;
                font-weight: 500;
            }

            .btn-save:hover {
                background-color: #005f8e;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="card profile-card">
                <div class="card-header text-center py-3">
                    <h4 class="mb-0">Cập nhật hồ sơ cá nhân</h4>
                </div>
                <form action="update-profile-firtstime" method="post">
                    <div class="card-body px-4 py-4">
                        <div class="mb-3">
                            <label for="fullname" class="form-label">Họ và tên</label>
                            <input type="text" class="form-control" id="fullname" name="fullname" value="${user.fullName}" required>
                        </div>

                        <div class="mb-3">
                            <label for="phone" class="form-label">Số điện thoại</label>
                            <input type="text" class="form-control" id="phone" name="phone" value="${user.phoneNumber}" pattern="0[0-9]{9,10}" placeholder="VD: 0912345678" required>
                        </div>

                        <div class="mb-3">
                            <label for="address" class="form-label">Địa chỉ</label>
                            <textarea class="form-control" id="address" name="address" rows="3" placeholder="Nhập địa chỉ của bạn...">${user.address}</textarea>
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-save btn-lg">Lưu thông tin</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>
