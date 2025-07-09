<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Khám Bệnh - Quản Lý Cuộc Hẹn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light text-dark">
<div class="container-fluid py-4">
    <!-- Nút quay lại -->
    <div class="mb-3">
        
     <c:if test="${not empty sessionScope.backUrl}">
    <button type="button" class="btn btn-secondary" onclick="window.location.href='${sessionScope.backUrl}'">
        <i class="bi bi-arrow-left"></i> Quay lại
    </button>
</c:if>



    </div>

    <!-- Tiêu đề -->
    <h2 class="text-center text-primary mb-4">Quản Lý Cuộc Hẹn - Khám Bệnh</h2>
    <input  type="hidden" name="appointmentStatus" id="appointmentStatus" value=""/>
    <div class="row gx-4 align-items-start">
        <!-- Cột trái: Tabs -->
        <div class="col-lg-8 col-md-7 mb-4">
            <ul class="nav nav-tabs mb-3" id="doctorTabs" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="tab-diagnosis" data-bs-toggle="tab" data-bs-target="#diagnosis-panel" type="button" role="tab">1. Chuẩn đoán sơ bộ</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="tab-services" data-bs-toggle="tab" data-bs-target="#services-panel" type="button" role="tab">2. Điều hướng dịch vụ</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="tab-conclude" data-bs-toggle="tab" data-bs-target="#conclude-panel" type="button" role="tab">3. Kết luận</button>
                </li>
            </ul>

            <div class="tab-content" id="doctorTabsContent">
                <div class="tab-pane fade show active" id="diagnosis-panel" role="tabpanel">
                    <%@ include file="../content/DoctorClinicalDiagnosis.jsp" %>
                </div>
                <div class="tab-pane fade" id="services-panel" role="tabpanel">
                    <%@ include file="../content/AddAppointmentServices.jsp" %>
                </div>
                <div class="tab-pane fade" id="conclude-panel" role="tabpanel">
                    <%@ include file="../content/AddMedicalRecord.jsp" %>
                </div>
            </div>
        </div>

        <!-- Cột phải: Thông tin pet -->
        <div class="col-lg-4 col-md-5 mb-4">
            <div class="card shadow-sm">
                <div class="text-center p-3">
                    <img id="petAvatar" src="" alt="Pet Avatar"
                         class="img-fluid rounded-circle border border-primary" style="max-width: 100px;">
                </div>
                <div class="card-body pt-0">
                    <div class="mb-2"><strong class="text-primary">Mã Pet:</strong> <span id="petCode">Loading...</span></div>
                    <div class="mb-2"><strong class="text-primary">Tên Pet:</strong> <span id="petName">Loading...</span></div>
                    <div class="mb-2"><strong class="text-primary">Giống:</strong> <span id="petBreed">Loading...</span></div>
                    <div class="mb-2"><strong class="text-primary">Giới tính:</strong> <span id="petGender">Loading...</span></div>
                    <div class="mb-2"><strong class="text-primary">Ngày sinh:</strong> <span id="petBirth">Loading...</span></div>
                    <hr>
                    <div class="mb-2"><strong class="text-primary">Chủ nuôi:</strong> <span id="ownerName">Loading...</span></div>
                    <div class="mb-2"><strong class="text-primary">Điện thoại:</strong> <span id="ownerPhone">Loading...</span></div>
                    <div class="mb-2"><strong class="text-primary">Email:</strong> <span id="ownerEmail">Loading...</span></div>
                    <div class="mb-2"><strong class="text-primary">Địa chỉ:</strong> <span id="ownerAddress">Loading...</span></div>
                </div>
            </div>
        </div>
    </div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
document.addEventListener('DOMContentLoaded', function() {
    const appointmentId = document.getElementById('appointmentId')?.value || new URLSearchParams(window.location.search).get('appointmentId');
    if (!appointmentId) {
        alert('Không tìm thấy mã cuộc hẹn!');
        return;
    }

    fetch('./api/getappointmentdetails?id=' + appointmentId)
        .then(res => res.json())
        .then(data => {
            const appt = data.appointments[0];
            document.getElementById('petAvatar').src = (appt.petAvatar);
            document.getElementById('petCode').innerText = appt.petCode || '-';
            document.getElementById('petName').innerText = appt.petName || '-';
            document.getElementById('petBreed').innerText = appt.petBreed || '-';
            document.getElementById('petGender').innerText = appt.petGender || '-';
            document.getElementById('petBirth').innerText = appt.petBirth || '-';
            document.getElementById('ownerName').innerText = appt.ownerName || '-';
            document.getElementById('ownerPhone').innerText = appt.ownerPhone || '-';
            document.getElementById('ownerEmail').innerText = appt.ownerEmail || '-';
            document.getElementById('ownerAddress').innerText = appt.ownerAddress || '-';
            document.getElementById('doctorId')?.setAttribute('value', appt.doctorId);
            document.getElementById('petId')?.setAttribute('value', appt.petId);
            document.getElementById('appointmentStatus')?.setAttribute('value', appt.appointmentStatus);
            applyStatusUI(document.getElementById('appointmentStatus').value);
        })
        .catch(() => alert('Không thể load thông tin pet!'));

    document.querySelectorAll('button[data-bs-toggle="tab"]').forEach(tabBtn => {
        tabBtn.addEventListener('shown.bs.tab', function(e) {
            document.querySelectorAll('.tab-pane input, .tab-pane textarea, .tab-pane select').forEach(el => {
                el.removeAttribute('required');
            });
            const activeTab = document.querySelector(e.target.getAttribute('data-bs-target'));
            if (activeTab) {
                activeTab.querySelectorAll('[data-required="true"]').forEach(el => {
                    el.setAttribute('required', 'required');
                });
            }
        });
    });
    
});
function applyStatusUI(status) {
    if (status === "completed") {
        document.getElementById('formDiagnosis')?.style?.setProperty("display", "none");
        document.getElementById('serviceForm')?.style?.setProperty("display", "none");

        const actionHeader = document.querySelector('table thead th:last-child');
        if (actionHeader) actionHeader.style.display = 'none';

        document.querySelectorAll('#diagnosisList td.action-icons').forEach(td => {
            td.style.display = 'none';
        });
    }
}

</script>
<script>
document.addEventListener("DOMContentLoaded", function () {
    const tab = "${activeTab}";
    if (tab) {
        const tabMap = {
            "diagnosis": "#tab-diagnosis",
            "services": "#tab-services",
            "conclude": "#tab-conclude"
        };
        const selector = tabMap[tab];
        if (selector) {
            const tabTrigger = document.querySelector(selector);
            if (tabTrigger) {
                new bootstrap.Tab(tabTrigger).show();
            }
        }
    }
});
</script>

</body>
</html>
