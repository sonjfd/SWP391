/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Appointment;
import Model.Doctor;
import Model.MedicalRecord;
import Model.MedicalRecordFile;
import Model.Pet;
import Model.PrescribedMedicine;
import Model.User;
import java.util.ArrayList;
import java.util.List;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.Types;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;



/**
 *
 * @author ASUS
 */
public class MedicalRecordDAO {
    
//CỦA HẢI NGU
    public List<MedicalRecord> getMedicalRecordsByPetId(String petId) {
        List<MedicalRecord> list = new ArrayList<>();
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
                MedicalRecord mr = new MedicalRecord();
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

    public List<MedicalRecord> getMedicalRecordsByCustomerId(String customerId) {
        List<MedicalRecord> list = new ArrayList<>();
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
                MedicalRecord mr = new MedicalRecord();
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
public List<MedicalRecord> getMedicalRecordsByCustomerIdAndPetName(String customerId, String petName) {
        List<MedicalRecord> list = new ArrayList<>();
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
                MedicalRecord mr = new MedicalRecord();
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
    //HẾT HẢI NGU
// MedicalRecordDAO.java

    

    

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

    public List<MedicalRecord> getMedicalRecordsByDateRangeAndPaging(
            String doctorId, Date fromDate, Date toDate, int offset, int pageSize
    ) {
        List<MedicalRecord> list = new ArrayList<>();
        String sql = "SELECT mr.id as mr_id,mr.pet_id AS mr_pet_id,a.id as apm_id, "
                + "appointment_time,pet_code,treatment,diagnosis,re_exam_date, "
                + "p.avatar AS pet_avatar,gender,birth_date,description,full_name,name "
                + "FROM medical_records mr "
                + "JOIN pets p ON mr.pet_id = p.id "
                + "JOIN users u ON u.id = p.owner_id "
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
                MedicalRecord mr = new MedicalRecord();
                // set các trường của mr
                mr.setId(rs.getString("mr_id"));
                Pet pet = new Pet();
                pet.setId(rs.getString("mr_pet_id"));
                pet.setPet_code(rs.getString("pet_code"));
                User u = new User();
                u.setFullName(rs.getString("full_name"));
                pet.setUser(u);
                pet.setAvatar(rs.getString("pet_avatar"));
                pet.setDescription(rs.getString("description"));
                pet.setName(rs.getString("name"));
                pet.setGender(rs.getString("gender"));
                pet.setBirthDate(rs.getDate("birth_date"));
                Appointment appointment = new Appointment();
                appointment.setAppointmentDate(rs.getDate("appointment_time"));
                appointment.setId(rs.getString("apm_id"));
                Doctor doctor = new Doctor();
                mr.setAppointment(appointment);
                mr.setDoctor(doctor);
                mr.setPet(pet);
                mr.setDiagnosis(rs.getString("diagnosis"));
                mr.setReExamDate((java.sql.Date)rs.getDate("re_exam_date"));
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
   
    public boolean createFullMedicalRecord(
        String appointmentId, String doctorId, String petId,
        String diagnosis, String treatment, java.sql.Date reExamDate,
        List<PrescribedMedicine> prescribedList,
        List<MedicalRecordFile> files // UploadedFile có sẵn file_path, file_name đã lưu
    ) throws Exception {
        // Tự mở connection, transaction
        try (Connection conn = DBContext.getConnection()) {
            try {
                conn.setAutoCommit(false);
                String sql = "INSERT INTO medical_records (pet_id, doctor_id, appointment_id, diagnosis, treatment, re_exam_date, created_at) VALUES (?, ?, ?, ?, ?, ?, GETDATE())";
                String medicalRecordId = null;
                try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                    ps.setString(1, petId);
                    ps.setString(2, doctorId);
                    ps.setString(3, appointmentId);
                    ps.setString(4, diagnosis);
                    ps.setString(5, treatment);
                    if (reExamDate != null)
                        ps.setDate(6, reExamDate);
                    else
                        ps.setNull(6, Types.DATE);
                    ps.executeUpdate();
                    try (ResultSet rs = ps.getGeneratedKeys()) {
                        if (rs.next()) {
                            medicalRecordId = rs.getString(1);
                        }
                    }
                }

                // Insert các file đính kèm (nếu có)
                if (files != null && !files.isEmpty()) {
                    String fileSql = "INSERT INTO medical_record_files (medical_record_id, file_name, file_url) VALUES (?, ?, ?)";
                    try (PreparedStatement psFile = conn.prepareStatement(fileSql)) {
                        for (MedicalRecordFile uf : files) {
                            psFile.setString(1, medicalRecordId);
                            psFile.setString(2, uf.getFileName());
                            psFile.setString(3, uf.getFileName());
                            psFile.addBatch();
                        }
                        psFile.executeBatch();
                    }
                }

                // Insert các thuốc kê đơn (nếu có)
                if (prescribedList != null && !prescribedList.isEmpty()) {
                    String medSql = "INSERT INTO prescribed_medicines (medical_record_id, medicine_id, quantity, dosage, duration, usage_instructions) VALUES (?, ?, ?, ?, ?, ?)";
                    try (PreparedStatement psMed = conn.prepareStatement(medSql)) {
                        for (PrescribedMedicine pm : prescribedList) {
                            psMed.setString(1, medicalRecordId);
                            psMed.setString(2, pm.getMedicineId());
                            psMed.setInt(3, pm.getQuantity());
                            psMed.setString(4, pm.getDosage());
                            psMed.setString(5, pm.getDuration());
                            psMed.setString(6, pm.getUsageInstructions());
                            psMed.addBatch();
                        }
                        psMed.executeBatch();
                    }
                }

                conn.commit();
                return true;
            } catch (Exception ex) {
                conn.rollback();
                throw ex;
            }
        }
    }
    public static void main(String[] args) {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date fd = sdf.parse("2025-06-06");
            Date td = sdf.parse("2025-06-07");
List<MedicalRecord> l = new MedicalRecordDAO().getMedicalRecordsByDateRangeAndPaging("AE9A08FC-2F7B-45F5-A61F-40CF39A7BBCA", null, null, 0, 5);
        System.out.println(l.size());
            System.out.println("From date: " + fd);
            System.out.println("To date: " + td);
        } catch (Exception e) {
            e.printStackTrace();
        }
        List<MedicalRecord> l = new MedicalRecordDAO().getMedicalRecordsByPetId("D8AE52E3-7227-4778-8BDC-079F583C0243");
        System.out.println(l.size());
    }
}
