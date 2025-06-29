<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Model.ProductVariant" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
            th, td {
                white-space: nowrap;
                vertical-align: middle;
                font-size: 14px;
                padding: 0.75rem 1rem;
            }
            .table-wrapper {
                width: 100%;
                overflow-x: auto;
            }
        </style>
    </head>
    <body>
        <%@ include file="../layout/Header.jsp" %>

        <div class="container-fluid mt-6 pt-4" style="margin-top: 50px;">
            <h5 class="mb-4">Danh sách biến thể sản phẩm</h5>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <!-- Form tìm kiếm và lọc -->
            <form method="get" action="admin-productVariant" class="row g-3 mb-4">
                <input type="hidden" name="action" value="list">

                <!-- Nút Thêm bên trái -->
                <div class="col-md-3">
                    <a href="admin-productVariant?action=add" class="btn btn-primary w-100">+ Thêm biến thể</a>
                </div>

                <!-- Phần tìm kiếm bên phải -->
                <div class="col-md-9">
                    <div class="d-flex justify-content-end gap-2">
                        <input type="text" name="keyword" class="form-control" placeholder="Tìm theo tên sản phẩm"
                               value="${param.keyword}" style="max-width: 300px;">
                        <select name="status" class="form-select" style="max-width: 200px;">
                            <option value="">Tất cả trạng thái</option>
                            <option value="1" ${param.status == '1' ? 'selected' : ''}>Đang bán</option>
                            <option value="0" ${param.status == '0' ? 'selected' : ''}>Ngừng bán</option>
                        </select>
                        <button class="btn btn-primary" type="submit">Tìm Kiếm</button>
                    </div>
                </div>
            </form>

            <div class="table-wrapper">
                <table class="table table-bordered table-hover align-middle text-center" style="min-width: 1200px;">
                    <thead class="table-primary">
                        <tr>
                            <th>ID</th>
                            <th>Sản phẩm</th>
                            <th>Danh mục</th>
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
                                    <td colspan="12" class="text-center text-muted py-4">Không có dữ liệu biến thể sản phẩm.</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="v" items="${variants}">
                                    <tr>
                                        <td>${v.productVariantId}</td>
                                        <td>${v.productName}</td>
                                        <td>${v.categoryName}</td>
                                        <td>${v.weight}g</td>
                                        <td>${v.flavorName}</td>
                                        <td><fmt:formatNumber value="${v.price}" type="number" pattern="#,##0.##" /> đ</td>
                                        <td>${v.stockQuantity}</td>
                                        <td><img src="${v.image}" class="thumbnail" />
                                        </td>
                                        <td>
                                            <span class="badge bg-${v.status ? 'success' : 'danger'}">
                                                ${v.status ? 'Đang bán' : 'Ngừng bán'}
                                            </span>
                                        </td>
                                        <td><fmt:formatDate value="${v.createdAt}" pattern="yyyy-MM-dd" /></td>
                                        <td><fmt:formatDate value="${v.updatedAt}" pattern="yyyy-MM-dd" /></td>
                                        <td>
                                            <a href="admin-editProductVariant?id=${v.productVariantId}" class="btn btn-warning btn-sm">Sửa</a>
                                            <a href="admin-productVariant?action=delete&id=${v.productVariantId}"
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

            <!-- Phân trang -->
            <c:if test="${totalPage > 1}">
                <nav aria-label="Page navigation">
                    <ul class="pagination justify-content-center mt-3">

                        <!-- Nút Trước (disabled nếu đang ở trang 1) -->
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link"
                               href="admin-productVariant?action=list&page=${currentPage - 1}&keyword=${param.keyword}&status=${param.status}">
                                Trước
                            </a>
                        </li>

                        <!-- Các số trang -->
                        <c:forEach begin="1" end="${totalPage}" var="i">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link"
                                   href="admin-productVariant?action=list&page=${i}&keyword=${param.keyword}&status=${param.status}">
                                    ${i}
                                </a>
                            </li>
                        </c:forEach>

                        <!-- Nút Sau (disabled nếu đang ở trang cuối) -->
                        <li class="page-item ${currentPage == totalPage ? 'disabled' : ''}">
                            <a class="page-link"
                               href="admin-productVariant?action=list&page=${currentPage + 1}&keyword=${param.keyword}&status=${param.status}">
                                Sau
                            </a>
                        </li>

                    </ul>
                </nav>
            </c:if>
        </div>
    </body>
</html>