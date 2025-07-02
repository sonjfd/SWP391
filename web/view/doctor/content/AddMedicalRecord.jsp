<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
    .table td, .table th {
  word-wrap: break-word;
  word-break: break-word;
  white-space: normal; /* Cho phép xuống dòng */
  vertical-align: middle;
}

</style>
<form></form>
<div id="medicalRecordFormContainer">
  <form method="post" action="doctor-add-medical-record" id="medicalRecordForm" enctype="multipart/form-data">
    <input type="hidden" name="appointmentId" id="appointmentId" value="${param.appointmentId}"/>
    <input type="hidden" name="doctorId" id="doctorId" value=""/>
    <input type="hidden" name="petId" id="petId" value=""/>

    <div class="row g-3 mb-3">
      <div class="col-md-6">
        <label class="form-label">Chẩn đoán <span class="text-danger">*</span></label>
        <textarea class="form-control" name="diagnosis" id="diagnosis" rows="2" data-required="true" maxlength="255"></textarea>
      </div>
      <div class="col-md-6">
        <label class="form-label">Phác đồ điều trị <span class="text-danger">*</span></label>
        <textarea class="form-control" name="treatment" id="treatment" rows="2" data-required="true" maxlength="255"></textarea>
      </div>
    </div>

    <div class="row g-3 mb-3">
      <div class="col-md-4">
        <label class="form-label">Ngày hẹn tái khám</label>
        <input type="date" class="form-control" name="reExamDate" id="reExamDate"/>
      </div>
      <div class="col-md-8">
        <label class="form-label">Tải hồ sơ đính kèm</label>
        <input type="file" class="form-control" name="files" id="files" multiple>
      </div>
    </div>

    <div class="mb-3">
      <label class="form-label">Kê đơn thuốc</label>
      <div class="table-responsive">
        <table class="table table-bordered align-middle text-center">
          <thead class="table-light">
            <tr>
              <th>Tên thuốc</th>
              <th>Số lượng</th>
              <th>Liều dùng</th>
              <th>Thời gian</th>
              <th>Hướng dẫn</th>
              <th>
                <button type="button" id="addMedicineBtn" class="btn btn-sm btn-success">
                  <i class="bi bi-plus"></i>
                </button>
              </th>
            </tr>
          </thead>
          <tbody id="prescribedMedicinesBody">
            <!-- JS thêm dòng thuốc -->
          </tbody>
        </table>
      </div>
    </div>

    <div class="text-end">
      <button type="submit" class="btn btn-primary">Lưu hồ sơ</button>
    </div>
  </form>
</div>
<!-- Danh sách hồ sơ -->
<div class="mt-4">
  <h5 class="mb-3">Danh sách hồ sơ y tế đã tạo</h5>
  <div class="table-responsive">
  <table class="table table-striped table-hover border rounded">
    <thead class="table-primary text-center align-middle">
      <tr>
        <th style="width: 50px;">STT</th>
        <th style="width: 120px;">Ngày tạo</th>
        <th style="width: 200px;">Chẩn đoán</th>
        <th style="width: 200px;">Phác đồ</th>
        <th style="width: 120px;">Tái khám</th>
        <th style="width: 150px;">File</th>
        <th style="width: 250px;">Thuốc</th>
        <th style="width: 80px;">Hành động</th>
      </tr>
      </thead>
      <tbody id="listMedicalRecordBody" class="text-center">
        <!-- JS render data -->
      </tbody>
    </table>
  </div>
</div>

        <c:if test="${not empty errorMessage}">
    <c:set var="error" value="${errorMessage}"></c:set>
    <script>
        window.onload = function() { alert(error); };
    </script>
    <div id="errorMessageBox" class="alert alert-danger mt-3">${errorMessage}</div>
</c:if>
  <c:if test="${not empty sessionScope.message}">
    <script>
        window.onload = function() { alert('Thêm hồ sơ thành công!'); }
    </script>
    <c:remove var="message" scope="session"/>
</c:if>
<script>
// Truyền list thuốc từ server sang JS (mảng object)
window.medicineList = [
    <c:forEach var="m" items="${medicines}" varStatus="s">
        {id: "${m.id}", name: "${m.name}"}<c:if test="${!s.last}">,</c:if>
    </c:forEach>
];

