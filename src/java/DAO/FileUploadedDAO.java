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

        String sql = "SELECT uf.id, uf.result_id, uf.file_url, uf.uploaded_at,u.file_name " +
                     "nsr.id as nsr_id, nsr.appointment_id, nsr.service_id, nsr.nurse_id, nsr.created_at " +
                     "FROM uploaded_files uf " +
                     "JOIN nurse_specialization_results nsr ON uf.result_id = nsr.id " +
                     "WHERE nsr.appointment_id = ? AND nsr.service_id = ?";

        try (
            Connection conn = DBContext.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
        ) {
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
}
