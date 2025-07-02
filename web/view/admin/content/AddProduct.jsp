<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Category" %>

<%
    List<Category> categories = (List<Category>) request.getAttribute("categories");

    String oldName = request.getAttribute("oldName") != null ? (String) request.getAttribute("oldName") : "";
    String oldDesc = request.getAttribute("oldDesc") != null ? (String) request.getAttribute("oldDesc") : "";
    String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm sản phẩm</title>
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4">Thêm sản phẩm mới</h2>

    <%-- HIỂN THỊ THÔNG BÁO LỖI (nếu có) --%>
    <% if (error != null) { %>
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <%= error %>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <% } %>

    <form action="${pageContext.request.contextPath}/admin-product" method="post" id="productForm">
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
            <input type="text" class="form-control" id="productName" name="productName" maxlength="50" required value="<%= oldName %>">
            <small id="productNameError" class="text-danger" style="display:none;"></small>
        </div>

        <!-- Mô tả -->
        <div class="mb-3">
            <label for="description" class="form-label">Mô tả <span class="text-danger">*</span></label>
            <textarea class="form-control" id="description" name="description" rows="3" maxlength="200" required><%= oldDesc %></textarea>
            <small id="descriptionError" class="text-danger" style="display:none;"></small>
        </div>

        <!-- Nút -->
        <button type="submit" class="btn btn-success">Thêm</button>
        <a href="${pageContext.request.contextPath}/admin-product" class="btn btn-secondary">Huỷ</a>
    </form>
</div>

<script>
    function showError(id, message) {
        const el = document.getElementById(id + "Error");
        el.textContent = message;
        el.style.display = message ? "block" : "none";
    }

    function validateProductName() {
        const value = document.getElementById("productName").value.trim();
        if (!value) {
            showError("productName", "Tên sản phẩm không được để trống.");
            return false;
        }
        if (value.length > 50) {
            showError("productName", "Tên sản phẩm không được vượt quá 50 ký tự.");
            return false;
        }
        showError("productName", "");
        return true;
    }

    function validateDescription() {
        const value = document.getElementById("description").value.trim();
        if (!value) {
            showError("description", "Mô tả không được để trống.");
            return false;
        }
        if (value.length > 200) {
            showError("description", "Mô tả không được vượt quá 200 ký tự.");
            return false;
        }
        showError("description", "");
        return true;
    }

    document.addEventListener("DOMContentLoaded", function () {
        document.getElementById("productName").addEventListener("blur", validateProductName);
        document.getElementById("description").addEventListener("blur", validateDescription);

        document.getElementById("productForm").addEventListener("submit", function (e) {
            if (!validateProductName() || !validateDescription()) {
                e.preventDefault();
            }
        });
    });
</script>
</body>
</html>
