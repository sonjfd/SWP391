<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Model.ProductVariant" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
    <head>
        <meta charset="UTF-8">
        <title>Biến thể sản phẩm</title>
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" />
        <style>
            img.thumbnail {
                width: 50px;
                height: 50px;
                object-fit: cover;
                border-radius: 5px;
            }
        </style>
    </head>
    <body>
        <%@ include file="../layout/Header.jsp" %>

        <div class="container mt-6 pt-4" style="margin-top: 50px;">
            <h2 class="mb-4">Danh sách biến thể sản phẩm</h2>

            <!-- Thông báo lỗi nếu có -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <a href="${pageContext.request.contextPath}/addProductVariant" class="btn btn-primary mb-3">+ Thêm biến thể</a>

            <table class="table table-bordered table-hover">
                <thead class="table-light">
                    <tr class="text-center">
                        <th>ID</th>
                        <th>Sản phẩm</th>
                        <th>Tên biến thể</th>
                        <th>Khối lượng</th>
                        <th>Hương vị</th>
                        <th>Giá</th>
                        <th>Tồn kho</th>
                        <th>Ảnh</th>
                        <th>Trạng thái</th>
                        <th>Ngày tạo</th>
                        <th>Ngày cập nhật</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty variants}">
                            <tr>
                                <td colspan="12" class="text-center text-muted py-4">
                                    Không có dữ liệu biến thể sản phẩm.
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="v" items="${variants}">
                                <tr class="text-center align-middle">
                                    <td>${v.productVariantId}</td>
                                    <td>${v.productName}</td>
                                    <td>${v.variantName}</td>
                                    <td>${v.weight}g</td>
                                    <td>${v.flavorName}</td>
                                    <td>${v.price}</td>
                                    <td>${v.stockQuantity}</td>
                                    <td>
                                        <img src="${v.image}" class="thumbnail" alt="Ảnh sản phẩm"/>
                                             
                                    </td>
                                    <td>
                                        <span class="badge bg-${v.status ? 'success' : 'danger'}">
                                            ${v.status ? 'Đang bán' : 'Ngừng bán'}
                                        </span>
                                    </td>
                                    <td>${v.createdAt}</td>
                                    <td>${v.updatedAt}</td>
                                    <td>
                                        <!-- ✅ Đã sửa đúng -->
                                        <a href="${pageContext.request.contextPath}/editProductVariant?action=edit&id=${v.productVariantId}" class="btn btn-sm btn-warning">Sửa</a>

                                        <a href="${pageContext.request.contextPath}/productVariant?action=delete&id=${v.productVariantId}"
                                           class="btn btn-sm btn-danger"
                                           onclick="return confirm('Bạn có chắc chắn muốn xoá không?')">Xoá</a>
                                           
                                           
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>

    </body>
</html>
