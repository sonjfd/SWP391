<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <title>Quản lý thuốc kê đơn cho hồ sơ y tế</title>
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/assets/css/remixicon.css" rel="stylesheet" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" />
    </head>

    <body>
        <%@include file="../layout/Header.jsp" %>

        <!-- Toast thông báo thành công hoặc thất bại -->
        <div class="position-fixed bottom-0 start-0 p-3" style="z-index: 1055">
            <div id="alertToast" class="toast align-items-center border-0 shadow fade" role="alert" aria-live="assertive" aria-atomic="true" data-bs-delay="2000">
                <div class="d-flex">
                    <div class="toast-body" id="alertToastMsg"></div>
                    <button type="button" class="btn-close me-2 m-auto" data-bs-dismiss="toast"></button>
                </div>
                <div class="progress" style="height: 3px;">
                    <div class="progress-bar" id="alertToastProgressBar" style="width: 100%; transition: width 2s linear;"></div>
                </div>
            </div>
        </div>

        <!-- Hiển thị Toast khi có thông báo -->
        <c:if test="${not empty message}">
            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    var msg = "${message}";
                    var status = "${status}";
                    showToast(msg, status);
                });

                function showToast(message, status) {
                    const toastEl = document.getElementById('alertToast');
                    const msg = document.getElementById('alertToastMsg');
                    const bar = document.getElementById('alertToastProgressBar');

                    msg.innerText = message;

                    toastEl.classList.remove('text-bg-success', 'text-bg-danger', 'text-bg-warning');
                    bar.classList.remove('bg-success', 'bg-danger', 'bg-warning');

                    if (status === 'success') {
                        toastEl.classList.add('text-bg-success');
                        bar.classList.add('bg-success');
                    } else if (status === 'error') {
                        toastEl.classList.add('text-bg-danger');
                        bar.classList.add('bg-danger');
                    } else if (status === 'warning') {
                        toastEl.classList.add('text-bg-warning');
                        bar.classList.add('bg-warning');
                    }

                    bar.style.width = '100%';
                    setTimeout(() => {
                        bar.style.width = '0%';
                    }, 10);

                    new bootstrap.Toast(toastEl).show();
                }
            </script>
        </c:if>

        <section class="bg-dashboard">
            <div class="container-fluid">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h3 class="mb-0">Quản lý thuốc kê đơn cho hồ sơ y tế</h3>
                    <a href="doctor-record-examination" class="btn btn-outline-secondary">
                        <i class="mdi mdi-arrow-left"></i> Quay lại danh sách hồ sơ
                    </a>
                </div>

                <!-- Hiển thị danh sách thuốc kê đơn -->
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Tên thuốc</th>
                            <th>Số lượng</th>
                            <th>Liều lượng</th>
                            <th>Thời gian sử dụng</th>
                            <th>Hướng dẫn sử dụng</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${prescribedMedicines}" var="medicine">
                            <tr>
                                <td>${medicine.medicine.name}</td>
                                <td>${medicine.quantity}</td>
                                <td>${medicine.dosage}</td>
                                <td>${medicine.duration}</td>
                                <td>${medicine.usageInstructions}</td>
                                <td>
                                    <a href="update-prescribed-medicine?medicineId=${medicine.medicine.id}&medicalRecordId=${medicalRecordId}" class="btn btn-warning btn-sm">Sửa</a>
                                    <button class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#confirmDeleteModal" data-medicine-id="${medicine.medicine.id}" data-medical-record-id="${medicalRecordId}">
                                        Xóa
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <!-- Nút thêm thuốc -->
                <a href="add-prescribed-medicine?medicalRecordId=${medicalRecordId}" class="btn btn-success">Thêm thuốc mới</a>
            </div>
        </section>
        <!-- Modal xác nhận xóa -->
        <div class="modal fade" id="confirmDeleteModal" tabindex="-1" aria-labelledby="confirmDeleteModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="confirmDeleteModalLabel">Xác nhận xóa thuốc</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        Bạn có chắc chắn muốn xóa thuốc này không?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <a id="confirmDeleteBtn" class="btn btn-danger">Xóa</a>
                    </div>
                </div>
            </div>
        </div>
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
        <script>
        // Sự kiện mở modal xác nhận xóa
        const deleteButtons = document.querySelectorAll('button[data-bs-toggle="modal"][data-bs-target="#confirmDeleteModal"]');
        deleteButtons.forEach(button => {
            button.addEventListener('click', function() {
                const medicineId = this.getAttribute('data-medicine-id');
                const medicalRecordId = this.getAttribute('data-medical-record-id');
                const confirmDeleteBtn = document.getElementById('confirmDeleteBtn');
                confirmDeleteBtn.setAttribute('href', 'delete-prescribed-medicine?medicineId=' + medicineId + '&medicalRecordId=' + medicalRecordId);
            });
        });
    </script>
    </body>

</html>
