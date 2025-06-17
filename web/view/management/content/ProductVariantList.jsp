<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Model.ProductVariant" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Biến thể sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-4">

    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3>Biến thể sản phẩm</h3>
        <a href="productVariant?action=add" class="btn btn-primary">+ Thêm biến thể</a>
    </div>

    <% String error = (String) request.getAttribute("error"); if (error != null) { %>
        <div class="alert alert-danger"><%= error %></div>
    <% } %>

    <table class="table table-bordered table-hover">
        <thead class="table-light">
            <tr>
                <th>ID</th>
                <th>Product ID</th>
                <th>Tên</th>
                <th>Giá</th>
                <th>Tồn kho</th>
                <th>Ngày tạo</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<ProductVariant> variants = (List<ProductVariant>) request.getAttribute("variants");
                if (variants != null && !variants.isEmpty()) {
                    for (ProductVariant v : variants) {
            %>
            <tr>
                <td><%= v.getProductVariantId() %></td>
                <td><%= v.getProductId() %></td>
                <td><%= v.getVariantName() %></td>
                <td><%= v.getPrice() %></td>
                <td><%= v.getStockQuantity() %></td>
                <td><%= v.getCreatedAt() %></td>
                <td>
                    <a href="productVariant?action=edit&id=<%= v.getProductVariantId() %>" class="btn btn-sm btn-warning">Sửa</a>
                    <a href="productVariant?action=delete&id=<%= v.getProductVariantId() %>" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc muốn xoá?');">Xoá</a>
                </td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="7" class="text-center">Không có dữ liệu</td>
            </tr>
            <% } %>
        </tbody>
    </table>

</body>
</html>