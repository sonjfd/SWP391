/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.NurseSpecializationResult;
import Model.UploadedFile;
import java.util.ArrayList;
import java.util.List;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author ASUS
 */
public class FileUploadedDAO {

    public List<UploadedFile> getFilesByAppointmentAndService(String appointmentId, String serviceId) {
        List<UploadedFile> files = new ArrayList<>();

        String sql = "SELECT uf.id, uf.result_id, uf.file_url, uf.uploaded_at,uf.file_name, "
                + "nsr.id as nsr_id, nsr.appointment_id, nsr.service_id, nsr.nurse_id, nsr.created_at "
                + "FROM uploaded_files uf "
                + "JOIN nurse_specialization_results nsr ON uf.result_id = nsr.id "
                + "WHERE nsr.appointment_id = ? AND nsr.service_id = ?";

        try (
                Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql);) {
            ps.setString(1, appointmentId);
            ps.setString(2, serviceId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    NurseSpecializationResult nurseResult = new NurseSpecializationResult();
                    nurseResult.setId(rs.getString("nsr_id"));

                    UploadedFile file = new UploadedFile();
                    file.setId(rs.getString("id"));
                    file.setNurseResult(nurseResult);
                    file.setFile_url(rs.getString("file_url"));
                    file.setUploaded_at(rs.getTimestamp("uploaded_at"));
                    file.setFile_name(rs.getString("file_name"));
                    files.add(file);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return files;
    }

    /// PHẦN NURSE
    public void insert(String resultId, String fileUrl, String fileName) {
        String id = java.util.UUID.randomUUID().toString();
        String sql = "INSERT INTO uploaded_files (id, result_id, file_url, file_name, uploaded_at) VALUES (?, ?, ?, ?, GETDATE())";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            ps.setString(2, resultId);
            ps.setString(3, fileUrl);
            ps.setString(4, fileName);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<UploadedFile> getByAppointmentAndServiceId(String appointmentId, String serviceId) {
        List<UploadedFile> list = new ArrayList<>();
        String sql = "SELECT uf.*, u.full_name "
                + "FROM uploaded_files uf "
                + "JOIN nurse_specialization_results nsr ON uf.result_id = nsr.id "
                + "JOIN users u ON nsr.nurse_id = u.id "
                + "WHERE nsr.appointment_id = ? AND nsr.service_id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, appointmentId);
            ps.setString(2, serviceId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                UploadedFile f = new UploadedFile();
                f.setId(rs.getString("id"));
                f.setFile_url(rs.getString("file_url"));
                f.setFile_name(rs.getString("file_name"));
                f.setUploaderName(rs.getString("full_name"));
                f.setUploaded_at(rs.getTimestamp("uploaded_at"));
                list.add(f);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean deleteById(String id) {
        String sql = "DELETE FROM uploaded_files WHERE id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

/// HẾT NURSE
}
