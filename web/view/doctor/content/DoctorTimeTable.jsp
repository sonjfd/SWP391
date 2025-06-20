<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Lịch làm việc bác sĩ</title>
    <!-- Bootstrap 5 CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap -->
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- Select2 -->
        <link href="${pageContext.request.contextPath}/assets/css/select2.min.css" rel="stylesheet" />
        <!-- Date picker -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/flatpickr.min.css">
        <link href="${pageContext.request.contextPath}/assets/css/jquery.timepicker.min.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- Css -->
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
    <style>
    body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            color: #333;
        }

        .container {
            margin-top: 50px;
            max-width: 1200px;
        }

        h2 {
            color: #0056b3;
            font-weight: 600;
            text-align: center;
        }

        form {
            margin-bottom: 30px;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        label {
            font-weight: 500;
            margin-right: 10px;
        }

        select {
            width: 150px;
            padding: 8px;
            margin-right: 15px;
            border-radius: 5px;
            border: 1px solid #ddd;
        }

        button {
            padding: 8px 20px;
            background-color: #0056b3;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        button:hover {
            background-color: #004080;
        }

        table {
            width: 100%;
            margin-top: 30px;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 15px;
            text-align: center;
            border: 1px solid #ddd;
        }

        th {
            background-color: #007bff;
            color: white;
        }

        td {
            background-color: #f9f9f9;
        }

        .appointment {
            background-color: #28a745;
            color: white;
            padding: 5px;
            border-radius: 5px;
        }

        .appointment:hover {
            background-color: #218838;
        }

        .text-muted {
            color: #6c757d !important;
        }

        .bg-primary {
            background-color: #007bff !important;
        }

        /* Responsiveness */
        @media (max-width: 768px) {
            .container {
                margin-top: 30px;
            }

            table {
                font-size: 12px;
            }

            select {
                width: 100px;
            }

            button {
                width: 100%;
            }
        }
        .cell-status-dot {
            position: absolute;
            top: 7px;
            left: 7px;
            width: 13px;
            height: 13px;
            border-radius: 50%;
            display: inline-block;
            border: 2px solid #fff;
            z-index: 2;
            box-shadow: 0 0 2px rgba(0,0,0,0.14);
        }
        .status-pending { background-color: #ffc107; }   /* vàng */
        .status-completed { background-color: #28a745; } /* xanh lá */
        .status-canceled { background-color: #dc3545; }  /* đỏ */
        .appointment-cell {
            position: relative;
            min-height: 90px;
            padding-top: 15px;
        }
        .action-icons {
            display: flex;
            justify-content: center;
            gap: 7px;
            margin-top: 10px;
        }
        .action-icons button {
            background: none;
            border: none;
            cursor: pointer;
            padding: 0;
        }
        .action-icons button:focus { outline: none; }
        .action-icons i {
            font-size: 18px;
            color: #007bff;
            transition: color 0.2s;
        }
        .action-icons .icon-service i { color: #28a745; }
        .action-icons .icon-record i { color: #0dcaf0; }
        .action-icons .icon-service i:hover { color: #198754; }
        .action-icons .icon-record i:hover { color: #0b5ed7; }
    </style>
<!-- Font Awesome for icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">    
    
</head>
<body>
    <%@include file="../layout/Header.jsp" %>
    <div class="container-fluid bg-light">
            <div class="layout-specing">
                <div class="row justify-content-center">
        <h2 class="mb-4">Lịch cuộc hẹn bác sĩ: ${sessionScope.user.fullName}</h2>

        <!-- Form chọn năm và tuần -->
        <form method="get" action="your_api_endpoint">
            <label for="year">Chọn năm:</label>
            <select id="year" name="year">
                <!-- JavaScript sẽ điền vào đây -->
            </select>

            <label for="week">Chọn tuần:</label>
            <select id="week" name="week">
                <!-- JavaScript sẽ điền vào đây -->
            </select>

            
        </form>

        <!-- Bảng hiển thị các cuộc hẹn -->
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Time Slot</th>
                    <c:forEach var="day" items="${weekDates}">
                        <th class="text-center">
                            <fmt:formatDate value="${day}" pattern="EEEE" />
                            <br />
                            <fmt:formatDate value="${day}" pattern="dd/MM/yyyy" />
                        </th>
                    </c:forEach>
                </tr>
            </thead>
            <tbody id="appointmentsTableBody">
                <!-- JavaScript sẽ điền vào đây -->
            </tbody>
        </table>
    </div>
            </div>
    </div>
        
        <!-- Modal -->
<!-- Modal -->
<div class="modal fade" id="appointmentModal" tabindex="-1" aria-labelledby="appointmentModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="appointmentModalLabel">Chi tiết cuộc hẹn</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <!-- Tab navigation -->
        <ul class="nav nav-tabs" id="appointmentModalTabs" role="tablist">
          <li class="nav-item" role="presentation">
            <a class="nav-link active" id="appointment-details-tab" data-bs-toggle="tab" href="#appointment-details" role="tab" aria-controls="appointment-details" aria-selected="true">Chi tiết cuộc hẹn</a>
          </li>
          <li class="nav-item" role="presentation">
            <a class="nav-link" id="medical-history-tab" data-bs-toggle="tab" href="#medical-history" role="tab" aria-controls="medical-history" aria-selected="false">Lịch sử y tế</a>
          </li>
        </ul>

        <div class="tab-content mt-3" id="appointmentModalTabContent">
          <div class="tab-pane fade show active" id="appointment-details" role="tabpanel" aria-labelledby="appointment-details-tab">
            <!-- Chi tiết cuộc hẹn -->
            <div id="appointmentDetails"></div>
          </div>
          <div class="tab-pane fade" id="medical-history" role="tabpanel" aria-labelledby="medical-history-tab">
            <!-- Lịch sử y tế của Pet -->
            <div id="medicalHistoryDetails"></div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>



    <script>
    document.addEventListener('DOMContentLoaded', function() {
        // Lấy currentYear và currentWeek từ JavaScript
        const currentYear = new Date().getFullYear();

        // Hàm tính tuần hiện tại
        function getCurrentWeek(date) {
            const startDate = new Date(date.getFullYear(), 0, 1); // Đầu năm
            const days = Math.floor((date - startDate) / (24 * 60 * 60 * 1000)); // Số ngày từ đầu năm
            return Math.ceil((days + 1) / 7);
        }

        const currentWeek = getCurrentWeek(new Date());

        // Điền vào dropdown năm
        const yearSelect = document.getElementById('year');
        for (let i = currentYear - 5; i <= currentYear + 5; i++) {
            const option = document.createElement('option');
            option.value = i;
            option.textContent = i;
            if (i === currentYear) {
                option.selected = true;
            }
            yearSelect.appendChild(option);
        }

        // Điền vào dropdown tuần (1-52)
        const weekSelect = document.getElementById('week');
        for (let i = 1; i <= 52; i++) {
            const weekOption = document.createElement('option');
            weekOption.value = i;
            // Tính ngày bắt đầu và kết thúc của tuần i
        const weekDates = getStartAndEndOfWeek(currentYear, i);
        const weekRange = 'Tuần '+i +'('+weekDates.start.toLocaleDateString()+ ' - ' +weekDates.end.toLocaleDateString()+')';
            weekOption.textContent = weekRange;
            if (i === currentWeek) {
                weekOption.selected = true;
            }
            weekSelect.appendChild(weekOption);
        }

        // Gọi API khi trang được tải
        setTimeout(fetchAppointments, 1000); // Đặt thời gian trì hoãn 1 giây (1000ms)

        // Khi người dùng thay đổi năm hoặc tuần, gọi lại API để lấy dữ liệu mới
        document.getElementById('year').addEventListener('change', fetchAppointments);
        document.getElementById('week').addEventListener('change', fetchAppointments);

        // Hàm tính ngày bắt đầu và kết thúc của tuần
    function getStartAndEndOfWeek(year, week) {
        const startOfYear = new Date(year, 0, 1);
        const daysInMillis = (week - 1) * 7 * 24 * 60 * 60 * 1000;
        const startOfWeek = new Date(startOfYear.getTime() + daysInMillis);

        // Đảm bảo rằng ngày là thứ Hai
        while (startOfWeek.getDay() !== 1) {
            startOfWeek.setDate(startOfWeek.getDate() - 1); // Lùi lại đến ngày thứ Hai
        }

        const endOfWeek = new Date(startOfWeek);
        endOfWeek.setDate(startOfWeek.getDate() + 6); // Chủ nhật

        return { start: startOfWeek, end: endOfWeek };
    }
        function fetchAppointments() {
            const year = document.getElementById('year').value;
            const week = document.getElementById('week').value;
            const doctorId = '${sessionScope.user.id}'; // Dùng JSTL thay vì literal

            if (!year || !week || !doctorId) {
                alert('Vui lòng chọn năm, tuần và bác sĩ');
                return;
            }

            const url = './api/getappointmentbyweek?doctorId=' + doctorId + '&year=' + year + '&week=' + week;

            // Gọi API để lấy các cuộc hẹn của bác sĩ trong tuần đã chọn
            fetch(url)
                .then(function(response) {
                    return response.json();
                })
                .then(function(data) {
                    const appointments = data.appointments;
                    const timeSlots = data.timeSlots;
                    const weekDates = data.weekDates;
                    const tableBody = document.getElementById('appointmentsTableBody');

                    tableBody.innerHTML = ''; // Clear previous data

                    // Lặp qua các time slots
                    timeSlots.forEach(function(slot) {
                        const row = document.createElement('tr');
                        row.innerHTML = '<td>' + slot + '</td>';

                        // Lặp qua các ngày trong tuần
                        weekDates.forEach(function(day) {
                            const cell = document.createElement('td');
                            const foundAppointment = appointments.find(function(appt) {
                                const apptDate = new Date(appt.appointmentDate);
                                const dayDate = new Date(day);

                                const isSameDay = apptDate.toDateString() === dayDate.toDateString();
                                const isInSlot = appt.startTime === slot.split(' - ')[0] && appt.endTime === slot.split(' - ')[1];

                                return isSameDay && isInSlot;
                            });

                            // Nếu có cuộc hẹn, hiển thị thông tin
                            if (foundAppointment) {
    // Chọn màu theo trạng thái
    let dotClass = 'status-pending';
    let statusText = 'Đang chờ'; // default

    if (foundAppointment.appointmentStatus === 'completed') {
        dotClass = 'status-completed';
        statusText = 'Hoàn thành';
    };

    cell.classList.add('appointment-cell');
    cell.innerHTML =
        '<span class="cell-status-dot ' + dotClass + '" title="' + statusText + '"></span>' +
        '<a href="#" class="appointment-link fw-bold" data-id="' + foundAppointment.id + '" data-pet_id="' + foundAppointment.petId + '">' +
    foundAppointment.petCode + ' - ' + foundAppointment.petName + '<br/>' +
    '<small>' + foundAppointment.ownerName + '</small>' +
'</a>'+

        '<div class="action-icons">' +
            '<button type="button" class="icon-service add-service-btn" title="Thêm dịch vụ" data-id="' + foundAppointment.id + '">' +
                '<i class="fa-solid fa-plus"></i>' +
            '</button>' +
            '<button type="button" class="icon-record add-record-btn" title="Thêm hồ sơ" data-id="' + foundAppointment.id + '">' +
                '<i class="fa-solid fa-file-medical"></i>' +
            '</button>' +
        '</div>';
console.log(foundAppointment.id);
} else {
    cell.innerHTML = '-';
}


                            row.appendChild(cell);
                        });

                        tableBody.appendChild(row);
                    });
                    // Thêm sự kiện click cho các link cuộc hẹn
                document.querySelectorAll('.appointment-link').forEach(function(link) {
                    link.addEventListener('click', function(event) {
                        event.preventDefault();
                        const appointmentId = event.target.getAttribute('data-id');
                        const petId = event.target.getAttribute('data-pet_id');
                        openAppointmentModal(appointmentId,petId); // Mở modal và load dữ liệu
                    });
                });
                // Nút Thêm dịch vụ
document.querySelectorAll('.icon-service').forEach(function(button) {
    button.addEventListener('click', function(event) {
        const appointmentId = button.getAttribute('data-id');
        window.location.href = './add-appointment-service?appointmentId=' + appointmentId;
    });
});

// Nút Thêm hồ sơ
document.querySelectorAll('.add-record-btn').forEach(function(button) {
    button.addEventListener('click', function(event) {
        const appointmentId = button.getAttribute('data-id');
        // Gọi trang thêm hồ sơ bệnh án, truyền id
        window.location.href = './add-medical-record?appointmentId=' + appointmentId;
    });
});
                })
                .catch(function(error) {
                    console.log('Có lỗi xảy ra khi gọi API:', error);
                    alert('Có lỗi xảy ra khi tải dữ liệu');
                });
        }
    
    
    // Hàm mở modal và hiển thị thông tin chi tiết cuộc hẹn
    function openAppointmentModal(appointmentId,petId) {
        const url = './api/getappointmentdetails?id=' + appointmentId; // API lấy thông tin chi tiết cuộc hẹn
        const medicalHistoryUrl = './api/pet-medical-records?petId=' + petId; // API lấy thông tin lịch sử y tế của pet
        fetch(url)
            .then(function(response) {
                return response.json();
            })
            .then(function(data) {
                const appointment = data.appointments;
                const modalBody = document.getElementById('appointmentDetails');
                
                modalBody.innerHTML = '<p><strong>Tên Pet:</strong> ' + appointment[0].petName + '</p>' +
                                      '<p><strong>Pet Code:</strong> ' + appointment[0].petCode + '</p>' +
                                      '<p><strong>Giới tính Pet :</strong> ' + appointment[0].petGender + '</p>' +
                                      '<p><strong>Giống:</strong> ' + appointment[0].petBreed + '</p>' +
                                      '<p><strong>Mô tả:</strong> ' + appointment[0].petDescription + '</p>' +

                                      '<p><strong>Owner:</strong> ' + appointment[0].ownerName + '</p>' +
                                      '<p><strong>Phone:</strong> ' + appointment[0].ownerPhone + '</p>' +
                                      '<p><strong>Email:</strong> ' + appointment[0].ownerEmail + '</p>' +
                                      '<p><strong>Address:</strong> ' + appointment[0].ownerAddress + '</p>' +

                                      '<p><strong>Appointment Date:</strong> ' + appointment[0].appointmentDate + '</p>' +
                                      '<p><strong>Start Time:</strong> ' + appointment[0].startTime + '</p>' +
                                      '<p><strong>End Time:</strong> ' + appointment[0].endTime + '</p>' +
                                      '<p><strong>Note:</strong> ' + appointment[0].appointmentNote + '</p>' +
                                      '<p><strong>Status:</strong> ' + appointment[0].appointmentStatus + '</p>';

                // Mở modal
                const modal = new bootstrap.Modal(document.getElementById('appointmentModal'));
                setTimeout(modal.show(),1000);
            })
            .catch(function(error) {
                console.log('Có lỗi xảy ra khi tải thông tin cuộc hẹn:', error);
                alert('Có lỗi xảy ra khi tải thông tin cuộc hẹn');
            });
            
            fetch(medicalHistoryUrl)
        .then(function(response) {
            return response.json();
        })
        .then(function(data) {
            const medicalHistory = data.medicalRecords;
            const medicalHistoryDiv = document.getElementById('medicalHistoryDetails');
            medicalHistoryDiv.innerHTML = ''; // Clear previous data

            if (medicalHistory.length === 0) {
                medicalHistoryDiv.innerHTML = '<p>Không có lịch sử y tế.</p>';
                return;
            }

            medicalHistory.forEach(function(record) {
                medicalHistoryDiv.innerHTML += '<p><strong>Chẩn đoán:</strong> ' + record.diagnosis + '</p>' +
                                              '<p><strong>Điều trị:</strong> ' + record.treatment + '</p>' +
                                              '<p><strong>Ngày tái khám:</strong> ' + record.reexamdate + '</p>' +
                                              '<p><strong>Ngày tạo:</strong> ' + record.createddate + '</p>' +
                                              '<hr>';
            });
        })
        .catch(function(error) {
            console.log('Có lỗi xảy ra khi tải lịch sử y tế:', error);
            alert('Có lỗi xảy ra khi tải lịch sử y tế');
        });
    }
});


    </script>

    <!-- Bootstrap JS (optional) -->
     <!-- Bootstrap JS (optional) -->
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
       
        
       
        
        <!-- Icons -->
        <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
</body>
</html>


    