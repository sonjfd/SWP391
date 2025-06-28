/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;
import Model.AppointmentSymptom;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
/**
 *
 * @author ASUS
 */
public class AppointmentSymptomDAO {
     // Thêm một chuẩn đoán triệu chứng mới
    public boolean addAppointmentSymptom(AppointmentSymptom symptom) {
        String sql = "INSERT INTO appointment_symptoms (appointment_id, symptom, diagnosis, note, created_at) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, symptom.getAppointmentId());
            stmt.setString(2, symptom.getSymptom());
            stmt.setString(3, symptom.getDiagnosis());
            stmt.setString(4, symptom.getNote());
            stmt.setTimestamp(5, new Timestamp(symptom.getCreated_at().getTime()));

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Lấy danh sách triệu chứng của một cuộc hẹn
    public List<AppointmentSymptom> getDiagnosisByAppointmentId(String appointmentId) {
        List<AppointmentSymptom> symptoms = new ArrayList<>();
        String sql = "SELECT * FROM appointment_symptoms WHERE appointment_id = ?";
        try (
                Connection conn = DBContext.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, appointmentId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                AppointmentSymptom symptom = new AppointmentSymptom();
                symptom.setId(rs.getString("id"));
                symptom.setAppointmentId(rs.getString("appointment_id"));
                symptom.setSymptom(rs.getString("symptom"));
                symptom.setDiagnosis(rs.getString("diagnosis"));
                symptom.setNote(rs.getString("note"));
                symptom.setCreated_at(rs.getTimestamp("created_at"));
                symptoms.add(symptom);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return symptoms;
    }

    // Cập nhật thông tin triệu chứng
    public boolean updateAppointmentSymptom(AppointmentSymptom symptom) {
        String sql = "UPDATE appointment_symptoms SET symptom = ?, diagnosis = ?, note = ? WHERE id = ?";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, symptom.getSymptom());
            stmt.setString(2, symptom.getDiagnosis());
            stmt.setString(3, symptom.getNote());
            stmt.setString(4, symptom.getId());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa triệu chứng theo ID
    public boolean deleteAppointmentSymptom(String id) {
        String sql = "DELETE FROM appointment_symptoms WHERE id = ?";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, id);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Phương thức lấy chuẩn đoán theo ID
    public AppointmentSymptom getDiagnosisById(String id) {
        String sql = "SELECT * FROM appointment_symptoms WHERE id = ?";
        AppointmentSymptom symptom = null;
        try (PreparedStatement stmt = DBContext.getConnection().prepareStatement(sql)) {
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                symptom = new AppointmentSymptom();
                symptom.setId(rs.getString("id"));
                symptom.setAppointmentId(rs.getString("appointment_id"));
                symptom.setSymptom(rs.getString("symptom"));
                symptom.setDiagnosis(rs.getString("diagnosis"));
                symptom.setNote(rs.getString("note"));
                symptom.setCreated_at(rs.getTimestamp("created_at"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return symptom;
    }
    public static void main(String[] args) {
        Boolean b = new AppointmentSymptomDAO().addAppointmentSymptom(new AppointmentSymptom("", "624B3809-EE79-45C1-9885-24C76ED29261", "", "", "", new Date()));
                System.out.println(b);
    }
}

