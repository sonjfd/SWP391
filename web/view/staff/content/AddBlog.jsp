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

        <form action="staff-add-blog" method="post" enctype="multipart/form-data" class="row g-4" onsubmit="return validateForm(event)">
            <div class="col-md-6">
                <label for="title" class="form-label">📌 Tiêu đề</label>
                <input type="text" class="form-control" id="title" name="title" maxlength="100" required onblur="validateTitle()">
                <small id="titleError" class="text-danger" style="display:none;">Tiêu đề không được để trống và không quá 100 ký tự.</small>
            </div>

            <div class="col-md-12">
                <label for="image" class="form-label">🖼 Ảnh đại diện</label>
                <input type="file" class="form-control" id="image" name="image" accept="image/*" required onblur="validateImage()">
                <small id="imageError" class="text-danger" style="display:none;">Vui lòng chọn ảnh.</small>
            </div>

            <div class="col-md-12">
                <label for="default" class="form-label">📄 Nội dung</label>
                <textarea class="form-control" id="default" name="content"  onblur="validateContent()"></textarea>
                <small id="contentError" class="text-danger" style="display:none;">Nội dung không được để trống.</small>
            </div>

            <div class="col-md-12">
                <label class="form-label">🏷️ Chọn thẻ liên quan</label>
                <div class="row">
                    <c:forEach var="tag" items="${tagList}">
                        <div class="col-md-4">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="tags" value="${tag.id}" id="tag-${tag.id}" onblur="validateTags()">
                                <label class="form-check-label" for="tag-${tag.id}">
                                    ${tag.name}
                                </label>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <small id="tagsError" class="text-danger" style="display:none;">Vui lòng chọn ít nhất một thẻ.</small>
            </div>

            <div class="col-12 d-flex justify-content-end">
                <button type="submit" name="status" value="draft" class="btn btn-warning me-2">💾 Lưu nháp</button>
                <button type="submit" name="status" value="published" class="btn btn-success">💾 Lưu và đăng</button>
                <a href="staff-list-blog" class="btn btn-outline-secondary">↩️ Quay lại</a>
            </div>
        </form>
    </div>
</div>

<script>
    // Escape HTML for title input to prevent XSS
    function escapeTitle() {
        const titleInput = document.getElementById('title');
        titleInput.value = titleInput.value.replace(/</g, "&lt;").replace(/>/g, "&gt;");
    }

    // Validate title input
    function validateTitle() {
        const title = document.getElementById('title').value;
        const titleError = document.getElementById('titleError');
        if (title.trim() === '' || title.length > 100) {
            titleError.style.display = 'block';
        } else {
            titleError.style.display = 'none';
        }
    }

    // Validate image input
    function validateImage() {
        const image = document.getElementById('image').files.length;
        const imageError = document.getElementById('imageError');
        if (image === 0) {
            imageError.style.display = 'block';
        } else {
            imageError.style.display = 'none';
        }
    }

    // Validate content textarea
    function validateContent() {
        const content = document.getElementById('default').value;
        const contentError = document.getElementById('contentError');
        if (content.trim() === '') {
            contentError.style.display = 'block';
        } else {
            contentError.style.display = 'none';
        }
    }

    // Validate if at least one tag is selected
    function validateTags() {
        const tags = document.getElementsByName('tags');
        const tagsError = document.getElementById('tagsError');
        let isChecked = false;

        // Check if at least one checkbox is selected
        for (let tag of tags) {
            if (tag.checked) {
                isChecked = true;
                break;
            }
        }

        if (!isChecked) {
            tagsError.style.display = 'block';
        } else {
            tagsError.style.display = 'none';
        }
    }

    // Validate form before submission
    function validateForm(e) {
        tinymce.triggerSave();
        // Run all individual field validations
        validateTitle();
        validateImage();
        validateContent();
        validateTags();

        // Check if any errors are visible, if so prevent form submission
        if (document.querySelector('.text-danger[style="display: block;"]')) {
            e.preventDefault();
            return false;  // Prevent form submission if there are errors
        }
        return true;  // Allow form submission if all fields are valid
    }
</script>


        
        <script src="${pageContext.request.contextPath}/tinymce/tinymce.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/tinymceConfig.js"></script>
<!-- simplebar -->
        <script src="${pageContext.request.contextPath}/assets/js/simplebar.min.js"></script>
        <!-- Chart -->
        <script src="${pageContext.request.contextPath}/assets/js/apexcharts.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/columnchart.init.js"></script>
        <!-- Icons -->
        <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
    </body>
</html>
