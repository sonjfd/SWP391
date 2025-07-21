<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>Pet24h - Quản lý giống - Doctris</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico">
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

        <style>
            .toolbar {
                display: flex;
                justify-content: space-between;
                margin-bottom: 15px;
            }
            .toolbar a, .toolbar button {
                padding: 8px 15px;
                background-color: #33CCFF;
                color: white;
                border-radius: 4px;
                text-decoration: none;
                border: none;
            }
            .toolbar a:hover, .toolbar button:hover {
                background-color: #29b3e6;
            }
            table {
                width: 100%;
                border-collapse: collapse;
            }
            th, td {
                padding: 10px;
                border: 1px solid #ddd;
                text-align: left;
            }
            th {
                background-color: #33CCFF;
                color: white;
            }
            tr:nth-child(even) {
                background-color: #f2f2f2;
            }
            .action-btn {
                padding: 5px 10px;
                margin-right: 5px;
                color: white;
                border-radius: 4px;
                text-decoration: none;
            }
            .edit-btn {
                background-color: #2196F3;
            }
            .edit-btn:hover {
                background-color: #1e88e5;
            }
            .delete-btn {
                background-color: #f44336;
            }
            .delete-btn:hover {
                background-color: #d32f2f;
            }
            .message {
                color: green;
                margin-bottom: 10px;
            }

            .error {
                color: red;
                margin-bottom: 10px;
            }

        </style>
    </head>
    <body>
        <%@include file="../layout/Header.jsp" %>

        <div class="container-fluid">
            <div class="layout-specing">
                <h5 class="mb-0">Quản lý danh mục</h5>

                <div class="toolbar">
                    <!-- Nút mở Modal -->
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addCategoryModal">Tạo mới</button>
                </div>


                <c:if test="${not empty message}">
                    <div class="alert alert-danger">${message}</div>
                </c:if>


                <c:if test="${not empty param.msg}">
                    <div class="alert ${param.msg == 'deleted' ? 'alert-success' : 'alert-danger'}">
                        <c:choose>
                            <c:when test="${param.msg == 'deleted'}">Xóa thành công!</c:when>
                            <c:when test="${param.msg == 'missing'}">Thiếu ID để xóa!</c:when>
                            <c:when test="${param.msg == 'invalid'}">ID không hợp lệ!</c:when>
                            <c:otherwise>Xóa thất bại!</c:otherwise>
                        </c:choose>
                    </div>
                </c:if>



                <table>
                    <thead>
                        <tr>
                            <th>STT</th>
                            <th>Tên danh mục</th>
                            <th>Mô tả</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="c" items="${categories}" varStatus="counter">
                            <tr>
                                <td>${counter.count}</td>
                                <td>${c.name}</td>
                                <td>${c.name}</td>
                                <td>
                                    <a href="#"
                                       class="action-btn edit-btn"
                                       data-bs-toggle="modal"
                                       data-bs-target="#updateCategoryModal"
                                       data-id="${c.id}"
                                       data-name="${c.name}"
                                       data-description="${c.description}">Sửa</a>

                                    <a href="admin-delete-category?id=${c.id}" onclick="return confirm('Bạn có chắc chắn muốn xoá danh mục này không?')" class="action-btn delete-btn">Xóa</a>


                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>


            </div>
        </div>
        <!-- Modal tạo mới danh mục -->
        <div class="modal fade" id="addCategoryModal" tabindex="-1" aria-labelledby="addCategoryModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addCategoryModalLabel">Tạo mới danh mục</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="admin-add-categories" method="get">
                            <div class="mb-3">
                                <label for="categoryName" class="form-label">Tên danh mục</label>
                                <input type="text" class="form-control" id="categoryName" name="categoryName" required>
                            </div>
                            <div class="mb-3">
                                <label for="categoryDescription" class="form-label">Mô tả</label>
                                <textarea class="form-control" id="categoryDescription" name="categoryDescription" rows="3"></textarea>
                            </div>
                            <button type="submit" class="btn btn-primary">Lưu</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>



        <!-- Modal cập nhật danh mục -->
        <div class="modal fade" id="updateCategoryModal" tabindex="-1" aria-labelledby="updateCategoryModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <form method="post" action="${pageContext.request.contextPath}/admin/update-category">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Cập nhật danh mục</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" name="id" id="updateCategoryId">
                            <div class="mb-3">
                                <label class="form-label">Tên danh mục</label>
                                <input type="text" class="form-control" name="name" id="updateCategoryName" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Mô tả</label>
                                <textarea class="form-control" name="description" id="updateCategoryDescription" rows="3"></textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary">Cập nhật</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>




        <%@include file="../layout/Footer.jsp" %>





        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <script>
            <script>
        function confirmDelete(id) {
                                                if (confirm("Bạn có chắc chắn muốn xoá danh mục này không?")) {
            window.location.href = 'admin-delete-category?id=' + id;
                                        }
        }
        document.addEventListener('DOMContentLoaded', function () {
                                                const updateModal = document.getElementById('updateCategoryModal');
                                        updateModal.addEventListener('show.bs.modal', function (event) {
                                        const button = event.relatedTarget;
                                        const id = button.getAttribute('data-id');
                                        const name = button.getAttribute('data-name');
                                        const description = button.getAttribute('data-description');
                                        document.getElementById('updateCategoryId').value = id;
                                        document.getElementById('updateCategoryName').value = name;
                                        document.getElementById('updateCategoryDescription').value = description;
                                        });
                };
                </script>
    </body>
</html>
