<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${empty sessionScope.user}">
    <c:redirect url="login"/>
</c:if>

<c:set var="user" value="${sessionScope.user}" />
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Cập nhật hồ sơ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f2fbff; }
        .profile-card {
            max-width: 600px;
            margin: 50px auto;
            padding: 30px;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
        }
        .btn-save {
            background-color: #0077b6;
            color: white;
            font-weight: 500;
        }
        .btn-save:hover {
            background-color: #005f8e;
        }
        .error-msg {
            color: red;
            font-size: 0.875rem;
            display: none;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="profile-card">
        <h4 class="text-center mb-4">Cập nhật hồ sơ cá nhân</h4>

        <form action="update-profile-first-time" method="post" id="profileForm" novalidate>
            <h5 class="mt-4 mb-3">Thông tin chuyên môn (Bác sĩ)</h5>

            <div class="mb-3">
                <label class="form-label">Chuyên môn</label>
                <input type="text" name="specialty" class="form-control" maxlength="100" required onblur="validateField(this)">
                <div class="error-msg">Vui lòng nhập chuyên môn (tối đa 100 ký tự).</div>
            </div>

            <div class="mb-3">
                <label class="form-label">Bằng cấp</label>
                <input type="text" name="qualifications" class="form-control" maxlength="255" required onblur="validateField(this)">
                <div class="error-msg">Vui lòng nhập bằng cấp (tối đa 255 ký tự).</div>
            </div>

            <div class="mb-3">
                <label class="form-label">Chứng chỉ</label>
                <textarea name="certificates" class="form-control" rows="2" maxlength="1000" onblur="validateField(this)"></textarea>
                <div class="error-msg">Chứng chỉ không được quá 1000 ký tự.</div>
            </div>

            <div class="mb-3">
                <label class="form-label">Số năm kinh nghiệm</label>
                <input type="number" name="yearsOfExperience" class="form-control" min="0" max="100" required onblur="validateField(this)">
                <div class="error-msg">Vui lòng nhập số năm hợp lệ (0 - 100).</div>
            </div>

            <div class="mb-3">
                <label class="form-label">Tiểu sử</label>
                <textarea name="biography" class="form-control" rows="3" maxlength="1000" placeholder="Mô tả ngắn gọn về bạn..." onblur="validateField(this)"></textarea>
                <div class="error-msg">Tiểu sử không được quá 1000 ký tự.</div>
            </div>

            <div class="d-grid mt-4">
                <button type="submit" class="btn btn-save btn-lg">Lưu thông tin</button>
            </div>
        </form>
    </div>
</div>

<script>
    function escapeHtml(str) {
        if (!str) return "";
        return str.replace(/[&<>"']/g, function(m) {
            return {
                '&': '&amp;',
                '<': '&lt;',
                '>': '&gt;',
                '"': '&quot;',
                "'": '&#39;'
            }[m];
        });
    }

    function validateField(field) {
        const errorDiv = field.nextElementSibling;
        let valid = true;

        if (field.required && !field.value.trim()) {
            valid = false;
        }

        if (field.type === 'number') {
            const val = parseInt(field.value, 10);
            if (isNaN(val) || val < parseInt(field.min) || val > parseInt(field.max)) {
                valid = false;
            }
        }

        if (field.maxLength > 0 && field.value.length > field.maxLength) {
            valid = false;
        }

        if (!valid) {
            errorDiv.style.display = 'block';
            field.classList.add("is-invalid");
        } else {
            errorDiv.style.display = 'none';
            field.classList.remove("is-invalid");
        }
        return valid;
    }

    document.getElementById('profileForm').addEventListener('submit', function (e) {
        const fields = this.querySelectorAll('input, textarea');
        let valid = true;
        fields.forEach(f => {
            if (!validateField(f)) valid = false;
        });
        if (!valid) {
            e.preventDefault();
        }
    });
</script>

</body>
</html>
