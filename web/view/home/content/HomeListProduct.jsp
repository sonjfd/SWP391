

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
            .card {
                width: 100%;
                margin-bottom: 20px; /* Thêm khoảng cách dưới mỗi sản phẩm */
            }

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

            .card-body {
                padding: 15px;
            }

            .card-title {
                font-size: 18px;
            }

            .card-text {
                font-size: 14px;
                color: #555;
            }

            .btn-primary {
                width: 100%;
            }

            .btn-filter {
                width: 100%;
                margin-top: 15px;
            }

            .form-control {
                margin-bottom: 1rem;
            }

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
                                <ul class="list-group">
                                    <li class="list-group-item">Thức Ăn</li>
                                    <li class="list-group-item">Đồ Chơi</li>
                                    <li class="list-group-item">Phụ Kiện</li>
                                    <li class="list-group-item">Sản Phẩm Chăm Sóc</li>
                                </ul>
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
                                <div>
                                    <input type="checkbox" id="weight1" name="weight" value="low-high" class="form-check-input">
                                    <label for="weight1" class="form-check-label">Trọng Lượng Nhẹ Đến Nặng</label>
                                </div>
                                <div>
                                    <input type="checkbox" id="weight2" name="weight" value="high-low" class="form-check-input">
                                    <label for="weight2" class="form-check-label">Trọng Lượng Nặng Đến Nhẹ</label>
                                </div>
                            </div>
                        </div>

                        <div class="row mt-3">
                            <h5>Lọc Theo Hương Vị</h5>
                            <div class="checkbox-container">
                                <div>
                                    <input type="checkbox" id="flavor1" name="flavor" value="chicken" class="form-check-input">
                                    <label for="flavor1" class="form-check-label">Gà</label>
                                </div>
                                <div>
                                    <input type="checkbox" id="flavor2" name="flavor" value="fish" class="form-check-input">
                                    <label for="flavor2" class="form-check-label">Cá</label>
                                </div>
                                <div>
                                    <input type="checkbox" id="flavor3" name="flavor" value="beef" class="form-check-input">
                                    <label for="flavor3" class="form-check-label">Bò</label>
                                </div>
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
                        <!-- Product Card -->
                        <div class="col-md-4 col-sm-6 mb-4">
                            <div class="card">
                                <img class="card-img-top" src="https://via.placeholder.com/150" alt="Sản phẩm">
                                <div class="card-body">
                                    <h5 class="card-title">Sản phẩm 1</h5>
                                    <p class="card-text">Mô tả ngắn về sản phẩm.</p>
                                    <p><strong>Giá: 100,000 VND</strong></p>
                                    <a href="#" class="btn btn-primary">Mua Ngay</a>
                                </div>
                            </div>
                        </div>

                       
                        
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
