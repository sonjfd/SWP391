<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="Model.ProductVariantWeight" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="jakarta.servlet.http.*" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Đơn vị trọng lượng biến thể</title>
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" />
    </head>
    <body>
        <%@ include file="../layout/Header.jsp" %>

        <div class="container-fluid">
            <div class="layout-specing">
                <h5 class="mb-3">Đơn vị trọng lượng</h5>

                <!-- Form tìm kiếm -->
                <form method="get" action="admin-productVariantWeight" class="mb-3 d-flex align-items-center justify-content-between w-100">


                    <input type="hidden" name="action" value="list" />

                    <!-- Bên trái: nút thêm -->
                    <div>
                        <a href="admin-productVariantWeight?action=add" class="btn btn-primary">+ Thêm trọng lượng</a>
                    </div>

                    <!-- Bên phải: các input tìm kiếm -->
                    <div class="d-flex align-items-center gap-2">
                        <div>
                            <input type="text" class="form-control" name="keyword" placeholder="Nhập trọng lượng"
                                   value="${param.weight != null ? param.weight : ''}">
                        </div>

                        <div>
                            <select class="form-select" name="status">
                                <option value=""> Tất cả trạng thái </option>
                                <option value="1" ${param.status == '1' ? 'selected' : ''}>Đang bán</option>
                                <option value="0" ${param.status == '0' ? 'selected' : ''}>Ngừng bán</option>
                            </select>
                        </div>

                        <div>
                            <button type="submit" class="btn btn-primary">Tìm kiếm</button>
                        </div>
                    </div>
                </form>



                <table class="table table-bordered table-hover align-middle">
                    <thead class="table-primary text-center">
                        <tr>
                            <th>ID</th>
                            <th>Trọng lượng</th>
                            <th>Trạng thái</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<ProductVariantWeight> list = (List<ProductVariantWeight>) request.getAttribute("list");
                            DecimalFormat df = new DecimalFormat("#,##0.##");
                            if (list != null && !list.isEmpty()) {
                                for (ProductVariantWeight w : list) {
                        %>
                        <tr class="text-center">
                            <td><%= w.getWeightId() %></td>
                            <td><%= df.format(w.getWeight()) %> g</td>
                            <td>
                                <span class="badge bg-<%= w.isStatus() ? "success" : "secondary" %>">
                                    <%= w.isStatus() ? "Đang bán" : "Ngừng bán" %>
                                </span>
                            </td>
                            <td>
                                <a href="admin-productVariantWeight?action=edit&id=<%= w.getWeightId() %>" class="btn btn-sm btn-warning">Sửa</a>

                                <% if (w.isStatus()) { %>
                                <a href="admin-productVariantWeight?action=hide&id=<%= w.getWeightId() %>"
                                   class="btn btn-sm btn-danger"
                                   onclick="return confirm('Bạn có chắc chắn muốn NGỪNG BÁN trọng lượng này không?');">
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
                        String queryWeight = request.getParameter("weight") != null ? "&weight=" + request.getParameter("weight") : "";
                        String queryStatus = request.getParameter("status") != null ? "&status=" + request.getParameter("status") : "";
                %>
                <nav class="mt-3">
                    <ul class="pagination justify-content-center">
                        <li class="page-item <%= (currentPage == 1) ? "disabled" : "" %>">
                            <a class="page-link" href="admin-productVariantWeight?action=list&page=<%= currentPage - 1 %><%= queryWeight + queryStatus %>">Trước</a>
                        </li>
                        <% for (int i = 1; i <= totalPage; i++) { %>
                        <li class="page-item <%= (i == currentPage) ? "active" : "" %>">
                            <a class="page-link" href="admin-productVariantWeight?action=list&page=<%= i %><%= queryWeight + queryStatus %>"><%= i %></a>
                        </li>
                        <% } %>
                        <li class="page-item <%= (currentPage == totalPage) ? "disabled" : "" %>">
                            <a class="page-link" href="admin-productVariantWeight?action=list&page=<%= currentPage + 1 %><%= queryWeight + queryStatus %>">Sau</a>
                        </li>
                    </ul>
                </nav>
                <% } %>

            </div>
        </div>

        <!-- JS -->
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
    </body>
</html>
