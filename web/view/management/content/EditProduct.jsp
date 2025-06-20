<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Product" %>
<%@ page import="Model.Category" %>

<%
    Product p = (Product) request.getAttribute("editProduct");
    List<Category> categories = (List<Category>) request.getAttribute("categories");

    if (p == null) {
%>
    <div class="container mt-5">
        <h3 class="text-danger">Không tìm thấy sản phẩm!</h3>
        <a href="${pageContext.request.contextPath}/product" class="btn btn-secondary">Quay lại danh sách</a>
    </div>
<%
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4">Chỉnh sửa sản phẩm</h2>

    <form action="${pageContext.request.contextPath}/product" method="post">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="<%= p.getProductId() %>">

        <!-- Danh mục -->
        <div class="mb-3">
            <label for="categoryId" class="form-label">Danh mục <span class="text-danger">*</span></label>
            <select class="form-select" id="categoryId" name="categoryId" required>
                <option value="">-- Chọn danh mục --</option>
                <%
                    if (categories != null) {
                        for (Category c : categories) {
                            boolean selected = (c.getCategoryId() == p.getCategory().getCategoryId());
                %>
                    <option value="<%= c.getCategoryId() %>" <%= selected ? "selected" : "" %>>
                        <%= c.getCategoryName() %>
                    </option>
                <%
                        }
                    }
                %>
            </select>
        </div>

        <!-- Tên sản phẩm -->
        <div class="mb-3">
            <label for="productName" class="form-label">Tên sản phẩm <span class="text-danger">*</span></label>
            <input type="text" class="form-control" id="productName" name="productName"
                   value="<%= p.getProductName() %>" required>
        </div>

        <!-- Mô tả -->
        <div class="mb-3">
            <label for="description" class="form-label">Mô tả <span class="text-danger">*</span></label>
            <textarea class="form-control" id="description" name="description" rows="3" required><%= p.getDescription() %></textarea>
        </div>

        <!-- Nút -->
        <button type="submit" class="btn btn-primary">Cập nhật</button>
        <a href="${pageContext.request.contextPath}/product" class="btn btn-secondary">Huỷ</a>
    </form>
</div>
</body>
</html>
