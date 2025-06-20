<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Sửa Hồ Sơ Y Tế</title>
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
        body {
    background: #f6f8fa;
    font-family: 'Segoe UI', sans-serif;
}

.container {
    max-width: 800px;
    margin-top: 40px;
    background: #fff;
    padding: 30px;
    border-radius: 12px;
    box-shadow: 0 0 10px rgba(0,0,0,0.05);
}

h2 {
    font-weight: 600;
}

.form-label {
    font-weight: 500;
    margin-bottom: 6px;
    color: #333;
}

.form-control,
.form-select {
    border-radius: 8px;
    font-size: 0.95rem;
}

textarea.form-control {
    resize: vertical;
}

input[type="file"].form-control {
    padding: 8px;
}

.readonly-box {
    background: #f0f4f8;
    border-radius: 8px;
    padding: 20px;
    margin-bottom: 25px;
    font-size: 0.95rem;
}

.pet-avatar {
    width: 80px;
    height: 80px;
    object-fit: cover;
    border-radius: 8px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.1);
}

.table {
    font-size: 0.95rem;
}

.table th {
    font-weight: 600;
    background: #e3e9f0;
    color: #1a3d6d;
    text-align: center;
}

.table td {
    vertical-align: middle;
    text-align: center;
    padding: 10px 8px;
}

#prescribedMedicinesTable input,
#prescribedMedicinesTable select {
    font-size: 0.9rem;
    padding: 6px;
}

button.btn-sm {
    padding: 5px 10px;
    font-size: 0.85rem;
}

.alert {
    font-size: 0.9rem;
    border-radius: 6px;
}
#prescribedMedicinesTable textarea {
    resize: vertical;
    font-size: 0.9rem;
    padding: 6px;
}
textarea {
    overflow: hidden;
    resize: none;
}


    </style>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body>
     <c:if test="${not empty sessionScope.message}">
    <script>
        window.onload = function() { alert('Sửa hồ sơ thành công!'); }
    </script>
    <c:remove var="message" scope="session"/>
</c:if>
<div class="container">
    <h2 class="text-center mb-4 text-primary">Sửa Hồ Sơ Y Tế</h2>

    <!-- Thông tin Pet & Chủ pet (readonly) -->
    <div class="readonly-box" id="petOwnerInfo">
        <div class="row align-items-center">
            <div class="col-auto">
                <img id="petAvatar" src="${pageContext.request.contextPath}/assets/images/default_pet.png" class="pet-avatar" alt="pet avatar"/>
            </div>
            <div class="col">
                <div><b>Mã Pet:</b> <span id="petCode">${medicalRecord.pet.pet_code}</span></div>
                <div><b>Tên Pet:</b> <span id="petName">${medicalRecord.pet.name}</span></div>
                <div><b>Giống:</b> <span id="petBreed">${medicalRecord.pet.breed.name}</span></div>
                <div><b>Giới tính:</b> <span id="petGender">${medicalRecord.pet.gender}</span></div>
                <div><b>Ngày sinh:</b> <span id="petBirth">${medicalRecord.pet.birthDate}</span></div>
            </div>
            <div class="col">
                <div><b>Chủ nuôi:</b> <span id="ownerName">${medicalRecord.pet.user.fullName}</span></div>
                <div><b>Điện thoại:</b> <span id="ownerPhone">${medicalRecord.pet.user.phoneNumber}</span></div>
                <div><b>Email:</b> <span id="ownerEmail">${medicalRecord.pet.user.email}</span></div>
                <div><b>Địa chỉ:</b> <span id="ownerAddress">${medicalRecord.pet.user.address}</span></div>
            </div>
        </div>
    </div>

    <!-- Form Sửa Hồ Sơ Y Tế -->
    <form method="post" action="edit-medical-record" id="editMedicalRecordForm" class="mb-4" enctype="multipart/form-data">
        <input type="hidden" name="medicalRecordId" id="medicalRecordId" value="${medicalRecord.id}"/>

        <div class="mb-3">
            <label class="form-label">Chẩn đoán <span class="text-danger">*</span></label>
            <textarea class="form-control" name="diagnosis" id="diagnosis" rows="2" required>${medicalRecord.diagnosis}</textarea>
        </div>
        <div class="mb-3">
            <label class="form-label">Phác đồ điều trị <span class="text-danger">*</span></label>
            <textarea class="form-control" name="treatment" id="treatment" rows="2" required>${medicalRecord.treatment}</textarea>
        </div>
        <div class="mb-3">
            <label class="form-label">Ngày hẹn tái khám</label>
            <input type="date" class="form-control" name="reExamDate" id="reExamDate" value="${medicalRecord.reExamDate != null ? medicalRecord.reExamDate : ''}"/>
        </div>
        <div class="mb-3">
            <label class="form-label">Tải lên hồ sơ đính kèm (nếu có)</label>
            <input type="file" class="form-control" name="files" id="files" multiple value="${medicalRecord.files}">
            
            <!-- Hiển thị các file đã upload trước đó -->
