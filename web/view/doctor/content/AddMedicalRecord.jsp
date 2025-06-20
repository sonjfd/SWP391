<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm Hồ Sơ Y Tế</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f6f8fa; }
        .container { max-width: 750px; margin-top: 40px; }
        .form-label { font-weight: 500; }
        .readonly-box { background: #f0f4f8; border-radius: 5px; padding: 15px; margin-bottom: 20px; }
        .pet-avatar { width: 80px; height: 80px; object-fit: cover; border-radius: 8px; }
        .table th, .table td { vertical-align: middle !important; text-align: center; font-size: 1rem; }
        .table th { font-weight: 600; background: #e3e9f0; color: #1a3d6d; }
        .table td { font-weight: 400; }
        .action-icon { cursor: pointer; font-size: 1.2em; color: #0056b3; transition: color 0.15s; }
        .action-icon:hover { color: #17a2b8; }
        body {
    background: #f8fafc;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.container {
    max-width: 820px;
    margin-top: 50px;
    padding: 20px 30px;
    background: #ffffff;
    border-radius: 12px;
    box-shadow: 0 0 10px rgba(0,0,0,0.05);
}

h2 {
    font-weight: 600;
    color: #0d6efd;
}

.form-label {
    font-weight: 600;
    color: #2c3e50;
}

.readonly-box {
    background-color: #f0f4f8;
    padding: 18px 20px;
    border-radius: 10px;
    border: 1px solid #dbe4ec;
    margin-bottom: 25px;
}

.readonly-box span {
    display: block;
    margin-bottom: 0.35rem;
    color: #333;
    font-size: 0.95rem;
}

.pet-avatar {
    width: 90px;
    height: 90px;
    object-fit: cover;
    border-radius: 10px;
    border: 1px solid #ccc;
}

textarea.form-control,
input.form-control {
    border-radius: 0.5rem;
    padding: 12px;
    font-size: 0.95rem;
    border: 1px solid #ced4da;
    transition: border 0.3s;
}

textarea.form-control:focus,
input.form-control:focus {
    border-color: #0d6efd;
    box-shadow: 0 0 0 0.15rem rgba(13, 110, 253, 0.25);
}

.btn {
    font-weight: 500;
    border-radius: 8px;
    padding: 0.5rem 1.4rem;
    transition: all 0.2s ease-in-out;
}

.btn-success:hover, .btn-outline-secondary:hover {
    transform: translateY(-1px);
    opacity: 0.95;
}

/* Bảng thuốc */
#prescribedMedicinesTable {
    border: 1px solid #dee2e6;
    border-radius: 8px;
    overflow: hidden;
}

#prescribedMedicinesTable th {
    background: #e9f1fb;
    color: #0d6efd;
    font-weight: 600;
    text-align: center;
    font-size: 1rem;
}

#prescribedMedicinesTable td {
    text-align: center;
    vertical-align: middle;
    padding: 10px;
    font-size: 0.95rem;
}

#prescribedMedicinesTable select,
#prescribedMedicinesTable input {
    font-size: 0.9rem;
    border-radius: 6px;
}

.remove-medicine-btn {
    padding: 4px 8px;
}

/* Danh sách hồ sơ y tế */
#medicalRecordListTable th {
    background: #f0f4fa;
    color: #1a3d6d;
    font-weight: 600;
}

#medicalRecordListTable td {
    padding: 8px 10px;
    font-size: 0.95rem;
    vertical-align: middle;
}

#medicalRecordListTable a.btn-link {
    font-size: 0.9rem;
    color: #0d6efd;
    text-decoration: underline;
}

.action-icon {
    cursor: pointer;
    font-size: 1.3em;
    color: #0d6efd;
    transition: transform 0.2s, color 0.2s;
}

.action-icon:hover {
    color: #198754;
    transform: scale(1.1);
}

/* Responsive */
@media (max-width: 768px) {
    .readonly-box {
        font-size: 0.9rem;
    }
    .container {
        padding: 15px;
    }
    .btn {
        padding: 0.4rem 1rem;
    }
}

        /* Căn chỉnh modal header */
.modal-header {
    background-color: #0d6efd;
    color: #fff;
    border-bottom: none;
    padding: 1rem 1.5rem;
}

.modal-title {
    font-size: 1.25rem;
    font-weight: 600;
}

/* Thông tin bên trái */
.readonly-box {
    background-color: #f8f9fa;
    padding: 15px;
    border-radius: 8px;
    border: 1px solid #dee2e6;
    margin-bottom: 20px;
}

.readonly-box span {
    display: block;
    margin-bottom: 0.5rem;
    color: #333;
    font-size: 0.95rem;
}

