<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chuẩn Đoán Sơ Bộ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* CSS cho các phần tử của trang */
        .diagnosis-tab-wrapper {
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }

        .diagnosis-tab-wrapper h4 {
            font-weight: 600;
            color: #007bff;
            margin-bottom: 20px;
            letter-spacing: 0.01em;
        }

        .form-label {
            font-weight: 600;
            color: #495057;
            margin-bottom: 8px;
            font-size: 1rem;
        }

        .diagnosis-tab-wrapper textarea,
        .diagnosis-tab-wrapper input[type="text"] {
            border-radius: 8px;
            border: 1.2px solid #ced4da;
            padding: 11px 13px;
            font-size: 1.03rem;
            box-shadow: none;
            margin-bottom: 12px;
            transition: border-color 0.18s;
            background: #fff;
        }

        .diagnosis-tab-wrapper textarea:focus,
        .diagnosis-tab-wrapper input[type="text"]:focus {
            border-color: #007bff;
            outline: none;
            background: #f6fafe;
        }

        .btn-diagnosis {
            background: linear-gradient(90deg, #007bff 0%, #36c6ff 100%);
            color: #fff;
            border: none;
            font-weight: 600;
            padding: 0.7rem 2rem;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(33, 150, 243, 0.07);
            transition: background 0.2s, transform 0.16s;
            font-size: 1.05rem;
        }

        .btn-diagnosis:hover {
            background: linear-gradient(90deg, #0056b3 0%, #0dcaf0 100%);
            transform: translateY(-1px) scale(1.02);
            color: #fff;
        }

        table {
            width: 100%;
            margin-top: 20px;
        }

        table th, table td {
            text-align: center;
            padding: 10px;
        }

        .action-icons {
            cursor: pointer;
        }

        .action-icons i {
            margin: 0 5px;
        }
        .input-error {
    border-color: #dc3545 !important;
    background-color: #fff3f3;
}

    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="diagnosis-tab-wrapper">
            <h4><i class="bi bi-heart-pulse"></i> Chuẩn đoán sơ bộ</h4>
            

            <!-- Form nhập chuẩn đoán -->
            <form method="post" action="save-preliminary-diagnosis" id="formDiagnosis" novalidate autocomplete="off">
                <div class="mb-3">
                    <label class="form-label" for="symptoms">Triệu chứng lâm sàng <span class="text-danger">*</span></label>
                    <textarea class="form-control is-invalid" name="symptoms" id="symptoms" rows="3" required placeholder="Nhập triệu chứng quan sát được..."></textarea>
                    <div class="invalid-feedback" id="err-symptoms"></div>
                </div>
                <div class="mb-3">
                    <label class="form-label" for="preliminaryDiagnosis">Chuẩn đoán sơ bộ <span class="text-danger">*</span></label>
                    <textarea class="form-control is-invalid" name="preliminaryDiagnosis" id="preliminaryDiagnosis" rows="3" required placeholder="Nhập chuẩn đoán bước đầu..."></textarea>
                    <div class="invalid-feedback" id="err-preliminaryDiagnosis"></div>
                </div>
                <div class="mb-2">
                    <label class="form-label" for="note">Ghi chú thêm</label>
                    <input type="text" class="form-control" name="note" id="note" maxlength="255" placeholder="Ghi chú (nếu có)">
                </div>
                <div class="mt-3 d-flex justify-content-between">
                    

                    <button type="submit" class="btn btn-diagnosis">
                        <i class="bi bi-floppy2-fill"></i> Lưu chuẩn đoán
                    </button>
                </div>
            </form>

            <!-- Bảng hiển thị danh sách chuẩn đoán -->
            <h4 class="mt-4">Danh sách chuẩn đoán</h4>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Triệu chứng</th>
                        <th>Chuẩn đoán sơ bộ</th>
                        <th>Ghi chú</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody id="diagnosisList">
                    <!-- Các chuẩn đoán sẽ được load vào đây -->
                </tbody>
            </table>
        </div>
    </div>

    <div class="modal fade" id="editDiagnosisModal" tabindex="-1" aria-labelledby="editDiagnosisModalLabel" style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editDiagnosisModalLabel">Sửa chuẩn đoán</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="editDiagnosisForm" novalidate>
                    <input type="hidden" id="editDiagnosisId" name="id" />
                    <div class="mb-3">
                        <label class="form-label" for="editSymptoms">Triệu chứng lâm sàng</label>
                        <textarea class="form-control is-invalid" name="symptoms" id="editSymptoms" rows="3" required placeholder="Nhập triệu chứng..."></textarea>
                        <div class="invalid-feedback" id="err-editSymptoms"></div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="editPreliminaryDiagnosis">Chuẩn đoán sơ bộ</label>
                        <textarea class="form-control is-invalid" name="preliminaryDiagnosis" id="editPreliminaryDiagnosis" rows="3" required placeholder="Nhập chuẩn đoán..."></textarea>
                        <div class="invalid-feedback" id="err-editPreliminaryDiagnosis"></div>
                    </div>
                    <div class="mb-2">
                        <label class="form-label" for="editNote">Ghi chú thêm</label>
                        <input type="text" class="form-control" name="note" id="editNote" maxlength="255" placeholder="Ghi chú (nếu có)">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                <button type="button" class="btn btn-primary" id="saveEditDiagnosisBtn">Lưu thay đổi</button>
            </div>
        </div>
    </div>
</div>


    <script>
        
        // Escape HTML để tránh XSS khi show lỗi
function escapeHtml(str) {
    if (!str) return '';
    return String(str)
        .replace(/&/g, "&amp;")
        .replace(/"/g, "&quot;")
        .replace(/'/g, "&#39;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;");
}

const appointmentId = new URLSearchParams(window.location.search).get('appointmentId');

document.addEventListener('DOMContentLoaded', function () {
    
        
        
        // Kiểm tra trạng thái cuộc hẹn
    
     const check = document.getElementById('appointmentStatus');
console.log("Đối tượng check:", check); // Lúc này bạn thấy thẻ input

if (check) {
    // Đợi 100ms (hoặc hơn) để xem giá trị có được gán không
    setTimeout(() => {
        let status = check.value;
        console.log("Giá trị status sau 100ms:", status);
        if (status === "" || status === undefined) {
            console.log("Giá trị vẫn rỗng/không xác định sau khi chờ.");
        }
    }, 100);
} else {
    console.log("Không tìm thấy phần tử 'appointmentStatus'.");
}
let status ='';
if (check) {
    // Đợi 100ms (hoặc hơn) để xem giá trị có được gán không
    setTimeout(() => {
         status = check.value;
         console.log(status);
    }, 100);
}

    if (status === 'completed') {
        // 1. Ẩn form nhập chuẩn đoán
        const formSection = document.getElementById('formDiagnosis');
        if (formSection) {
            formSection.style.display = 'none';
        }

        // 2. Ẩn cột hành động trong thead
        const actionHeader = document.querySelector('table thead th:last-child');
        if (actionHeader) {
            actionHeader.style.display = 'none';
        }

        // 3. Ẩn các cột hành động trong tbody
        document.querySelectorAll('#diagnosisList td.action-icons').forEach(function (td) {
            td.style.display = 'none';
        });
    }
        // Phần form thêm chuẩn đoán
    const formAdd = document.getElementById('formDiagnosis');
    const fieldsAdd = [
        { id: 'symptoms', required: true, label: 'Triệu chứng lâm sàng' },
        { id: 'preliminaryDiagnosis', required: true, label: 'Chuẩn đoán sơ bộ' }
    ];

    // Validate khi blur cho phần thêm chuẩn đoán
    fieldsAdd.forEach(f => {
        const input = document.getElementById(f.id);
        const errBox = document.getElementById('err-' + f.id);
        input.addEventListener('focusin', function () {
            input.classList.remove('input-error');
            errBox.innerHTML = '';  // Clear the error when focusing the field
        });
        input.addEventListener('blur', function () {
            console.log("Blur fired on: ", input.id);
            let val = input.value.trim();
            if (f.required && val.length === 0) {
                input.classList.add('input-error');
                errBox.innerHTML = escapeHtml('Vui lòng nhập ' + f.label.toLowerCase() + '!');
            } else if (val.length > 1000) {
                input.classList.add('input-error');
                errBox.innerHTML = escapeHtml(f.label + ' không được quá 1000 ký tự!');
            } else {
                input.classList.remove('input-error');
                errBox.innerHTML = '';
            }
        });
    });

    // Validate trước khi submit cho phần thêm
    formAdd.addEventListener('submit', function (e) {
        e.preventDefault();  // Ngừng gửi form mặc định

        let valid = true;
        fieldsAdd.forEach(f => {
            const input = document.getElementById(f.id);
            const errBox = document.getElementById('err-' + f.id);
            let val = input.value.trim();
            if (f.required && val.length === 0) {
                input.classList.add('input-error');
                errBox.innerHTML = escapeHtml('Vui lòng nhập ' + f.label.toLowerCase() + '!');
                valid = false;
            } else if (val.length > 1000) {
                input.classList.add('input-error');
                errBox.innerHTML = escapeHtml(f.label + ' không được quá 1000 ký tự!');
                valid = false;
            } else {
                input.classList.remove('input-error');
                errBox.innerHTML = '';
            }
        });

        if (valid) {
            // Escape dữ liệu trước khi gửi
            const formData = new FormData(formAdd);
            formData.set('symptoms', escapeHtml(formData.get('symptoms')));
            formData.set('preliminaryDiagnosis', escapeHtml(formData.get('preliminaryDiagnosis')));
            formData.set('note', escapeHtml(formData.get('note')));

            formData.append("appointmentId", appointmentId);

            // Gửi yêu cầu tới servlet để lưu chuẩn đoán
            fetch('doctor-save-preliminary-diagnosis', {
                method: 'POST',
                body: formData
            })
                .then(response => response.json())
                .then(data => {
                    alert(data.message);  // Hiển thị thông báo thành công hoặc thất bại
                    if (data.status === 'success') {
                        loadDiagnosisList();  // Cập nhật lại danh sách chuẩn đoán
                        formAdd.reset();  // Reset form sau khi lưu thành công
                    }
                })
                .catch(error => {
                    alert('Có lỗi xảy ra, vui lòng thử lại!');
                });
        }
    });

    // Phần form sửa chuẩn đoán
    const formEdit = document.getElementById('editDiagnosisForm');
    const fieldsEdit = [
        { id: 'editSymptoms', required: true, label: 'Triệu chứng lâm sàng' },
        { id: 'editPreliminaryDiagnosis', required: true, label: 'Chuẩn đoán sơ bộ' }
    ];

    // Validate khi blur cho phần sửa chuẩn đoán
    fieldsEdit.forEach(f => {
        const input = document.getElementById(f.id);
        const errBox = document.getElementById('err-' + f.id);
        input.addEventListener('focusin', function () {
            input.classList.remove('input-error');
            errBox.innerHTML = '';  // Clear the error when focusing the field
        });
        input.addEventListener('blur', function () {
            let val = input.value.trim();
            if (f.required && val.length === 0) {
                input.classList.add('input-error');
                errBox.innerHTML = escapeHtml('Vui lòng nhập ' + f.label.toLowerCase() + '!');
            } else if (val.length > 1000) {
                input.classList.add('input-error');
                errBox.innerHTML = escapeHtml(f.label + ' không được quá 1000 ký tự!');
            } else {
                input.classList.remove('input-error');
                errBox.innerHTML = '';
            }
        });
    });

    // Lắng nghe sự kiện khi người dùng nhấn Lưu thay đổi trong Modal
    document.getElementById('saveEditDiagnosisBtn').addEventListener('click', function () {
        let valid = true;

        fieldsEdit.forEach(f => {
            const input = document.getElementById(f.id);
            const errBox = document.getElementById('err-' + f.id);
            let val = input.value.trim();
            if (f.required && val.length === 0) {
                input.classList.add('input-error');
                errBox.innerHTML = escapeHtml('Vui lòng nhập ' + f.label.toLowerCase() + '!');
                valid = false;
            } else if (val.length > 1000) {
                input.classList.add('input-error');
                errBox.innerHTML = escapeHtml(f.label + ' không được quá 1000 ký tự!');
                valid = false;
            } else {
                input.classList.remove('input-error');
                errBox.innerHTML = '';
            }
        });

        if (valid) {
            const formData = new FormData(formEdit);
            const appointmentId = new URLSearchParams(window.location.search).get('appointmentId');
            formData.append("appointmentId", appointmentId); // Đảm bảo gửi appointmentId

            // Escape dữ liệu trước khi gửi
            formData.set('symptoms', escapeHtml(formData.get('symptoms')));
            formData.set('preliminaryDiagnosis', escapeHtml(formData.get('preliminaryDiagnosis')));
            formData.set('note', escapeHtml(formData.get('note')));

            fetch('./save-edited-diagnosis', {
                method: 'POST',
                body: formData
            })
                .then(response => response.json())
                .then(data => {
                    alert(data.message);  // Hiển thị thông báo thành công hoặc thất bại
                    if (data.status === 'success') {
                        loadDiagnosisList();  // Cập nhật lại danh sách chuẩn đoán
                        const modal = bootstrap.Modal.getInstance(document.getElementById('editDiagnosisModal'));
                        modal.hide();  // Đóng Modal
                    }
                })
                .catch(error => {
                    alert('Có lỗi xảy ra, vui lòng thử lại!');
                });
        }
    });
     
    loadDiagnosisList();
    
});

// Load danh sách chuẩn đoán
function loadDiagnosisList() {
    const appointmentId = new URLSearchParams(window.location.search).get('appointmentId');
    fetch("./api/getdiagnosis?appointmentId=" + appointmentId)
        .then(response => response.json())
        .then(data => {
            const diagnosisList = document.getElementById('diagnosisList');
            diagnosisList.innerHTML = ''; // Clear previous list

            data.symptoms.forEach(symptom => {
                const row = document.createElement('tr');
                row.innerHTML = '<td>' + escapeHtml(symptom.symptom) + '</td>' +
                    '<td>' + escapeHtml(symptom.diagnosis) + '</td>' +
                    '<td>' + (symptom.note || '') + '</td>' +
                    '<td class="action-icons">' +
                    '<i class="bi bi-pencil-square" onclick="loadDiagnosisForEdit(\'' + symptom.id + '\')"></i>' +
                    '<i class="bi bi-trash" onclick="deleteDiagnosis(\'' + symptom.id + '\')"></i>' +
                    '</td>';
                diagnosisList.appendChild(row);
            });
        })
        .catch(error => {
            console.error('Error loading diagnosis list:', error);
        });
}

// Load thông tin chuẩn đoán cần sửa vào Modal
function loadDiagnosisForEdit(id) {
    fetch("./api/getappointmentsymptombyid?id=" + id)
        .then(response => response.json())
        .then(data => {
            if (data.status === 'success') {
                // Điền dữ liệu vào Modal và escape HTML
                document.getElementById('editDiagnosisId').value = escapeHtml(data.id);
                document.getElementById('editSymptoms').value = escapeHtml(data.symptom);
                document.getElementById('editPreliminaryDiagnosis').value = escapeHtml(data.diagnosis);
                document.getElementById('editNote').value = escapeHtml(data.note);

                // Mở Modal
                const modal = new bootstrap.Modal(document.getElementById('editDiagnosisModal'));
                modal.show();
            } else {
                alert('Không thể tải thông tin chuẩn đoán!');
            }
        })
        .catch(error => {
            console.error('Error loading diagnosis data:', error);
            alert('Có lỗi xảy ra, vui lòng thử lại!');
        });
}

// Xóa chuẩn đoán
function deleteDiagnosis(id) {
    if (confirm('Bạn có chắc chắn muốn xóa chuẩn đoán này?')) {
        fetch("./api/delete-diagnosis", {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: "id=" + encodeURIComponent(id) + "&action=delete"
        })
            .then(function (response) {
                return response.json();
            })
            .then(function (data) {
                if (data.success) {
                    loadDiagnosisList();  // Reload danh sách
                } else {
                    alert('Không thể xóa chuẩn đoán');
                }
            })
            .catch(function (error) {
                console.error('Lỗi khi xóa chuẩn đoán:', error);
            });
    }
}


// Lắng nghe sự kiện khi người dùng nhấn nút Quay lại


    </script>
</body>
</html>
