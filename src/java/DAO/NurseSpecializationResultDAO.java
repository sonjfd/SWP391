package DAO;

import Model.NurseSpecializationResult;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NurseSpecializationResultDAO {

    // Thêm kết quả mới
    public String getResultIdIfExists(String appointmentId, String serviceId) {
    String sql = "SELECT id FROM nurse_specialization_results WHERE appointment_id = ? AND service_id = ?";
    try (Connection conn = DBContext.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, appointmentId);
        ps.setString(2, serviceId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getString("id"); // Trả về resultId đã tồn tại
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return null;
}

public String insertIfNotExists(String appointmentId, String nurseId, String serviceId) {
    String existingId = getResultIdIfExists(appointmentId, serviceId);
    if (existingId != null) {
        return existingId;
    }

    String resultId = java.util.UUID.randomUUID().toString();
    String sql = "INSERT INTO nurse_specialization_results (id, appointment_id, service_id, nurse_id, created_at) VALUES (?, ?, ?, ?, GETDATE())";
    try (Connection conn = DBContext.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, resultId);
        ps.setString(2, appointmentId);
        ps.setString(3, serviceId);
        ps.setString(4, nurseId);
        ps.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return resultId;
}


    // Lấy danh sách kết quả của một y tá
    public List<NurseSpecializationResult> findByNurse(String nurseId) {
        List<NurseSpecializationResult> list = new ArrayList<>();
        String sql = "SELECT * FROM nurse_specialization_results WHERE nurse_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, nurseId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                NurseSpecializationResult result = new NurseSpecializationResult();
                result.setId(rs.getString("id"));
                // set thêm các trường khác nếu cần
                list.add(result);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy kết quả theo appointment + service
    public NurseSpecializationResult findByAppointmentService(String appointmentId, String serviceId) {
        String sql = "SELECT * FROM nurse_specialization_results WHERE appointment_id = ? AND service_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, appointmentId);
            ps.setString(2, serviceId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                NurseSpecializationResult result = new NurseSpecializationResult();
                result.setId(rs.getString("id"));
                // set thêm các trường khác nếu cần
                return result;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
