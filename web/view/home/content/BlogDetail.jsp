<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>${blog.title}</title>
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico.png">
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/assets/css/remixicon.css" rel="stylesheet" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" id="theme-opt" />

        <style>
            .blog-cover {
                width: 100%;
                height: 400px;
                object-fit: cover;
                border-radius: 10px;
            }
            .tag-badge {
                font-size: 13px;
                margin-right: 5px;
            }
        </style>
    </head>
    <body>
        <%@ include file="../layout/Header.jsp" %>

        <div class="container my-5">
            <div class="row justify-content-center">
                <div class="col-lg-10">

                    <!-- Tiêu đề và thông tin -->
                    <h2 class="fw-bold mb-3">${blog.title}</h2>
                    <p class="text-muted small">
                        Tác giả: <strong>${blog.author.fullName}</strong> |
                        Ngày đăng: <fmt:formatDate value="${blog.publishedAt}" pattern="dd/MM/yyyy" />
                    </p>

                    <!-- Tags -->


                    <!-- Ảnh chính -->
                    <img src="${pageContext.request.contextPath}/${blog.image}" class="blog-cover mb-4" alt="${blog.title}" />

                    <!-- Nội dung -->
                    <div class="fs-6 text-dark" style="line-height: 1.8;">
                        ${blog.content}
                    </div>
                    <c:if test="${not empty blog.tags}">
                        <div class="mb-3">
                            <c:forEach var="tag" items="${blog.tags}">
                                <span class="badge bg-primary tag-badge">
                                    <a href="homeblog?tag=${tag.id}" class="text-white text-decoration-none">${tag.name}</a>
                                </span>
                            </c:forEach>
                        </div>
                    </c:if>
                    <!-- Reactions -->
                    <div id="reactions"class="mt-4 d-flex align-items-center">
                        <form action="toggle-reaction" method="post">
                            <input type="hidden" name="blogId" value="${blog.id}" />
                            <button class="btn btn-sm ${hasReacted ? 'btn-danger' : 'btn-outline-danger'} reaction-btn" type="submit">
                                ${hasReacted ? '💔 Bỏ yêu thích' : '❤️ Yêu thích'} (${blog.reactionCount})
                            </button>
                        </form>

                        <form action="toggle-bookmark" method="post">
                            <input type="hidden" name="blogId" value="${blog.id}" />
                            <button class="btn btn-sm ${isBookmarked ? 'btn-secondary' : 'btn-outline-secondary'} reaction-btn" type="submit">
                                ${isBookmarked ? '✅ Đã lưu' : '🔖 Bookmark'}
                            </button>
                        </form>
                    </div>


                    <!-- Bình luận -->
                    <div class="mt-5">
                        <h5>Bình luận (${blog.commentCount})</h5>

                        <!-- Form bình luận -->
                        <form action="add-comment" method="post" class="mb-4">
                            <input type="hidden" name="blogId" value="${blog.id}" />
                            <textarea name="content" class="form-control mb-2" rows="3" required placeholder="Viết bình luận..."></textarea>
                            <button class="btn btn-primary btn-sm" type="submit">Gửi</button>
                        </form>

                        <!-- Danh sách bình luận -->
                        <c:forEach var="comment" items="${comments}">
                            <div class="border rounded p-3 mb-3 bg-white">
                                <!-- Comment Header -->
                                <div class="d-flex justify-content-between">
                                    <div><strong>${comment.user.fullName}</strong></div>
                                    <small class="text-muted">
                                        <fmt:formatDate value="${comment.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                                    </small>
                                </div>

                                <!-- Comment Content -->
                                <div class="mt-2">
                                    ${comment.content}
                                    <c:if test="${comment.isEdited == 1}">
                                        <span class="badge bg-warning text-dark mt-1">Đã chỉnh sửa</span>
                                    </c:if>
                                </div>

                                <!-- Edit and Delete Buttons (visible if user is the comment author) -->
                                <c:if test="${comment.user.id == user.id}">
                                    <div class="mt-2">
                                        <!-- Edit Button -->
                                        <button class="btn btn-sm btn-warning" data-bs-toggle="collapse" data-bs-target="#edit-comment-${comment.id}">
                                            Sửa
                                        </button>
                                        <!-- Delete Button -->
                                        <form action="delete-comment" method="post" class="d-inline-block ms-2">
                                            <input type="hidden" name="blogId" value="${blog.id}" />

                                            <input type="hidden" name="commentId" value="${comment.id}" />
                                            <button class="btn btn-sm btn-danger" type="submit" onclick="return confirm('Bạn có chắc chắn muốn xóa bình luận này?')">Xóa</button>
                                        </form>
                                    </div>

                                    <!-- Edit Form (collapsed by default) -->
                                    <div id="edit-comment-${comment.id}" class="collapse mt-3">
                                        <form action="edit-comment" method="post">
                                            <input type="hidden" name="commentId" value="${comment.id}" />
                                            <input type="hidden" name="blogId" value="${blog.id}" />
                                            <textarea name="content" class="form-control mb-2" rows="3" required>${comment.content}</textarea>
                                            <button class="btn btn-warning btn-sm" type="submit">Lưu chỉnh sửa</button>
                                        </form>
                                    </div>
                                </c:if>
                            </div>
                        </c:forEach>


                    </div>
                </div>
            </div>
        </div>

        <%@ include file="../layout/Footer.jsp" %>
        <!-- javascript -->
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <!-- SLIDER -->
        <script src="${pageContext.request.contextPath}/assets/js/tiny-slider.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/tiny-slider-init.js"></script>
        <!-- Counter -->
        <script src="${pageContext.request.contextPath}/assets/js/counter.init.js"></script>
        <!-- Icons -->
        <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
    </body>
</html>
