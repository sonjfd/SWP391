/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Doctor;
import Model.Role;
import Model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.List;

/**
 *
 * @author ASUS
 */
public class DoctorDAO {

    public boolean updateDoctor(String userId, String specialty, String certificates, String qualifications, int yearsOfExperience, String biography) {
        // Câu lệnh SQL để cập nhật thông tin bác sĩ
        String sql = "UPDATE doctors SET specialty=?, certificates=?, qualifications=?, years_of_experience=?, biography=? WHERE user_id=?";

        try {
            // Kết nối đến cơ sở dữ liệu
            Connection conn = DAO.DBContext.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);

            // Gán giá trị cho các tham số trong câu SQL
            stmt.setString(1, specialty);
            stmt.setString(2, certificates);
            stmt.setString(3, qualifications);
            stmt.setInt(4, yearsOfExperience);
            stmt.setString(5, biography);
            stmt.setString(6, userId);  // Lưu ý: `user_id` là khóa ngoại tham chiếu tới bảng `users`

            // Thực thi câu lệnh cập nhật
            int check = stmt.executeUpdate();
            if (check > 0) {
                return true; // Nếu cập nhật thành công
            }

        } catch (Exception e) {
            e.printStackTrace(); // In ra lỗi nếu có
        }
        return false; // Nếu không thành công
    }

    // Lấy thông tin bác sĩ từ cơ sở dữ liệu theo doctor_id
    public Doctor getDoctorById(String doctorId) {
        Doctor doctor = null;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBContext.getConnection();
            // Truy vấn lấy thông tin bác sĩ từ bảng doctors
            String sql = "SELECT user_id, specialty, certificates, qualifications, years_of_experience, biography "
                    + "FROM doctors WHERE user_id = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, doctorId);  // Truyền vào user_id để lấy thông tin bác sĩ
            rs = ps.executeQuery();

            // Kiểm tra nếu có kết quả trả về
            if (rs.next()) {
                // Tạo đối tượng Doctor
                doctor = new Doctor();
                doctor.setSpecialty(rs.getString("specialty"));
                doctor.setCertificates(rs.getString("certificates"));
                doctor.setQualifications(rs.getString("qualifications"));
                doctor.setYearsOfExperience(rs.getInt("years_of_experience"));
                doctor.setBiography(rs.getString("biography"));
                

                // Lấy thông tin người dùng từ bảng users
                UserDAO udao = new UserDAO();
                User user = udao.getUserById(rs.getString("user_id")); // Lấy thông tin người dùng
                doctor.setUser(user);  // Gán đối tượng User vào Doctor
            }
        } catch (SQLException e) {
            // In thông báo lỗi ra console khi có ngoại lệ
            e.printStackTrace();
        }
        return doctor;
    }

    // Lấy tất cả bác sĩ từ cơ sở dữ liệu
    public List<Doctor> getAllDoctors() {
        List<Doctor> doctorList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBContext.getConnection();
            // Truy vấn lấy tất cả bác sĩ từ bảng doctors
            String sql = "SELECT user_id, specialty, certificates, qualifications, years_of_experience, biography "
                    + "FROM doctors";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            // Lặp qua kết quả và tạo đối tượng Doctor cho mỗi bản ghi
            while (rs.next()) {
                Doctor doctor = new Doctor();
                doctor.setSpecialty(rs.getString("specialty"));
                doctor.setCertificates(rs.getString("certificates"));
                doctor.setQualifications(rs.getString("qualifications"));
                doctor.setYearsOfExperience(rs.getInt("years_of_experience"));
                doctor.setBiography(rs.getString("biography"));
               

                // Lấy thông tin người dùng từ bảng users
                User user = new UserDAO().getUserById(rs.getString("user_id")); // Lấy thông tin người dùng
                doctor.setUser(user);  // Gán thông tin người dùng vào bác sĩ

                // Thêm bác sĩ vào danh sách
                doctorList.add(doctor);
            }
        } catch (SQLException e) {
            // In thông báo lỗi ra console khi có ngoại lệ
            e.printStackTrace();
        } finally {
            // Đảm bảo đóng tất cả tài nguyên
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return doctorList;
    }

    public List<Doctor> getDoctorsByDate(Date date) {
        List<Doctor> doctors = new ArrayList<>();
        String sql = "SELECT DISTINCT u.id AS doctor_id, u.full_name\n"
                + "FROM doctor_schedule ds\n"
                + "JOIN doctors d ON ds.doctor_id = d.user_id\n"
                + "JOIN users u ON d.user_id = u.id\n"
                + "WHERE ds.work_date = ? AND ds.is_available = 1\n"
                + "ORDER BY u.full_name";

        try (Connection conn = DBContext.getConnection(); PreparedStatement stm = conn.prepareStatement(sql)) {

               java.sql.Date sqlDate = new java.sql.Date(date.getTime());
        stm.setDate(1, sqlDate);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                User user = new User();
                user.setId(rs.getString("doctor_id"));
                user.setFullName(rs.getString("full_name"));

                Doctor doctor = new Doctor();
                doctor.setUser(user);

                doctors.add(doctor);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return doctors;
    }

    
}
