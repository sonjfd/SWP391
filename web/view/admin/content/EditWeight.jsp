<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.ProductVariantWeight" %>

<%
    ProductVariantWeight weight = (ProductVariantWeight) request.getAttribute("weight");
    if (weight == null) {
%>
    <div class="container mt-4">
        <p class="text-danger">Không tìm thấy dữ liệu để chỉnh sửa.</p>
        <a href="admin-productVariantWeight" class="btn btn-secondary">Quay lại danh sách</a>
    </div>
<%
    return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa trọng lượng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script>
        function validateForm() {
            const weight = document.getElementById("weight").value.trim();
            if (!weight || isNaN(weight) || parseFloat(weight) <= 0) {
                alert("Trọng lượng phải là số dương.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body class="container mt-4">

    <h2 class="mb-4">Chỉnh sửa trọng lượng</h2>

    <form action="admin-productVariantWeight" method="post" onsubmit="return validateForm();">
        <input type="hidden" name="action" value="edit">
        <input type="hidden" name="weightId" value="<%= weight.getWeightId() %>">

        <!-- Trọng lượng -->
        <div class="mb-3">
            <label for="weight" class="form-label">Trọng lượng (gram) <span class="text-danger">*</span></label>
            <input type="number" step="0.01" class="form-control" id="weight" name="weight"
                   value="<%= weight.getWeight() %>" required>
        </div>

        <!-- Trạng thái -->
        <div class="mb-3">
            <label for="status" class="form-label">Trạng thái <span class="text-danger">*</span></label>
            <select class="form-select" name="status" id="status">
                <option value="1" <%= weight.isStatus() ? "selected" : "" %>>Đang bán</option>
                <option value="0" <%= !weight.isStatus() ? "selected" : "" %>>Ngừng bán</option>
            </select>
        </div>

        <!-- Nút -->
        <button type="submit" class="btn btn-primary">Cập nhật</button>
        <a href="admin-productVariantWeight" class="btn btn-secondary">Quay lại</a>
    </form>

</body>
</html>
