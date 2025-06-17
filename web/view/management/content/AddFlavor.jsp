<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="Model.ProductVariant" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thêm Hương vị</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script>
        function validateForm() {
            const flavor = document.getElementById("flavor").value.trim();
            if (flavor.length === 0) {
                alert("Vui lòng nhập tên hương vị.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body class="container mt-4">
    <h2 class="mb-4">Thêm Hương vị</h2>

    <form action="productVariantFlavor" method="post" onsubmit="return validateForm();">
        <input type="hidden" name="action" value="add">

        <div class="mb-3">
            <label for="variantId" class="form-label">Chọn Biến thể</label>
            <select class="form-select" id="variantId" name="variantId" required>
                <%
                    List<ProductVariant> variantList = (List<ProductVariant>) request.getAttribute("variantList");
                    for (ProductVariant v : variantList) {
                %>
                    <option value="<%= v.getProductVariantId() %>"><%= v.getVariantName() %> (ID: <%= v.getProductVariantId() %>)</option>
                <%
                    }
                %>
            </select>
        </div>

        <div class="mb-3">
            <label for="flavor" class="form-label">Tên hương vị</label>
            <input type="text" class="form-control" id="flavor" name="flavor" maxlength="50" required>
        </div>

        <button type="submit" class="btn btn-primary">Thêm</button>
        <a href="productVariantFlavor" class="btn btn-secondary">Quay lại</a>
    </form>
</body>
</html>