<div class="mb-3">
    <label class="form-label">Các file đã tải lên trước đây:</label>
    <ul>
        <c:forEach var="file" items="${medicalRecord.files}">
            <li>
                <a href="${file.fileUrl}" target="_blank">${file.fileName}</a>
                <input type="checkbox" name="removeFiles" value="${file.id}" /> Xóa
            </li>
        </c:forEach>
    </ul>
</div>
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
                    <c:forEach var="medicine" items="${medicalRecord.prescribedMedicines}">
                        <tr>
                            <td>
                                <select name="medicineId" class="form-select" required>
                                    <c:forEach var="med" items="${medicines}">
                                        <option value="${med.id}" ${med.id == medicine.medicineId ? 'selected' : ''}>${med.name}</option>
                                    </c:forEach>
                                </select>
                            </td>
                            <td><input type="number" name="medicineQuantity" class="form-control" value="${medicine.quantity}" min="1" required></td>
                            <td><textarea name="medicineDosage" class="form-control" rows="2">${medicine.dosage}</textarea></td>
<td><textarea name="medicineDuration" class="form-control" rows="2">${medicine.duration}</textarea></td>
<td><textarea name="medicineInstructions" class="form-control" rows="2">${medicine.usageInstructions}</textarea></td>

                            <td><button type="button" class="btn btn-danger btn-sm remove-medicine-btn"><i class="bi bi-x"></i></button></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <div class="mb-4 d-flex justify-content-between align-items-center">
            <a href="add-medical-record?appointmentId=${medicalRecord.appointment.id}" class="btn btn-outline-secondary">
                <i class="bi bi-arrow-left"></i> Quay lại
            </a>
            <button type="submit" class="btn btn-success">Cập nhật hồ sơ y tế</button>
        </div>
        <c:if test="${not empty errorMessage}">
            <div id="errorMessageBox" class="alert alert-danger mt-3">${errorMessage}</div>
        </c:if>
    </form>

</div>

<script>
    // Truyền list thuốc từ server sang JS (mảng object)
window.medicineList = [
    <c:forEach var="m" items="${medicines}" varStatus="s">
        {id: "${m.id}", name: "${m.name}"}<c:if test="${!s.last}">,</c:if>
    </c:forEach>
];
document.addEventListener('DOMContentLoaded', function() {
    // Thêm thuốc
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
            '<td><textarea name="medicineDosage" class="form-control" rows="2"></textarea></td>' +
'<td><textarea name="medicineDuration" class="form-control" rows="2"></textarea></td>' +
'<td><textarea name="medicineInstructions" class="form-control" rows="2"></textarea></td>' +

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

    
});

</script>
<script>
function autoResizeTextarea(textarea) {
    textarea.style.height = 'auto';
    textarea.style.height = textarea.scrollHeight + 'px';
}

document.addEventListener('input', function (event) {
    if (event.target.tagName.toLowerCase() === 'textarea') {
        autoResizeTextarea(event.target);
    }
});

// Gọi resize lúc load (nếu có dữ liệu sẵn)
document.addEventListener('DOMContentLoaded', function () {
    document.querySelectorAll('textarea').forEach(autoResizeTextarea);
});
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
