<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="Model.Product" %>

<%
    List<Product> productList = (List<Product>) request.getAttribute("list");
    String keyword = request.getParameter("keyword") != null ? request.getParameter("keyword") : "";
    int currentPage = request.getAttribute("currentPage") != null ? (int) request.getAttribute("currentPage") : 1;
    int totalPages = request.getAttribute("totalPages") != null ? (int) request.getAttribute("totalPages") : 1;
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Quản lý Sản phẩm</title>
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
        </style>
    </head>
    <body>
        <%@ include file="../layout/Header.jsp" %>

        <div class="container mt-5 pt-5">
            <h5 class="mb-4">Danh sách sản phẩm</h5>

            <div class="d-flex justify-content-between align-items-center mb-3">
                <a href="${pageContext.request.contextPath}/admin-product?action=addForm" class="btn btn-primary">
                    + Thêm sản phẩm
                </a>

                <form action="admin-product" method="get" class="d-flex" style="width: 250px;">
                    <input type="text" name="keyword" value="<%= keyword %>" class="form-control custom-input" placeholder="Tìm theo tên" />
                    <button type="submit" class="btn btn-primary ms-2">Tìm</button>
                </form>
            </div>

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
                    <%
                        if (productList != null && !productList.isEmpty()) {
                            for (Product p : productList) {
                    %>
                    <tr>
                        <td class="text-center"><%= p.getProductId() %></td>
                        <td><%= p.getCategory() != null ? p.getCategory().getCategoryName() : "N/A" %></td>
                        <td><%= p.getProductName() %></td>
                        <td><%= p.getDescription() %></td>
                        <td class="text-center"><%= p.getCreatedAt().toLocalDateTime().toLocalDate() %></td>
                        <td class="text-center"><%= p.getUpdatedAt().toLocalDateTime().toLocalDate() %></td>
                        <td class="text-center">
                            <a href="admin-product?action=edit&id=<%= p.getProductId() %>" class="btn btn-warning btn-sm">Sửa</a>
                            <a href="admin-product?action=delete&id=<%= p.getProductId() %>" class="btn btn-danger btn-sm"
                               onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm không?');">Xóa</a>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="7" class="text-center">Không có sản phẩm nào.</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>

            <!-- PHÂN TRANG -->
            <nav class="mt-3 d-flex justify-content-center">
                <ul class="pagination">
                    <li class="page-item <%= (currentPage == 1) ? "disabled" : "" %>">
                        <a class="page-link" href="admin-product?page=<%= currentPage - 1 %><%= !keyword.isEmpty() ? "&keyword=" + keyword : "" %>">Trước</a>
                    </li>

                    <%
                        for (int i = 1; i <= totalPages; i++) {
                            String activeClass = (i == currentPage) ? "active" : "";
                    %>
                    <li class="page-item <%= activeClass %>">
                        <a class="page-link"
                           href="admin-product?page=<%= i %><%= !keyword.isEmpty() ? "&keyword=" + keyword : "" %>"><%= i %></a>
                    </li>
                    <%
                        }
                    %>

                    <li class="page-item <%= (currentPage == totalPages) ? "disabled" : "" %>">
                        <a class="page-link" href="admin-product?page=<%= currentPage + 1 %><%= !keyword.isEmpty() ? "&keyword=" + keyword : "" %>">Sau</a>
                    </li>
                </ul>
            </nav>
        </div>
    </body>
</html>
