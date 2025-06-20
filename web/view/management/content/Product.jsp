<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="Model.Product" %>

<%
    List<Product> productList = (List<Product>) request.getAttribute("list");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Sản phẩm</title>
    <!-- Bootstrap 5 -->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" />
</head>
<body>
<%@ include file="../layout/Header.jsp" %>

<div class="container mt-5 pt-5" style="margin-top: 100px;">
    <h2 class="mb-4">Danh sách sản phẩm</h2>

    <!-- Nút thêm sản phẩm -->
    <a href="${pageContext.request.contextPath}/product?action=addForm" class="btn btn-primary mb-3">+ Thêm sản phẩm</a>

    <!-- Bảng danh sách sản phẩm -->
    <table class="table table-bordered table-hover align-middle">
        <thead class="table-dark text-center">
        <tr>
            <th>ID</th>
            <th>Danh mục</th>
            <th>Tên sản phẩm</th>
            <th>Mô tả</th>
            <th>Ngày tạo</th>
            <th>Ngày cập nhật</th>
            <th>Hành động</th>
        </tr>
        </thead>
        <tbody>
        <%
            if (productList != null && !productList.isEmpty()) {
                for (Product p : productList) {
        %>
        <tr>
            <td class="text-center"><%= p.getProductId() %></td>
            <td><%= p.getCategory() != null ? p.getCategory().getCategoryName() : "N/A" %></td>
            <td><%= p.getProductName() %></td>
            <td><%= p.getDescription() %></td>
            <td class="text-center"><%= p.getCreatedAt() %></td>
            <td class="text-center"><%= p.getUpdatedAt() %></td>
            <td class="text-center">
                <a href="${pageContext.request.contextPath}/product?action=edit&id=<%= p.getProductId() %>" class="btn btn-warning btn-sm">Sửa</a>
                <a href="${pageContext.request.contextPath}/product?action=delete&id=<%= p.getProductId() %>"
                   class="btn btn-danger btn-sm"
                   onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm không?');">Xóa</a>
            </td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="7" class="text-center">Không có sản phẩm nào.</td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>
</body>
</html>
