<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Model.Category" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>Quản lí danh mục</title>
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" />
    </head>
    <body>
        <%@include file="../layout/Header.jsp" %>

        <div class="container-fluid">
            <div class="layout-specing">
                <h5 class="mb-3">Quản lí danh mục</h5>

                <!-- Hiển thị thông báo -->
                <%
                    String message = (String) session.getAttribute("message");
                    String error = (String) session.getAttribute("error");
                    if (message != null) {
                %>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <%= message %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <%
                        session.removeAttribute("message");
                    }
                    if (error != null) {
                %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <%= error %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <%
                        session.removeAttribute("error");
                    }
                %>

                <!-- Form lọc theo trạng thái -->
                <form method="get" action="admin-category" class="mb-3 d-flex align-items-center justify-content-between w-100">
                    <!-- Bên trái: nút thêm -->
                    <a href="${pageContext.request.contextPath}/admin-category?action=addForm" class="btn btn-success">+ Thêm danh mục</a>

                    <!-- Bên phải: bộ lọc -->
                    <div class="d-flex align-items-center gap-2">
                        <select name="status" class="form-select w-auto">
                            <option value="">Tất cả trạng thái</option>
                            <option value="1" <%= "1".equals(request.getParameter("status")) ? "selected" : "" %>>Hiển thị</option>
                            <option value="0" <%= "0".equals(request.getParameter("status")) ? "selected" : "" %>>Đã ẩn</option>
                        </select>
                        <button type="submit" class="btn btn-primary">Lọc</button>
                    </div>
                </form>

                <!-- Bảng dữ liệu -->
                <table class="table table-bordered">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Tên</th>
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
                        <tr>
                            <td><%= c.getCategoryId() %></td>
                            <td><%= c.getCategoryName() %></td>
                            <td><%= c.getDescription() %></td>
                            <td><%= c.isStatus() ? "Hiển thị" : "Đã ẩn" %></td>
                            <td>
                                <a href="admin-category?action=edit&id=<%= c.getCategoryId() %>" class="btn btn-warning btn-sm">Sửa</a>
                                <form method="get" action="admin-category" style="display:inline-block;" 
                                      onsubmit="return confirm('Bạn có chắc chắn muốn ẩn danh mục này không?');">
                                    <input type="hidden" name="action" value="delete" />
                                    <input type="hidden" name="id" value="<%= c.getCategoryId() %>" />
                                    <button type="submit" class="btn btn-danger btn-sm">Ẩn</button>
                                </form>
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="5" class="text-center">Không tìm thấy danh mục nào.</td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
            <%
Integer currentPage = (Integer) request.getAttribute("currentPage");
Integer totalPage = (Integer) request.getAttribute("totalPage");
String statusParam = (String) request.getAttribute("status");
String queryStatus = (statusParam != null && !statusParam.isEmpty()) ? "&status=" + statusParam : "";
if (currentPage != null && totalPage != null && totalPage > 1) {
            %>
            <!-- PHÂN TRANG -->
            <nav aria-label="Page navigation" class="mt-4">
                <ul class="pagination justify-content-center">
                    <li class="page-item <%= currentPage == 1 ? "disabled" : "" %>">
                        <a class="page-link" href="admin-category?page=<%= currentPage - 1 %><%= queryStatus %>">Trước</a>
                    </li>
                    <% for (int i = 1; i <= totalPage; i++) { %>
                    <li class="page-item <%= (i == currentPage) ? "active" : "" %>">
                        <a class="page-link" href="admin-category?page=<%= i %><%= queryStatus %>"><%= i %></a>
                    </li>
                    <% } %>
                    <li class="page-item <%= currentPage == totalPage ? "disabled" : "" %>">
                        <a class="page-link" href="admin-category?page=<%= currentPage + 1 %><%= queryStatus %>">Sau</a>
                    </li>
                </ul>
            </nav>
            <% } %>
        </div>

        <!-- JavaScript -->
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>

    </body>
</html>
