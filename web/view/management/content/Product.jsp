<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Product" %>

<%
    List<Product> productList = (List<Product>) request.getAttribute("list");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Product Management</title>
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4">Product List</h2>

    <!-- Nút thêm sản phẩm -->
    <a href="${pageContext.request.contextPath}/view/management/content/AddProduct.jsp" class="btn btn-primary mb-3">Thêm sản phẩm</a>

    <!-- Bảng danh sách sản phẩm -->
    <table class="table table-bordered table-hover">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Category ID</th>
            <th>Supplier ID</th>
            <th>Name</th>
            <th>Description</th>
            <th>Image</th>
            <th>Created At</th>
            <th>Updated At</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            if (productList != null && !productList.isEmpty()) {
                for (Product p : productList) {
        %>
        <tr>
            <td><%= p.getProductId() %></td>
            <td><%= p.getCategoryId() %></td>
            <td><%= p.getSupplierId() %></td>
            <td><%= p.getProductName() %></td>
            <td><%= p.getDescription() %></td>
            <td><img src="<%= p.getImage() %>" width="80" height="80" alt="Image"></td>
            <td><%= p.getCreatedAt() %></td>
            <td><%= p.getUpdatedAt() %></td>
            <td>
                <a href="${pageContext.request.contextPath}/product?action=edit&id=<%= p.getProductId() %>" class="btn btn-warning btn-sm">Sửa</a>
                <a href="${pageContext.request.contextPath}/product?action=delete&id=<%= p.getProductId() %>" class="btn btn-danger btn-sm"
                   onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm không?');">Xóa</a>
            </td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="9" class="text-center">No products available.</td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>
</body>
</html>
