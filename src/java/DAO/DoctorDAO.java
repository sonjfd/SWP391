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
// CỦA ĐẠI

    public boolean updateDoctor(String userId, String specialty, String certificates, String qualifications, int yearsOfExperience, String biography) {
        // Câu lệnh SQL để cập nhật thông tin bác sĩ
        String sql = "UPDATE doctors SET specialty=?, certificates=?, qualifications=?, years_of_experience=?, biography=? WHERE user_id=?";

        try (Connection conn = DAO.DBContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            // Gán giá trị cho các tham số trong câu SQL
            stmt.setString(1, specialty);
            stmt.setString(2, certificates);
            stmt.setString(3, qualifications);
            stmt.setInt(4, yearsOfExperience);
            stmt.setString(5, biography);
            stmt.setString(6, userId);

            // Thực thi câu lệnh cập nhật
            int check = stmt.executeUpdate();
            return check > 0; // Trả về true nếu có ít nhất một hàng được cập nhật
        } catch (Exception e) {
            e.printStackTrace(); // In ra lỗi nếu có
            return false; // Nếu không thành công
        }
    }

    // Lấy thông tin bác sĩ từ cơ sở dữ liệu theo doctor_id
    public Doctor getDoctorById(User user, String doctorId) {
        Doctor doctor = null;
        // Truy vấn lấy thông tin bác sĩ từ bảng doctors
        String sql = "SELECT user_id, specialty, certificates, qualifications, years_of_experience, biography "
                + "FROM doctors WHERE user_id = ?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, doctorId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    doctor = new Doctor();
                    doctor.setSpecialty(rs.getString("specialty"));
                    doctor.setCertificates(rs.getString("certificates"));
                    doctor.setQualifications(rs.getString("qualifications"));
                    doctor.setYearsOfExperience(rs.getInt("years_of_experience"));
                    doctor.setBiography(rs.getString("biography"));
                    doctor.setUser(user);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return doctor;
    }

    // Lấy tất cả bác sĩ từ cơ sở dữ liệu
    public List<Doctor> getAllDoctors() {
        List<Doctor> doctorList = new ArrayList<>();
        // Truy vấn tối ưu bằng JOIN để lấy thông tin cả bác sĩ và người dùng
        String sql = "SELECT d.user_id AS doctor_user_id, d.specialty, d.certificates, d.qualifications, d.years_of_experience, d.biography, u.id AS user_id, u.username, u.email, u.password, u.full_name, u.phone, u.address, u.avatar, u.status, u.role_id FROM doctors d JOIN users u ON d.user_id = u.id";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Doctor doctor = new Doctor();
                doctor.setSpecialty(rs.getString("specialty"));
                doctor.setCertificates(rs.getString("certificates"));
                doctor.setQualifications(rs.getString("qualifications"));
                doctor.setYearsOfExperience(rs.getInt("years_of_experience"));
                doctor.setBiography(rs.getString("biography"));

                // Tạo role
                Role role = new Role();
                role.setId(rs.getInt("role_id"));
                // Cần lấy tên role từ database, không phải từ biến sql
                // Giả sử tên cột là 'role_name' hoặc tương tự trong bảng roles (nếu bạn có)
                // Nếu không, bạn cần một truy vấn riêng để lấy tên role dựa trên role_id
                // Ví dụ: role.setName(rs.getString("role_name")); // Nếu cột role_name có trong SELECT

                // Tạo đối tượng User và gán thông tin từ ResultSet
                User user = new User();
                // Lấy user_id từ alias đã đặt trong SQL: "user_id"
                user.setId(rs.getString("user_id"));
                user.setUserName(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setFullName(rs.getString("full_name"));
                user.setPhoneNumber(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setAvatar(rs.getString("avatar"));
                user.setStatus(rs.getInt("status"));
                user.setRole(role);

                doctor.setUser(user);
                doctorList.add(doctor);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return doctorList;
    }
// HẾT CỦA ĐẠI

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

    // Lấy thông tin bác sĩ từ cơ sở dữ liệu theo doctor_id
    public Doctor getDoctorById(String doctorId) {
        Doctor doctor = null;
        // Truy vấn lấy thông tin bác sĩ từ bảng doctors
        String sql = "SELECT user_id, specialty, certificates, qualifications, years_of_experience, biography "
                + "FROM doctors WHERE user_id = ?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, doctorId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    doctor = new Doctor();
                    doctor.setSpecialty(rs.getString("specialty"));
                    doctor.setCertificates(rs.getString("certificates"));
                    doctor.setQualifications(rs.getString("qualifications"));
                    doctor.setYearsOfExperience(rs.getInt("years_of_experience"));
                    doctor.setBiography(rs.getString("biography"));
                    User user = new UserDAO().getUserById(doctorId);
                    doctor.setUser(user);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return doctor;
    }

    public List<Doctor> getDoctorLimit(int limit) {
        List<Doctor> doctorList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBContext.getConnection();
            // Truy vấn lấy tất cả bác sĩ từ bảng doctors
            String sql = "SELECT user_id, specialty, certificates, qualifications, years_of_experience, biography "
                    + "FROM doctors order by years_of_experience desc";
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

    public static void main(String[] args) {
        List<Doctor> l = new DoctorDAO().getAllDoctors();
        System.out.println(l.size());
    }
}
