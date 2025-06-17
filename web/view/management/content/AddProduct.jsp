<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Add Product</title>
        <!-- Bootstrap 5 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-5">
            <h2 class="mb-4">Add New Product</h2>

            <!-- Sử dụng context path để form hoạt động đúng với mọi tên project -->
            <form action="${pageContext.request.contextPath}/product" method="post">
                <input type="hidden" name="action" value="add">

                <div class="mb-3">
                    <label for="categoryId" class="form-label">Category ID <span class="text-danger">*</span></label>
                    <input type="number" class="form-control" id="categoryId" name="categoryId" required="">
                </div>

                <div class="mb-3">
                    <label for="supplierId" class="form-label">Supplier ID <span class="text-danger">*</span></label>
                    <input type="number" class="form-control" id="supplierId" name="supplierId" required="">
                </div>

                <div class="mb-3">
                    <label for="productName" class="form-label">Product Name <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" id="productName" name="productName" required="">
                </div>

                <div class="mb-3">
                    <label for="description" class="form-label">Description <span class="text-danger">*</span></label>
                    <textarea class="form-control" id="description" name="description" rows="3" required=""></textarea>
                </div>

                <div class="mb-3">
                    <label for="image" class="form-label">Image URL<span class="text-danger">*</span></label>
                    <input type="text" class="form-control" id="image" name="image" required="">
                </div>

                <button type="submit" class="btn btn-success">Save</button>
                <a href="${pageContext.request.contextPath}/product" class="btn btn-secondary">Cancel</a>
            </form>
        </div>

        
    </body>
</html>
