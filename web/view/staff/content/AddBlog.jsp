<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thêm bài viết Blog</title>
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet"/>
        <link href="${pageContext.request.contextPath}/assets/css/select2.min.css" rel="stylesheet"/>
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet"/>
        <style>
            textarea {
                min-height: 150px;
            }
            
        </style>
    </head>
    <body>
        <%@ include file="../layout/Header.jsp" %>

        <div class="container-fluid bg-light py-4">
            <div class="layout-specing">
                <h4 class="mb-4">📝 Tạo bài viết mới</h4>

                <form action="add-blog" method="post" enctype="multipart/form-data" class="row g-4">
                    <div class="col-md-6">
                        <label for="title" class="form-label">📌 Tiêu đề</label>
                        <input type="text" class="form-control" id="title" name="title" required>
                    </div>

                    <div class="col-md-6">
                        <label for="status" class="form-label">📤 Trạng thái</label>
                        <select class="form-select" id="status" name="status">
                            <option value="draft">Nháp</option>
                            <option value="published">Đã đăng</option>
                        </select>
                    </div>

                    <div class="col-md-12">
                        <label for="image" class="form-label">🖼 Ảnh đại diện</label>
                        <input type="file" class="form-control" id="image" name="image" accept="image/*" required>
                    </div>

                    <div class="col-md-12">
                        <label for="default" class="form-label">📄 Nội dung</label>
                        <textarea class="form-control" id="default" name="content"></textarea>
                    </div>

                    <div class="col-md-12">
                        <label class="form-label">🏷️ Chọn thẻ liên quan</label>
                        <div class="row">
                            <c:forEach var="tag" items="${tagList}">
                                <div class="col-md-4">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" 
                                               name="tags" value="${tag.id}" id="tag-${tag.id}">
                                        <label class="form-check-label" for="tag-${tag.id}">
                                            ${tag.name}
                                        </label>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>


                    <div class="col-12 d-flex justify-content-end">
                        <button type="submit" class="btn btn-primary me-2">💾 Lưu bài viết</button>
                        <a href="list-blog" class="btn btn-outline-secondary">↩️ Quay lại</a>
                    </div>
                </form>
            </div>
        </div>
<script src="${pageContext.request.contextPath}/tinymce/tinymce.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/tinymceConfig.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/select2.min.js"></script>
        
    </body>
</html>
