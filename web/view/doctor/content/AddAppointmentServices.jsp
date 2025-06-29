<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Thêm Dịch Vụ Cho Cuộc Hẹn</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background: #f6f8fa;
            }
            .container {
                max-width: 750px;
                margin-top: 40px;
            }
            .form-label {
                font-weight: 500;
            }
            .readonly-box {
                background: #f0f4f8;
                border-radius: 5px;
                padding: 15px;
                margin-bottom: 20px;
            }
            .pet-avatar {
                width: 80px;
                height: 80px;
                object-fit: cover;
                border-radius: 8px;
            }

            .status-badge {
                display: inline-block;
                padding: 4px 12px;
                border-radius: 16px;
                font-weight: 500;
                font-size: 0.98em;
                border: 2px solid;
            }
            .status-pending {
                color: #b8860b;
                border-color: #ffd700;
                background: #fffbe6;
            }
            .status-canceled {
                color: #c82333;
                border-color: #f5c6cb;
                background: #f8d7da;
            }
            .status-completed {
                color: #218838;
                border-color: #34d058;
                background: #e6ffed;
            }
            .action-icon {
                color: #0056b3;
                cursor: pointer;
                font-size: 1.15em;
                transition: color 0.15s;
            }
            .action-icon:hover {
                color: #17a2b8;
            }
            .table th, .table td {
                vertical-align: middle !important;
                text-align: center;
                font-size: 1rem;
            }
            .action-icon {
                color: #0056b3;
                cursor: pointer;
                font-size: 1.25em;
                margin: 0 7px;
                transition: color 0.15s;
                vertical-align: middle;
            }
            .action-icon:hover {
                color: #17a2b8;
            }
            .icon-result {
                color: #28a745;
            }
            .icon-result:hover {
                color: #1e7e34;
            }
            .table th {
                font-weight: 600;
                background: #e3e9f0;
                color: #1a3d6d;
            }
            .table td {
                font-weight: 400;
            }

        </style>
        <!-- Đừng quên Bootstrap Icons -->

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    </head>
    <body>
        <c:if test="${not empty sessionScope.serviceAddSuccess}">
            <script>
                window.onload = function () {
                    alert('Thêm dịch vụ thành công!');
                }
            </script>
            <c:remove var="serviceAddSuccess" scope="session"/>
        </c:if>

        <div class="container-fluid">




            <!-- Form Thêm Dịch Vụ -->
            <form method="post" action="add-appointment-service" id="serviceForm" class="mb-4">
                <input type="hidden" name="appointmentId" id="appointmentId" value="${param.appointmentId}"/>
                <div class="mb-3">
                    <label class="form-label">Dịch vụ <span class="text-danger">*</span></label>
                    <select name="serviceId" id="serviceId" class="form-select">
                        <c:forEach var="service" items="${services}" varStatus="counter">


                            <option 
                                value="${service.id}"
                                data-price="${service.price}"
                                data-description="${service.description}"   <!-- thêm mô tả -->

                                ${counter.count}
                                ${service.name} 
                            </option>
                        </c:forEach>
                    </select>



                </div>

                <div class="mb-3">
                    <label class="form-label">Mô tả dịch vụ</label>
                    <input type="text" class="form-control" name="description" id="description" readonly>
                </div>

                <div class="mb-3">
                    <label class="form-label">Giá dịch vụ</label>
                    <input type="text" class="form-control" name="price" id="price" readonly>
                </div>
                <!-- Thêm nút quay lại -->
                <div class="mb-4 d-flex justify-content-between align-items-center">

                    <button type="submit" form="serviceForm" class="btn btn-success">Thêm dịch vụ</button>
                </div>
            </form>
                <c:if test="${not empty errorMessage}">
                    <div id="errorMessageBox" class="alert alert-danger mt-3">${errorMessage}</div>
                </c:if>
                <!-- Bảng dịch vụ -->
                <div class="card mt-4">
                    <div class="card-header bg-primary text-white">
                        Danh sách dịch vụ đã thêm cho cuộc hẹn này
                    </div>
                    <div class="card-body p-0">
                        <table class="table mb-0 align-middle text-center" id="serviceListTable">
                            <thead>
                                <tr>
                                    <th>STT</th>
                                    <th>Tên dịch vụ</th>
                                    <th>Giá (VNĐ)</th>
                                    <th>Trạng thái</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>
                            <tbody id="listServiceBody">
                                <!-- JS sẽ đổ dữ liệu vào đây -->
                            </tbody>
                        </table>
                    </div>
                </div>





        </div>


        



        <script>
            document.addEventListener('DOMContentLoaded', function () {
                let appointmentId = document.getElementById('appointmentId').value || new URLSearchParams(window.location.search).get('appointmentId');


                var serviceSelect = document.getElementById('serviceId');
                function updateServiceFields() {
                    let selected = serviceSelect.options[serviceSelect.selectedIndex];
                    document.getElementById('price').value = selected.getAttribute('data-price') || '';
                    document.getElementById('description').value = selected.getAttribute('data-description') || '';
                }
                if (serviceSelect) {
                    serviceSelect.addEventListener('change', updateServiceFields);
                    // Nếu có lựa chọn sẵn, fill luôn giá và mô tả
                    updateServiceFields();
                }


                // Hiển thị list dịch vụ đã add
                function loadListAppointmentService() {
                    fetch('./api/get-appointment-service-list?appointmentId=' + appointmentId)
                            .then(res => res.json())
                            .then(data => {
                                const tbody = document.getElementById('listServiceBody');
                                tbody.innerHTML = '';
                                if (data.services && data.services.length > 0) {
                                    data.services.forEach(function (sv, idx) {
                                        // Tô màu trạng thái
                                        let statusClass = "status-pending";
                                        let statusText = "Chờ thực hiện";
                                        if (sv.status === 'completed') {
                                            statusClass = "status-completed";
                                            statusText = "Hoàn thành";
                                        } else if (sv.status === 'canceled') {
                                            statusClass = "status-canceled";
                                            statusText = "Đã hủy";
                                        }

                                        let actionHtml = '';

// Chỉ cho hủy khi đang chờ thực hiện
                                        if (sv.status === 'pending') {
                                            actionHtml += '<span title="Hủy dịch vụ" class="action-icon cancel-service-btn text-danger" ' +
                                                    'data-id="' + sv.id + '" style="cursor:pointer">' +
                                                    '<i class="bi bi-x-circle"></i></span>';
                                        }

// Chỉ cho nhận kết quả nếu đã hoàn tất
                                        if (sv.status === 'completed') {
                                            actionHtml += '<span title="Nhận kết quả" class="action-icon icon-result receive-result-btn" ' +
                                                    'data-serid="' + sv.serid + '">' +
                                                    '<i class="bi bi-file-earmark-medical"></i></span>';
                                        }



                                        let tr = document.createElement('tr');
                                        tr.innerHTML =
                                                '<td>' + (idx + 1) + '</td>' +
                                                '<td>' + sv.serviceName + '</td>' +
                                                '<td>' + Number(sv.price).toLocaleString('vi-VN') + '</td>' +
                                                '<td><span class="status-badge ' + statusClass + '">' + statusText + '</span></td>' +
                                                '<td >' +actionHtml + '</td>';

                                        tbody.appendChild(tr);
                                    });
                                    document.querySelectorAll('.update-status-btn').forEach(function (btn) {
                                        btn.onclick = function () {
                                            document.getElementById('modalAppointmentServiceId').value = btn.getAttribute('data-id');
                                            document.getElementById('modalStatus').value = btn.getAttribute('data-status');
                                            let modalEle = document.getElementById('updateStatusModal');
                                            let modal = new bootstrap.Modal(modalEle);
                                            modal.show();
                                        };



                                    });

                                } else {
                                    tbody.innerHTML = '<tr><td colspan="5" class="text-center text-muted">Chưa có dịch vụ nào</td></tr>';
                                }
                            });
                }


                loadListAppointmentService();
                document.addEventListener('click', function (e) {
                    const btn = e.target.closest('.receive-result-btn');
                    if (btn) {
                        // Lấy đúng appointmentId hiện tại

                        const serviceId = btn.getAttribute('data-serid');
                        if (!serviceId) {
                            alert("Không tìm thấy mã dịch vụ.");
                            return;
                        }
                        fetch('./api/get-files?appointmentId=' + appointmentId + '&serviceId=' + serviceId)
                                .then(res => res.json())
                                .then(data => {
                                    if (data.files && data.files.length > 0) {
                                        data.files.forEach(file => {
                                            const a = document.createElement('a');
                                            a.href = file.fileUrl;
                                            a.download = file.fileName || 'result_file';
                                            document.body.appendChild(a);
                                            a.click();
                                            document.body.removeChild(a);
                                        });
                                    } else {
                                        alert('Không có file kết quả nào!');
                                    }
                                });
                    }
                });


                // Reload lại list khi form submit thành công
                document.getElementById('serviceForm').addEventListener('submit', function (e) {
                    setTimeout(loadListAppointmentService, 500); // Sau 0.5s reload list lại (hoặc reload sau khi xử lý thành công ở backend)
                });
                var errBox = document.getElementById('errorMessageBox');
                if (errBox) {
                    setTimeout(function () {
                        errBox.style.display = 'none';
                    }, 3000);
                }
                document.addEventListener('click', function (e) {
                    const btn = e.target.closest('.cancel-service-btn');
                    if (btn) {
                        const serviceId = btn.getAttribute('data-id');
                        if (!confirm('Bạn có chắc muốn hủy dịch vụ này?'))
                            return;

                        fetch('./doctor-update-status-appointment-service?id=' + encodeURIComponent(serviceId) + '&status=canceled', {
                            method: 'GET'
                        })
                                .then(response => {
                                    if (response.ok) {
                                        alert('Dịch vụ đã được hủy.');
                                        loadListAppointmentService();
                                    } else {
                                        alert('Không thể hủy dịch vụ!');
                                    }
                                })
                                .catch(() => alert('Có lỗi xảy ra khi gửi yêu cầu hủy.'));
                    }
                });

                document.getElementById('serviceForm').addEventListener('submit', function (e) {
                    e.preventDefault();
                    let form = e.target;
                    let formData = new FormData(form);
                    formData.append("appointmentId", appointmentId);

                    fetch('add-appointment-service', {
                        method: 'POST',
                        body: formData
                    })
                            .then(res => res.json())
                            .then(data => {
                                alert(data.message);
                                if (data.status === 'success') {
                                    form.reset();
                                    // Sau khi thành công, load lại bảng dịch vụ
                                    loadListAppointmentService();
                                }
                            })
                            .catch(() => alert('Lỗi khi gửi dữ liệu!'));
                });


            });

        </script>


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
