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
