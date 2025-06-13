<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm Dịch Vụ Cho Cuộc Hẹn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f6f8fa; }
        .container { max-width: 750px; margin-top: 40px; }
        .form-label { font-weight: 500; }
        .readonly-box { background: #f0f4f8; border-radius: 5px; padding: 15px; margin-bottom: 20px; }
        .pet-avatar { width: 80px; height: 80px; object-fit: cover; border-radius: 8px; }
    
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
.action-icon:hover { color: #17a2b8; }
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
    .action-icon:hover { color: #17a2b8; }
    .icon-result { color: #28a745; }
    .icon-result:hover { color: #1e7e34; }
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
<div class="container">
    <h2 class="text-center mb-4 text-primary">Thêm Dịch Vụ Cho Cuộc Hẹn</h2>

    <!-- Thông tin Pet & Chủ pet (readonly) -->
    <div class="readonly-box" id="petOwnerInfo">
        <div class="row align-items-center">
            <div class="col-auto">
                <img id="petAvatar" src="${pageContext.request.contextPath}/assets/images/default_pet.png" class="pet-avatar" alt="pet avatar"/>
            </div>
            <div class="col">
                <div><b>Mã Pet:</b> <span id="petCode"></span></div>
                <div><b>Tên Pet:</b> <span id="petName"></span></div>
                <div><b>Giống:</b> <span id="petBreed"></span></div>
                <div><b>Giới tính:</b> <span id="petGender"></span></div>
                <div><b>Ngày sinh:</b> <span id="petBirth"></span></div>
            </div>
            <div class="col">
                <div><b>Chủ nuôi:</b> <span id="ownerName"></span></div>
                <div><b>Điện thoại:</b> <span id="ownerPhone"></span></div>
                <div><b>Email:</b> <span id="ownerEmail"></span></div>
                <div><b>Địa chỉ:</b> <span id="ownerAddress"></span></div>
            </div>
        </div>
    </div>

    <!-- Form Thêm Dịch Vụ -->
    <form method="post" action="add-appointment-service" id="serviceForm" class="mb-4">
        <input type="hidden" name="appointmentId" id="appointmentId" value="${param.appointmentId}"/>
        <div class="mb-3">
            <label class="form-label">Dịch vụ <span class="text-danger">*</span></label>
            <select name="serviceId" id="serviceId" class="form-select">
    <c:forEach var="service" items="${services}">
        <c:set var="isAdded" value="false"/>
        <c:forEach var="apmService" items="${addedServices}">
            <c:if test="${apmService.service.id eq service.id}">
                <c:set var="isAdded" value="true"/>
            </c:if>
        </c:forEach>
        <option 
            value="${service.id}"
            data-price="${service.price}"    <!-- NÀY LÀ QUAN TRỌNG -->
            <c:if test="${isAdded}">disabled</c:if>
        >
            ${service.name} <c:if test="${isAdded}">(Đã thêm)</c:if>
        </option>
    </c:forEach>
</select>


        </div>
        <div class="mb-3">
            <label class="form-label">Giá dịch vụ</label>
            <input type="text" class="form-control" name="price" id="price" readonly>
        </div>
        <!-- Thêm nút quay lại -->
<div class="mb-4 d-flex justify-content-between align-items-center">
    <a href="doctor-time-table" class="btn btn-outline-secondary">
        <i class="bi bi-arrow-left"></i> Quay lại
    </a>
    <button type="submit" form="serviceForm" class="btn btn-success">Thêm dịch vụ</button>
</div>
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
        

<c:if test="${not empty sessionScope.serviceAddSuccess}">
    <script>
        window.onload = function() { alert('Thêm dịch vụ thành công!'); }
    </script>
    <c:remove var="serviceAddSuccess" scope="session"/>
</c:if>

   <div class="modal fade" id="updateStatusModal" tabindex="-1" aria-labelledby="updateStatusModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="updateStatusModalLabel">Cập nhật trạng thái</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <input type="hidden" id="modalAppointmentServiceId">
        <div class="mb-3">
          <label for="modalStatus" class="form-label">Trạng thái</label>
          <select id="modalStatus" class="form-select">
            <option value="pending">Đang xử lý</option>
            
            <option value="completed">Hoàn tất</option>
            <option value="canceled">Đã hủy</option>
          </select>
        </div>
      </div>
      <div class="modal-footer">
        <button id="btnUpdateStatus" type="button" class="btn btn-primary">Cập nhật</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
      </div>
    </div>
  </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    let appointmentId = document.getElementById('appointmentId').value || new URLSearchParams(window.location.search).get('appointmentId');
    if (!appointmentId) {
        alert('Không tìm thấy mã cuộc hẹn!');
        return;
    }
    // Gọi API để lấy thông tin pet, chủ pet
    fetch('./api/getappointmentdetails?id=' + appointmentId)
        .then(res => res.json())
        .then(data => {
            const appt = data.appointments[0];
            
            document.getElementById('petAvatar').src = './'+ appt.petAvatar;
            document.getElementById('petCode').innerText = appt.petCode || '-';
            document.getElementById('petName').innerText = appt.petName || '-';
            document.getElementById('petBreed').innerText = appt.petBreed || '-';
            document.getElementById('petGender').innerText = appt.petGender || '-';
            document.getElementById('petBirth').innerText = appt.petBirth || '-';
            document.getElementById('ownerName').innerText = appt.ownerName || '-';
            document.getElementById('ownerPhone').innerText = appt.ownerPhone || '-';
            document.getElementById('ownerEmail').innerText = appt.ownerEmail || '-';
            document.getElementById('ownerAddress').innerText = appt.ownerAddress || '-';
        })
        .catch(() => alert('Không thể load thông tin pet!'));

    var serviceSelect = document.getElementById('serviceId');
    if (serviceSelect) {
        serviceSelect.addEventListener('change', function() {
            let selected = this.options[this.selectedIndex];
            document.getElementById('price').value = selected.getAttribute('data-price') || '';
        });
        // Nếu có lựa chọn sẵn, fill luôn giá
        if (serviceSelect.selectedIndex >= 0) {
            let selected = serviceSelect.options[serviceSelect.selectedIndex];
            document.getElementById('price').value = selected.getAttribute('data-price') || '';
        }
    }

    // Hiển thị list dịch vụ đã add
    function loadListAppointmentService() {
    fetch('./api/get-appointment-service-list?appointmentId=' + appointmentId)
        .then(res => res.json())
        .then(data => {
            const tbody = document.getElementById('listServiceBody');
            tbody.innerHTML = '';
            if (data.services && data.services.length > 0) {
                data.services.forEach(function(sv, idx) {
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

                    // Icon update
                    let updateBtn = '<span title="Cập nhật trạng thái" class="action-icon update-status-btn" ' +
    'data-id="' + sv.id + '" data-status="' + sv.status + '" style="cursor:pointer">' +
    '<i class="bi bi-pencil-square"></i>' +
    '</span>';
    let resultBtn = 
    '<span title="Nhận kết quả" class="action-icon icon-result receive-result-btn" ' +
    'data-id="' + sv.id + '">' +
        '<i class="bi bi-file-earmark-medical"></i>' +
    '</span>';



                    let tr = document.createElement('tr');
                    tr.innerHTML =
                        '<td>' + (idx + 1) + '</td>' +
                        '<td>' + sv.serviceName + '</td>' +
                        '<td>' + Number(sv.price).toLocaleString('vi-VN') + '</td>' +
                        '<td><span class="status-badge ' + statusClass + '">' + statusText + '</span></td>' +
                        '<td >' + updateBtn +resultBtn+ '</td>';

                    tbody.appendChild(tr);
                });
                document.querySelectorAll('.update-status-btn').forEach(function(btn) {
  btn.onclick = function() {
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
    document.addEventListener('click', function(e) {
    const btn = e.target.closest('.receive-result-btn');
    if (btn) {
        // Lấy đúng appointmentId hiện tại
        
        const serviceId = btn.getAttribute('data-id');
        if (!serviceId) {
            alert("Không tìm thấy mã dịch vụ.");
            return;
        }
        fetch('/api/get-files?appointmentId=' + appointmentId + '&serviceId=' + serviceId)
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
    document.getElementById('serviceForm').addEventListener('submit', function(e) {
        setTimeout(loadListAppointmentService, 500); // Sau 0.5s reload list lại (hoặc reload sau khi xử lý thành công ở backend)
    });
     var errBox = document.getElementById('errorMessageBox');
    if (errBox) {
        setTimeout(function() {
            errBox.style.display = 'none';
        }, 3000);
    }
     document.getElementById('btnUpdateStatus').addEventListener('click', function () {
      const appointmentServiceId = document.getElementById('modalAppointmentServiceId').value;
      const status = document.getElementById('modalStatus').value;

      fetch('update-status-appointment-service?id=' + encodeURIComponent(appointmentServiceId) + '&status=' + encodeURIComponent(status), {
        method: 'GET'
      })
      .then(response => {
        if (response.ok) {
          // Ẩn modal
          bootstrap.Modal.getInstance(document.getElementById('updateStatusModal')).hide();
          // Gọi lại API hoặc hàm render danh sách
          loadListAppointmentService();
        } else {
          alert('Cập nhật thất bại!');
        }
      });
    });
  });

</script>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
