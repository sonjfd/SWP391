<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Sửa Hồ Sơ Y Tế</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        
    .is-invalid + .invalid-feedback {
        display: block;
    }


    </style>
</head>
<body class="bg-light">
<c:if test="${not empty sessionScope.message}">
    <script>
        window.onload = function() { alert('Sửa hồ sơ thành công!'); }
    </script>
    <c:remove var="message" scope="session"/>
</c:if>

<div class="container py-4">
    <h2 class="text-center mb-4 text-primary">Sửa Hồ Sơ Y Tế</h2>

    <!-- Thông tin Pet & Chủ pet -->
    <div class="bg-white border rounded p-3 mb-4">
        <div class="row align-items-center">
            <div class="col-auto">
                <img src="${pageContext.request.contextPath}/assets/images/default_pet.png" class="rounded img-thumbnail" style="width: 80px; height: 80px; object-fit: cover;" alt="pet avatar"/>
            </div>
            <div class="col">
                <p><strong>Mã Pet:</strong> ${medicalRecord.pet.pet_code}</p>
                <p><strong>Tên Pet:</strong> ${medicalRecord.pet.name}</p>
                <p><strong>Giống:</strong> ${medicalRecord.pet.breed.name}</p>
                <p><strong>Giới tính:</strong> ${medicalRecord.pet.gender}</p>
                <p><strong>Ngày sinh:</strong> ${medicalRecord.pet.birthDate}</p>
            </div>
            <div class="col">
                <p><strong>Chủ nuôi:</strong> ${medicalRecord.pet.user.fullName}</p>
                <p><strong>Điện thoại:</strong> ${medicalRecord.pet.user.phoneNumber}</p>
                <p><strong>Email:</strong> ${medicalRecord.pet.user.email}</p>
                <p><strong>Địa chỉ:</strong> ${medicalRecord.pet.user.address}</p>
            </div>
        </div>
    </div>

    <!-- Form -->
    <form method="post" action="doctor-edit-medical-record" id="editMedicalRecordForm" enctype="multipart/form-data">
        <input type="hidden" name="medicalRecordId" value="${medicalRecord.id}"/>

        <div class="mb-3">
            <label class="form-label">Chẩn đoán <span class="text-danger">*</span></label>
            <textarea class="form-control" name="diagnosis" rows="2" required>${medicalRecord.diagnosis}</textarea>
        </div>
        <div class="mb-3">
            <label class="form-label">Phác đồ điều trị <span class="text-danger">*</span></label>
            <textarea class="form-control" name="treatment" rows="2" required>${medicalRecord.treatment}</textarea>
        </div>
        <div class="mb-3">
            <label class="form-label">Ngày hẹn tái khám</label>
            <input type="date" class="form-control" name="reExamDate" value="${medicalRecord.reExamDate != null ? medicalRecord.reExamDate : ''}"/>
        </div>
        <div class="mb-3">
            <label class="form-label">Tải lên hồ sơ đính kèm (nếu có)</label>
            <input type="file" class="form-control" name="files" id="files" multiple>

            <div class="mt-3">
                <label class="form-label">Các file đã tải lên trước đây:</label>
                <ul class="list-unstyled">
                    <c:forEach var="file" items="${medicalRecord.files}">
                        <li>
                            <a href="${file.fileUrl}" target="_blank">${file.fileName}</a>
                            <div class="form-check d-inline-block ms-2">
                                <input class="form-check-input" type="checkbox" name="removeFiles" value="${file.id}">
                                <label class="form-check-label">Xóa</label>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>

        <!-- Bảng thuốc -->
        <div class="mb-3">
            <label class="form-label">Kê đơn thuốc</label>
            <table class="table table-bordered align-middle table-striped" id="prescribedMedicinesTable">
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

        <div class="mb-4 d-flex justify-content-between">
            <button id="backButton" type="button" class="btn btn-secondary"><i class="bi bi-arrow-left"></i> Quay lại</button>
            <button type="submit" class="btn btn-success">Cập nhật hồ sơ y tế</button>
        </div>

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger mt-3">${errorMessage}</div>
        </c:if>
    </form>
</div>

<!-- Script -->
<script>
    window.medicineList = [
        <c:forEach var="m" items="${medicines}" varStatus="s">
            {id: "${m.id}", name: "${m.name}"}<c:if test="${!s.last}">,</c:if>
        </c:forEach>
    ];

    document.addEventListener('DOMContentLoaded', function() {
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

        tbody.addEventListener('click', function(e) {
            if (e.target.closest('.remove-medicine-btn')) {
                var btn = e.target.closest('.remove-medicine-btn');
                btn.parentNode.parentNode.parentNode.removeChild(btn.parentNode.parentNode);
            }
        });

        document.getElementById('backButton').addEventListener('click', function () {
            window.history.back();
        });

        // Tự động resize textarea
        document.querySelectorAll('textarea').forEach(function(textarea) {
            textarea.style.height = 'auto';
            textarea.style.height = textarea.scrollHeight + 'px';
            textarea.addEventListener('input', function() {
                this.style.height = 'auto';
                this.style.height = this.scrollHeight + 'px';
            });
        });
        const form = document.getElementById('editMedicalRecordForm');
    form.querySelectorAll('textarea, input[type="text"], input[type="date"]').forEach(function(input) {
        input.addEventListener('blur', function () {
            const value = input.value.trim();
            const maxLength = 255;

            if (input.hasAttribute('required') && !value) {
                setError(input, 'Trường này là bắt buộc.');
                return;
            }

            if (value.length > maxLength) {
                setError(input, `Không được vượt quá ${maxLength} ký tự.`);
                return;
            }

            if (input.type === 'date' && value) {
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
    });
    
</script>
<script>
    // Hàm đặt lỗi
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

// Hàm xóa lỗi
function clearError(input) {
    input.classList.remove('is-invalid');
    let errorSpan = input.nextElementSibling;
    if (errorSpan && errorSpan.classList.contains('invalid-feedback')) {
        errorSpan.remove();
    }
}

document.getElementById("editMedicalRecordForm").addEventListener("submit", async function (e) {
    e.preventDefault(); // Ngăn submit form truyền thống
// Gọi blur để trigger validate
    let valid = true;
    let form = document.getElementById('editMedicalRecordForm');
    form.querySelectorAll('textarea, input[type="text"], input[type="date"]').forEach(function(input) {
        input.dispatchEvent(new Event('blur'));
        if (input.classList.contains('is-invalid')) {
            valid = false;
        }
    });

    if (!valid) {
        alert("Vui lòng kiểm tra các trường bị lỗi.");
        return;
    }
     form = e.target;
    const formData = new FormData(form);

    try {
        const response = await fetch("edit-medical-record", {
            method: "POST",
            body: formData
        });

        const resultText = await response.text();

        if (response.ok) {
            alert("Cập nhật hồ sơ thành công!");
            // Có thể redirect hoặc reload tùy bạn:
            window.location.href = document.referrer + (document.referrer.includes('?') ? '&' : '?') + 'reload=1';
        } else {
            alert("Cập nhật thất bại! " + resultText);
        }
    } catch (error) {
        console.error("Lỗi khi gửi AJAX:", error);
        alert("Có lỗi xảy ra khi gửi yêu cầu.");
    }
});
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
