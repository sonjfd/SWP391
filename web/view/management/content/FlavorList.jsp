<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Model.ProductVariantFlavor" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Quản lý Hương vị</title>
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" />
    </head>
    <%@ include file="../layout/Header.jsp" %>
    <body class="container mt-4">
        <h2 class="mb-4">Danh sách Hương vị</h2>
        <a href="admin-productVariantFlavor?action=add" class="btn btn-success mb-3">Thêm hương vị</a>

        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Flavor ID</th>
                    <th>Hương vị</th>
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
                    <td><%= f.getFlavor() %></td>
                    <td>
                        <a href="admin-productVariantFlavor?action=edit&id=<%= f.getFlavorId() %>" class="btn btn-warning btn-sm">Sửa</a>
                        <a href="admin-productVariantFlavor?action=delete&id=<%= f.getFlavorId() %>" class="btn btn-danger btn-sm" onclick="return confirm('Xác nhận xoá?')">Xoá</a>
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
