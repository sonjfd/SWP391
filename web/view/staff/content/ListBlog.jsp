<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Blog</title>
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet"> <!-- Thêm font-awesome -->
    <link href="${pageContext.request.contextPath}/assets/css/simplebar.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/assets/css/select2.min.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/assets/css/remixicon.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/assets/css/tiny-slider.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet"/>
    <style>
        /* Tổng thể bảng */
        .table {
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            background-color: #fff;
            font-size: 14px;
        }

        /* Header bảng */
        .table thead th {
            background-color: #007bff !important;
            color: #fff !important;
            font-weight: 600;
            padding: 10px 12px;
            text-align: center;
        }

        /* Dòng bảng */
        .table tbody td {
            vertical-align: middle;
            padding: 10px 12px;
        }

        /* Màu dòng chẵn/lẻ */
        .table-striped tbody tr:nth-of-type(odd) {
            background-color: #f9fbfc;
        }
        .table-striped tbody tr:nth-of-type(even) {
            background-color: #ffffff;
        }

        /* Hover dòng */
        .table-striped tbody tr:hover {
            background-color: #eaf4ff;
            transition: all 0.3s ease;
        }

        /* Badge */
        .badge {
            display: inline-block;
            font-size: 12px;
            padding: 6px 10px;
            border-radius: 20px;
            font-weight: 500;
        }

        /* Nút nhỏ */
        .btn-sm {
            font-size: 10px;
            
            border-radius: 6px;
        }

        /* Căn giữa cột hoạt động */
        td:last-child {
            text-align: center;
        }

        /* Hover nút */
        .btn-info:hover {
            background-color: #138496 !important;
            border-color: #117a8b !important;
        }
        .btn-danger:hover {
            background-color: #dc3545 !important;
            border-color: #c82333 !important;
        }
        .btn-success:hover {
            background-color: #218838 !important;
            border-color: #1e7e34 !important;
        }

        .action-buttons {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 6px;
            flex-wrap: nowrap; /* CHỐT không cho xuống dòng */
        }
        .btn {
            padding: 5px !important;
            font-size: 10px;
        }
        .action-buttons .btn {
            
            font-size: 14px;
            border-radius: 6px;
            display: inline-flex; /* QUAN TRỌNG, giúp giữ inline */
            align-items: center;
            justify-content: center;
            width: auto !important; /* ép không full width */
            min-width: 36px; /* nhỏ gọn */
        }

        /* Responsive table đẹp hơn trên mobile */
        @media (max-width: 768px) {
            .table thead {
                display: none;
            }

            .table, .table tbody, .table tr, .table td {
                display: block;
                width: 100%;
            }

            .table tr {
                margin-bottom: 15px;
                border-radius: 10px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.05);
                background-color: #fff;
                padding: 10px;
            }

            .table td {
                text-align: right;
                padding-left: 50%;
                position: relative;
            }

            .table td::before {
                content: attr(data-label);
                position: absolute;
                left: 15px;
                width: 50%;
                padding-left: 15px;
                font-weight: 600;
                text-align: left;
            }
        }

        /* Lọc */
        .filter-form {
            display: flex;
            justify-content: flex-start;
            align-items: center;
            margin-bottom: 10px;
            gap: 10px;
        }

        .filter-input, .filter-button {
            font-size: 12px;
        }

        .filter-button {
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
        }

        .filter-button:hover {
            background-color: #0056b3;
        }

        .filter-label {
            margin-right: 5px;
        }

        .icon-btn {
            font-size: 1.2rem;
        }

        .add-btn-container {
            display: flex;
            justify-content: flex-end;
        }

        .btn-add {
            display: flex;
            align-items: center;
            font-size: 12px;
            
        }

        .action-buttons {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 6px;
        }

        /* Đảm bảo nút Lọc và Thêm mới cùng dòng */
        .filter-and-add-container {
            display: flex;
            justify-content: space-between;
            width: 100%;
        }

    </style>
</head>
<body>
    <%@ include file="../layout/Header.jsp" %>

    <div class="container-fluid bg-light">
        <div class="layout-specing">
            
            <h4 class="mb-3">Danh sách Blogs</h4>
            <div class="filter-and-add-container">
                <!-- Phần lọc nằm bên trái -->
                <div class="filter-form">
                    <form method="get" action="list-blog" class="d-flex mb-4">
    <input type="date" name="dateFrom" value="${param.dateFrom}" class="form-control mr-2" />
    <input type="date" name="dateTo" value="${param.dateTo}" class="form-control mr-2" />
    <select name="status" class="form-control mr-2">
        <option value="">Tất cả</option>
        <option value="published" ${param.status == 'published' ? 'selected' : ''}>Đã đăng</option>
        <option value="draft" ${param.status == 'draft' ? 'selected' : ''}>Nháp</option>
    </select>
    <!-- Dropdown tag -->
    <select name="tag" class="form-control mr-2">
        <option value="">Chọn tag</option>
        <c:forEach var="tag" items="${tagsList}">
            <option value="${tag.id}" ${param.tag == tag.id ? 'selected' : ''}>${tag.name}</option>
        </c:forEach>
    </select>
    <button type="submit" class="btn btn-primary">Lọc</button>
</form>
                </div>

                <!-- Nút "Thêm mới" nằm bên phải -->
                <div class="add-btn-container">
                    <a href="add-blog" class="btn btn-success btn-add">
                        <i class="fas fa-plus-circle"></i> Thêm mới
                    </a>
                </div>
            </div>

            <!-- Bảng Danh sách Blog -->
            <table class="table table-striped table-bordered">
                <thead class="bg-primary text-white">
                    <tr>
                        <th>#</th>
                        <th>Tiêu đề</th>
                        <th>Hình ảnh</th>
                        <th>Trạng thái</th>
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
                                <img src="${pageContext.request.contextPath}/${blog.image}" class="img-thumbnail image-thumb" style="width: 30px;height: 30px" alt="blog-img"/>
                            </td>
                            <td>
                                <span class="badge ${blog.status == 'published' ? 'bg-success' : 'bg-secondary'}">
                                    ${blog.status == 'published' ? 'Đã đăng' : 'Nháp'}
                                </span>
                            </td>
                            <td><c:if test="${blog.publishedAt eq null}">Chưa có</c:if>${blog.publishedAt}</td>
                            <td>
                                <a href="edit-blog?id=${blog.id}" class="btn btn-sm btn-warning">
                                    <i class="fas fa-edit icon-btn"></i> Sửa
                                </a>
                                <a href="delete-blog?id=${blog.id}" 
                                   class="btn btn-sm btn-danger"
                                   onclick="return confirm('Bạn có chắc chắn muốn xóa bài viết này không?')">
                                    <i class="fas fa-trash-alt icon-btn"></i> Xóa
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty listBlogs}">
                        <tr>
                            <td colspan="6" class="text-center">Không có bài viết nào.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>

        </div>
    </div>

    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>




    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
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
