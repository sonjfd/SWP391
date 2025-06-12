package DAO;

import Model.MedicalRecordFile;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class MedicalRecordFileDAO {

    // Thêm file mới cho hồ sơ
    public boolean addFile(String medicalRecordId, String fileName, String fileUrl) {
        String sql = "INSERT INTO medical_record_files (medical_record_id, file_name, file_url, uploaded_at) VALUES (?, ?, ?, GETDATE())";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, medicalRecordId);
            ps.setString(2, fileName);
            ps.setString(3, fileUrl);
            return ps.executeUpdate() > 0;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }

    // Lấy danh sách file của 1 hồ sơ
    public List<MedicalRecordFile> getFilesByMedicalRecordId(String medicalRecordId) {
        List<MedicalRecordFile> list = new ArrayList<>();
        String sql = "SELECT * FROM medical_record_files WHERE medical_record_id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, medicalRecordId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                MedicalRecordFile file = new MedicalRecordFile(
                        rs.getString("id"),
                        rs.getString("medical_record_id"),
                        rs.getString("file_name"),
                        rs.getString("file_url"),
                        rs.getTimestamp("uploaded_at")
                );
                list.add(file);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }

    // Xóa file (nếu cần)
    public boolean deleteFile(String fileId) {
        String sql = "DELETE FROM medical_record_files WHERE id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, fileId);
            return ps.executeUpdate() > 0;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }

    public List<MedicalRecordFile> getFilesByMedicalRecordIds(List<String> ids) {
        if (ids == null || ids.isEmpty()) {
            return new ArrayList<>();
        }
        String inSql = ids.stream().map(s -> "?").collect(Collectors.joining(","));
        String sql = "SELECT * FROM medical_record_files WHERE medical_record_id IN (" + inSql + ")";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            for (int i = 0; i < ids.size(); i++) {
                ps.setString(i + 1, ids.get(i));
            }
            ResultSet rs = ps.executeQuery();
            List<MedicalRecordFile> list = new ArrayList<>();
            while (rs.next()) {
                list.add(new MedicalRecordFile(
                        rs.getString("id"),
                        rs.getString("medical_record_id"),
                        rs.getString("file_name"),
                        rs.getString("file_url"),
                        rs.getTimestamp("uploaded_at")
                ));
            }
            return list;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ArrayList<>();
    }

    public MedicalRecordFile getFileById(String fileId) {
        String sql = "SELECT * FROM MedicalRecordFiles WHERE id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, fileId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new MedicalRecordFile(
                        rs.getString("id"),
                        rs.getString("medical_record_id"),
                        rs.getString("file_name"),
                        rs.getString("file_url"),
                        rs.getDate("uploaded_at")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public String updateMedicalRecordFile(String originalFileName,String fileUrl,String fileId) {
        String message="";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(
                "UPDATE medical_record_files SET file_name = ?, file_url = ?, uploaded_at = GETDATE() WHERE id = ?")) {
            ps.setString(1, originalFileName);
            ps.setString(2, fileUrl);
            ps.setString(3, fileId);
            int updated = ps.executeUpdate();
            if (updated > 0) {
                message = "Cập nhật file thành công!";
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return message;
    }

}
