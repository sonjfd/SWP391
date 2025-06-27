

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
        <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
        <meta name="author" content="Shreethemes" />
        <meta name="email" content="support@shreethemes.in" />
        <meta name="website" content="${pageContext.request.contextPath}/index.html" />
        <meta name="Version" content="v1.2.0" />
        <!-- favicon -->
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico.png">
        <!-- Bootstrap -->
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- SLIDER -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
        <!-- Swiper JS -->
        <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/tiny-slider.css"/>
        <!-- Css -->
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <style>
            .wrapper {
                margin-bottom: 30px; /* Khoảng cách giữa các hàng */
                margin-top: 40px;
            }

            .filter-section {
                margin-bottom: 20px;
            }

            .filter-section h5 {
                margin-bottom: 15px;
            }

            .checkbox-container {
                display: flex;
                flex-direction: column;
                gap: 10px;
            }

            .btn-primary {
                width: 100%;
                padding: 10px 15px;
                font-size: 16px;
                border-radius: 5px;
                background-color: #007bff; /* Màu nền cho nút */
                color: white;
                border: none;
                transition: background-color 0.3s ease; /* Thêm hiệu ứng khi hover */
            }

            .btn-primary:hover {
                background-color: #0056b3; /* Màu nền khi hover */
            }

            /* Button filter */
            .btn-filter {
                width: 100%;
                margin-top: 15px;
                padding: 10px 15px;
                background-color: #f8f9fa; /* Màu nền sáng cho nút lọc */
                border: 1px solid #ddd; /* Viền xung quanh nút lọc */
                font-size: 16px;
            }

            .btn-filter:hover {
                background-color: #e2e6ea; /* Màu nền khi hover */
            }

            /* Form control */
            .form-control {
                margin-bottom: 1rem; /* Khoảng cách dưới các trường input */
            }

            /* Load more link */
            .load-more-link {
                text-align: center;
                margin-top: 20px;
            }

            .load-more-link a {
                color: #0d6efd; /* Bootstrap primary color */
                text-decoration: none;
                font-weight: bold;
            }

            .load-more-link a:hover {
                text-decoration: underline;
            }

        </style>

    <body>

        <%@include file="../layout/Header.jsp" %>

        <!-- Main Content -->
        <div class="container">
            <div class="row wrapper">
                <!-- Filter Section -->
                <div class="col-md-3 filter-section">
                    <div class="accordion" id="categoryAccordion">
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="headingOne">
                                <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
                                    Danh Mục
                                </button>
                            </h2>
                            <div id="collapseOne" class="accordion-collapse collapse" aria-labelledby="headingOne" data-bs-parent="#categoryAccordion">
                                <div class="list-group">
                                    <c:forEach var="cate" items="${categories}">
                                        <button class="list-group-item list-group-item-action" onclick="filterByCate(${cate.id})">
                                            ${cate.name} 
                                        </button>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>


                    <!-- Sorting Section -->
                    <div class="row mt-3">

                        <div class="col-6">
                            <a href="#" id="sortAscending" class="btn btn-link">Giá Tăng Dần</a>
                        </div>
                        <div class="col-6">
                            <a href="#" id="sortDescending" class="btn btn-link">Giá Giảm Dần</a>
                        </div>

                    </div>


                    <!-- Other Filters -->
                    <form id="filterForm">
                        <div class="row mt-3">
                            <h5>Lọc Theo Trọng Lượng</h5>
                            <div class="checkbox-container">
                                <c:forEach var="w" items="${weights}">
                                    <div class="form-check">
                                        <input type="checkbox" name="weight" value="${w.weightId}" class="form-check-input" id="weight${w.weightId}">
                                        <label class="form-check-label" for="weight${w.weightId}">${w.weight} kg</label>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>


                        <div class="row mt-3">
                            <h5>Lọc Theo Hương Vị</h5>
                            <div class="checkbox-container">
                                <c:forEach var="f" items="${flavors}">
                                    <div class="form-check">
                                        <input type="checkbox" name="weight" value="${f.flavorId}" class="form-check-input" id="weight${f.flavorId}">
                                        <label class="form-check-label">${f.flavor} </label>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>

                        <div class="row mt-3">
                            <h5>Lọc Theo Giá</h5>
                            <div class="mb-3">
                                <label for="priceRange" class="form-label">Chọn Khoảng Giá</label>
                                <select class="form-control" id="priceRange" name="priceRange">
                                    <option value="0-100000">Từ 0 đến 100,000 VND</option>
                                    <option value="100000-3000000">Từ 100,000 đến 3,000,000 VND</option>
                                    <option value="3000000-">Trên 3,000,000 VND</option>
                                </select>
                            </div>
                        </div>



                        <!-- Button Filter -->
                        <button type="submit" class="btn btn-primary btn-filter">Lọc</button>
                    </form>
                </div>

                <!-- Product List Section -->
                <div class="col-md-9">
                    <div class="row">
                        <c:forEach items="${products}" var="p">
                            <div class="col-md-4 col-sm-6 mb-4">
                                <div class="card h-100 shadow-sm">
                                    <c:if test="${not empty p.productVariants}">
                                        <img class="card-img-top img-fluid" 
                                             src="${pageContext.request.contextPath}${p.productVariants[0].image}" 
                                             alt="${p.productName}" 
                                             style="height: 200px; object-fit: cover;">
                                        <div class="card-body d-flex flex-column justify-content-between">
                                            <h5 class="card-title text-truncate" title="${p.productName}">
                                                ${p.productName}
                                            </h5>
                                            <p class="card-text text-muted" style="font-size: 0.9rem;">
                                                ${p.description}
                                            </p>
                                            <div class="mb-2">
                                                <span class="d-block"><strong>Giá:</strong> ${p.productVariants[0].price}₫</span>
                                                <span class="d-block"><strong>Còn lại:</strong> ${p.productVariants[0].stockQuantity} sản phẩm</span>
                                            </div>
                                            <a href="product-detail?id=${p.productId}" class="btn btn-outline-primary btn-sm mt-auto w-100">
                                                Xem chi tiết
                                            </a>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>



            </div>
        </div>

        <%@include file="../layout/Footer.jsp" %>

        <script>

        </script>

        <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
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
