
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Giỏ hàng</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico.png">
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" />


        <style>
            body, html {
                height: 100%;
                margin: 0;
            }
            .full-width-container {
                width: 100%;
                height: 70%;
                padding: 0 10%;
            }

        </style>
    </head>
    <body>

        <%@include file="../layout/Header.jsp" %>

        <div class="full-width-container mt-5">
            <h2 class="mb-4">Giỏ hàng của bạn</h2>

            <c:choose>
                <c:when test="${empty cartItems}">
                    <div class="alert alert-info">Giỏ hàng của bạn đang trống.</div>
                </c:when>
                <c:otherwise>
                    <table class="table table-bordered align-middle">
                        <thead class="table-light">
                            <tr>
                                <th>STT</th>
                                <th>Sản phẩm</th>
                                <th>Khối lượng</th>
                                <th>Hương vị</th>
                                <th>Số lượng</th>
                                <th>Giá</th>
                                <th>Thành tiền</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="total" value="0" />
                            <c:forEach var="item" items="${cartItems}" varStatus="loop">
                                <tr>
                                    <td>${loop.index + 1}</td>
                                    <td>${item.variant.productName}</td>
                                    <td>${item.variant.weight}</td>
                                    <td>${item.variant.flavorName}</td>
                                    <td>${item.quantity}</td>
                                    <td><fmt:formatNumber value="${item.variant.price}" pattern="#,##0₫"/></td>
                                    <td>
                                        <fmt:formatNumber value="${item.quantity * item.variant.price}" pattern="#,##0₫"/>
                                        <c:set var="total" value="${total + (item.quantity * item.variant.price)}"/>
                                    </td>

                                    <td>
                                        <form method="post" action="user-delete-cart">
                                            <input type="hidden" name="cartItemId" value="${item.id}" />
                                            <button type="submit" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng?')">
                                                Xóa
                                            </button>
                                        </form>
                                    </td>


                                </tr>
                            </c:forEach>
                        </tbody>
                        <tfoot>
                            <tr>
                                <th colspan="6" class="text-end">Tổng cộng:</th>
                                <th colspan="2">
                                    <fmt:formatNumber value="${total}" pattern="#,##0₫"/>
                                </th>
                            </tr>
                        </tfoot>
                    </table>

                    <div class="d-flex justify-content-end">
                        <a href="home-list-product" class="btn btn-primary">Tiếp tục mua sắm</a>

                        <form action="user-checkout-cart" method="post" class="ms-2">
                            <button type="submit" class="btn btn-success">Gửi tới lễ tân</button>
                        </form>
                    </div>

                </c:otherwise>
            </c:choose>
        </div>


        <div class="modal fade" id="checkoutSuccessModal" tabindex="-1" aria-labelledby="checkoutSuccessLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content text-center">
                    <div class="modal-header">
                        <h5 class="modal-title" id="checkoutSuccessLabel">Đơn hàng đã được gửi!</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                    </div>
                    <div class="modal-body">
                        Hãy  tới quầy để thanh toán trực tiếp với nhân viên.
                    </div>
                    <div class="modal-footer justify-content-center">
                        <a href="home-list-product" class="btn btn-primary">Tiếp tục mua sắm</a>
                    </div>
                </div>
            </div>
        </div>





        <c:if test="${param.checkout == 'success'}">
            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    const modal = new bootstrap.Modal(document.getElementById('checkoutSuccessModal'));
                    modal.show();
                });
            </script>
        </c:if>

        <%@include file="../layout/Footer.jsp" %>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/counter.init.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
    </body>
</html>
