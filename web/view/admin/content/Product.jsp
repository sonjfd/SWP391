<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Pet24h - Quản lý Sản phẩm</title>
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" />
        <style>
            .custom-input:focus {
                box-shadow: none;
                border-color: #ced4da;
            }
            .pagination .page-item.active .page-link {
                background-color: #0d6efd;
                border-color: #0d6efd;
            }
            .alert {
                position: relative;
                padding-right: 3rem;
            }
            .alert .btn-close {
                position: absolute;
                top: 50%;
                right: 1rem;
                transform: translateY(-18%);
            }
        </style>
    </head>
    <body>
        <%@ include file="../layout/Header.jsp" %>

        <div class="container mt-5 pt-5">
            <h5 class="mb-4">Danh sách sản phẩm</h5>

            <!-- THÔNG BÁO -->
            <c:if test="${not empty sessionScope.message}">
                <div class="alert alert-success alert-dismissible fade show mt-3" role="alert">
                    ${sessionScope.message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="message" scope="session"/>
            </c:if>

            <c:if test="${not empty sessionScope.error}">
                <div class="alert alert-danger alert-dismissible fade show mt-3" role="alert">
                    ${sessionScope.error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="error" scope="session"/>
            </c:if>

            <!-- FORM TÌM KIẾM + THÊM -->
            <div class="d-flex justify-content-between align-items-center mb-3">
                <a href="${pageContext.request.contextPath}/admin-product?action=addForm" class="btn btn-primary">
                    + Thêm sản phẩm
                </a>

                <form action="admin-product" method="get" class="d-flex" style="width: 250px;">
                    <input type="text" name="keyword" value="${param.keyword}" class="form-control custom-input" placeholder="Tìm theo tên" />
                    <button type="submit" class="btn btn-primary ms-2">Tìm</button>
                </form>
            </div>

            <!-- BẢNG SẢN PHẨM -->
            <table class="table table-bordered table-hover align-middle">
                <thead class="table-primary text-center">
                    <tr>
                        <th>ID</th>
                        <th>Danh mục</th>
                        <th>Tên sản phẩm</th>
                        <th>Mô tả</th>
                        <th>Ngày tạo</th>
                        <th>Ngày cập nhật</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty requestScope.list}">
                            <c:forEach var="p" items="${list}">
                                <tr>
                                    <td class="text-center">${p.productId}</td>
                                    <td>${p.category != null ? p.category.categoryName : 'N/A'}</td>
                                    <td>${p.productName}</td>
                                    <td>${p.description}</td>
                                    <td class="text-center"><fmt:formatDate value="${p.createdAt}" pattern="yyyy-MM-dd"/></td>
                                    <td class="text-center"><fmt:formatDate value="${p.updatedAt}" pattern="yyyy-MM-dd"/></td>
                                    <td class="text-center">
                                        <a href="admin-product?action=edit&id=${p.productId}" class="btn btn-warning btn-sm">Sửa</a>

                                        <c:choose>
                                            <c:when test="${p.status}">
                                                <!-- Hiện nút Ẩn -->
                                                <a href="admin-product?action=delete&id=${p.productId}"
                                                   class="btn btn-outline-danger btn-sm"
                                                   onclick="return confirm('Bạn có chắc chắn muốn ẩn sản phẩm này không?');">
                                                    Ẩn
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <!-- Hiện nút Hiện -->
                                                <a href="admin-product?action=restore&id=${p.productId}"
                                                   class="btn btn-outline-success btn-sm"
                                                   onclick="return confirm('Bạn có chắc chắn muốn hiển thị lại sản phẩm này không?');">
                                                    Hiện
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="7" class="text-center">Không có sản phẩm nào.</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>

            <!-- PHÂN TRANG -->
            <c:set var="keywordParam" value="${not empty param.keyword ? '&keyword=' : ''}" />

            <ul class="pagination">
                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                    <a class="page-link" href="admin-product?page=${currentPage - 1}${keywordParam}${param.keyword}">Trước</a>
                </li>

                <c:forEach var="i" begin="1" end="${totalPages}">
                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                        <a class="page-link" href="admin-product?page=${i}${keywordParam}${param.keyword}">${i}</a>
                    </li>
                </c:forEach>

                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                    <a class="page-link" href="admin-product?page=${currentPage + 1}${keywordParam}${param.keyword}">Sau</a>
                </li>
            </ul>

        </div>

        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
