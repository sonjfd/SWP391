<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Pet24h - Thêm trọng lượng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script>
        function validateForm() {
            const weight = document.getElementById("weight").value.trim();
            let errors = [];

            if (!weight || isNaN(weight) || parseFloat(weight) <= 0) {
                errors.push("Trọng lượng phải là số dương.");
            }

            if (errors.length > 0) {
                alert(errors.join("\n"));
                return false;
            }

            return true;
        }
    </script>
</head>
<body class="container mt-4">

    <h2 class="mb-4">Thêm trọng lượng sản phẩm</h2>

    <!-- ✅ Thông báo lỗi -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- ✅ Thông báo thành công -->
    <c:if test="${not empty message}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- ✅ Form thêm -->
    <form action="admin-productVariantWeight" method="post" onsubmit="return validateForm();">
        <input type="hidden" name="action" value="add">

        <div class="mb-3">
            <label for="weight" class="form-label">Trọng lượng (gram) <span class="text-danger">*</span></label>
            <input
                type="number"
                step="0.01"
                class="form-control"
                id="weight"
                name="weight"
                required
                value="${weight != null ? weight : ''}"
            />
        </div>

        <div class="mb-3">
            <label for="status" class="form-label">Trạng thái <span class="text-danger">*</span></label>
            <select class="form-select" id="status" name="status">
                <option value="1" ${status == '1' ? 'selected' : ''}>Đang bán</option>
                <option value="0" ${status == '0' ? 'selected' : ''}>Ngừng bán</option>
            </select>
        </div>

        <button type="submit" class="btn btn-success">Thêm</button>
        <a href="admin-productVariantWeight" class="btn btn-secondary">Quay lại</a>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
