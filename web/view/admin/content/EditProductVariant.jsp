<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Pet24h - Chỉnh sửa Biến Thể Sản Phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">

<h2>Chỉnh sửa Biến Thể Sản Phẩm</h2>

<c:if test="${not empty error}">
    <div class="alert alert-danger">${error}</div>
</c:if>

<form action="${pageContext.request.contextPath}/admin-editProductVariant" method="post" enctype="multipart/form-data" onsubmit="return validateForm();">

    <input type="hidden" name="variant_id" value="${variant.productVariantId}"/>

    <!-- Sản phẩm -->
    <div class="mb-3">
        <label for="product_id" class="form-label">Sản phẩm <span class="text-danger">*</span></label>
        <select class="form-select" name="product_id" id="product_id" required>
            <option value="">-- Chọn sản phẩm --</option>
            <c:forEach var="p" items="${products}">
                <option value="${p.productId}" ${p.productId == variant.productId ? 'selected' : ''}>
                    ${p.productName}
                </option>
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
                    <option value="${w.weightId}" ${w.weightId == variant.weightId ? 'selected' : ''}>
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
                    <option value="${f.flavorId}" ${f.flavorId == variant.flavorId ? 'selected' : ''}>
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
               value="${variant.price}">
    </div>

    <!-- Tồn kho -->
    <div class="mb-3">
        <label for="stock_quantity" class="form-label">Số lượng trong kho <span class="text-danger">*</span></label>
        <input type="number" class="form-control" name="stock_quantity" id="stock_quantity" required min="0"
               value="${variant.stockQuantity}">
    </div>

    <!-- Ảnh hiện tại -->
    <div class="mb-3">
        <label class="form-label">Ảnh hiện tại</label><br>
        <c:choose>
            <c:when test="${not empty variant.image}">
                <img src="${variant.image}" alt="Ảnh sản phẩm" style="height: 100px;">
            </c:when>
            <c:otherwise>
                <p>Chưa có ảnh.</p>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Ảnh mới -->
    <div class="mb-3">
        <label for="imageFile" class="form-label">Chọn ảnh mới (nếu muốn thay)</label>
        <input type="file" class="form-control" name="imageFile" id="imageFile" accept="image/*">
    </div>

    <!-- Trạng thái -->
    <div class="mb-3">
        <label for="status" class="form-label">Trạng thái <span class="text-danger">*</span></label>
        <select class="form-select" name="status" id="status" required>
            <option value="1" ${variant.status ? 'selected' : ''}>Đang bán</option>
            <option value="0" ${!variant.status ? 'selected' : ''}>Ngừng bán</option>
        </select>
    </div>

    <!-- Nút -->
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
