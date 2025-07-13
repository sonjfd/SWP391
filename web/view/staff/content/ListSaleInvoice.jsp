<%-- 
    Document   : ListSaleInvoice
    Created on : Jul 2, 2025, 5:41:12 PM
    Author     : Admin
--%>
<%-- 
    Document   : ListAppointment
    Created on : Jun 8, 2025, 8:33:32 PM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Trang Nhân Viên</title>
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

        <style>
            .table-invoice thead th {
                background-color: #f8f9fc;
                color: #333;
                font-weight: 600;
                text-align: center;
                vertical-align: middle;
            }

            .table-invoice tbody td {
                vertical-align: middle;
                text-align: center;
            }

            .table-invoice .btn-info {
                background-color: #00bcd4;
                border: none;
            }

            .table-invoice .btn-primary {
                background-color: #007bff;
                border: none;
            }

            .table-invoice .btn-primary:hover {
                background-color: #0069d9;
            }

            .table-invoice .btn-success {
                background-color: #28a745;
                border: none;
            }

            .table-invoice .btn-success:hover {
                background-color: #218838;
            }

            .table-invoice .btn-secondary {
                background-color: #6c757d;
                border: none;
            }

            .filter-controls {
                display: flex;
                flex-wrap: wrap;
                gap: 8px;
                margin-bottom: 16px;
            }

            .filter-controls input,
            .filter-controls select,
            .filter-controls button {
                height: 38px;
            }

            .pagination li a.page-link {
                border-radius: 6px;
                margin: 0 2px;
                color: #007bff;
                border: 1px solid #ddd;
            }

            .pagination li.active a.page-link {
                background-color: #007bff;
                border-color: #007bff;
                color: #fff;
            }

            .pagination li.disabled a.page-link {
                color: #ccc;
                pointer-events: none;
                background-color: #f8f9fa;
            }

            .pagination {
                margin-top: 20px;
            }

            .btn-print {
                background-color: #007bff;
                border: none;
            }

            .btn-print:hover {
                background-color: #0069d9;
            }

        </style>


    </head>
    <body>
        <%@ include file="../layout/Header.jsp" %>



        <div class="container-fluid bg-light">
            <h3 class="mb-4">Danh sách hóa đơn bán hàng chờ thanh toán</h3>

            <form method="get" action="staff-list-invoices" class="row g-2 mb-3" style="margin-top: 10px">
                <div class="col-auto">
                    <input type="date" class="form-control" name="searchDate" value="${searchDate}">
                </div>
                <div class="col-auto">
                    <select class="form-select" name="paymentStatus">
                        <option value="">Tất cả trạng thái</option>
                        <option value="unpaid" ${paymentStatus == 'unpaid' ? 'selected' : ''}>Chưa thanh toán</option>
                        <option value="paid" ${paymentStatus == 'paid' ? 'selected' : ''}>Đã thanh toán</option>
                    </select>
                </div>
                <div class="col-auto">
                    <button type="submit" class="btn btn-primary">Lọc</button>
                </div>
            </form>


            <table class="table table-bordered table-invoice">

                <thead class="table-light">
                    <tr>
                        <th>STT</th>
                        <th>Mã hóa đơn</th>
                        <th>Tổng tiền</th>
                        <th>Hành động</th>
                        <th>Phương thức thanh toán</th>
                        <th>Ngày tạo</th>
                        <th>Hành động</th>


                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="invoice" items="${invoices}" varStatus="loop">
                        <tr>
                            <td>${offset + loop.index + 1}</td>
                            <td>${invoice.invoiceId}</td>
                            <td><fmt:formatNumber value="${invoice.totalAmount}" type="number" groupingUsed="true"/> VNĐ</td>
                            <td>
                                <button type="button" class="btn btn-sm btn-info view-detail-btn"
                                        data-invoice-id="${invoice.invoiceId}">
                                    Chi tiết
                                </button>
                            </td>

                            <td>
                                <c:choose>
                                    <c:when test="${invoice.paymentStatus == 'paid'}">
                                        <button type="button" class="btn btn-sm btn-secondary" disabled>Đã thanh toán</button>
                                    </c:when>
                                    <c:otherwise>
                                        <form method="post" action="staff-update-invoice-payment" class="d-flex flex-column flex-md-row align-items-center">
                                            <input type="hidden" name="invoiceId" value="${invoice.invoiceId}" />

                                            <select name="paymentMethod" class="form-select form-select-sm me-md-2 mb-2 mb-md-0" required>
                                                <option value="cash" ${invoice.paymentMethod == 'cash' ? 'selected' : ''}>Tiền mặt</option>
                                                <option value="online" ${invoice.paymentMethod == 'online' ? 'selected' : ''}>Chuyển khoản</option>
                                            </select>

                                            <select name="paymentStatus" class="form-select form-select-sm me-md-2 mb-2 mb-md-0" required>
                                                <option value="unpaid" ${invoice.paymentStatus == 'unpaid' ? 'selected' : ''}>Chưa thanh toán</option>
                                                <option value="paid" ${invoice.paymentStatus == 'paid' ? 'selected' : ''}>Đã thanh toán</option>
                                            </select>

                                            <button type="submit" class="btn btn-sm btn-success">Cập nhật</button>
                                        </form>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td><fmt:formatDate value="${invoice.createdAt}" pattern="dd/MM/yyyy HH:mm"/></td>
                            <td>
                                <c:if test="${invoice.paymentStatus == 'paid'}">
                                    <button type="button" class="btn btn-sm btn-primary print-invoice-btn" data-invoice-id="${invoice.invoiceId}">
                                        In hóa đơn
                                    </button>

                                </c:if>
                            </td>





                        </tr>
                    </c:forEach>

                </tbody>

            </table>
            <div class="modal fade" id="invoiceDetailModal" tabindex="-1" aria-labelledby="invoiceDetailModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg modal-dialog-scrollable">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Chi tiết hóa đơn</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                        </div>
                        <div class="modal-body" id="invoiceDetailContent">
                            <!-- Nội dung chi tiết sản phẩm sẽ được load vào đây -->
                        </div>
                    </div>
                </div>
            </div>
            <div class="container my-4 d-none" id="printArea">
                <div class="text-center mb-4">
                    <c:if test="${not empty ClinicInfo.logo}">
                        <img src="${pageContext.request.contextPath}${ClinicInfo.logo}" alt="Logo" height="80">
                    </c:if>
                    <h4 class="fw-bold mt-2">${ClinicInfo.name}</h4>
                    <div>Địa chỉ: ${ClinicInfo.address}</div>
                    <div>Điện thoại: ${ClinicInfo.phone}</div>
                    <hr>
                </div>

                <h5 class="fw-bold text-center mb-3">HÓA ĐƠN BÁN HÀNG</h5>

                <table class="table table-bordered table-striped">
                    <thead class="table-light text-center">
                        <tr>
                            <th>STT</th>
                            <th>Sản phẩm</th>
                            <th>Đơn giá</th>
                            <th>Số lượng</th>
                            <th>Thành tiền</th>
                        </tr>
                    </thead>
                    <tbody id="productList">
                        <!-- AJAX sẽ render chi tiết sản phẩm vào đây -->
                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="4" class="text-end fw-bold">Tổng cộng:</td>
                            <td class="text-end fw-bold" id="totalAmount">0 VNĐ</td>
                        </tr>
                    </tfoot>
                </table>

                <div class="note-section mt-4">
                    <strong>Ghi chú:</strong>
                    <p>- Cảm ơn quý khách đã mua sắm tại phòng khám!</p>
                </div>

                <div class="row text-center mt-5 signature-section">
                    <div class="col-6">
                        <div>Khách hàng<br><em>(Ký, ghi rõ họ tên)</em></div>
                    </div>
                    <div class="col-6">
                        <div>Nhân viên bán hàng<br><em>(Ký, ghi rõ họ tên)</em></div>
                    </div>
                </div>
            </div>


            <c:if test="${totalPages > 0}">
                <nav>
                    <ul class="pagination justify-content-center">
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link" href="staff-list-invoices?page=${currentPage - 1}&searchDate=${searchDate}&paymentStatus=${paymentStatus}">Trước</a>
                        </li>
                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link" href="staff-list-invoices?page=${i}&searchDate=${searchDate}&paymentStatus=${paymentStatus}">${i}</a>
                            </li>
                        </c:forEach>
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link" href="staff-list-invoices?page=${currentPage + 1}&searchDate=${searchDate}&paymentStatus=${paymentStatus}">Sau</a>
                        </li>
                    </ul>
                </nav>
            </c:if>


        </div>
        <script>

            document.addEventListener("DOMContentLoaded", function () {
                const viewDetailButtons = document.querySelectorAll(".view-detail-btn");
                const printButtons = document.querySelectorAll(".print-invoice-btn");

                // Xem chi tiết hóa đơn
                viewDetailButtons.forEach(btn => {
                    btn.addEventListener("click", function () {
                        const invoiceId = this.getAttribute("data-invoice-id");

                        fetch("staff-invoice-detail-ajax?id=" + invoiceId)
                                .then(response => response.text())
                                .then(data => {
                                    document.getElementById("invoiceDetailContent").innerHTML = data;
                                    const modal = new bootstrap.Modal(document.getElementById("invoiceDetailModal"));
                                    modal.show();
                                })
                                .catch(err => {
                                    alert("Lỗi tải chi tiết hóa đơn!");
                                    console.error(err);
                                });
                    });
                });

                // In và tải hóa đơn PDF
                printButtons.forEach(btn => {
                    btn.addEventListener("click", function () {
                        const invoiceId = this.getAttribute("data-invoice-id");

                        fetch("staff-invoice-detail-print-ajax?id=" + invoiceId)
                                .then(response => response.json())
                                .then(data => {
                                    if (data.error) {
                                        alert(data.error);
                                        return;
                                    }

                                    // Render sản phẩm vào bảng in hóa đơn
                                    var productListHTML = "";
                                    data.details.forEach(function (item, index) {
                                        productListHTML += "<tr>";
                                        productListHTML += "<td class='text-center'>" + (index + 1) + "</td>";
                                        productListHTML += "<td>" + item.productName + "</td>";
                                        productListHTML += "<td class='text-end'>" + item.unitPrice.toLocaleString() + " VNĐ</td>";
                                        productListHTML += "<td class='text-center'>" + item.quantity + "</td>";
                                        productListHTML += "<td class='text-end'>" + item.lineTotal.toLocaleString() + " VNĐ</td>";
                                        productListHTML += "</tr>";
                                    });

                                    document.getElementById("productList").innerHTML = productListHTML;
                                    document.getElementById("totalAmount").innerText = data.totalAmount.toLocaleString() + " VNĐ";

                                    // Gọi hàm tải PDF
                                    downloadInvoicePDF(invoiceId);
                                })
                                .catch(err => {
                                    alert("Lỗi khi lấy hóa đơn");
                                    console.error(err);
                                });
                    });
                });
            });

            function downloadInvoicePDF(invoiceId) {
                var printContent = document.getElementById("printArea").cloneNode(true);
                printContent.classList.remove("d-none");
                printContent.style.display = "block";
                printContent.id = "tempPrintArea"; // tránh trùng id

                // Append tạm vào body để html2pdf render được
                document.body.appendChild(printContent);

                var opt = {
                    margin: 0.5,
                    filename: invoiceId + ".pdf",
                    image: {type: 'jpeg', quality: 0.98},
                    html2canvas: {scale: 2},
                    jsPDF: {unit: 'in', format: 'a4', orientation: 'portrait'}
                };

                html2pdf().set(opt).from(printContent).save().then(() => {
                    // Xóa vùng clone sau khi in xong
                    document.body.removeChild(printContent);
                });
            }


        </script>


        <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>


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
