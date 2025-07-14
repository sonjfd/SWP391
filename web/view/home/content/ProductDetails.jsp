<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Chi Tiết Sản Phẩm</title>
        <!-- CSS & Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico.png">
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" />

        <style>
            body {
                background-color: #f8f9fa;
            }
            .selected {
                border: 2px solid #0d6efd !important;
                background-color: #e7f1ff !important;
            }
            .btn-variant {
                min-width: 100px;
                font-weight: 500;
            }
            .price-current {
                font-size: 1.5rem;
                color: #dc3545;
                font-weight: bold;
            }
            .stock.out {
                color: red;
                font-weight: 500;
            }
            .stock.available {
                color: #198754;
                font-weight: 500;
            }
        </style>
    </head>
    <body>
        <%@include file="../layout/Header.jsp" %>

        <div class="container my-5 d-flex justify-content-center">
            <div class="row w-100" style="max-width: 1000px;">
                <div class="col-md-5">
                    <img src="${selectedVariant.image}" alt="${selectedVariant.productName}" class="img-fluid rounded shadow" id="variantImage">
                </div>
                <div class="col-md-7">
                    <h2 class="product-title mb-3" id="productName">${selectedVariant.productName}</h2>
                    <div class="mb-3">
                        <span class="price-current">
                            <fmt:formatNumber value="${selectedVariant.price}" type="number" groupingUsed="true"/> VNĐ
                        </span>
                        <c:choose>
                            <c:when test="${selectedVariant.stockQuantity == 0}">
                                <span class="ms-3 stock out">Hết hàng</span>
                            </c:when>
                            <c:otherwise>
                                <span class="ms-3 stock available">Số lượng: ${selectedVariant.stockQuantity}</span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <input type="hidden" id="productId" value="${selectedVariant.productId}" />
                    <input type="hidden" id="maxStock" value="${selectedVariant.stockQuantity}" />

                    <!-- Hương vị -->
                    <div class="mb-3">
                        <label class="form-label">Hương vị:</label><br>
                        <c:forEach var="f" items="${flavors}">
                            <a href="product-details?productid=${selectedVariant.productId}&flavorId=${f.flavorId}"
                               class="btn btn-outline-primary btn-variant me-2 mb-2
                               <c:if test='${f.flavorId == selectedVariant.flavorId}'>selected</c:if>">
                                ${f.flavor}
                            </a>
                        </c:forEach>
                    </div>

                    <!-- Trọng lượng -->
                    <div class="mb-3">
                        <label class="form-label">Trọng lượng:</label><br>
                        <c:forEach var="w" items="${weights}">
                            <a href="product-details?productid=${selectedVariant.productId}&flavorId=${selectedVariant.flavorId}&weightId=${w.weightId}"
                               class="btn btn-outline-secondary btn-variant me-2 mb-2
                               <c:if test='${w.weightId == selectedVariant.weightId}'>selected</c:if>">
                                ${w.weight}
                            </a>
                        </c:forEach>
                    </div>



                    <form action="user-add-to-cart" method="post" class="mb-4">
                        <input type="hidden" name="variantId" value="${selectedVariant.productVariantId}" />

                        <div class="row mb-3">
                            <div class="col-md-4">
                                <label class="form-label">Số lượng</label>
                                <input type="number"
                                       id="quantityInput"
                                       name="quantity"
                                       value="1"
                                       min="1"
                                       max="${selectedVariant.stockQuantity}"
                                       class="form-control"
                                       <c:if test="${selectedVariant.stockQuantity == 0}">disabled</c:if> />
                                       <div class="form-text text-danger d-none" id="quantityError">
                                           Số lượng vượt quá tồn kho.
                                       </div>
                                </div>
                            </div>

                            <button type="submit"
                                    class="btn btn-primary"
                            <c:if test="${selectedVariant.stockQuantity == 0}">disabled</c:if>>
                                Thêm vào giỏ hàng
                            </button>
                        </form>

                    </div>
                </div>
            </div>

        <%@include file="../layout/Footer.jsp" %>

        <!-- JS validate -->
        <script>
            document.addEventListener("DOMContentLoaded", () => {
                const maxStock = parseInt(document.getElementById("maxStock").value);
                const quantityInput = document.getElementById("quantityInput");
                const errorText = document.getElementById("quantityError");

                if (quantityInput) {
                    quantityInput.addEventListener("input", () => {
                        const value = parseInt(quantityInput.value);
                        if (value > maxStock) {
                            errorText.classList.remove("d-none");
                            quantityInput.classList.add("is-invalid");
                        } else {
                            errorText.classList.add("d-none");
                            quantityInput.classList.remove("is-invalid");
                        }
                    });
                }
            });
        </script>

        <!-- JS thư viện -->
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/counter.init.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>

    </body>
</html>
