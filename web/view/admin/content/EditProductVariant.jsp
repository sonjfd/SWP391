<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Product" %>
<%@ page import="Model.ProductVariantWeight" %>
<%@ page import="Model.ProductVariantFlavor" %>
<%@ page import="Model.ProductVariant" %>

<%
    List<Product> products = (List<Product>) request.getAttribute("products");
    List<ProductVariantWeight> weights = (List<ProductVariantWeight>) request.getAttribute("weights");
    List<ProductVariantFlavor> flavors = (List<ProductVariantFlavor>) request.getAttribute("flavors");
    ProductVariant variant = (ProductVariant) request.getAttribute("variant");
    String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa Biến Thể Sản Phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">

<h2>Chỉnh sửa Biến Thể Sản Phẩm</h2>

<% if (error != null) { %>
    <div class="alert alert-danger"><%= error %></div>
<% } %>

<form action="${pageContext.request.contextPath}/admin-editProductVariant" method="post" enctype="multipart/form-data" onsubmit="return validateForm();">

    <input type="hidden" name="variant_id" value="<%= variant.getProductVariantId() %>"/>

    <!-- Sản phẩm -->
    <div class="mb-3">
        <label for="product_id" class="form-label">Sản phẩm <span class="text-danger">*</span></label>
        <select class="form-select" name="product_id" id="product_id" required>
            <option value="">-- Chọn sản phẩm --</option>
            <% for (Product p : products) { %>
                <option value="<%= p.getProductId() %>" <%= (p.getProductId() == variant.getProductId()) ? "selected" : "" %>>
                    <%= p.getProductName() %>
                </option>
            <% } %>
        </select>
    </div>

    <!-- Khối lượng -->
    <div class="mb-3">
        <label for="weight_id" class="form-label">Khối lượng <span class="text-danger">*</span></label>
        <select class="form-select" name="weight_id" id="weight_id" required>
            <option value="">-- Chọn khối lượng --</option>
            <% for (ProductVariantWeight w : weights) { %>
                <option value="<%= w.getWeightId() %>" <%= (w.getWeightId() == variant.getWeightId()) ? "selected" : "" %>>
                    <%= w.getWeight() %> g
                </option>
            <% } %>
        </select>
    </div>

    <!-- Hương vị -->
    <div class="mb-3">
        <label for="flavor_id" class="form-label">Hương vị <span class="text-danger">*</span></label>
        <select class="form-select" name="flavor_id" id="flavor_id" required>
            <option value="">-- Chọn hương vị --</option>
            <% for (ProductVariantFlavor f : flavors) { %>
                <option value="<%= f.getFlavorId() %>" <%= (f.getFlavorId() == variant.getFlavorId()) ? "selected" : "" %>>
                    <%= f.getFlavor() %>
                </option>
            <% } %>
        </select>
    </div>

    <!-- Giá -->
    <div class="mb-3">
        <label for="price" class="form-label">Giá (VNĐ) <span class="text-danger">*</span></label>
        <input type="number" class="form-control" name="price" id="price" required step="0.01" min="0"
               value="<%= variant.getPrice() %>">
    </div>

    <!-- Tồn kho -->
    <div class="mb-3">
        <label for="stock_quantity" class="form-label">Số lượng trong kho <span class="text-danger">*</span></label>
        <input type="number" class="form-control" name="stock_quantity" id="stock_quantity" required min="0"
               value="<%= variant.getStockQuantity() %>">
    </div>

    <!-- Ảnh hiện tại -->
    <div class="mb-3">
        <label class="form-label">Ảnh hiện tại <span class="text-danger">*</span></label><br>
        <% if (variant.getImage() != null && !variant.getImage().isEmpty()) { %>
            <img src="<%= variant.getImage() %>" alt="Ảnh sản phẩm" style="height: 100px;">
        <% } else { %>
            <p>Chưa có ảnh.</p>
        <% } %>
    </div>

    <!-- Upload ảnh mới -->
    <div class="mb-3">
        <label for="imageFile" class="form-label">Chọn ảnh mới (nếu muốn thay) <span class="text-danger">*</span></label>
        <input type="file" class="form-control" name="imageFile" id="imageFile" accept="image/*">
    </div>

    <!-- Trạng thái -->
    <div class="mb-3">
        <label for="status" class="form-label">Trạng thái <span class="text-danger">*</span></label>
        <select class="form-select" name="status" id="status" required>
            <option value="1" <%= variant.isStatus() ? "selected" : "" %>>Đang bán</option>
            <option value="0" <%= !variant.isStatus() ? "selected" : "" %>>Ngừng bán</option>
        </select>
    </div>

    <!-- Nút thao tác -->
    <button type="submit" class="btn btn-success">Cập nhật</button>
    <a href="${pageContext.request.contextPath}/admin-productVariant" class="btn btn-secondary ms-2">Hủy</a>
</form>

<script>
    function validateForm() {
        const price = parseFloat(document.getElementById("price").value);
        const quantity = parseInt(document.getElementById("stock_quantity").value);

        if (isNaN(price) || price < 0) {
            alert("Giá phải lớn hơn hoặc bằng 0.");
            return false;
        }

        if (isNaN(quantity) || quantity < 0) {
            alert("Số lượng phải lớn hơn hoặc bằng 0.");
            return false;
        }

        return true;
    }
</script>

</body>
</html>
