<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thêm Biến Thể Sản Phẩm</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="container mt-5">

        <h2>Thêm Biến Thể Sản Phẩm</h2>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/admin-addProductVariant"
              method="post" enctype="multipart/form-data" onsubmit="return validateForm();">

            <!-- Sản phẩm -->
            <div class="mb-3">
                <label for="product_id" class="form-label">Sản phẩm <span class="text-danger">*</span></label>
                <select class="form-select" name="product_id" id="product_id" required>
                    <option value="">-- Chọn sản phẩm --</option>
                    <c:forEach var="p" items="${products}">
                        <option value="${p.productId}" ${p.productId == param.product_id ? 'selected' : ''}>${p.productName}</option>
                    </c:forEach>
                </select>
            </div>

            <!-- Khối lượng -->
            <div class="mb-3">
                <label for="weight_id" class="form-label">Khối lượng <span class="text-danger">*</span></label>
                <select class="form-select" name="weight_id" id="weight_id" required>
                    <option value="">-- Chọn khối lượng --</option>
                    <c:forEach var="w" items="${weights}">
                        <c:if test="${w.status}">
                            <option value="${w.weightId}" ${w.weightId == param.weight_id ? 'selected' : ''}>
                                ${w.weight} g
                            </option>
                        </c:if>
                    </c:forEach>
                </select>
            </div>


            <!-- Hương vị -->
            <div class="mb-3">
                <label for="flavor_id" class="form-label">Hương vị <span class="text-danger">*</span></label>
                <select class="form-select" name="flavor_id" id="flavor_id" required>
                    <option value="">-- Chọn hương vị --</option>
                    <c:forEach var="f" items="${flavors}">
                        <c:if test="${f.status}">
                            <option value="${f.flavorId}" ${f.flavorId == param.flavor_id ? 'selected' : ''}>
                                ${f.flavor}
                            </option>
                        </c:if>
                    </c:forEach>
                </select>
            </div>


            <!-- Giá -->
            <div class="mb-3">
                <label for="price" class="form-label">Giá (VNĐ) <span class="text-danger">*</span></label>
                <input type="number" class="form-control" name="price" id="price" required step="0.01" min="0"
                       value="${param.price}">
            </div>

            <!-- Tồn kho -->
            <div class="mb-3">
                <label for="stock_quantity" class="form-label">Số lượng trong kho <span class="text-danger">*</span></label>
                <input type="number" class="form-control" name="stock_quantity" id="stock_quantity" required min="0"
                       value="${param.stock_quantity}">
            </div>

            <!-- Upload ảnh -->
            <div class="mb-3">
                <label for="imageFile" class="form-label">Ảnh sản phẩm <span class="text-danger">*</span></label>
                <input type="file" class="form-control" name="imageFile" id="imageFile" accept="image/*" required>
            </div>

            <!-- Xem trước ảnh -->
            <div class="mb-3">
                <img id="preview" src="#" alt="Xem trước ảnh" style="max-height: 200px; display: none; border: 1px solid #ccc;" />
            </div>

            <!-- Trạng thái -->
            <div class="mb-3">
                <label for="status" class="form-label">Trạng thái <span class="text-danger">*</span></label>
                <select class="form-select" name="status" id="status" required>
                    <option value="1" ${param.status == '1' ? 'selected' : ''}>Đang bán</option>
                    <option value="0" ${param.status == '0' ? 'selected' : ''}>Ngừng bán</option>
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
