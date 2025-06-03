<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Quản lý Blog</title>
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet"/>
        <style>
            .table th, .table td {
                vertical-align: middle;
            }
            .blog-title {
                max-width: 250px;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }
            .image-thumb {
                width: 100px;
                height: 60px;
                object-fit: cover;
            }
        </style>
    </head>
    <body>
        <%@ include file="../layout/Header.jsp" %>

        <div class="container-fluid bg-light">
            <div class="layout-specing">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h4>Danh sách bài viết Blog</h4>
                    <a href="add-blog" class="btn btn-success">+ Thêm mới</a>
                </div>

                <table class="table table-bordered table-hover">
                    <thead class="table-primary">
                        <tr>
                            <th>#</th>
                            <th>Tiêu đề</th>
                            <th>Hình ảnh</th>
                            <th>Trạng thái</th>
                            <th>Lượt thích</th>
                            <th>Bình luận</th>
                            <th>Ngày đăng</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="blog" items="${listBlogs}" varStatus="loop">
                            <tr>
                                <td>${loop.index + 1}</td>
                                <td class="blog-title">${blog.title}</td>
                                <td>
                                    <img src="${pageContext.request.contextPath}/${blog.image}" class="img-thumbnail image-thumb" alt="blog-img"/>
                                </td>
                                <td>
                                    <span class="badge ${blog.status == 'published' ? 'bg-success' : 'bg-secondary'}">
                                        ${blog.status == 'published' ? 'Đã đăng' : 'Nháp'}
                                    </span>
                                </td>
                                <td>${blog.reactionCount}</td>
                                <td>${blog.commentCount}</td>
                                <td><c:if test="${blog.publishedAt eq null}">Chưa có</c:if>${blog.publishedAt}</td>
                                    <td>
                                        <a href="edit-blog?id=${blog.id}" class="btn btn-sm btn-warning">Sửa</a>
                                    <a href="delete-blog?id=${blog.id}" 
                                       class="btn btn-sm btn-danger"
                                       onclick="return confirm('Bạn có chắc chắn muốn xóa bài viết này không?')">
                                        Xóa
                                    </a>

                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty listBlogs}">
                            <tr>
                                <td colspan="8" class="text-center">Không có bài viết nào.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>

        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
