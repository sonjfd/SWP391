<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="Model.ProductVariantFlavor" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý Hương vị</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-4">
    <h2 class="mb-4">Danh sách Hương vị</h2>
    <a href="productVariantFlavor?action=add" class="btn btn-success mb-3">Thêm hương vị</a>

    <table class="table table-bordered">
        <thead>
            <tr>
                <th>Flavor ID</th>
                <th>Variant ID</th>
                <th>Hương vị</th>
                <th>Ngày tạo</th>
                <th>Ngày cập nhật</th>
                <th>Thao tác</th>
            </tr>
        </thead>
        <tbody>
        <%
            List<ProductVariantFlavor> list = (List<ProductVariantFlavor>) request.getAttribute("list");
            if (list != null) {
                for (ProductVariantFlavor f : list) {
        %>
            <tr>
                <td><%= f.getFlavorId() %></td>
                <td><%= f.getProductVariantId() %></td>
                <td><%= f.getFlavor() %></td>
                <td><%= f.getCreatedAt() %></td>
                <td><%= f.getUpdatedAt() %></td>
                <td>
                    <a href="productVariantFlavor?action=edit&id=<%= f.getFlavorId() %>" class="btn btn-warning btn-sm">Sửa</a>
                    <a href="productVariantFlavor?action=delete&id=<%= f.getFlavorId() %>" class="btn btn-danger btn-sm" onclick="return confirm('Xác nhận xoá?')">Xoá</a>
                </td>
            </tr>
        <%
                }
            }
        %>
        </tbody>
    </table>
</body>
</html>