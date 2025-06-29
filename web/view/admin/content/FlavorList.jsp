<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="Model.ProductVariantFlavor" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Đơn vị hương vị</title>
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" />
</head>
<body>
<%@ include file="../layout/Header.jsp" %>

<div class="container-fluid">
    <div class="layout-specing">
        <h5 class="mb-3">Đơn vị hương vị</h5>

        <!-- Form tìm kiếm -->
        <form method="get" action="admin-productVariantFlavor" class="mb-3 d-flex align-items-center justify-content-between w-100">
            <input type="hidden" name="action" value="list" />

            <div>
                <a href="admin-productVariantFlavor?action=add" class="btn btn-primary">+ Thêm hương vị</a>
            </div>

            <div class="d-flex align-items-center gap-2">
                <div>
                    <input type="text" class="form-control" name="keyword" placeholder="Nhập tên hương vị"
                           value="${param.flavor != null ? param.flavor : ''}">
                </div>

                <div>
                    <select class="form-select" name="status">
                        <option value="">Tất cả trạng thái</option>
                        <option value="1" ${param.status == '1' ? 'selected' : ''}>Đang bán</option>
                        <option value="0" ${param.status == '0' ? 'selected' : ''}>Ngừng bán</option>
                    </select>
                </div>

                <div>
                    <button type="submit" class="btn btn-primary">Tìm kiếm</button>
                </div>
            </div>
        </form>

        <!-- Bảng -->
        <table class="table table-bordered table-hover align-middle">
            <thead class="table-primary text-center">
            <tr>
                <th>ID</th>
                <th>Tên hương vị</th>
                <th>Trạng thái</th>
                <th>Hành động</th>
            </tr>
            </thead>
            <tbody>
            <%
                List<ProductVariantFlavor> list = (List<ProductVariantFlavor>) request.getAttribute("list");
                if (list != null && !list.isEmpty()) {
                    for (ProductVariantFlavor f : list) {
            %>
            <tr class="text-center">
                <td><%= f.getFlavorId() %></td>
                <td><%= f.getFlavor() %></td>
                <td>
                    <span class="badge bg-<%= f.isStatus() ? "success" : "secondary" %>">
                        <%= f.isStatus() ? "Đang bán" : "Ngừng bán" %>
                    </span>
                </td>
                <td>
                    <a href="admin-productVariantFlavor?action=edit&id=<%= f.getFlavorId() %>" class="btn btn-sm btn-warning">Sửa</a>

                    <% if (f.isStatus()) { %>
                    <a href="admin-productVariantFlavor?action=hide&id=<%= f.getFlavorId() %>"
                       class="btn btn-sm btn-danger"
                       onclick="return confirm('Bạn có chắc chắn muốn NGỪNG BÁN hương vị này không?');">
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
                <td colspan="4" class="text-center">Không có dữ liệu.</td>
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

            if (currentPage != null && totalPage != null && totalPage > 1) {
                String queryFlavor = request.getParameter("flavor") != null ? "&flavor=" + request.getParameter("flavor") : "";
                String queryStatus = request.getParameter("status") != null ? "&status=" + request.getParameter("status") : "";
        %>
        <nav class="mt-3">
            <ul class="pagination justify-content-center">
                <li class="page-item <%= (currentPage == 1) ? "disabled" : "" %>">
                    <a class="page-link" href="admin-productVariantFlavor?action=list&page=<%= currentPage - 1 %><%= queryFlavor + queryStatus %>">Trước</a>
                </li>
                <% for (int i = 1; i <= totalPage; i++) { %>
                <li class="page-item <%= (i == currentPage) ? "active" : "" %>">
                    <a class="page-link" href="admin-productVariantFlavor?action=list&page=<%= i %><%= queryFlavor + queryStatus %>"><%= i %></a>
                </li>
                <% } %>
                <li class="page-item <%= (currentPage == totalPage) ? "disabled" : "" %>">
                    <a class="page-link" href="admin-productVariantFlavor?action=list&page=<%= currentPage + 1 %><%= queryFlavor + queryStatus %>">Sau</a>
                </li>
            </ul>
        </nav>
        <%
            }
        %>

    </div>
</div>

<script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
</body>
</html>
