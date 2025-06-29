<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
  <title>In hồ sơ y tế</title>
  <style>
    body { font-family: Arial, sans-serif; padding: 20px; }
    h1, h2, h3 { margin: 0 0 10px; }
    .section {
      padding: 15px 20px;
      border: 1px solid #e0e0e0;
      border-radius: 8px;
      margin-bottom: 30px;
      background-color: #f9f9f9;
    }
    .label { font-weight: bold; display: inline-block; min-width: 140px; }
    .muted { color: #888; }
    .table { width: 100%; border-collapse: collapse; margin-top: 10px; }
    .table th, .table td {
      border: 1px solid #bbb;
      padding: 8px;
      text-align: left;
    }
    .table th {
      background-color: #f0f0f0;
    }
    .clinic-header {
      display: flex;
      align-items: center;
      margin-bottom: 20px;
    }
    .clinic-header img {
      height: 80px;
      margin-right: 20px;
    }
    .clinic-header h1 {
      margin-bottom: 5px;
    }
    @media print {
      .no-print { display: none !important; }
    }
  </style>
</head>
<body>

  <!-- Nút in -->
  <div class="text-end no-print" style="margin-bottom: 20px;">
    <button onclick="window.print()" class="btn btn-primary">🖨️ In hồ sơ</button>
  </div>

  <!-- Thông tin phòng khám -->
  <div class="clinic-header">
    <c:if test="${not empty clinic.logo}">
      <img src="${clinic.logo}" alt="Logo phòng khám">
    </c:if>
    <div>
      <h1>${clinic.name}</h1>
      <p>${clinic.address} | ${clinic.phone} | ${clinic.email}</p>
    </div>
  </div>
  <hr>

  <h2>Hồ sơ y tế</h2>

  <!-- Thông tin thú cưng -->
  <div class="section">
    <h3>Thông tin thú cưng</h3>
    <p><span class="label">Tên:</span> ${record.pet.name}</p>
    <p><span class="label">Mã thú cưng:</span> ${record.pet.pet_code}</p>
    <p><span class="label">Giống:</span> ${record.pet.breed.name}</p>
    <p><span class="label">Giới tính:</span> ${record.pet.gender}</p>
    <p><span class="label">Ngày sinh:</span>
      <c:choose>
        <c:when test="${not empty record.pet.birthDate}">
          <fmt:formatDate value="${record.pet.birthDate}" pattern="dd/MM/yyyy" />
        </c:when>
        <c:otherwise><span class="muted">Không có</span></c:otherwise>
      </c:choose>
    </p>
  </div>

  <!-- Thông tin chủ nuôi -->
  <div class="section">
    <h3>Thông tin chủ nuôi</h3>
    <p><span class="label">Họ tên:</span> ${record.pet.user.fullName}</p>
    <p><span class="label">Email:</span> ${record.pet.user.email}</p>
    <p><span class="label">SĐT:</span> ${record.pet.user.phoneNumber}</p>
    <p><span class="label">Địa chỉ:</span> ${record.pet.user.address}</p>
  </div>

  <!-- Chi tiết hồ sơ -->
  <div class="section">
    <h3>Chi tiết hồ sơ</h3>
    <p><span class="label">Ngày tạo:</span>
      <fmt:formatDate value="${record.createdAt}" pattern="dd/MM/yyyy HH:mm" />
    </p>
    <p><span class="label">Chẩn đoán:</span> <c:out value="${record.diagnosis}" default="-" /></p>
    <p><span class="label">Phác đồ điều trị:</span> <c:out value="${record.treatment}" default="-" /></p>
    <p><span class="label">Ngày tái khám:</span>
      <c:choose>
        <c:when test="${not empty record.reExamDate}">
          <fmt:formatDate value="${record.reExamDate}" pattern="dd/MM/yyyy" />
        </c:when>
        <c:otherwise><span class="muted">Không có</span></c:otherwise>
      </c:choose>
    </p>
  </div>

  <!-- Thuốc kê đơn -->
  <c:if test="${not empty record.prescribedMedicines}">
    <div class="section">
      <h3>Thuốc kê đơn</h3>
      <table class="table">
        <thead>
          <tr>
            <th>Tên thuốc</th>
            <th>Số lượng</th>
            <th>Liều dùng</th>
            <th>Thời gian</th>
            <th>Hướng dẫn</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="m" items="${record.prescribedMedicines}">
            <tr>
              <td><c:out value="${m.medicineName}" default="-" /></td>
              <td>${m.quantity}</td>
              <td><c:out value="${m.dosage}" default="-" /></td>
              <td><c:out value="${m.duration}" default="-" /></td>
              <td><c:out value="${m.usageInstructions}" default="-" /></td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>
  </c:if>

  <!-- Chuẩn đoán sơ bộ -->
  <c:if test="${not empty record.appointmentSymptoms}">
    <div class="section">
      <h3>Chuẩn đoán sơ bộ</h3>
      <table class="table">
        <thead>
          <tr>
            <th>Triệu chứng</th>
            <th>Chuẩn đoán</th>
            <th>Ghi chú</th>
            <th>Thời gian</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="s" items="${record.appointmentSymptoms}">
            <tr>
              <td><c:out value="${s.symptom}" default="-" /></td>
              <td><c:out value="${s.diagnosis}" default="-" /></td>
              <td><c:out value="${s.note}" default="-" /></td>
              <td>
                <c:choose>
                  <c:when test="${not empty s.created_at}">
                    <fmt:formatDate value="${s.created_at}" pattern="dd/MM/yyyy HH:mm" />
                  </c:when>
                  <c:otherwise><span class="muted">-</span></c:otherwise>
                </c:choose>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>
  </c:if>

  <!-- Dịch vụ chỉ định -->
  <c:if test="${not empty record.appointmentServices}">
    <div class="section">
      <h3>Dịch vụ chỉ định</h3>
      <table class="table">
        <thead>
          <tr>
            <th>Dịch vụ</th>
            <th>Giá</th>
            <th>Trạng thái</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="s" items="${record.appointmentServices}">
            <tr>
              <td>${s.service.name}</td>
              <td>
                <fmt:formatNumber value="${s.price}" maxFractionDigits="0" type="currency" currencySymbol="₫" groupingUsed="true"/>
              </td>
              <td>Đã hoàn thành</td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>
  </c:if>

  <!-- File đính kèm -->
  <c:if test="${not empty record.files}">
    <div class="section no-print">
      <h3>File đính kèm</h3>
      <ul>
        <c:forEach var="f" items="${record.files}">
          <li>
            <span class="file-name">${f.fileName}</span>
            <span class="muted">(<fmt:formatDate value="${f.uploadedAt}" pattern="dd/MM/yyyy HH:mm" />)</span>
            <span class="no-print"> - <a href="${f.fileUrl}" target="_blank">Xem</a></span>
          </li>
        </c:forEach>
      </ul>
    </div>
  </c:if>

  <!-- Chữ ký bác sĩ -->
  <c:if test="${not empty record.doctor.user.fullName}">
    <div style="margin-top: 80px;">
      <div style="float: right; text-align: center;">
        <p>Bác sĩ điều trị</p>
        <div style="height: 80px;"></div>
        <p><strong>${record.doctor.user.fullName}</strong></p>
      </div>
    </div>
  </c:if>

</body>
</html>
