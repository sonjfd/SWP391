/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Medicine;
import Model.PrescribedMedicine;
import java.util.ArrayList;
import java.util.List;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.stream.Collectors;

/**
 *
 * @author ASUS
 */
public class MedicalRecordMedicineDAO {

    public List<PrescribedMedicine> getMedicinesByMedicalRecordId(String medicalRecordId) {
        List<PrescribedMedicine> list = new ArrayList<>();
        String sql = "SELECT pm.medicine_id, m.name AS medicine_name, pm.quantity, pm.dosage, pm.duration, pm.usage_instructions "
                + "FROM prescribed_medicines pm "
                + "JOIN medicines m ON pm.medicine_id = m.id "
                + "WHERE pm.medical_record_id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, medicalRecordId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Medicine medicine = new Medicine();
                medicine.setName(rs.getString("medicine_name"));
                medicine.setId(rs.getString("medicine_id"));
                PrescribedMedicine preMedicine = new PrescribedMedicine(medicalRecordId,
                        medicine,
                        rs.getInt("quantity"), // Lấy số lượng thuốc
                        rs.getString("dosage"),
                        rs.getString("duration"),
                        rs.getString("usage_instructions")
                );
                list.add(preMedicine);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public boolean deleteMedicine(String medicalRecordId, String medicineId) {
        String sql = "DELETE FROM prescribed_medicines WHERE medical_record_id = ? AND medicine_id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, medicalRecordId);
            ps.setString(2, medicineId);
            return ps.executeUpdate() > 0;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }

    public boolean addPrescribedMedicine(String medicalRecordId, String medicineId, int quantity, String dosage, String duration, String usageInstructions) {
        String sql = "INSERT INTO prescribed_medicines (medical_record_id, medicine_id, quantity, dosage, duration, usage_instructions) "
                + "VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, medicalRecordId);
            ps.setString(2, medicineId);
            ps.setInt(3, quantity);
            ps.setString(4, dosage);
            ps.setString(5, duration);
            ps.setString(6, usageInstructions);
            return ps.executeUpdate() > 0;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }

    public List<PrescribedMedicine> getMedicinesByMedicalRecordIds(List<String> ids) {
        if (ids == null || ids.isEmpty()) {
            return new ArrayList<>();
        }
        String inSql = ids.stream().map(s -> "?").collect(Collectors.joining(","));
        String sql = "SELECT pm.medical_record_id, m.id AS medicine_id, m.name AS medicine_name, pm.quantity, pm.dosage, pm.duration, pm.usage_instructions "
                + "FROM prescribed_medicines pm "
                + "JOIN medicines m ON pm.medicine_id = m.id "
                + "WHERE pm.medical_record_id IN (" + inSql + ")";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            for (int i = 0; i < ids.size(); i++) {
                ps.setString(i + 1, ids.get(i));
            }
            ResultSet rs = ps.executeQuery();
            List<PrescribedMedicine> list = new ArrayList<>();
            while (rs.next()) {
                Medicine medicine = new Medicine();
                medicine.setName(rs.getString("medicine_name"));
                medicine.setId(rs.getString("medicine_id"));
                PrescribedMedicine preMedicine = new PrescribedMedicine(
                        rs.getString("medical_record_id"),
                        medicine,
                        rs.getInt("quantity"),
                        rs.getString("dosage"),
                        rs.getString("duration"),
                        rs.getString("usage_instructions")
                );
                list.add(preMedicine);
            }
            return list;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ArrayList<>();
    }

    // Lấy tất cả các thuốc có sẵn
    public List<Medicine> getAllAvailableMedicine() {
        List<Medicine> l = new ArrayList<>();
        String sql = """
                     SELECT id,name,description,price,status
                     FROM medicines
                     WHERE status = 1
                     """;
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {

                l.add(new Medicine(rs.getString("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("status")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return l;
    }

    public boolean updatePrescribedMedicine(String oldMedicineId, String medicalRecordId, String newMedicineId, int quantity, String dosage, String duration, String usageInstructions) {
        String sql = "UPDATE prescribed_medicines SET medicine_id = ?, quantity = ?, dosage = ?, duration = ?, usage_instructions = ? "
                + "WHERE medical_record_id = ? AND medicine_id = ?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newMedicineId);
            ps.setInt(2, quantity);
            ps.setString(3, dosage);
            ps.setString(4, duration);
            ps.setString(5, usageInstructions);
            ps.setString(6, medicalRecordId);
            ps.setString(7, oldMedicineId);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }

    public PrescribedMedicine getPrescribedMedicineById(String medicineId, String medicalRecordId) {
    PrescribedMedicine prescribedMedicine = null;
    String sql = "SELECT pm.medicine_id, m.name AS medicine_name, pm.quantity, pm.dosage, pm.duration, pm.usage_instructions "
               + "FROM prescribed_medicines pm "
               + "JOIN medicines m ON pm.medicine_id = m.id "
               + "WHERE pm.medical_record_id = ? AND pm.medicine_id = ?";
    
    try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, medicalRecordId);
        ps.setString(2, medicineId);

        ResultSet rs = ps.executeQuery();
        
        if (rs.next()) {
            Medicine medicine = new Medicine();
            medicine.setId(rs.getString("medicine_id"));
            medicine.setName(rs.getString("medicine_name"));
            
            prescribedMedicine = new PrescribedMedicine(
                medicalRecordId,
                medicine,
                rs.getInt("quantity"),
                rs.getString("dosage"),
                rs.getString("duration"),
                rs.getString("usage_instructions")
            );
        }
    } catch (Exception ex) {
        ex.printStackTrace();
    }
    
    return prescribedMedicine;
}

}
