<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.Product" %>

<%
    Product p = (Product) request.getAttribute("editProduct");
    if (p == null) {
%>
    <div class="container mt-5">
        <h3 class="text-danger">Product not found!</h3>
        <a href="${pageContext.request.contextPath}/product" class="btn btn-secondary">Back to Product List</a>
    </div>
<%
    return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Product</title>
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4">Edit Product</h2>

    <form action="${pageContext.request.contextPath}/product" method="post">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="<%= p.getProductId() %>">

        <div class="mb-3">
            <label for="categoryId" class="form-label">Category ID <span class="text-danger">*</span></label>
            <input type="number" class="form-control" id="categoryId" name="categoryId" value="<%= p.getCategoryId() %>" required>
        </div>

        <div class="mb-3">
            <label for="supplierId" class="form-label">Supplier ID <span class="text-danger">*</span></label>
            <input type="number" class="form-control" id="supplierId" name="supplierId" value="<%= p.getSupplierId() %>" required>
        </div>

        <div class="mb-3">
            <label for="productName" class="form-label">Product Name <span class="text-danger">*</span></label>
            <input type="text" class="form-control" id="productName" name="productName" value="<%= p.getProductName() %>" required>
        </div>

        <div class="mb-3">
            <label for="description" class="form-label">Description <span class="text-danger">*</span></label>
            <textarea class="form-control" id="description" name="description" rows="3" required><%= p.getDescription() %></textarea>
        </div>

        <div class="mb-3">
            <label for="image" class="form-label">Image URL <span class="text-danger">*</span></label>
            <input type="text" class="form-control" id="image" name="image" value="<%= p.getImage() %>" required>
        </div>

        <button type="submit" class="btn btn-primary">Update</button>
        <a href="${pageContext.request.contextPath}/product" class="btn btn-secondary">Cancel</a>
    </form>
</div>
</body>
</html>