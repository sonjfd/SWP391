<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Nhập kết quả xét nghiệm - Y tá</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <style>
            body {
                background: #f8f9fa;
            }
            .table-hover tbody tr:hover {
                background-color: #e7f3fa;
            }
            .nurse-header {
                background: #0d6efd;
                color: white;
            }
            .avatar {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                object-fit: cover;
            }
            .icon-btn {
                border: none;
                background: none;
                color: #0d6efd;
                font-size: 1.2rem;
                transition: color 0.15s;
            }
            .icon-btn:hover {
                color: #0a58ca;
            }
            .form-control, .form-select {
                min-height: 34px !important;
                height: 34px !important;
                padding-top: 2px;
                padding-bottom: 2px;
                font-size: 0.98rem;
            }
        </style>
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

    </head>
    <body>
        <%@include file="../layout/Header.jsp" %>

         <div class="container-fluid bg-light">
            <div class="layout-specing">



                

            <!-- FILTER FORM -->
            <form class="row g-2 mb-4 align-items-center" method="get" action="">
                <div class="col-md-2">
                    <input type="text" name="petName" class="form-control form-control-sm" placeholder="Tên thú cưng" value="${fn:escapeXml(param.petName)}">
                </div>
                <div class="col-md-2">
                    <input type="text" name="ownerName" class="form-control form-control-sm" placeholder="Tên chủ nuôi" value="${fn:escapeXml(param.ownerName)}">
                </div>
                <div class="col-md-3">
                    <select name="serviceId" class="form-select form-select-sm">
                        <option value="">-- Tất cả dịch vụ --</option>
                        <c:forEach var="sv" items="${serviceList}">
                            <option value="${sv.id}" ${param.serviceId==sv.id ? 'selected' : ''}><c:out value="${sv.name}" /></option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-3 d-flex">
                    <input type="date" name="fromDate" class="form-control form-control-sm me-2" value="${param.fromDate}">
                    <input type="date" name="toDate" class="form-control form-control-sm me-2" value="${param.toDate}">
                    <button class="btn btn-primary btn-sm px-3" type="submit"><i class="bi bi-funnel"></i></button>
                </div>
            </form>

            <!-- BẢNG DANH SÁCH -->
            <div class="card shadow mb-4">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0">Danh sách phiếu xét nghiệm chờ nhập kết quả</h5>
                </div>
                <div class="card-body p-0">
                    <table class="table table-hover align-middle mb-0">
                        <thead>
                            <tr>
                                <th>Mã thú cưng</th>
                                <th>Thú cưng</th>
                                <th>Chủ nuôi</th>
                                <th>Dịch vụ</th>
                                <th>Ngày chỉ định</th>
                                <th class="text-center">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="aps" items="${list}">
                            <tr>
                                <td>
                            <c:out value="${aps.appointment.pet.pet_code}" />
                            </td>
                            <td>
                                <img src="${aps.appointment.pet.avatar != null ? aps.appointment.pet.avatar : '/assets/images/default_pet.png'}" class="avatar me-2" />
                            <c:out value="${aps.appointment.pet.name}" />
                            </td>
                            <td>
                            <c:out value="${aps.appointment.pet.user.fullName}" />
                            </td>
                            <td>
                            <c:out value="${aps.service.name}" />
                            </td>
                            <td>
                            <fmt:formatDate value="${aps.createdAt}" pattern="dd/MM/yyyy" />
                            </td>
                            <td class="text-center">
                                <!-- Icon Nhập kết quả -->
                                <button type="button" class="icon-btn open-upload-modal-btn"
                                        data-bs-toggle="modal"
                                        data-bs-target="#uploadResultModal"
                                        data-id="${aps.appointment.id}"
                                        data-serid="${aps.service.id}"
                                        data-petname="${aps.appointment.pet.name}"
                                        data-petavatar="${aps.appointment.pet.avatar != null ? aps.appointment.pet.avatar : '/assets/images/default_pet.png'}"
                                        data-ownername="${aps.appointment.pet.user.fullName}"
                                        data-servicename="${aps.service.name}"
                                        title="Upload file kết quả">
                                    <i class="bi bi-upload"></i>
                                </button>
                                <!-- Icon Xem file kết quả (giả sử link JSP là NurseViewResultServlet?id=...) -->
                                <a href="#" class="icon-btn ms-2 open-view-result-modal-btn"
                                   data-id="${aps.appointment.id}"
                                   data-serid="${aps.service.id}"
                                   title="Xem kết quả đã upload">
                                    <i class="bi bi-file-earmark-text"></i>
                                </a>
                                <!-- Thêm icon "Đánh dấu hoàn thành" -->
                                <button type="button"
                                        class="icon-btn mark-completed-btn"
                                        data-id="${aps.id}"
                                        title="Đánh dấu đã hoàn thành">
                                    <i class="bi bi-check-circle"></i>
                                </button>

                            </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty list}">
                            <tr>
                                <td colspan="6" class="text-center text-muted py-4">Không có phiếu nào phù hợp!</td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- PHÂN TRANG -->
            <c:if test="${totalPages > 1}">
                <nav aria-label="Page navigation">
                    <ul class="pagination justify-content-center">
                        <c:forEach begin="1" end="${totalPages}" var="p">
                            <li class="page-item ${p == page ? 'active' : ''}">
                                <a class="page-link"
                                   href="?page=${p}&pageSize=10
                                   &petName=${fn:escapeXml(param.petName)}
                                   &ownerName=${fn:escapeXml(param.ownerName)}
                                   &serviceId=${fn:escapeXml(param.serviceId)}
                                   &fromDate=${fn:escapeXml(param.fromDate)}
                                   &toDate=${fn:escapeXml(param.toDate)}">
                                    ${p}
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </nav>
            </c:if>

        </div>
         </div>
        <!-- Modal upload file -->
        <div class="modal fade" id="uploadResultModal" tabindex="-1" aria-labelledby="uploadResultLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form id="uploadResultForm" enctype="multipart/form-data">
                        <div class="modal-header bg-success text-white">
                            <h5 class="modal-title" id="uploadResultLabel">Upload file kết quả xét nghiệm</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" name="appointmentId" id="modal-appointmentId" />
                            <input type="hidden" name="serviceId" id="modal-serviceId" />
                            <div class="mb-3 d-flex align-items-center">
                                <img src="" id="modal-pet-avatar" class="avatar me-3">
                                <div>
                                    <div><strong id="modal-pet-name"></strong></div>
                                    <div class="text-muted" style="font-size: 0.95em;">Chủ nuôi: <span id="modal-owner-name"></span></div>
                                    <div class="text-muted" style="font-size: 0.95em;">Dịch vụ: <strong id="modal-service-name"></strong></div>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Đính kèm file kết quả (ảnh, PDF...)</label>
                                <input class="form-control" type="file" name="files" id="modal-upload-files" accept="image/*,.pdf" multiple required>
                                <div class="form-text">Có thể chọn nhiều file (tối đa 5 file, tối đa 10MB/file)</div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-success">
                                <i class="bi bi-upload"></i> Upload
                            </button>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        
        <!--modal danh sách file-->
        <div class="modal fade" id="viewResultModal" tabindex="-1" aria-labelledby="viewResultLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header bg-info text-white">
        <h5 class="modal-title" id="viewResultLabel">Kết quả đã upload</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
      </div>
      <div class="modal-body">
        <div id="view-result-list">
          <!-- Bảng sẽ render bằng JS -->
        </div>
      </div>
    </div>
  </div>
