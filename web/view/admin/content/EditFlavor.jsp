<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="Model.ProductVariantFlavor" %>

<%
    ProductVariantFlavor flavor = (ProductVariantFlavor) request.getAttribute("flavor");
    if (flavor == null) {
%>
    <div class="container mt-4">
        <p class="text-danger">Không tìm thấy dữ liệu để chỉnh sửa.</p>
        <a href="admin-productVariantFlavor" class="btn btn-secondary">Quay lại danh sách</a>
    </div>
<%
    return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa hương vị</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script>
        function validateForm() {
            const flavor = document.getElementById("flavor").value.trim();
            if (flavor.length === 0) {
                alert("Vui lòng nhập tên hương vị.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body class="container mt-4">

    <h2 class="mb-4">Chỉnh sửa hương vị sản phẩm</h2>

    <!-- ✅ Hiển thị lỗi nếu có -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- ✅ Hiển thị thông báo thành công -->
    <c:if test="${not empty message}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <form action="admin-productVariantFlavor" method="post" onsubmit="return validateForm();">
        <input type="hidden" name="action" value="edit">
        <input type="hidden" name="flavorId" value="<%= flavor.getFlavorId() %>">

        <div class="mb-3">
            <label for="flavor" class="form-label">Tên hương vị <span class="text-danger">*</span></label>
            <input
                type="text"
                class="form-control"
                id="flavor"
                name="flavor"
                maxlength="50"
                required
                value="${param.flavor != null ? param.flavor : flavor.flavor}"
            />
        </div>

        <div class="mb-3">
            <label for="status" class="form-label">Trạng thái <span class="text-danger">*</span></label>
            <select class="form-select" id="status" name="status">
                <option value="1" ${param.status == '1' || (param.status == null && flavor.status) ? 'selected' : ''}>Đang bán</option>
                <option value="0" ${param.status == '0' || (param.status == null && !flavor.status) ? 'selected' : ''}>Ngừng bán</option>
            </select>
        </div>

        <button type="submit" class="btn btn-success">Cập nhật</button>
        <a href="admin-productVariantFlavor" class="btn btn-secondary">Quay lại</a>
    </form>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
