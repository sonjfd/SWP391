<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Model.Category" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>Pet24h - Quản lí danh mục</title>
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" />
    </head>
    <style>
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
    <body>
        <%@include file="../layout/Header.jsp" %>

        <div class="container-fluid">
            <div class="layout-specing">
                <h5 class="mb-3">Quản lí danh mục</h5>

                <!-- Thông báo -->
                <%
                    String message = (String) session.getAttribute("message");
                    String error = (String) session.getAttribute("error");
                    if (message != null) {
                %>
                <div class="alert alert-success alert-dismissible fade show mt-3" role="alert">
                    <%= message %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <%
                        session.removeAttribute("message");
                    }
                    if (error != null) {
                %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <%= error %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <%
                        session.removeAttribute("error");
                    }
                %>

                <!-- Form tìm kiếm + lọc -->
                <form method="get" action="admin-category" class="mb-3 d-flex align-items-center justify-content-between w-100">
                    <!-- Bên trái: Thêm -->
                    <a href="${pageContext.request.contextPath}/admin-category?action=addForm" class="btn btn-primary">+ Thêm danh mục</a>

                    <!-- Bên phải: Tìm kiếm + Lọc -->
                    <div class="d-flex align-items-center gap-2">
                        <input type="text" name="keyword" class="form-control" placeholder="Tìm tên danh mục"
                               value="<%= request.getParameter("keyword") != null ? request.getParameter("keyword") : "" %>" />

                        <select name="status" class="form-select w-auto">
                            <option value="">Tất cả trạng thái</option>
                            <option value="1" <%= "1".equals(request.getParameter("status")) ? "selected" : "" %>>Đang bán</option>
                            <option value="0" <%= "0".equals(request.getParameter("status")) ? "selected" : "" %>>Ngừng bán</option>
                        </select>

                        <button type="submit" class="btn btn-primary px-3 text-nowrap" style="height: 38px; min-width: 100px;">
                            Tìm kiếm
                        </button>
                    </div>

                </form>

                <!-- Bảng danh mục -->
                <table class="table table-bordered">
                    <thead class="table-primary">
                        <tr>
                            <th>ID</th>
                            <th>Tên danh mục</th>
                            <th>Giới thiệu sản phẩm</th>
                            <th>Trạng thái</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Category> list = (List<Category>) request.getAttribute("list");
                            if (list != null && !list.isEmpty()) {
                                for (Category c : list) {
                        %>
                        <tr class="text-center align-middle">
                            <td><%= c.getCategoryId() %></td>
                            <td><%= c.getCategoryName() %></td>
                            <td><%= c.getDescription() %></td>
                            <td>
                                <span class="badge bg-<%= c.isStatus() ? "success" : "secondary" %>">
                                    <%= c.isStatus() ? "Đang bán" : "Ngừng bán" %>
                                </span>
                            </td>
                            <td>
                                <a href="admin-category?action=edit&id=<%= c.getCategoryId() %>" class="btn btn-sm btn-warning">Sửa</a>

                                <% if (c.isStatus()) { %>
                                <a href="admin-category?action=hide&id=<%= c.getCategoryId() %>"
                                   class="btn btn-sm btn-danger"
                                   onclick="return confirm('Bạn có chắc chắn muốn NGỪNG BÁN danh mục này không?');">
                                    Ẩn
                                </a>
                                <% } else { %>
                                <span class="btn btn-sm btn-secondary disabled">Đã ẩn</span>
                                <% } %>
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="5" class="text-center">Không có danh mục nào.</td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>

                <!-- PHÂN TRANG -->
                <%
                    Integer currentPage = (Integer) request.getAttribute("currentPage");
                    Integer totalPage = (Integer) request.getAttribute("totalPage");
                    String keywordParam = request.getParameter("keyword");
                    String statusParam = request.getParameter("status");

                    StringBuilder extraParams = new StringBuilder();
                    if (keywordParam != null && !keywordParam.isEmpty()) {
                        extraParams.append("&keyword=").append(keywordParam);
                    }
                    if (statusParam != null && !statusParam.isEmpty()) {
                        extraParams.append("&status=").append(statusParam);
                    }

                    if (currentPage != null && totalPage != null && totalPage > 1) {
                %>
                <nav aria-label="Page navigation" class="mt-4">
                    <ul class="pagination justify-content-center">
                        <li class="page-item <%= currentPage == 1 ? "disabled" : "" %>">
                            <a class="page-link" href="admin-category?page=<%= currentPage - 1 %><%= extraParams %>">Trước</a>
                        </li>
                        <% for (int i = 1; i <= totalPage; i++) { %>
                        <li class="page-item <%= (i == currentPage) ? "active" : "" %>">
                            <a class="page-link" href="admin-category?page=<%= i %><%= extraParams %>"><%= i %></a>
                        </li>
                        <% } %>
                        <li class="page-item <%= currentPage == totalPage ? "disabled" : "" %>">
                            <a class="page-link" href="admin-category?page=<%= currentPage + 1 %><%= extraParams %>">Sau</a>
                        </li>
                    </ul>
                </nav>
                <% } %>
            </div>
        </div>

        <!-- Scripts -->
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
    </body>
</html>
