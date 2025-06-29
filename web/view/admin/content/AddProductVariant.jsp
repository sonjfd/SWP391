<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Product" %>
<%@ page import="Model.ProductVariantWeight" %>
<%@ page import="Model.ProductVariantFlavor" %>

<%
    List<Product> products = (List<Product>) request.getAttribute("products");
    List<ProductVariantWeight> weights = (List<ProductVariantWeight>) request.getAttribute("weights");
    List<ProductVariantFlavor> flavors = (List<ProductVariantFlavor>) request.getAttribute("flavors");
    String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm Biến Thể Sản Phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">

<h2>Thêm Biến Thể Sản Phẩm</h2>

<% if (error != null) { %>
    <div class="alert alert-danger"><%= error %></div>
<% } %>

<form action="${pageContext.request.contextPath}/admin-addProductVariant"
      method="post" enctype="multipart/form-data" onsubmit="return validateForm();">

    <!-- Sản phẩm -->
    <div class="mb-3">
        <label for="product_id" class="form-label">Sản phẩm</label>
        <select class="form-select" name="product_id" id="product_id" required>
            <option value="">-- Chọn sản phẩm --</option>
            <%
                String selectedProduct = request.getParameter("product_id");
                for (Product p : products) {
                    String selected = (p.getProductId() + "").equals(selectedProduct) ? "selected" : "";
            %>
            <option value="<%= p.getProductId() %>" <%= selected %>><%= p.getProductName() %></option>
            <% } %>
        </select>
    </div>

    <!-- Khối lượng -->
    <div class="mb-3">
        <label for="weight_id" class="form-label">Khối lượng</label>
        <select class="form-select" name="weight_id" id="weight_id" required>
            <option value="">-- Chọn khối lượng --</option>
            <%
                String selectedWeight = request.getParameter("weight_id");
                for (ProductVariantWeight w : weights) {
                    String selected = (w.getWeightId() + "").equals(selectedWeight) ? "selected" : "";
            %>
            <option value="<%= w.getWeightId() %>" <%= selected %>><%= w.getWeight() %> g</option>
            <% } %>
        </select>
    </div>

    <!-- Hương vị -->
    <div class="mb-3">
        <label for="flavor_id" class="form-label">Hương vị</label>
        <select class="form-select" name="flavor_id" id="flavor_id" required>
            <option value="">-- Chọn hương vị --</option>
            <%
                String selectedFlavor = request.getParameter("flavor_id");
                for (ProductVariantFlavor f : flavors) {
                    String selected = (f.getFlavorId() + "").equals(selectedFlavor) ? "selected" : "";
            %>
            <option value="<%= f.getFlavorId() %>" <%= selected %>><%= f.getFlavor() %></option>
            <% } %>
        </select>
    </div>

    <!-- Giá -->
    <div class="mb-3">
        <label for="price" class="form-label">Giá (VNĐ)</label>
        <input type="number" class="form-control" name="price" id="price" required step="0.01" min="0"
               value="<%= request.getParameter("price") != null ? request.getParameter("price") : "" %>">
    </div>

    <!-- Tồn kho -->
    <div class="mb-3">
        <label for="stock_quantity" class="form-label">Số lượng trong kho</label>
        <input type="number" class="form-control" name="stock_quantity" id="stock_quantity" required min="0"
               value="<%= request.getParameter("stock_quantity") != null ? request.getParameter("stock_quantity") : "" %>">
    </div>

    <!-- Upload ảnh -->
    <div class="mb-3">
        <label for="imageFile" class="form-label">Ảnh sản phẩm</label>
        <input type="file" class="form-control" name="imageFile" id="imageFile" accept="image/*" required>
    </div>

    <!-- Xem trước ảnh -->
    <div class="mb-3">
        <img id="preview" src="#" alt="Xem trước ảnh" style="max-height: 200px; display: none; border: 1px solid #ccc;" />
    </div>

    <!-- Trạng thái -->
    <div class="mb-3">
        <label for="status" class="form-label">Trạng thái</label>
        <select class="form-select" name="status" id="status" required>
            <option value="1" <%= "1".equals(request.getParameter("status")) ? "selected" : "" %>>Đang bán</option>
            <option value="0" <%= "0".equals(request.getParameter("status")) ? "selected" : "" %>>Ngừng bán</option>
        </select>
    </div>

    <!-- Nút thao tác -->
    <button type="submit" class="btn btn-primary">Thêm Biến Thể</button>
    <a href="${pageContext.request.contextPath}/admin-productVariant" class="btn btn-secondary ms-2">Hủy</a>
</form>

<!-- JS preview ảnh -->
<script>
    document.getElementById("imageFile").addEventListener("change", function (event) {
        const preview = document.getElementById("preview");
        const file = event.target.files[0];
        if (file) {
            preview.src = URL.createObjectURL(file);
            preview.style.display = "block";
        } else {
            preview.src = "#";
            preview.style.display = "none";
        }
    });

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
