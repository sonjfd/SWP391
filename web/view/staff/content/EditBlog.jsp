<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa bài viết</title>
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- simplebar -->
        <link href="${pageContext.request.contextPath}/assets/css/simplebar.css" rel="stylesheet" type="text/css" />
        <!-- Select2 -->
        <link href="${pageContext.request.contextPath}/assets/css/select2.min.css" rel="stylesheet" />
        <!-- Icons -->
        <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- SLIDER -->
        <link href="${pageContext.request.contextPath}/assets/css/tiny-slider.css" rel="stylesheet" />
        <!-- Css -->
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
<%@ include file="../layout/Header.jsp" %>

<div class="container-fluid bg-light py-4">
    <div class="layout-specing">
    <h4>Chỉnh sửa bài viết Blog</h4>
    <form action="staff-edit-blog" method="post" enctype="multipart/form-data" onsubmit="return validateForm(event)">
        <input type="hidden" name="id" value="${blog.id}" />

        <div class="mb-3">
            <label class="form-label">Tiêu đề</label>
            <input type="text" class="form-control" name="title" value="${blog.title}" id="title" maxlength="100" required onblur="validateTitle()">
            <small id="titleError" class="text-danger" style="display:none;">Tiêu đề không được để trống và không quá 100 ký tự.</small>
        </div>

        <div class="mb-3">
            <label class="form-label">Hình ảnh (bỏ trống nếu không đổi)</label><br/>
            <img id="currentImage" src="${blog.image}" alt="Ảnh hiện tại" width="150" style="border: 1px solid #ddd; padding: 5px; border-radius: 5px;"><br><br>
            <input type="file" class="form-control" id="image" name="image" accept="image/*" onblur="validateImage()">
            <small id="imageError" class="text-danger" style="display:none;">Vui lòng chọn ảnh nếu bạn muốn thay đổi.</small>
        </div>

        <div class="mb-3">
            <label class="form-label">Nội dung</label>
            <textarea class="form-control" name="content" rows="8" id="content" onblur="validateContent()">${blog.content}</textarea>
            <small id="contentError" class="text-danger" style="display:none;">Nội dung không được để trống.</small>
        </div>

        <div class="mb-3">
            <label>Gắn thẻ:</label><br/>
            <c:forEach var="tag" items="${tagList}">
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="checkbox" name="tags" value="${tag.id}" id="tag-${tag.id}" onblur="validateTags()"
                        <c:if test="${blog.tagsAsList.contains(tag.id)}">checked</c:if>>
                    <label class="form-check-label" for="tag-${tag.id}">${tag.name}</label>
                </div>
            </c:forEach>
            <small id="tagsError" class="text-danger" style="display:none;">Vui lòng chọn ít nhất một thẻ.</small>
        </div>

        <!-- Buttons for save as draft or publish -->
        <button type="submit" name="status" value="draft" class="btn btn-warning me-2" onclick="setStatus('draft')">💾 Lưu nháp</button>
        <button type="submit" name="status" value="published" class="btn btn-success" onclick="setStatus('published')">💾 Lưu và đăng</button>
        
        <a href="staff-list-blog" class="btn btn-secondary">Hủy</a>
    </form>
</div>
</div>

<script>
    
    
    document.getElementById("image").addEventListener("change", function (event) {
        const preview = document.getElementById("currentImage");
        const file = event.target.files[0];

        if (file && file.type.startsWith("image/")) {
            const reader = new FileReader();
            reader.onload = function (e) {
                preview.src = e.target.result;
            };
            reader.readAsDataURL(file);
        }
    });


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

    // Validate image input (optional)
    function validateImage() {
        const image = document.getElementsByName('image')[0].files.length;
        const imageError = document.getElementById('imageError');
        if (image === 0 && document.getElementById('image').value !== '') {
            imageError.style.display = 'block';
        } else {
            imageError.style.display = 'none';
        }
    }

    // Validate content textarea
    function validateContent() {
        const content = document.getElementById('content').value;
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

    // Set the status for draft or published
    function setStatus(status) {
        const statusInput = document.querySelector("input[name='status'][value='" + status + "']");
        if (statusInput) {
            statusInput.value = status;
        }
    }

    // Validate form before submission
    function validateForm(e) {
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
