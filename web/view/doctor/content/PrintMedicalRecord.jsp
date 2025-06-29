<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
  <title>In hồ sơ y tế</title>
  <style>
    body { font-family: Arial; padding: 20px; }
    h3 { margin-top: 40px; border-bottom: 1px solid #ccc; padding-bottom: 5px; }
    .section { margin-bottom: 30px; }
    .label { font-weight: bold; display: inline-block; min-width: 140px; }
    .muted { color: #888; }
    .table { width: 100%; border-collapse: collapse; margin-top: 10px; }
    .table th, .table td { border: 1px solid #ccc; padding: 8px; text-align: left; }
    @media print {
      .no-print {
        display: none !important;
      }
    }
  </style>
</head>
<body>

  <div class="text-end no-print" style="margin-bottom: 20px;">
    <button onclick="window.print()" class="btn btn-primary">
      🖨️ In hồ sơ
    </button>
  </div>

  <h2>Hồ sơ y tế</h2>

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

  <div class="section">
    <h3>Thông tin chủ nuôi</h3>
    <p><span class="label">Họ tên:</span> ${record.pet.user.fullName}</p>
    <p><span class="label">Email:</span> ${record.pet.user.email}</p>
    <p><span class="label">SĐT:</span> ${record.pet.user.phoneNumber}</p>
    <p><span class="label">Địa chỉ:</span> ${record.pet.user.address}</p>
  </div>

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
              <td><c:out value="Đã hoàn thành" default="-" /></td>
            </tr>
              
          </c:forEach>
        </tbody>
      </table>
    </div>
  </c:if>

  <!-- Phần file đính kèm sẽ bị ẩn khi in -->
  <c:if test="${not empty record.files}">
    <div class="section no-print">
      <h3>File đính kèm</h3>
      <ul>
        <c:forEach var="f" items="${record.files}">
          <li>
            <a href="${f.fileUrl}" target="_blank">${f.fileName}</a>
            (<fmt:formatDate value="${f.uploadedAt}" pattern="dd/MM/yyyy HH:mm" />)
          </li>
        </c:forEach>
      </ul>
    </div>
  </c:if>

</body>
</html>
