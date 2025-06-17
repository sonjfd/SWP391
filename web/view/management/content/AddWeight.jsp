<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm trọng lượng biến thể</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script>
        function validateForm() {
            const variantId = document.getElementById("variantId").value.trim();
            const weight = document.getElementById("weight").value.trim();
            let errors = [];

            if (!variantId) {
                errors.push("Vui lòng chọn một biến thể.");
            }

            if (!weight || isNaN(weight) || parseFloat(weight) <= 0) {
                errors.push("Trọng lượng phải là số dương.");
            }

            if (errors.length > 0) {
                alert(errors.join("\n"));
                return false;
            }

            return true;
        }
    </script>
</head>
<body class="container mt-4">

    <h2 class="mb-4">Thêm trọng lượng cho biến thể sản phẩm</h2>

    <form action="productVariantWeight" method="post" onsubmit="return validateForm();">
        <input type="hidden" name="action" value="add">

        <div class="mb-3">
            <label for="variantId" class="form-label">Chọn biến thể</label>
            <select class="form-select" id="variantId" name="variantId" required>
                <option value="">-- Chọn biến thể sản phẩm --</option>
                <c:forEach var="v" items="${variantList}">
                    <option value="${v.productVariantId}">
                        ${v.productName} - ${v.variantName}
                    </option>
                </c:forEach>
            </select>
        </div>

        <div class="mb-3">
            <label for="weight" class="form-label">Trọng lượng (gram)</label>
            <input type="number" step="0.01" class="form-control" id="weight" name="weight" required>
        </div>

        <button type="submit" class="btn btn-success">Thêm</button>
        <a href="productVariantWeight" class="btn btn-secondary">Quay lại</a>
    </form>

</body>
</html>
