<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa bài viết</title>
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body>
<%@ include file="../layout/Header.jsp" %>

<div class="container mt-4">
    <h4>Chỉnh sửa bài viết Blog</h4>
    <form action="staff-edit-blog" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="${blog.id}" />

        <div class="mb-3">
            <label class="form-label">Tiêu đề</label>
            <input type="text" class="form-control" name="title" value="${blog.title}" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Trạng thái</label>
            <select class="form-select" name="status">
                <option value="draft" ${blog.status == 'draft' ? 'selected' : ''}>Nháp</option>
                <option value="published" ${blog.status == 'published' ? 'selected' : ''}>Đã đăng</option>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Hình ảnh (bỏ trống nếu không đổi)</label><br/>
            <img src="${pageContext.request.contextPath}/${blog.image}" alt="Ảnh hiện tại" width="150"><br><br>
            <input type="file" class="form-control" name="image" accept="image/*">
        </div>

        <div class="mb-3">
            <label class="form-label">Nội dung</label>
            <textarea class="form-control" name="content" rows="8">${blog.content}</textarea>
        </div>

        <div class="mb-3">
            <label>Gắn thẻ:</label><br/>
            <c:forEach var="tag" items="${tagList}">
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="checkbox" name="tags" value="${tag.id}"
                           <c:if test="${blog.tagsAsList.contains(tag.id)}">checked</c:if>>
                    <label class="form-check-label">${tag.name}</label>
                </div>
            </c:forEach>
        </div>

        <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
        <a href="staff-list-blog" class="btn btn-secondary">Hủy</a>
    </form>
</div>
</body>
</html>
