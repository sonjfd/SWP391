/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Appointment;
import Model.Breed;
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
import java.util.UUID;

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
// Của ĐẠI
// Kiểm tra xem cuộc hẹn đã có hồ sơ y tế hay chưa
    public boolean checkExistingMedicalRecordForAppointment(String appointmentId) {
        boolean hasMedicalRecord = false;

        String sql = "SELECT COUNT(*) FROM medical_records WHERE appointment_id = ?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, appointmentId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                hasMedicalRecord = rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return hasMedicalRecord;
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
                String medicalRecordId = UUID.randomUUID().toString();
                conn.setAutoCommit(false);
                String sql = "INSERT INTO medical_records (id,pet_id, doctor_id, appointment_id, diagnosis, treatment, re_exam_date, created_at) VALUES (?,?, ?, ?, ?, ?, ?, GETDATE())";

                try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                    ps.setString(1, medicalRecordId);
                    ps.setString(2, petId);
                    ps.setString(3, doctorId);
                    ps.setString(4, appointmentId);
                    ps.setString(5, diagnosis);
                    ps.setString(6, treatment);
                    if (reExamDate != null) {
                        ps.setDate(7, reExamDate);
                    } else {
                        ps.setNull(7, Types.DATE);
                    }
                    ps.executeUpdate();

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

    public List<MedicalRecord> getMedicalRecordsByAppointmentId(String appointmentId) {
        List<MedicalRecord> medicalRecords = new ArrayList<>();

        String query = "SELECT * FROM medical_records WHERE appointment_id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, appointmentId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                MedicalRecord record = new MedicalRecord();
                record.setId(rs.getString("id"));
                record.setDiagnosis(rs.getString("diagnosis"));
                record.setTreatment(rs.getString("treatment"));
                record.setReExamDate(rs.getDate("re_exam_date"));
                record.setCreatedAt(rs.getTimestamp("created_at"));
                record.setUpdatedAt(rs.getTimestamp("updated_at"));

                // Lấy file đính kèm
                String fileQuery = "SELECT * FROM medical_record_files WHERE medical_record_id = ?";
                try (PreparedStatement psFile = conn.prepareStatement(fileQuery)) {
                    psFile.setString(1, record.getId());
                    ResultSet fileRs = psFile.executeQuery();
                    List<MedicalRecordFile> files = new ArrayList<>();
                    while (fileRs.next()) {
                        MedicalRecordFile file = new MedicalRecordFile();
                        file.setId(fileRs.getString("id"));
                        file.setFileName(fileRs.getString("file_name"));
                        file.setFileUrl(fileRs.getString("file_url"));
                        file.setUploadedAt(fileRs.getTimestamp("uploaded_at"));
                        files.add(file);
                    }
                    record.setFiles(files);
                } catch (Exception e) {
                    e.printStackTrace();
                }

                // Lấy kê đơn thuốc
                String medicineQuery = "SELECT * FROM prescribed_medicines WHERE medical_record_id = ?";
                try (PreparedStatement psMedicine = conn.prepareStatement(medicineQuery)) {
                    psMedicine.setString(1, record.getId());
                    ResultSet medicineRs = psMedicine.executeQuery();
                    List<PrescribedMedicine> medicines = new ArrayList<>();
                    while (medicineRs.next()) {
                        PrescribedMedicine medicine = new PrescribedMedicine();
                        medicine.setMedicineId(medicineRs.getString("medicine_id"));
                        medicine.setQuantity(medicineRs.getInt("quantity"));
                        medicine.setDosage(medicineRs.getString("dosage"));
                        medicine.setDuration(medicineRs.getString("duration"));
                        medicine.setUsageInstructions(medicineRs.getString("usage_instructions"));
                        medicines.add(medicine);
                    }
                    record.setPrescribedMedicines(medicines);
                } catch (Exception e) {
                    e.printStackTrace();
                }

                medicalRecords.add(record);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return medicalRecords;
    }
    
    public MedicalRecord getMedicalRecordById(String medicalRecordId) {
    MedicalRecord medicalRecord = null;
    String query = """
                   SELECT 
                       mr.id AS medical_record_id,
                       diagnosis,appointment_id as appt_id,
                   treatment,
                   re_exam_date,
                   mr.created_at as mr_created_at,
                   mr.updated_at as mr_updated_at,
                   b.name as breed_name,
                       p.pet_code,
                       p.name AS pet_name,
                       p.birth_date,
                       p.gender,

                       u.full_name AS owner_name,
                       u.email AS owner_email,
                       u.phone AS owner_phone,
                       u.address AS owner_address
                   
                   FROM medical_records mr
                   JOIN pets p ON mr.pet_id = p.id
                   JOIN breeds b on p.breeds_id=b.id
                   JOIN users u ON p.owner_id = u.id
                   WHERE mr.id = ?;
                   """;

    try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
        ps.setString(1, medicalRecordId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            medicalRecord = new MedicalRecord();
            medicalRecord.setId(medicalRecordId);
            medicalRecord.setDiagnosis(rs.getString("diagnosis"));
            medicalRecord.setTreatment(rs.getString("treatment"));
            medicalRecord.setReExamDate(rs.getDate("re_exam_date"));
            medicalRecord.setCreatedAt(rs.getTimestamp("mr_created_at"));
            medicalRecord.setUpdatedAt(rs.getTimestamp("mr_updated_at"));
            User user = new User();
            user.setFullName(rs.getString("owner_name"));
            user.setPhoneNumber(rs.getString("owner_phone"));
            user.setEmail(rs.getString("owner_email"));
            user.setAddress(rs.getString("owner_address"));
            Breed breed = new Breed();
            breed.setName(rs.getString("breed_name"));
            Pet pet = new Pet();
            pet.setBirthDate(rs.getDate("birth_date"));
            pet.setUser(user);
            pet.setBreed(breed);
            pet.setPet_code(rs.getString("pet_code"));
            pet.setGender(rs.getString("gender"));
            pet.setName(rs.getString("pet_name"));
            medicalRecord.setPet(pet);
            Appointment appt = new Appointment();
            appt.setId(rs.getString("appt_id"));
            medicalRecord.setAppointment(appt);
            
            // Lấy file đính kèm
            String fileQuery = "SELECT * FROM medical_record_files WHERE medical_record_id = ?";
            try (PreparedStatement psFile = conn.prepareStatement(fileQuery)) {
                psFile.setString(1, medicalRecord.getId());
                ResultSet fileRs = psFile.executeQuery();
                List<MedicalRecordFile> files = new ArrayList<>();
                while (fileRs.next()) {
                    MedicalRecordFile file = new MedicalRecordFile();
                    file.setId(fileRs.getString("id"));
                    file.setFileName(fileRs.getString("file_name"));
                    file.setFileUrl(fileRs.getString("file_url"));
                    file.setUploadedAt(fileRs.getTimestamp("uploaded_at"));
                    files.add(file);
                }
                medicalRecord.setFiles(files);
            } catch (Exception e) {
                e.printStackTrace();
            }

            // Lấy kê đơn thuốc
            String medicineQuery = "SELECT * FROM prescribed_medicines WHERE medical_record_id = ?";
            try (PreparedStatement psMedicine = conn.prepareStatement(medicineQuery)) {
                psMedicine.setString(1, medicalRecord.getId());
                ResultSet medicineRs = psMedicine.executeQuery();
                List<PrescribedMedicine> medicines = new ArrayList<>();
                while (medicineRs.next()) {
                    PrescribedMedicine medicine = new PrescribedMedicine();
                    medicine.setMedicineId(medicineRs.getString("medicine_id"));
                    medicine.setQuantity(medicineRs.getInt("quantity"));
                    medicine.setDosage(medicineRs.getString("dosage"));
                    medicine.setDuration(medicineRs.getString("duration"));
                    medicine.setUsageInstructions(medicineRs.getString("usage_instructions"));
                    medicines.add(medicine);
                }
                medicalRecord.setPrescribedMedicines(medicines);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    return medicalRecord;
}
    
    public boolean updateMedicalRecordWithFiles(
        String medicalRecordId, String doctorId, String petId,
        String diagnosis, String treatment, java.sql.Date reExamDate,
        List<PrescribedMedicine> prescribedList, List<MedicalRecordFile> files) {
    
    boolean result = false;
    String updateMedicalRecordQuery = "UPDATE medical_records SET diagnosis = ?, treatment = ?, re_exam_date = ?, updated_at = GETDATE() WHERE id = ?";
    String deletePrescribedMedicinesQuery = "DELETE FROM prescribed_medicines WHERE medical_record_id = ?";
    String insertPrescribedMedicinesQuery = "INSERT INTO prescribed_medicines (medical_record_id, medicine_id, quantity, dosage, duration, usage_instructions) VALUES (?, ?, ?, ?, ?, ?)";
    String insertMedicalRecordFileQuery = "INSERT INTO medical_record_files (medical_record_id, file_name, file_url, uploaded_at) VALUES (?, ?, ?, GETDATE())";

    try (Connection conn = DBContext.getConnection()) {
        // Disable auto-commit for transaction
        conn.setAutoCommit(false);

        try (PreparedStatement psUpdate = conn.prepareStatement(updateMedicalRecordQuery)) {
            // Cập nhật hồ sơ y tế
            psUpdate.setString(1, diagnosis);
            psUpdate.setString(2, treatment);
            psUpdate.setDate(3, reExamDate);
            psUpdate.setString(4, medicalRecordId);
            int affectedRows = psUpdate.executeUpdate();
            if (affectedRows == 0) {
                throw new Exception("Updating medical record failed, no rows affected.");
            }
        }

        // Xóa kê đơn thuốc cũ (nếu có)
        try (PreparedStatement psDelete = conn.prepareStatement(deletePrescribedMedicinesQuery)) {
            psDelete.setString(1, medicalRecordId);
            psDelete.executeUpdate();
        }

        // Thêm kê đơn thuốc mới
        try (PreparedStatement psInsertMedicine = conn.prepareStatement(insertPrescribedMedicinesQuery)) {
            for (PrescribedMedicine pm : prescribedList) {
                psInsertMedicine.setString(1, medicalRecordId);
                psInsertMedicine.setString(2, pm.getMedicineId());
                psInsertMedicine.setInt(3, pm.getQuantity());
                psInsertMedicine.setString(4, pm.getDosage());
                psInsertMedicine.setString(5, pm.getDuration());
                psInsertMedicine.setString(6, pm.getUsageInstructions());
                psInsertMedicine.addBatch();
            }
            psInsertMedicine.executeBatch();
        }

        // Thêm file đính kèm mới (nếu có)
        try (PreparedStatement psInsertFile = conn.prepareStatement(insertMedicalRecordFileQuery)) {
            for (MedicalRecordFile file : files) {
                psInsertFile.setString(1, medicalRecordId);
                psInsertFile.setString(2, file.getFileName());
                psInsertFile.setString(3, file.getFileUrl());
                psInsertFile.addBatch();
            }
            psInsertFile.executeBatch();
        }

        // Commit transaction if all operations were successful
        conn.commit();
        result = true;

    } catch (Exception e) {
        // Rollback in case of any errors
        try (Connection conn = DBContext.getConnection()) {
            conn.rollback();
        } catch (Exception rollbackEx) {
            rollbackEx.printStackTrace();
        }
        e.printStackTrace();
    }

    return result;
}

public boolean updateMedicalRecordWithFiles(String medicalRecordId, String diagnosis, String treatment, java.sql.Date reExamDate, 
        List<PrescribedMedicine> prescribedList, List<MedicalRecordFile> files, List<String> removeFiles) {
    boolean result = false;

    // Sử dụng try-with-resources để tự động đóng các tài nguyên
    String updateRecordQuery = "UPDATE medical_records SET diagnosis = ?, treatment = ?, re_exam_date = ? WHERE id = ?";
    String deleteMedicineQuery = "DELETE FROM prescribed_medicines WHERE medical_record_id = ?";
    String insertMedicineQuery = "INSERT INTO prescribed_medicines (medical_record_id, medicine_id, quantity, dosage, duration, usage_instructions) VALUES (?, ?, ?, ?, ?, ?)";
    String deleteFileQuery = "DELETE FROM medical_record_files WHERE id = ?";
    String insertFileQuery = "INSERT INTO medical_record_files (medical_record_id, file_name, file_url, uploaded_at) VALUES (?, ?, ?, ?)";

    try (
        Connection conn = DBContext.getConnection();
        PreparedStatement psUpdateRecord = conn.prepareStatement(updateRecordQuery);
        PreparedStatement psDeleteMedicine = conn.prepareStatement(deleteMedicineQuery);
        PreparedStatement psInsertMedicine = conn.prepareStatement(insertMedicineQuery);
        PreparedStatement psDeleteFile = conn.prepareStatement(deleteFileQuery);
        PreparedStatement psInsertFile = conn.prepareStatement(insertFileQuery)
    ) {
        conn.setAutoCommit(false);  // Bắt đầu transaction

        // 1. Cập nhật thông tin hồ sơ y tế
        psUpdateRecord.setString(1, diagnosis);
        psUpdateRecord.setString(2, treatment);
        psUpdateRecord.setDate(3, reExamDate);
        psUpdateRecord.setString(4, medicalRecordId);
        psUpdateRecord.executeUpdate();

        // 2. Xóa thuốc cũ
        psDeleteMedicine.setString(1, medicalRecordId);
        psDeleteMedicine.executeUpdate();

        // 3. Thêm thuốc mới
        for (PrescribedMedicine pm : prescribedList) {
            psInsertMedicine.setString(1, medicalRecordId);
            psInsertMedicine.setString(2, pm.getMedicineId());
            psInsertMedicine.setInt(3, pm.getQuantity());
            psInsertMedicine.setString(4, pm.getDosage());
            psInsertMedicine.setString(5, pm.getDuration());
            psInsertMedicine.setString(6, pm.getUsageInstructions());
            psInsertMedicine.addBatch();
        }
        psInsertMedicine.executeBatch();  // Thực thi tất cả các câu lệnh insert thuốc

        // 4. Xóa file nếu có (xóa file cũ đã chọn để xóa)
        if (removeFiles != null && !removeFiles.isEmpty()) {
            for (String fileId : removeFiles) {
                psDeleteFile.setString(1, fileId);
                psDeleteFile.executeUpdate();
            }
        }

        // 5. Thêm file mới
        for (MedicalRecordFile file : files) {
            psInsertFile.setString(1, medicalRecordId);
            psInsertFile.setString(2, file.getFileName());
            psInsertFile.setString(3, file.getFileUrl());
            psInsertFile.setTimestamp(4, new java.sql.Timestamp(file.getUploadedAt().getTime()));
            psInsertFile.addBatch();
        }
        psInsertFile.executeBatch();  // Thực thi tất cả các câu lệnh insert file mới

        conn.commit();  // Commit transaction
        result = true;
    } catch (Exception e) {
        e.printStackTrace();
        // Nếu có lỗi, rollback transaction
        try (Connection conn = DBContext.getConnection()) {
            if (conn != null) conn.rollback();
        } catch (Exception rollbackEx) {
            rollbackEx.printStackTrace();
        }
    }

    return result;
}

}


