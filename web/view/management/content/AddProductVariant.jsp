<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="Model.Product" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Thêm Biến Thể Sản Phẩm</title>
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
        <h2 class="mb-4">Thêm Biến Thể Sản Phẩm</h2>

        <% String error = (String) request.getAttribute("error"); if (error != null) { %>
        <div class="alert alert-danger"><%= error %></div>
        <% } %>

        <form name="variantForm" action="addProductVariant" method="post" onsubmit="return validateForm()">
            <div class="mb-3">
                <label class="form-label">Tên biến thể</label>
                <input type="text" class="form-control" name="variant_name" maxlength="100" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Sản phẩm</label>
                <select class="form-select" name="product_id" required>
                    <%
                        List<Product> products = (List<Product>) request.getAttribute("products");
                        for (Product p : products) {
                    %>
                    <option value="<%= p.getProductId() %>"><%= p.getProductName() %></option>
                    <% } %>
                </select>
            </div>

            <div class="mb-3">
                <label class="form-label">Giá</label>
                <input type="number" step="0.01" class="form-control" name="price" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Số lượng</label>
                <input type="number" class="form-control" name="stock_quantity" required>
            </div>

            <button type="submit" class="btn btn-primary">Thêm</button>
            <a href="productVariant?action=list" class="btn btn-secondary">Hủy</a>
        </form>
    </body>
</html>
