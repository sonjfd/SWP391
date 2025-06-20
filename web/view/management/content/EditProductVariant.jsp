<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Model.ProductVariant" %>
<%@ page import="Model.Product" %>
<%@ page import="Model.ProductVariantWeight" %>
<%@ page import="Model.ProductVariantFlavor" %>
<%@ page import="java.util.List" %>
<%
    ProductVariant variant = (ProductVariant) request.getAttribute("variant");
    List<Product> products = (List<Product>) request.getAttribute("products");
    List<ProductVariantWeight> weights = (List<ProductVariantWeight>) request.getAttribute("weights");
    List<ProductVariantFlavor> flavors = (List<ProductVariantFlavor>) request.getAttribute("flavors");
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cập Nhật Biến Thể Sản Phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body class="container mt-5">

    <h2 class="mb-4">Cập Nhật Biến Thể Sản Phẩm</h2>

    <% if (error != null) { %>
        <div class="alert alert-danger"><%= error %></div>
    <% } %>

    <form action="admin-editProductVariant" method="post">
        <input type="hidden" name="variant_id" value="<%= variant.getProductVariantId() %>" />

        <div class="mb-3">
            <label class="form-label">Tên Biến Thể</label>
            <input type="text" name="variant_name" class="form-control" value="<%= variant.getVariantName() %>" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Sản Phẩm</label>
            <select name="product_id" class="form-select" required>
                <% for (Product p : products) { %>
                    <option value="<%= p.getProductId() %>" <%= (p.getProductId() == variant.getProductId()) ? "selected" : "" %>>
                        <%= p.getProductName() %>
                    </option>
                <% } %>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Trọng Lượng</label>
            <select name="weight_id" class="form-select" required>
                <% for (ProductVariantWeight w : weights) { %>
                    <option value="<%= w.getWeightId() %>" <%= (w.getWeightId() == variant.getWeightId()) ? "selected" : "" %>>
                        <%= w.getWeight() %>g
                    </option>
                <% } %>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Hương Vị</label>
            <select name="flavor_id" class="form-select" required>
                <% for (ProductVariantFlavor f : flavors) { %>
                    <option value="<%= f.getFlavorId() %>" <%= (f.getFlavorId() == variant.getFlavorId()) ? "selected" : "" %>>
                        <%= f.getFlavor() %>
                    </option>
                <% } %>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Giá</label>
            <input type="number" step="0.01" name="price" class="form-control" value="<%= variant.getPrice() %>" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Số Lượng Tồn</label>
            <input type="number" name="stock_quantity" class="form-control" value="<%= variant.getStockQuantity() %>" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Trạng Thái</label>
            <select name="status" class="form-select">
                <option value="1" <%= variant.isStatus() ? "selected" : "" %>>Hiển thị</option>
                <option value="0" <%= !variant.isStatus() ? "selected" : "" %>>Ẩn</option>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Ảnh (URL)</label>
            <input type="text" name="image" class="form-control" value="<%= variant.getImage() != null ? variant.getImage() : "" %>">
        </div>

        <button type="submit" class="btn btn-primary">Cập Nhật</button>
        <a href="admin-productVariant?action=list" class="btn btn-secondary">Quay Lại</a>
    </form>

</body>
</html>
