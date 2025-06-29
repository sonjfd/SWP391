<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm danh mục</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h2 class="mb-4">Thêm danh mục mới</h2>

        <!-- Form thêm danh mục -->
        <form method="post" action="admin-category">
            <input type="hidden" name="action" value="add">

            <!-- Tên danh mục -->
            <div class="mb-3">
                <label class="form-label">Tên danh mục <span class="text-danger">*</span></label>
                <input type="text" name="name" class="form-control" maxlength="50" placeholder="Nhập tên danh mục">
                <div id="nameError" class="text-danger mt-1"></div>
            </div>

            <!-- Mô tả -->
            <div class="mb-3">
                <label class="form-label">Mô tả <span class="text-danger">*</span></label>
                <textarea name="description" class="form-control" maxlength="200" placeholder="Mô tả ngắn..."></textarea>
                <div id="descError" class="text-danger mt-1"></div>
            </div>

            <!-- Trạng thái -->
            <div class="mb-3">
                <label class="form-label">Trạng thái <span class="text-danger">*</span></label>
                <select name="status" class="form-select">
                    <option value="1" selected>Đang bán</option>
                    <option value="0">Ngừng bán</option>
                </select>
            </div>

            <!-- Nút -->
            <button type="submit" class="btn btn-success">Thêm</button>
            <a href="admin-category" class="btn btn-secondary">Quay lại</a>
        </form>
    </div>

    <!-- Script -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const nameInput = document.querySelector("input[name='name']");
            const descInput = document.querySelector("textarea[name='description']");
            const nameError = document.getElementById("nameError");
            const descError = document.getElementById("descError");

            const nameRegex = /^[^<>"]{1,50}$/u; // Cho phép chữ cái Unicode, số, khoảng trắng, dấu gạch

            nameInput.addEventListener("blur", function () {
                const nameValue = nameInput.value.trim();
                nameError.textContent = "";

                if (nameValue === "") {
                    nameError.textContent = "Tên danh mục không được để trống!";
                } else if (nameValue.length > 50) {
                    nameError.textContent = "Tên danh mục không được vượt quá 50 ký tự!";
                } else if (!nameRegex.test(nameValue)) {
                    nameError.textContent = "Chỉ cho phép chữ cái, số, khoảng trắng và dấu gạch ngang!";
                }
            });

            descInput.addEventListener("blur", function () {
                const descValue = descInput.value.trim();
                descError.textContent = "";

                if (descValue === "") {
                    descError.textContent = "Mô tả không được để trống!";
                } else if (descValue.length > 200) {
                    descError.textContent = "Mô tả không được vượt quá 200 ký tự!";
                }
            });

            document.querySelector("form").addEventListener("submit", function (e) {
                let valid = true;
                nameError.textContent = "";
                descError.textContent = "";

                const nameValue = nameInput.value.trim();
                const descValue = descInput.value.trim();

                if (nameValue === "") {
                    nameError.textContent = "Tên danh mục không được để trống!";
                    nameInput.focus();
                    valid = false;
                } else if (nameValue.length > 50) {
                    nameError.textContent = "Tên danh mục không được vượt quá 50 ký tự!";
                    nameInput.focus();
                    valid = false;
                } else if (!nameRegex.test(nameValue)) {
                    nameError.textContent = "Chỉ cho phép chữ cái, số, khoảng trắng và dấu gạch ngang!";
                    nameInput.focus();
                    valid = false;
                }

                if (descValue === "") {
                    descError.textContent = "Mô tả không được để trống!";
                    if (valid) descInput.focus();
                    valid = false;
                } else if (descValue.length > 200) {
                    descError.textContent = "Mô tả không được vượt quá 200 ký tự!";
                    if (valid) descInput.focus();
                    valid = false;
                }

                if (!valid) {
                    e.preventDefault();
                }
            });
        });
    </script>
</body>
</html>