document.addEventListener('DOMContentLoaded', function() {
    var appointmentId = document.getElementById('appointmentId').value || new URLSearchParams(window.location.search).get('appointmentId');
    if (!appointmentId) {
        alert('Không tìm thấy mã cuộc hẹn!');
        return;
    }
    
    
    

    // Kê đơn thuốc - add/remove dòng động
    var addBtn = document.getElementById('addMedicineBtn');
    var tbody = document.getElementById('prescribedMedicinesBody');
    addBtn.addEventListener('click', function() {
        var selectStr = '<select name="medicineId" class="form-select" data-required="true">';
        for (var i = 0; i < window.medicineList.length; i++) {
            selectStr += '<option value="' + window.medicineList[i].id + '">' + window.medicineList[i].name + '</option>';
        }
        selectStr += '</select>';
        var row = document.createElement('tr');
        row.innerHTML =
            '<td>' + selectStr + '</td>' +
            '<td><input type="number" name="medicineQuantity" min="1" class="form-control" required maxlength="255"></td>' +
            '<td><input type="text" name="medicineDosage" class="form-control" required maxlength="255"></td>' +
            '<td><input type="text" name="medicineDuration" class="form-control" required maxlength="255"></td>' +
            '<td><input type="text" name="medicineInstructions" class="form-control" required maxlength="255"></td>' +
            '<td><button type="button" class="btn btn-danger btn-sm remove-medicine-btn" ><i class="bi bi-x"></i></button></td>';
        tbody.appendChild(row);
    });

    // Xóa dòng thuốc
    tbody.addEventListener('click', function(e) {
        if (e.target.closest('.remove-medicine-btn')) {
            var btn = e.target.closest('.remove-medicine-btn');
            btn.parentNode.parentNode.parentNode.removeChild(btn.parentNode.parentNode);
        }
    });
    // Hàm tạo error span dưới input nếu chưa có
function setError(input, message) {
    input.classList.add('is-invalid');
    let errorSpan = input.nextElementSibling;
    if (!errorSpan || !errorSpan.classList.contains('invalid-feedback')) {
        errorSpan = document.createElement('div');
        errorSpan.className = 'invalid-feedback';
        input.parentNode.appendChild(errorSpan);
    }
    errorSpan.innerText = message;
}

// Xóa error
function clearError(input) {
    input.classList.remove('is-invalid');
    let errorSpan = input.nextElementSibling;
    if (errorSpan && errorSpan.classList.contains('invalid-feedback')) {
        errorSpan.remove();
    }
}

// Bắt sự kiện onblur
document.querySelectorAll('#medicalRecordForm input[type="text"], #medicalRecordForm textarea, #reExamDate').forEach(function(input) {
    input.addEventListener('blur', function() {
        const name = input.name || input.id;
        const value = input.value.trim();

        // Validate bắt buộc
        if (input.dataset.required === 'true' && !value) {
            setError(input, 'Trường này là bắt buộc.');
            return;
        }

        // Giới hạn ký tự
        const maxLen = 255;
        if (value.length > maxLen) {
            setError(input, 'Không được vượt quá ' + maxLen + ' ký tự.');
            return;
        }

        // Validate ngày hẹn tái khám
        if (input.id === 'reExamDate' && value) {
            const selectedDate = new Date(value);
            const today = new Date();
            today.setHours(0, 0, 0, 0);
            if (selectedDate < today) {
                setError(input, 'Không được chọn ngày trong quá khứ.');
                return;
            }
        }

        clearError(input);
    });
});


    // Load danh sách hồ sơ y tế đã tạo cho cuộc hẹn này
    function loadListMedicalRecords() {
        const formContainer = document.getElementById('medicalRecordFormContainer');
        fetch('./api/get-medical-records?appointmentId=' + appointmentId)
            .then(function(res) { return res.json(); })
            .then(function(data) {
                var tbody = document.getElementById('listMedicalRecordBody');
                tbody.innerHTML = '';
                if (data.records && data.records.length > 0) {
                    if (formContainer) formContainer.style.display = 'none';
                    for (var i = 0; i < data.records.length; i++) {
                        var rec = data.records[i];
                        var fileLinks = '';
                        if (rec.files && rec.files.length > 0) {
                            for (var j = 0; j < rec.files.length; j++) {
                                var file = rec.files[j];
                                fileLinks += '<a href="' + file.fileUrl + '" download="' + file.fileName + '" class="btn btn-link p-0">' + file.fileName + '</a><br>';
                            }
                        } else {
                            fileLinks = '<span class="text-muted">Không có</span>';
                        }

                        // Chuỗi thuốc đã kê
                        var medicinesStr = '';
                        if (rec.prescribedMedicines && rec.prescribedMedicines.length > 0) {
                            for (var k = 0; k < rec.prescribedMedicines.length; k++) {
                                var m = rec.prescribedMedicines[k];
                                medicinesStr +=
                                    (k + 1) + '. ' + m.medicineName +
                                    ' - SL: ' + m.quantity +
                                    (m.dosage ? ', Liều: ' + m.dosage : '') +
                                    (m.duration ? ', TG: ' + m.duration : '') +
                                    (m.instructions ? ', HD: ' + m.instructions : '') + '<br>';
                            }
                        } else {
                            medicinesStr = '<span class="text-muted">Không có</span>';
                        }

                        

var tr = document.createElement('tr');
let actionButtons = '';

if (rec.appointmentStatus.toLowerCase() !== 'completed') {
  actionButtons +=
    '<a href="doctor-edit-medical-record?id=' + rec.id + '" class="me-2 text-primary" title="Sửa">' +
      '<i class="bi bi-pencil-square"></i>' +
    '</a>' +
    '<button class="btn btn-sm btn-outline-success mark-done-btn" data-id="' + rec.appointmentId + '" title="Hoàn thành cuộc hẹn">' +
      '<i class="bi bi-check-circle"></i>' +
    '</button>';
}else{

actionButtons +=
  '<a href="doctor-print-medical-record?id=' + rec.id + '" target="_blank" class="me-2 text-secondary" title="In hồ sơ">' +
    '<i class="bi bi-printer"></i>' +
  '</a>';
}
tr.innerHTML =
  '<td>' + (i + 1) + '</td>' +
  '<td>' + (rec.createdAt ? new Date(rec.createdAt).toLocaleDateString('vi-VN') : '-') + '</td>' +
  '<td>' + (rec.diagnosis || '-') + '</td>' +
  '<td>' + (rec.treatment || '-') + '</td>' +
  '<td>' + (rec.reExamDate ? new Date(rec.reExamDate).toLocaleDateString('vi-VN') : '-') + '</td>' +
  '<td>' + fileLinks + '</td>' +
  '<td>' + medicinesStr + '</td>' +
  '<td>' + actionButtons + '</td>'; // Cột hành động

tbody.appendChild(tr);

                    }
                } else {
                    if (formContainer) formContainer.style.display = 'block';
                    tbody.innerHTML = '<tr><td colspan="8" class="text-center text-muted">Chưa có hồ sơ nào</td></tr>';
                }
            });
    }
    loadListMedicalRecords();
    
    document.addEventListener('click', function (e) {
    if (e.target.closest('.mark-done-btn')) {
        const btn = e.target.closest('.mark-done-btn');
        

        if (!confirm('Bạn chắc chắn muốn đánh dấu cuộc hẹn này là hoàn thành?')) return;

        fetch('./doctor-update-status-appointment', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                appointmentId: appointmentId,
                status: 'completed'
            })
        })
        .then(res => res.json())
        .then(data => {
            if (data.status === 'success') {
                alert('Đã đánh dấu hoàn thành!');
                loadListMedicalRecords(); // reload lại danh sách
                location.reload(true);
            } else {
                alert('Thao tác thất bại: ' + (data.message || 'Lỗi không xác định'));
            }
        })
        .catch(err => {
            console.error(err);
            alert('Lỗi khi gửi yêu cầu!');
        });
    }
});

    // Ẩn message lỗi sau 3s
    var errBox = document.getElementById('errorMessageBox');
    if (errBox) {
        setTimeout(function() {
            errBox.style.display = 'none';
        }, 3000);
    }
    var form = document.getElementById('medicalRecordForm');
    form.addEventListener('submit', function(e) {
        e.preventDefault(); // Ngăn submit mặc định

    let valid = true;

    // Gọi lại onblur để validate từng input
    form.querySelectorAll('#medicalRecordForm input[type="text"], #medicalRecordForm textarea, #reExamDate').forEach(function(input) {
        input.dispatchEvent(new Event('blur')); // Kích hoạt onblur
        if (input.classList.contains('is-invalid')) {
            valid = false;
        }
    });

    if (!valid) {
        alert('Vui lòng điền đầy đủ và đúng các trường bắt buộc!');
        return;
    }

        // Chuẩn bị FormData để gửi (bao gồm file, mảng thuốc ...)
        var formData = new FormData(form);
        
        formData.set("appointmentId",appointmentId);

        // Đọc thuốc đã kê (nhiều dòng)
        document.querySelectorAll('#prescribedMedicinesBody tr').forEach(function(tr, idx) {
            var medId = tr.querySelector('[name="medicineId"]')?.value;
            var medQty = tr.querySelector('[name="medicineQuantity"]')?.value;
            var medDosage = tr.querySelector('[name="medicineDosage"]')?.value;
            var medDuration = tr.querySelector('[name="medicineDuration"]')?.value;
            var medInstructions = tr.querySelector('[name="medicineInstructions"]')?.value;
            // Đặt tên field mảng, backend phải đọc đúng!
            if (medId && medQty) {
                formData.append('medicines['+idx+'][id]', medId);
                formData.append('medicines['+idx+'][quantity]', medQty);
                formData.append('medicines['+idx+'][dosage]', medDosage || '');
                formData.append('medicines['+idx+'][duration]', medDuration || '');
                formData.append('medicines['+idx+'][instructions]', medInstructions || '');
            }
        });

        // Gửi AJAX lên backend
        fetch('doctor-add-medical-record', {
            method: 'POST',
            body: formData
        })
        .then(res => res.json()) // Backend trả về JSON (nên sửa lại backend)
        .then(data => {
            if (data.status === 'success') {
                alert('Thêm hồ sơ thành công!');
                form.reset();
                document.getElementById('prescribedMedicinesBody').innerHTML = '';
                loadListMedicalRecords(); // reload list
            } else {
                alert(data.message || 'Có lỗi xảy ra!');
            }
        })
        .catch(() => alert('Gửi dữ liệu thất bại!'));
    });
    
});


</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
