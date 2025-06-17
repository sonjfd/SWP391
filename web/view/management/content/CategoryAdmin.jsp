<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Model.Category" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lí danh mục</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2 class="mb-4 text-center">Quản lí danh mục</h2>

    <!-- Nút chuyển sang trang thêm danh mục -->
    <a href="${pageContext.request.contextPath}/category?action=addForm" class="btn btn-success mb-3">+ Thêm danh mục</a>

    <table class="table table-bordered">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Tên</th>
            <th>Giới thiệu sản phẩm</th>
            <th>Hành động</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<Category> list = (List<Category>) request.getAttribute("list");
            if (list != null && !list.isEmpty()) {
                for (Category c : list) {
        %>
        <tr>
            <td><%= c.getCategoryId() %></td>
            <td><%= c.getCategoryName() %></td>
            <td><%= c.getDescription() %></td>
            <td>
                <!-- Nút Edit -->
                <a href="category?action=edit&id=<%= c.getCategoryId() %>" class="btn btn-warning btn-sm">Sửa</a>

                <!-- Nút Delete có xác nhận -->
                <form method="get"
                      action="category"
                      style="display:inline-block;"
                      onsubmit="return confirm('Bạn có chắc chắn muốn xóa danh mục này không?');">
                    <input type="hidden" name="action" value="delete" />
                    <input type="hidden" name="id" value="<%= c.getCategoryId() %>" />
                    <button type="submit" class="btn btn-danger btn-sm">Xóa</button>
                </form>
            </td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="4" class="text-center">Không thấy danh mục nào.</td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>
</body>
</html>
