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

    <!-- Hiển thị lỗi nếu có -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <form action="admin-productVariantFlavor" method="post" onsubmit="return validateForm();">
        <input type="hidden" name="action" value="edit">
        <input type="hidden" name="flavorId" value="<%= flavor.getFlavorId() %>">

        <div class="mb-3">
            <label for="flavor" class="form-label">Tên hương vị</label>
            <input
                type="text"
                class="form-control"
                id="flavor"
                name="flavor"
                value="<%= flavor.getFlavor() %>"
                maxlength="50"
                required
            />
        </div>

        <div class="mb-3">
            <label for="status" class="form-label">Trạng thái</label>
            <select class="form-select" id="status" name="status">
                <option value="1" <%= flavor.isStatus() ? "selected" : "" %>>Đang bán</option>
                <option value="0" <%= !flavor.isStatus() ? "selected" : "" %>>Ngừng bán</option>
            </select>
        </div>

        <button type="submit" class="btn btn-success">Cập nhật</button>
        <a href="admin-productVariantFlavor" class="btn btn-secondary">Quay lại</a>
    </form>
</body>
</html>
