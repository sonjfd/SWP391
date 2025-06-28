

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


            .container {
                margin-top: 20px;
            }

            .product-image {
                flex: 1;
                max-width: 500px;
                margin-right: 30px;
            }

            .product-image img {
                width: 100%;
                height: auto;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            .product-info {
                flex: 2;
                max-width: 600px;
                padding: 20px;
                background-color: white;
                border-radius: 10px;
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            }

            .product-info h2 {
                font-size: 30px;
                font-weight: bold;
                color: #333;
                margin-bottom: 15px;
            }

            .product-info p {
                font-size: 16px;
                color: #666;
                line-height: 1.6;
            }

            .product-info .price {
                font-size: 24px;
                font-weight: bold;
                color: #007bff;
                margin-top: 20px;
            }

            .product-info .stock-quantity {
                font-size: 18px;
                color: #28a745;
                margin-top: 10px;
            }

            .product-info .weight-flavor {
                font-size: 18px;
                margin-top: 10px;
                color: #333;
            }

            .product-info .add-to-cart {
                background-color: #007bff;
                color: white;
                font-size: 18px;
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                margin-top: 30px;
                width: 100%;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .product-info .add-to-cart:hover {
                background-color: #0056b3;
            }

            .product-info .description {
                font-size: 16px;
                margin-top: 15px;
                color: #666;
            }

            .back-btn {
                background-color: #f8f9fa;
                color: #007bff;
                padding: 10px 20px;
                border-radius: 5px;
                border: 1px solid #007bff;
                font-size: 16px;
                margin-top: 20px;
                text-decoration: none;
                display: inline-block;
                transition: background-color 0.3s ease;
            }

            .back-btn:hover {
                background-color: #007bff;
                color: white;
            }





            .mt-3 {
                margin-top: 30px; /* Khoảng cách trên giữa các phần tử */
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
                                        <a href="home-list-product?categoryId=${cate.categoryId}" class="list-group-item list-group-item-action">
                                            ${cate.categoryName}
                                        </a>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>



                    <div class="row mt-3">
                        <div class="col-12">
                            <div class="btn-link-container">
                                <a href="home-list-product?sort=asc" class="btn btn-link">Giá Tăng Dần</a>
                                <a href="home-list-product?sort=desc" class="btn btn-link">Giá Giảm Dần</a>
                            </div>
                        </div>
                    </div>

                    <form action="home-list-product" method="get" id="filterForm">
                        <div class="row mt-3">
                            <h5>Lọc Theo Trọng Lượng</h5>
                            <div class="checkbox-container">
                                <c:forEach var="w" items="${weights}">
                                    <c:set var="isChecked" value="false" />
                                    <c:forEach var="wid" items="${paramValues.weight}">
                                        <c:if test="${wid == w.weightId}">
                                            <c:set var="isChecked" value="true" />
                                        </c:if>
                                    </c:forEach>
                                    <div class="form-check">
                                        <input type="checkbox" name="weight" value="${w.weightId}"
                                               class="form-check-input" id="weight${w.weightId}"
                                               <c:if test="${isChecked}">checked</c:if>>
                                        <label class="form-check-label" for="weight${w.weightId}">${w.weight} kg</label>
                                    </div>
                                </c:forEach>

                            </div>
                        </div>

                        <div class="row mt-3">
                            <h5>Lọc Theo Hương Vị</h5>
                            <div class="checkbox-container">
                                <c:forEach var="f" items="${flavors}">
                                    <c:set var="isChecked" value="false" />
                                    <c:forEach var="fid" items="${paramValues.flavor}">
                                        <c:if test="${fid == f.flavorId}">
                                            <c:set var="isChecked" value="true" />
                                        </c:if>
                                    </c:forEach>
                                    <div class="form-check">
                                        <input type="checkbox" name="flavor" value="${f.flavorId}"
                                               class="form-check-input" id="flavor${f.flavorId}"
                                               <c:if test="${isChecked}">checked</c:if>>
                                        <label class="form-check-label" for="flavor${f.flavorId}">${f.flavor}</label>
                                    </div>
                                </c:forEach>



                            </div>
                        </div>

                        <div class="row mt-3">
                            <h5>Lọc Theo Giá</h5>
                            <div class="checkbox-container">
                                <div class="form-check">
                                    <c:set var="checked1" value="false" />
                                    <c:forEach var="val" items="${paramValues.priceRange}">
                                        <c:if test="${val == '0-100000'}">
                                            <c:set var="checked1" value="true" />
                                        </c:if>
                                    </c:forEach>
                                    <input type="checkbox" class="form-check-input" id="price1" name="priceRange" value="0-100000"
                                           <c:if test="${checked1}">checked</c:if>>
                                           <label class="form-check-label" for="price1">Từ 0 đến 100,000 VND</label>

                                    </div>
                                    <div class="form-check">
                                    <c:set var="checked2" value="false" />
                                    <c:forEach var="val" items="${paramValues.priceRange}">
                                        <c:if test="${val == '100000-3000000'}">
                                            <c:set var="checked2" value="true" />
                                        </c:if>
                                    </c:forEach>
                                    <input type="checkbox" class="form-check-input" id="price2" name="priceRange" value="100000-3000000"
                                           <c:if test="${checked2}">checked</c:if>>
                                           <label class="form-check-label" for="price2">Từ 100,000 đến 3,000,000 VND</label>

                                    </div>
                                    <div class="form-check">
                                    <c:set var="checked3" value="false" />
                                    <c:forEach var="val" items="${paramValues.priceRange}">
                                        <c:if test="${val == '3000000-'}">
                                            <c:set var="checked3" value="true" />
                                        </c:if>
                                    </c:forEach>
                                    <input type="checkbox" class="form-check-input" id="price3" name="priceRange" value="3000000-"
                                           <c:if test="${checked3}">checked</c:if>>
                                           <label class="form-check-label" for="price3">Trên 3,000,000 VND</label>

                                    </div>

                                </div>
                            </div>


                            <button type="submit" class="btn btn-primary btn-filter">Lọc</button>
                        </form>


                    </div>

                    <div class="col-md-9">
                        <div class="row"> 
                        <c:forEach items="${productVariants}" var="v">
                            <div class="col-md-4 col-sm-6 mb-4">
                                <div class="card h-100 shadow-sm">
                                    <img class="card-img-top img-fluid" 
                                         src="${v.image}" 
                                         alt="${v.productName}" 
                                         style="height: 200px; object-fit: cover;">
                                    <div class="card-body d-flex flex-column justify-content-between">
                                        <h5 class="card-title ">
                                            ${v.productName} ${v.weight}kg ${v.flavorName}
                                        </h5>
                                        <p class="card-text text-muted" style="font-size: 0.9rem;">
                                            Danh mục: ${v.categoryName}
                                        </p>
                                        <div class="mb-2">
                                            <span class="d-block"><strong>Giá:</strong> 
                                                <fmt:formatNumber value="${v.price}" />VNĐ
                                            </span>
                                            <span class="d-block"><strong>Còn lại:</strong> ${v.stockQuantity} sản phẩm</span>
                                            <span class="d-block"><strong>Trọng lượng:</strong> ${v.weight} kg</span>
                                            <span class="d-block"><strong>Hương vị:</strong> ${v.flavorName}</span>
                                        </div>
                                        <a href="product-details?productid=${v.productId}&weightId=${v.weightId}&flavorId=${v.flavorId}"
                                           class="btn btn-outline-primary btn-sm mt-auto w-100">
                                            Xem chi tiết
                                        </a>

                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <div class="row">
                    <div class="col-12 d-flex justify-content-center mt-4">
                        <nav>
                            <ul class="pagination">
                                <c:if test="${currentPage > 1}">
                                    <li class="page-item">
                                        <a class="page-link" href="?page=${currentPage - 1}">&laquo;</a>
                                    </li>
                                </c:if>
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="?page=${i}">${i}</a>
                                    </li>
                                </c:forEach>
                                <c:if test="${currentPage < totalPages}">
                                    <li class="page-item">
                                        <a class="page-link" href="?page=${currentPage + 1}">&raquo;</a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                    </div>
                </div>




            </div>
        </div>

        <%@include file="../layout/Footer.jsp" %>



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