</div>



        <script>
            document.addEventListener('DOMContentLoaded', function () {
                document.querySelectorAll('.mark-completed-btn').forEach(function (btn) {
                    btn.addEventListener('click', function () {
                        if (!confirm('Bạn chắc chắn muốn đánh dấu là hoàn thành?'))
                            return;
                        const id = btn.getAttribute('data-id');
                        fetch('./update-status-appointment-service', {
                            method: 'POST',
                            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                            body: 'id=' + encodeURIComponent(id) + '&status=completed'
                        })
                                .then(function (res) {
                                    return res.json();
                                })
                                .then(function (data) {
                                    if (data.success) {

                                        location.reload();
                                    } else {
                                        alert("Cập nhật thất bại!");
                                    }
                                })
                                .catch(function () {
                                    alert("Có lỗi xảy ra!");
                                });
                    });
                });
            });
        </script>
        <script>
            let modal = document.getElementById('uploadResultModal');
            let form = document.getElementById('uploadResultForm');
            let modalPetAvatar = document.getElementById('modal-pet-avatar');
            let modalPetName = document.getElementById('modal-pet-name');
            let modalOwnerName = document.getElementById('modal-owner-name');
            let modalServiceName = document.getElementById('modal-service-name');
            let modalAppointmentId = document.getElementById('modal-appointmentId');
            let modalServiceId = document.getElementById('modal-serviceId');

            document.querySelectorAll('.open-upload-modal-btn').forEach(function (btn) {
                btn.addEventListener('click', function () {
                    modalAppointmentId.value = btn.getAttribute('data-id');
                    modalServiceId.value = btn.getAttribute('data-serid');
                    modalPetName.textContent = btn.getAttribute('data-petname');
                    modalOwnerName.textContent = btn.getAttribute('data-ownername');
                    modalServiceName.textContent = btn.getAttribute('data-servicename');
                    modalPetAvatar.src = btn.getAttribute('data-petavatar');
                    // Reset file input
                    document.getElementById('modal-upload-files').value = '';
                });
            });

            // Submit form bằng fetch (AJAX)
            form.onsubmit = function (e) {
                e.preventDefault();
                let formData = new FormData(form);
                fetch('./nurse-uploadtestresultservice', {
                    method: 'POST',
                    body: formData
                })
                        .then(res => res.json())
                        .then(data => {
                            var modalInstance = bootstrap.Modal.getInstance(modal);
                            if (data.success) {
                                modalInstance.hide();
                                alert("Upload file thành công!");
                                // Có thể reload bảng, hoặc ẩn nút upload đã hoàn thành...
                                // location.reload();
                            } else {
                                alert("Có lỗi khi upload file!");
                            }
                        })
                        .catch(() => {
                            alert("Không gửi được file lên server!", "danger");
                        });
            };


