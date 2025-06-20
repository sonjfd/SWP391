<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Category" %>

<%
    List<Category> categories = (List<Category>) request.getAttribute("categories");

    // DEBUG: In số lượng danh mục (có thể xóa sau khi test)
    System.out.println("DEBUG - Số danh mục nhận được trong JSP: " + (categories == null ? "null" : categories.size()));
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm sản phẩm</title>
    <!-- Bootstrap 5 -->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4">Thêm sản phẩm mới</h2>

    <!-- Form thêm sản phẩm -->
    <form action="${pageContext.request.contextPath}/product" method="post">
        <input type="hidden" name="action" value="add">

        <!-- Danh mục -->
        <div class="mb-3">
            <label for="categoryId" class="form-label">Danh mục <span class="text-danger">*</span></label>
            <select class="form-select" id="categoryId" name="categoryId" required>
                <option value="">-- Chọn danh mục --</option>
                <%
                    if (categories != null && !categories.isEmpty()) {
                        for (Category c : categories) {
                %>
                <option value="<%= c.getCategoryId() %>"><%= c.getCategoryName() %></option>
                <%
                        }
                    } else {
                %>
                <option disabled>Không có danh mục nào hoạt động</option>
                <%
                    }
                %>
            </select>
        </div>

        <!-- Tên sản phẩm -->
        <div class="mb-3">
            <label for="productName" class="form-label">Tên sản phẩm <span class="text-danger">*</span></label>
            <input type="text" class="form-control" id="productName" name="productName" required>
        </div>

        <!-- Mô tả -->
        <div class="mb-3">
            <label for="description" class="form-label">Mô tả <span class="text-danger">*</span></label>
            <textarea class="form-control" id="description" name="description" rows="3" required></textarea>
        </div>

                <!-- Nút -->
        <button type="submit" class="btn btn-success">Lưu</button>
        <a href="${pageContext.request.contextPath}/product" class="btn btn-secondary">Huỷ</a>
    </form>
   
</div>
</body>
</html>
