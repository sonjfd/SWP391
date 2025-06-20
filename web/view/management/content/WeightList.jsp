<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="Model.ProductVariantWeight" %>
<%@ page import="java.text.DecimalFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý trọng lượng biến thể</title>
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" />
</head>
<body class="container mt-4">

    <%@ include file="../layout/Header.jsp" %>

    <h2 class="mb-4">Danh sách trọng lượng</h2>

    <a href="productVariantWeight?action=add" class="btn btn-primary mb-3">+ Thêm trọng lượng</a>

    <table class="table table-bordered table-striped">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Trọng lượng</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody>
        <%
            List<ProductVariantWeight> list = (List<ProductVariantWeight>) request.getAttribute("list");
            DecimalFormat df = new DecimalFormat("#,##0.##"); // format trọng lượng
            if (list != null && !list.isEmpty()) {
                for (ProductVariantWeight w : list) {
        %>
            <tr>
                <td><%= w.getWeightId() %></td>
                <td><%= df.format(w.getWeight()) %> g</td>
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
                <td colspan="3" class="text-center">Không có dữ liệu.</td>
            </tr>
        <%
            }
        %>
        </tbody>
    </table>

</body>
</html>
