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

        <form action="${pageContext.request.contextPath}/addProductVariant" method="post" onsubmit="return validateForm();">

            <div class="mb-3">
                <label for="variant_name" class="form-label">Tên Biến Thể</label>
                <input type="text" class="form-control" id="variant_name" name="variant_name" required
                       value="<%= request.getParameter("variant_name") != null ? request.getParameter("variant_name") : "" %>">
            </div>

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

            <div class="mb-3">
                <label for="price" class="form-label">Giá (VNĐ)</label>
                <input type="number" class="form-control" name="price" id="price" required step="0.01" min="0"
                       value="<%= request.getParameter("price") != null ? request.getParameter("price") : "" %>">
            </div>

            <div class="mb-3">
                <label for="stock_quantity" class="form-label">Số lượng trong kho</label>
                <input type="number" class="form-control" name="stock_quantity" id="stock_quantity" required min="0"
                       value="<%= request.getParameter("stock_quantity") != null ? request.getParameter("stock_quantity") : "" %>">
            </div>

            <div class="mb-3">
                <label for="image" class="form-label">Link hình ảnh</label>
                <input type="url" class="form-control" name="image" id="image" required
                       value="<%= request.getParameter("image") != null ? request.getParameter("image") : "" %>">
            </div>

            <div class="mb-3">
                <label for="status" class="form-label">Trạng thái</label>
                <select class="form-select" name="status" id="status" required>
                    <option value="1" <%= "1".equals(request.getParameter("status")) ? "selected" : "" %>>Đang bán</option>
                    <option value="0" <%= "0".equals(request.getParameter("status")) ? "selected" : "" %>>Ngừng bán</option>
                </select>
            </div>

            <button type="submit" class="btn btn-primary">Thêm Biến Thể</button>
            <a href="${pageContext.request.contextPath}/productVariant" class="btn btn-secondary ms-2">Hủy</a>
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