// của xem file 
document.querySelectorAll('.open-view-result-modal-btn').forEach(function(btn) {
    btn.addEventListener('click', function(e) {
        e.preventDefault();
        let appointmentServiceId = btn.getAttribute('data-id');
        let serviceId = btn.getAttribute('data-serid');

        fetch('./nurse-viewuploadedresultapi?appointmentId=' + encodeURIComponent(appointmentServiceId) + '&serviceId=' + encodeURIComponent(serviceId))
            .then(function(res) { return res.json(); })
            .then(function(data) {
                let html = '';
                if (data.files && data.files.length > 0) {
                    html += '<table class="table table-bordered align-middle">' +
                            '<thead class="table-light">' +
                              '<tr>' +
                                '<th>Tên file</th>' +
                                '<th>Xem</th>' +
                                '<th>Người upload</th>' +
                                '<th>Ngày upload</th>' +
                                '<th class="text-center">Xóa</th>' +
                              '</tr>' +
                            '</thead>' +
                            '<tbody>';
                    data.files.forEach(function(file) {
                        let ext = file.file_url.split('.').pop().toLowerCase();
                        let isImage = ['jpg','jpeg','png','gif','bmp','webp'].includes(ext);
                        html += '<tr data-fileid="' + file.id + '">' +
                            '<td>' + file.file_name + '</td>' +
                            '<td>' +
                                '<a href="' + file.file_url + '" target="_blank" class="btn btn-outline-info btn-sm">' +
                                    (isImage ?
                                        '<i class="bi bi-image"></i>' :
                                        '<i class="bi bi-file-earmark-pdf"></i>'
                                    ) +
                                '</a>' +
                            '</td>' +
                            '<td>' + (file.uploader_name || '<span class="text-muted">?</span>') + '</td>' +
                            '<td>' + (file.uploaded_at_fmt || '') + '</td>' +
                            '<td class="text-center">' +
                                '<button class="btn btn-outline-danger btn-sm delete-uploaded-file-btn" ' +
                                        'data-fileid="' + file.id + '" title="Xóa file">' +
                                    '<i class="bi bi-trash"></i>' +
                                '</button>' +
                            '</td>' +
                        '</tr>';
                    });
                    html += '</tbody></table>';
                } else {
                    html = '<div class="text-center text-muted py-3">Chưa có file nào được upload!</div>';
                }
                document.getElementById('view-result-list').innerHTML = html;

                let modal = new bootstrap.Modal(document.getElementById('viewResultModal'));
                modal.show();

                document.querySelectorAll('.delete-uploaded-file-btn').forEach(function(delBtn) {
                    delBtn.addEventListener('click', function() {
                        if (!confirm('Xóa file này?')) return;
                        let fileId = delBtn.getAttribute('data-fileid');
                        fetch('./nurse-deleteuploadedfileajax', {
                            method: 'POST',
                            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                            body: 'id=' + encodeURIComponent(fileId)
                        })
                        .then(function(res) { return res.json(); })
                        .then(function(data) {
                            if (data.success) {
                                delBtn.closest('tr').remove();
                                if (document.querySelectorAll('#view-result-list tbody tr').length === 0) {
                                    document.getElementById('view-result-list').innerHTML = '<div class="text-center text-muted py-3">Chưa có file nào được upload!</div>';
                                }
                            } else {
                                alert('Xóa thất bại!');
                            }
                        })
                        .catch(function() {
                            alert('Lỗi kết nối server!');
                        });
                    });
                });
            });
    });
});



        </script>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
 <!-- simplebar -->
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/simplebar.min.js"></script>
       
        <!-- Icons -->
        <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
    </body>
</html>
