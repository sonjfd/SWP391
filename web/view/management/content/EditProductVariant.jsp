<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Model.ProductVariant" %>
<%@ page import="Model.Product" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Cập Nhật Biến Thể Sản Phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script>
        function validateForm() {
            let name = document.forms["variantForm"]["variant_name"].value;
            let price = document.forms["variantForm"]["price"].value;
            let stock = document.forms["variantForm"]["stock_quantity"].value;

            if (name.trim() === "" || name.length > 100) {
                alert("Tên biến thể không được để trống và không quá 100 ký tự.");
                return false;
            }
            if (isNaN(price) || parseFloat(price) <= 0) {
                alert("Giá phải là số hợp lệ lớn hơn 0.");
                return false;
            }
            if (!Number.isInteger(Number(stock)) || Number(stock) < 0) {
                alert("Số lượng phải là số nguyên không âm.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body class="container mt-5">
    <h2 class="mb-4">Cập Nhật Biến Thể Sản Phẩm</h2>

    <%
        ProductVariant variant = (ProductVariant) request.getAttribute("variant");
        List<Product> products = (List<Product>) request.getAttribute("products");
        String error = (String) request.getAttribute("error");
        if (error != null) {
    %>
        <div class="alert alert-danger"><%= error %></div>
    <% } %>

    <form name="variantForm" action="editProductVariant" method="post" onsubmit="return validateForm()">
        <!-- ✅ Đổi tên input hidden này -->
        <input type="hidden" name="variant_id" value="<%= variant.getProductVariantId() %>">

        <div class="mb-3">
            <label class="form-label">Tên biến thể</label>
            <input type="text" class="form-control" name="variant_name" value="<%= variant.getVariantName() %>" maxlength="100" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Sản phẩm</label>
            <select class="form-select" name="product_id" required>
                <% for (Product p : products) { %>
                    <option value="<%= p.getProductId() %>" <%= (p.getProductId() == variant.getProductId()) ? "selected" : "" %>>
                        <%= p.getProductName() %>
                    </option>
                <% } %>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Giá (VNĐ)</label>
            <input type="number" step="0.01" min="0" class="form-control" name="price" value="<%= variant.getPrice() %>" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Số lượng tồn kho</label>
            <input type="number" min="0" class="form-control" name="stock_quantity" value="<%= variant.getStockQuantity() %>" required>
        </div>

        <div class="d-flex gap-2">
            <button type="submit" class="btn btn-success">Lưu thay đổi</button>
            <a href="productVariant?action=list" class="btn btn-secondary">Huỷ</a>
        </div>
    </form>
</body>
</html>