label.form-label {
    font-weight: 500;
    color: #444;
}

textarea.form-control,
input.form-control {
    border-radius: 0.5rem;
    padding: 10px;
    font-size: 0.95rem;
    resize: vertical;
}

/* Button thiết kế đẹp hơn */
.btn {
    font-weight: 500;
    border-radius: 0.5rem;
    padding: 0.5rem 1.2rem;
}

/* Bảng thuốc */
#prescribedMedicinesTable {
    border: 1px solid #dee2e6;
}

#prescribedMedicinesTable th,
#prescribedMedicinesTable td {
    vertical-align: middle;
    text-align: center;
}

#prescribedMedicinesTable input,
#prescribedMedicinesTable textarea {
    width: 100%;
    resize: vertical;
    padding: 6px;
    font-size: 0.9rem;
}

/* Responsive */
@media (max-width: 768px) {
    .readonly-box {
        font-size: 0.9rem;
    }
}

    </style>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body>
    <c:if test="${not empty sessionScope.message}">
    <script>
        window.onload = function() { alert('Thêm hồ sơ thành công!'); }
    </script>
    <c:remove var="message" scope="session"/>
</c:if>

<div class="container">
    <h2 class="text-center mb-4 text-primary">Thêm Hồ Sơ Y Tế</h2>

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

    <!-- Form Thêm Hồ Sơ Y Tế -->
    <form method="post" action="add-medical-record" id="medicalRecordForm" class="mb-4" enctype="multipart/form-data">
        <input type="hidden" name="appointmentId" id="appointmentId" value="${param.appointmentId}"/>
        <input type="hidden" name="doctorId" id="doctorId" value="">
        <input type="hidden" name="petId" id="petId" value="">


        <div class="mb-3">
            <label class="form-label">Chẩn đoán <span class="text-danger">*</span></label>
            <textarea class="form-control" name="diagnosis" id="diagnosis" rows="2" required></textarea>
        </div>
        <div class="mb-3">
            <label class="form-label">Phác đồ điều trị <span class="text-danger">*</span></label>
            <textarea class="form-control" name="treatment" id="treatment" rows="2" required></textarea>
        </div>
        <div class="mb-3">
            <label class="form-label">Ngày hẹn tái khám</label>
            <input type="date" class="form-control" name="reExamDate" id="reExamDate"/>
        </div>
        <div class="mb-3">
            <label class="form-label">Tải lên hồ sơ đính kèm (nếu có)</label>
            <input type="file" class="form-control" name="files" id="files" multiple>
        </div>

        <!-- PHẦN KÊ ĐƠN THUỐC -->
        <div class="mb-3">
            <label class="form-label">Kê đơn thuốc</label>
            <table class="table table-bordered mb-2" id="prescribedMedicinesTable">
                <thead class="table-light">
                    <tr>
                        <th>Tên thuốc</th>
                        <th>Số lượng</th>
                        <th>Liều dùng</th>
                        <th>Thời gian</th>
                        <th>Hướng dẫn</th>
                        <th>
                            <button type="button" id="addMedicineBtn" class="btn btn-sm btn-success"><i class="bi bi-plus"></i></button>
                        </th>
                    </tr>
                </thead>
                <tbody id="prescribedMedicinesBody">
                    <!-- JS render các dòng thuốc kê đơn -->
                </tbody>
            </table>
        </div>

        <div class="mb-4 d-flex justify-content-between align-items-center">
            <a href="doctor-time-table" class="btn btn-outline-secondary">
                <i class="bi bi-arrow-left"></i> Quay lại
            </a>
            <button type="submit" class="btn btn-success">Thêm hồ sơ y tế</button>
        </div>
    </form>
<c:if test="${not empty errorMessage}">
    <c:set var="error" value="${errorMessage}"></c:set>
    <script>
        window.onload = function() { alert(error); };
    </script>
    <div id="errorMessageBox" class="alert alert-danger mt-3">${errorMessage}</div>
</c:if>
    <!-- Hiển thị danh sách hồ sơ đã thêm cho cuộc hẹn này -->
    <div class="card mt-4">
        <div class="card-header bg-primary text-white">
            Danh sách hồ sơ y tế đã tạo
        </div>
        <div class="card-body p-0">
            <table class="table mb-0 align-middle text-center" id="medicalRecordListTable">
                <thead>
                    <tr>
                        <th>STT</th>
                        <th>Ngày tạo</th>
                        <th>Chẩn đoán</th>
                        <th>Phác đồ</th>
                        <th>Tái khám</th>
                        <th>File đính kèm</th>
                        <th>Thuốc đã kê</th>
                        <th>Hành động</th> <!-- Thêm cột hành động -->
                    </tr>
                </thead>
                <tbody id="listMedicalRecordBody">
                    <!-- JS sẽ đổ dữ liệu vào đây -->
                </tbody>
            </table>
        </div>
    </div>
