<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.ProductVariantWeight" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách trọng lượng biến thể</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-4">

    <h2 class="mb-4">Danh sách trọng lượng biến thể</h2>

    <a href="productVariantWeight?action=add" class="btn btn-primary mb-3">+ Thêm trọng lượng</a>

    <table class="table table-bordered table-striped">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Variant ID</th>
            <th>Trọng lượng</th>
            <th>Ngày tạo</th>
            <th>Ngày cập nhật</th>
            <th>Hành động</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<ProductVariantWeight> list = (List<ProductVariantWeight>) request.getAttribute("list");
            if (list != null && !list.isEmpty()) {
                for (ProductVariantWeight w : list) {
        %>
        <tr>
            <td><%= w.getWeightId() %></td>
            <td><%= w.getProductVariantId() %></td>
            <td><%= w.getWeight() %> g</td>
            <td><%= new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm").format(w.getCreatedAt()) %></td>
            <td><%= w.getUpdatedAt() != null ? new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm").format(w.getUpdatedAt()) : "—" %></td>
            <td>
                <a href="productVariantWeight?action=edit&id=<%= w.getWeightId() %>" class="btn btn-sm btn-warning">Sửa</a>
                <a href="productVariantWeight?action=delete&id=<%= w.getWeightId() %>"
                   class="btn btn-sm btn-danger"
                   onclick="return confirm('Bạn có chắc chắn muốn xoá không?');">Xoá</a>
            </td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="6" class="text-center">Không có dữ liệu.</td>
        </tr>
        <% } %>
        </tbody>
    </table>

</body>
</html>