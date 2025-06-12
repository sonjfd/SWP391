/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Appointment;
import Model.Doctor;

import Model.MedicalRecords;
import Model.Pet;
import Model.User;
import java.util.ArrayList;
import java.util.List;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.AbstractList;
import java.util.Date;

/**
 *
 * @author ASUS
 */
public class MedicalRecordsDAO {

    public List<MedicalRecords> getMedicalRecordsByPetId(String petId) {
        List<MedicalRecords> list = new ArrayList<>();
        String sql = """
        SELECT mr.*, d.specialty, u.full_name AS doctor_name
        FROM medical_records mr
        JOIN doctors d ON mr.doctor_id = d.user_id
        JOIN users u ON d.user_id = u.id
        WHERE mr.pet_id = ?
        ORDER BY mr.created_at DESC
    """;
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, petId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                MedicalRecords mr = new MedicalRecords();
                mr.setId(rs.getString("id"));
                mr.setDiagnosis(rs.getString("diagnosis"));
                mr.setTreatment(rs.getString("treatment"));
                mr.setReExamDate(rs.getDate("re_exam_date"));
                mr.setCreatedAt(rs.getDate("created_at"));

                // Nếu muốn show cả bác sĩ khám:
                Doctor doctor = new Doctor();
                User u = new User();
                u.setId(rs.getString("doctor_id"));
                u.setFullName(rs.getString("doctor_name"));
                doctor.setUser(u);
                doctor.setSpecialty(rs.getString("specialty"));
                mr.setDoctor(doctor);
                list.add(mr);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<MedicalRecords> getMedicalRecordsByCustomerId(String customerId) {
        List<MedicalRecords> list = new ArrayList<>();
        String sql = """
        SELECT 
            p.id AS pet_id,
            p.pet_code,
            p.name AS pet_name,
            p.avatar,
            m.id AS medical_record_id,
            m.diagnosis,
            m.treatment,
            m.re_exam_date,
            m.created_at AS record_created_at,
            m.updated_at AS record_updated_at,
            a.id AS appointment_id,
            a.appointment_time,
            a.status AS appointment_status,
            u.id AS doctor_id,
            u.full_name AS doctor_name,
            d.specialty
        FROM 
            pets p
        INNER JOIN medical_records m ON p.id = m.pet_id
        INNER JOIN appointments a ON m.appointment_id = a.id
        INNER JOIN users u ON m.doctor_id = u.id
        INNER JOIN doctors d ON u.id = d.user_id
        WHERE 
            p.owner_id = ?
        ORDER BY 
            m.created_at DESC
    """;

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, customerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                MedicalRecords mr = new MedicalRecords();
                mr.setId(rs.getString("medical_record_id"));
                mr.setDiagnosis(rs.getString("diagnosis"));
                mr.setTreatment(rs.getString("treatment"));
                mr.setReExamDate(rs.getDate("re_exam_date"));
                mr.setCreatedAt(rs.getTimestamp("record_created_at"));
                mr.setUpdatedAt(rs.getTimestamp("record_updated_at"));

                // Pet
                Pet pet = new Pet();
                pet.setId(rs.getString("pet_id"));
                pet.setPet_code(rs.getString("pet_code"));
                pet.setName(rs.getString("pet_name"));
                pet.setAvatar(rs.getString("avatar"));
                mr.setPet(pet);

                // Appointment
                Appointment apm = new Appointment();
                apm.setId(rs.getString("appointment_id"));
                apm.setAppointmentDate(rs.getTimestamp("appointment_time"));
                apm.setStatus(rs.getString("appointment_status"));
                mr.setAppointment(apm);

                // Doctor
                Doctor doctor = new Doctor();
                User user = new User();
                user.setId(rs.getString("doctor_id"));
                user.setFullName(rs.getString("doctor_name"));
                doctor.setUser(user);
                doctor.setSpecialty(rs.getString("specialty"));
                mr.setDoctor(doctor);

                list.add(mr);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
public List<MedicalRecords> getMedicalRecordsByCustomerIdAndPetName(String customerId, String petName) {
        List<MedicalRecords> list = new ArrayList<>();
        String sql = """
        SELECT 
            p.id AS pet_id,
            p.pet_code,
            p.name AS pet_name,
            p.avatar,
            
            m.id AS medical_record_id,
            m.diagnosis,
            m.treatment,
            m.re_exam_date,
            m.created_at AS record_created_at,
            m.updated_at AS record_updated_at,
            a.id AS appointment_id,
            a.appointment_time,
            a.status AS appointment_status,
            u.id AS doctor_id,
            u.full_name AS doctor_name,
            d.specialty
        FROM 
            pets p
        INNER JOIN medical_records m ON p.id = m.pet_id
        INNER JOIN appointments a ON m.appointment_id = a.id
        INNER JOIN users u ON m.doctor_id = u.id
        INNER JOIN doctors d ON u.id = d.user_id
        WHERE 
            p.owner_id = ? and P.name LIKE ?
        ORDER BY 
            m.created_at DESC
    """;

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, customerId);
             ps.setString(2, "%" + petName + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                MedicalRecords mr = new MedicalRecords();
                mr.setId(rs.getString("medical_record_id"));
                mr.setDiagnosis(rs.getString("diagnosis"));
                mr.setTreatment(rs.getString("treatment"));
                mr.setReExamDate(rs.getDate("re_exam_date"));
                mr.setCreatedAt(rs.getTimestamp("record_created_at"));
                mr.setUpdatedAt(rs.getTimestamp("record_updated_at"));

                // Pet
                Pet pet = new Pet();
                pet.setId(rs.getString("pet_id"));
                pet.setPet_code(rs.getString("pet_code"));
                pet.setName(rs.getString("pet_name"));
                pet.setAvatar(rs.getString("avatar"));
                mr.setPet(pet);

                // Appointment
                Appointment apm = new Appointment();
                apm.setId(rs.getString("appointment_id"));
                apm.setAppointmentDate(rs.getTimestamp("appointment_time"));
                apm.setStatus(rs.getString("appointment_status"));
                mr.setAppointment(apm);

                // Doctor
                Doctor doctor = new Doctor();
                User user = new User();
                user.setId(rs.getString("doctor_id"));
                user.setFullName(rs.getString("doctor_name"));
                doctor.setUser(user);
                doctor.setSpecialty(rs.getString("specialty"));
                mr.setDoctor(doctor);

                list.add(mr);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    // Thêm mới
    public boolean addMedicalRecord(String petId, String doctorId, String appointmentId,
            String diagnosis, String treatment,
            java.sql.Date reExamDate) {
        String sql = "INSERT INTO medical_records (pet_id, doctor_id, appointment_id, diagnosis, treatment, re_exam_date, created_at, updated_at) "
                + "VALUES (?, ?, ?, ?, ?, ?, GETDATE(), GETDATE())";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, petId);
            ps.setString(2, doctorId);
            ps.setString(3, appointmentId);
            ps.setString(4, diagnosis);
            ps.setString(5, treatment);
            if (reExamDate != null) {
                ps.setDate(6, reExamDate);
            } else {
                ps.setNull(6, java.sql.Types.DATE);
            }
            return ps.executeUpdate() > 0;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }

// Sửa hồ sơ
    public boolean updateMedicalRecord(String id, String petId, String doctorId, String appointmentId,
            String diagnosis, String treatment,
            java.sql.Date reExamDate) {
        String sql = "UPDATE medical_records SET diagnosis=?, treatment=?, re_exam_date=?, updated_at=GETDATE() WHERE id=?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, diagnosis);
            ps.setString(2, treatment);
            if (reExamDate != null) {
                ps.setDate(3, reExamDate);
            } else {
                ps.setNull(3, java.sql.Types.DATE);
            }
            ps.setString(4, id);
            return ps.executeUpdate() > 0;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }

// phân trang
    public List<MedicalRecords> getMedicalRecordsByDateRangeAndPaging(
            String doctorId, Date fromDate, Date toDate, int offset, int pageSize
    ) {
        List<MedicalRecords> list = new ArrayList<>();
        String sql = "SELECT mr.id as mr_id,mr.pet_id AS mr_pet_id,a.id as apm_id, "
                + "appointment_time,pet_code,treatment,diagnosis,re_exam_date "
                + "FROM medical_records mr "
                + "JOIN pets p ON mr.pet_id = p.id "
                + "JOIN appointments a on mr.appointment_id = a.id "
                + "WHERE (? IS NULL OR CAST(mr.created_at AS DATE) >= ?) "
                + "AND (? IS NULL OR CAST(mr.created_at AS DATE) <= ?) "
                + "AND mr.doctor_id = ? "
                + "ORDER BY mr.created_at DESC "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection con = DBContext.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setObject(1, fromDate);
            ps.setObject(2, fromDate);
            ps.setObject(3, toDate);
            ps.setObject(4, toDate);
            ps.setString(5, doctorId);
            ps.setInt(6, offset);
            ps.setInt(7, pageSize);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                MedicalRecords mr = new MedicalRecords();
                // set các trường của mr
                mr.setId(rs.getString("mr_id"));
                Pet pet = new Pet();
                pet.setId(rs.getString("mr_pet_id"));
                pet.setPet_code(rs.getString("pet_code"));
                Appointment appointment = new Appointment();
                appointment.setAppointmentDate(rs.getDate("appointment_time"));
                appointment.setId(rs.getString("apm_id"));
                Doctor doctor = new Doctor();
                mr.setAppointment(appointment);
                mr.setDoctor(doctor);
                mr.setPet(pet);
                mr.setDiagnosis(rs.getString("diagnosis"));
                mr.setReExamDate((java.sql.Date) rs.getDate("re_exam_date"));
                mr.setTreatment(rs.getString("treatment"));

                list.add(mr);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

// Đếm tổng số record để chia trang
    public int countMedicalRecordsByDateRange(String doctorId, Date fromDate, Date toDate) {
        String sql = "SELECT COUNT(*) FROM medical_records WHERE "
                + "(? IS NULL OR CAST(created_at AS DATE) >= ?) AND "
                + "(? IS NULL OR CAST(created_at AS DATE) <= ?) "
                + "AND doctor_id = ?";
        try (Connection con = DBContext.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setObject(1, fromDate);
            ps.setObject(2, fromDate);
            ps.setObject(3, toDate);
            ps.setObject(4, toDate);
            ps.setString(5, doctorId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public static void main(String[] args) {
        List<MedicalRecords> list = new ArrayList<>();
        MedicalRecordsDAO md = new MedicalRecordsDAO();
        list = md.getMedicalRecordsByCustomerId("573C2A95-E231-43C0-A784-7CA8DA43206E");
        for (MedicalRecords medicalRecords : list) {
            System.out.println(medicalRecords);
        }
    }
}