</div>

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
    
    // Load thông tin pet, chủ pet
    fetch('./api/getappointmentdetails?id=' + appointmentId)
        .then(function(res) { return res.json(); })
        .then(function(data) {
            var appt = data.appointments[0];
            document.getElementById('petAvatar').src = './' + appt.petAvatar;
            document.getElementById('petCode').innerText = appt.petCode || '-';
            document.getElementById('petName').innerText = appt.petName || '-';
            document.getElementById('petBreed').innerText = appt.petBreed || '-';
            document.getElementById('petGender').innerText = appt.petGender || '-';
            document.getElementById('petBirth').innerText = appt.petBirth || '-';
            document.getElementById('ownerName').innerText = appt.ownerName || '-';
            document.getElementById('ownerPhone').innerText = appt.ownerPhone || '-';
            document.getElementById('ownerEmail').innerText = appt.ownerEmail || '-';
            document.getElementById('ownerAddress').innerText = appt.ownerAddress || '-';
            document.getElementById('doctorId').value = appt.doctorId;
        document.getElementById('petId').value = appt.petId;
        })
        .catch(function() { alert('Không thể load thông tin pet!'); });

    // Kê đơn thuốc - add/remove dòng động
    var addBtn = document.getElementById('addMedicineBtn');
    var tbody = document.getElementById('prescribedMedicinesBody');
    addBtn.addEventListener('click', function() {
        var selectStr = '<select name="medicineId" class="form-select" required>';
        for (var i = 0; i < window.medicineList.length; i++) {
            selectStr += '<option value="' + window.medicineList[i].id + '">' + window.medicineList[i].name + '</option>';
        }
        selectStr += '</select>';
        var row = document.createElement('tr');
        row.innerHTML =
            '<td>' + selectStr + '</td>' +
            '<td><input type="number" name="medicineQuantity" min="1" class="form-control" required></td>' +
            '<td><input type="text" name="medicineDosage" class="form-control"></td>' +
            '<td><input type="text" name="medicineDuration" class="form-control"></td>' +
            '<td><input type="text" name="medicineInstructions" class="form-control"></td>' +
            '<td><button type="button" class="btn btn-danger btn-sm remove-medicine-btn"><i class="bi bi-x"></i></button></td>';
        tbody.appendChild(row);
    });

    // Xóa dòng thuốc
    tbody.addEventListener('click', function(e) {
        if (e.target.closest('.remove-medicine-btn')) {
            var btn = e.target.closest('.remove-medicine-btn');
            btn.parentNode.parentNode.parentNode.removeChild(btn.parentNode.parentNode);
        }
    });

    // Load danh sách hồ sơ y tế đã tạo cho cuộc hẹn này
    function loadListMedicalRecords() {
        fetch('./api/get-medical-records?appointmentId=' + appointmentId)
            .then(function(res) { return res.json(); })
            .then(function(data) {
                var tbody = document.getElementById('listMedicalRecordBody');
                tbody.innerHTML = '';
                if (data.records && data.records.length > 0) {
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
                        tr.innerHTML =
                            '<td>' + (i + 1) + '</td>' +
                            '<td>' + (rec.createdAt ? new Date(rec.createdAt).toLocaleDateString('vi-VN') : '-') + '</td>' +
                            '<td>' + (rec.diagnosis || '-') + '</td>' +
                            '<td>' + (rec.treatment || '-') + '</td>' +
                            '<td>' + (rec.reExamDate ? new Date(rec.reExamDate).toLocaleDateString('vi-VN') : '-') + '</td>' +
                            '<td>' + fileLinks + '</td>' +
                            '<td>' + medicinesStr + '</td>' +
                            '<td><a href="edit-medical-record?id=' + rec.id + '">' +
    '<span class="action-icon"><i class="bi bi-pencil-square"></i></span></a></td>'; // Cột hành động
                        tbody.appendChild(tr);
                    }
                } else {
                    tbody.innerHTML = '<tr><td colspan="8" class="text-center text-muted">Chưa có hồ sơ nào</td></tr>';
                }
            });
    }
    loadListMedicalRecords();
    // Ẩn message lỗi sau 3s
    var errBox = document.getElementById('errorMessageBox');
    if (errBox) {
        setTimeout(function() {
            errBox.style.display = 'none';
        }, 3000);
    }
});
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
