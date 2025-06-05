/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Doctor;
import Model.User;
import DAO.DBContext;
import Model.ClinicInfo;
import Model.Role;
import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Scanner;
import java.util.UUID;

/**
 *
 * @author FPT
 */
public class AdminDao {
    
    public boolean createAccount(User user, Doctor doctor) {
        try (Connection conn = DBContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                     "INSERT INTO users (id, username, email, password, full_name, phone, address, avatar, status, role_id, created_at, updated_at) " +
                     "VALUES (NEWID(), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")) {
            stmt.setString(1, user.getUserName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword()); // Nên mã hóa password
            stmt.setString(4, user.getFullName());
            stmt.setString(5, user.getPhoneNumber());
            stmt.setString(6, user.getAddress());
            stmt.setString(7, user.getAvatar());
            stmt.setInt(8, user.getStatus());
            stmt.setInt(9, user.getRole().getId());
            stmt.setTimestamp(10, new java.sql.Timestamp(user.getCreateDate().getTime()));
            stmt.setTimestamp(11, new java.sql.Timestamp(user.getUpdateDate().getTime()));
            stmt.executeUpdate();

            if (user.getRole().getId() == 3 && doctor != null) {
                try (PreparedStatement doctorStmt = conn.prepareStatement(
                        "INSERT INTO doctors (user_id, specialty, certificates, qualifications, years_of_experience, biography) " +
                        "VALUES ((SELECT id FROM users WHERE username = ?), ?, ?, ?, ?, ?)")) {
                    doctorStmt.setString(1, user.getUserName());
                    doctorStmt.setString(2, doctor.getSpecialty());
                    doctorStmt.setString(3, doctor.getCertificates());
                    doctorStmt.setString(4, doctor.getQualifications());
                    doctorStmt.setInt(5, doctor.getYearsOfExperience());
                    doctorStmt.setString(6, doctor.getBiography());
                  
                    doctorStmt.executeUpdate();
                }
            }
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    
//    public List<User> getAllAccounts() {
//        List<User> users = new ArrayList<>();
//        try (Connection conn = DBContext.getConnection();
//             PreparedStatement stmt = conn.prepareStatement(
//                     "SELECT u.id, u.username, u.email, u.full_name, u.phone, u.address, u.avatar, u.role_id, u.created_at, u.updated_at, r.name " +
//                     "FROM users u JOIN roles r ON u.role_id = r.id WHERE u.role_id IN (1,2,3,4)")) {
//            ResultSet rs = stmt.executeQuery();
//            while (rs.next()) {
//                User user = new User();
//                user.setId(rs.getString("id"));
//                user.setUserName(rs.getString("username"));
//                user.setEmail(rs.getString("email"));
//                user.setFullName(rs.getString("full_name"));
//                user.setPhoneNumber(rs.getString("phone"));
//                user.setAddress(rs.getString("address"));
//                user.setAvatar(rs.getString("avatar"));
//                Role role = new Role();
//                role.setId(rs.getInt("role_id"));
//                role.setName(rs.getString("name"));
//                user.setRole(role);
//                user.setCreateDate(rs.getTimestamp("created_at"));
//                user.setUpdateDate(rs.getTimestamp("updated_at"));
//                users.add(user);
//            }
//        } catch (SQLException | ClassNotFoundException e) {
//            e.printStackTrace();
//        }
//        return users;
//    }
    
    
    public List<User> getAllAccounts() {
        List<User> users = new ArrayList<>();
        try (Connection conn = DBContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                     "SELECT u.id, u.username, u.email, u.full_name, u.phone, u.address, u.avatar, u.status, u.role_id, u.created_at, u.updated_at, r.name " +
                     "FROM users u JOIN roles r ON u.role_id = r.id WHERE u.role_id IN (1,2,3,4)")) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getString("id"));
                user.setUserName(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setFullName(rs.getString("full_name"));
                user.setPhoneNumber(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setAvatar(rs.getString("avatar"));
                user.setStatus(rs.getInt("status")); // Lấy status
                Role role = new Role();
                role.setId(rs.getInt("role_id"));
                role.setName(rs.getString("name"));
                user.setRole(role);
                user.setCreateDate(rs.getTimestamp("created_at"));
                user.setUpdateDate(rs.getTimestamp("updated_at"));
                users.add(user);
            }
        } catch (SQLException e) {
            System.err.println("Error in getAllAccounts: " + e.getMessage());
        }
        return users;
    }
    
    public User getUserById(String id) {
        try (Connection conn = DBContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                     "SELECT u.id, u.username, u.email, u.full_name, u.phone, u.address, u.avatar, u.role_id, u.created_at, u.updated_at, r.name " +
                     "FROM users u JOIN roles r ON u.role_id = r.id WHERE u.id = ?")) {
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getString("id"));
                user.setUserName(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setFullName(rs.getString("full_name"));
                user.setPhoneNumber(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setAvatar(rs.getString("avatar"));
                Role role = new Role();
                role.setId(rs.getInt("role_id"));
                role.setName(rs.getString("name"));
                user.setRole(role);
                user.setCreateDate(rs.getTimestamp("created_at"));
                user.setUpdateDate(rs.getTimestamp("updated_at"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Doctor getDoctorByUserId(String userId) {
        try (Connection conn = DBContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                     "SELECT user_id, specialty, certificates, qualifications, years_of_experience, biography " +
                     "FROM doctors WHERE user_id = ?")) {
            stmt.setString(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Doctor doctor = new Doctor();
                User user = new User();
                user.setId(rs.getString("user_id"));
                doctor.setUser(user);
                doctor.setSpecialty(rs.getString("specialty"));
                doctor.setCertificates(rs.getString("certificates"));
                doctor.setQualifications(rs.getString("qualifications"));
                doctor.setYearsOfExperience(rs.getInt("years_of_experience"));
                doctor.setBiography(rs.getString("biography"));
                
                return doctor;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateAccount(User user, Doctor doctor) {
        try (Connection conn = DBContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                     "UPDATE users SET username = ?, email = ?, full_name = ?, phone = ?, address = ?, avatar = ?, updated_at = ? " +
                     "WHERE id = ?")) {
            stmt.setString(1, user.getUserName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getFullName());
            stmt.setString(4, user.getPhoneNumber());
            stmt.setString(5, user.getAddress());
            stmt.setString(6, user.getAvatar());
            stmt.setTimestamp(7, new java.sql.Timestamp(new Date().getTime()));
            stmt.setString(8, user.getId());
            stmt.executeUpdate();

            if (doctor != null) {
                try (PreparedStatement doctorStmt = conn.prepareStatement(
                        "UPDATE doctors SET specialty = ?, certificates = ?, qualifications = ?, years_of_experience = ?, biography = ? " +
                        "WHERE user_id = ?")) {
                    doctorStmt.setString(1, doctor.getSpecialty());
                    doctorStmt.setString(2, doctor.getCertificates());
                    doctorStmt.setString(3, doctor.getQualifications());
                    doctorStmt.setInt(4, doctor.getYearsOfExperience());
                    doctorStmt.setString(5, doctor.getBiography());
                   
                    doctorStmt.setString(6, doctor.getUser().getId());
                    doctorStmt.executeUpdate();
                }
            } else {
                try (PreparedStatement deleteStmt = conn.prepareStatement(
                        "DELETE FROM doctors WHERE user_id = ?")) {
                    deleteStmt.setString(1, user.getId());
                    deleteStmt.executeUpdate();
                }
            }
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteAccount(String id) {
        try (Connection conn = DBContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement("DELETE FROM users WHERE id = ?")) {
            stmt.setString(1, id);
            stmt.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean isUsernameTaken(String username) {
        try (Connection conn = DBContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT 1 FROM users WHERE username = ?")) {
            stmt.setString(1, username);
            return stmt.executeQuery().next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean isEmailTaken(String email) {
        try (Connection conn = DBContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT 1 FROM users WHERE email = ?")) {
            stmt.setString(1, email);
            return stmt.executeQuery().next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean updateStatus(String id, int status) {    
    try {
        Connection conn = DBContext.getConnection(); // Kết nối database
        PreparedStatement stmt = conn.prepareStatement("UPDATE users SET status = ? WHERE id = ?");
        stmt.setInt(1, status); // Gán status (0 hoặc 1)
        stmt.setString(2, id);  // Gán id
        int rows = stmt.executeUpdate(); // Thực thi
        return rows > 0; // Thành công nếu cập nhật được
    } catch (SQLException e ) {
        return false; // Lỗi thì trả false
    }
}
    
    public List<User> searchAccountsByFullName(String search) throws SQLException, ClassNotFoundException {
        List<User> users = new ArrayList<>();
        String sql = "SELECT u.id, u.username, u.full_name, u.status, r.name " +
                     "FROM users u JOIN roles r ON u.role_id = r.id " +
                     "WHERE u.full_name LIKE ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, "%" + search + "%");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getString("id"));
                user.setUserName(rs.getString("username"));
                user.setFullName(rs.getString("full_name"));
                user.setStatus(rs.getInt("status"));
                Role role = new Role();
                role.setName(rs.getString("name"));
                user.setRole(role);
                users.add(user);
            }
        }
        return users;
    }
    public List<ClinicInfo> getAllClinicInfo() throws SQLException, ClassNotFoundException {
        List<ClinicInfo> clinics = new ArrayList<>();
        String sql = "SELECT id, name, address, phone, email, website, working_hours, description, logo, googlemap, created_at, updated_at " +
                     "FROM clinic_info";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                ClinicInfo clinic = new ClinicInfo();
                clinic.setId(rs.getString("id"));
                clinic.setName(rs.getString("name"));
                clinic.setAddress(rs.getString("address"));
                clinic.setPhone(rs.getString("phone"));
                clinic.setEmail(rs.getString("email"));
                clinic.setWebsite(rs.getString("website"));
                clinic.setWorkingHours(rs.getString("working_hours"));
                clinic.setDescription(rs.getString("description"));
                clinic.setLogo(rs.getString("logo"));
                clinic.setGoogleMap(rs.getString("googlemap"));
                clinic.setCreatedAt(rs.getTimestamp("created_at"));
                clinic.setUpdatedAt(rs.getTimestamp("updated_at"));
                clinics.add(clinic);
            }
        }
        return clinics;
    }
    //Lấy id của thông tin phòng khám 
    public ClinicInfo getClinicInfoById(String id) throws SQLException, ClassNotFoundException {
        String sql = "SELECT id, name, address, phone, email, website, working_hours, description, logo, googlemap, created_at, updated_at " +
                     "FROM clinic_info WHERE id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                ClinicInfo clinic = new ClinicInfo();
                clinic.setId(rs.getString("id"));
                clinic.setName(rs.getString("name"));
                clinic.setAddress(rs.getString("address"));
                clinic.setPhone(rs.getString("phone"));
                clinic.setEmail(rs.getString("email"));
                clinic.setWebsite(rs.getString("website"));
                clinic.setWorkingHours(rs.getString("working_hours"));
                clinic.setDescription(rs.getString("description"));
                clinic.setLogo(rs.getString("logo"));
                clinic.setGoogleMap(rs.getString("googlemap"));
                clinic.setCreatedAt(rs.getTimestamp("created_at"));
                clinic.setUpdatedAt(rs.getTimestamp("updated_at"));
                return clinic;
            }
        }
        return null;
    }
    
    public boolean updateClinicInfo(ClinicInfo clinic) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE clinic_info SET name = ?, address = ?, phone = ?, email = ?, website = ?, working_hours = ?, " +
                     "description = ?, logo = ?, googlemap = ?, updated_at = GETDATE() WHERE id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, clinic.getName());
            stmt.setString(2, clinic.getAddress());
            stmt.setString(3, clinic.getPhone());
            stmt.setString(4, clinic.getEmail());
            stmt.setString(5, clinic.getWebsite());
            stmt.setString(6, clinic.getWorkingHours());
            stmt.setString(7, clinic.getDescription());
            stmt.setString(8, clinic.getLogo());
            stmt.setString(9, clinic.getGoogleMap());
            stmt.setString(10, clinic.getId());
            int rows = stmt.executeUpdate();
            return rows > 0;
        }
    }
    
   
    
    
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Nhập ID phòng khám cần tìm: ");
        String clinicId = scanner.nextLine();

        try {
            AdminDao dao = new AdminDao(); // Đảm bảo class DAO này chứa phương thức getClinicInfoById
            ClinicInfo clinic = dao.getClinicInfoById(clinicId);

            if (clinic != null) {
                System.out.println("=== Thông tin phòng khám ===");
                System.out.println("ID: " + clinic.getId());
                System.out.println("Tên: " + clinic.getName());
                System.out.println("Địa chỉ: " + clinic.getAddress());
                System.out.println("SĐT: " + clinic.getPhone());
                System.out.println("Email: " + clinic.getEmail());
                System.out.println("Website: " + clinic.getWebsite());
                System.out.println("Giờ làm việc: " + clinic.getWorkingHours());
                System.out.println("Mô tả: " + clinic.getDescription());
                System.out.println("Logo: " + clinic.getLogo());
                System.out.println("Google Map: " + clinic.getGoogleMap());
                System.out.println("Tạo lúc: " + clinic.getCreatedAt());
                System.out.println("Cập nhật lúc: " + clinic.getUpdatedAt());
            } else {
                System.out.println("Không tìm thấy phòng khám với ID: " + clinicId);
            }

        } catch (Exception e) {
            System.err.println("Đã xảy ra lỗi: " + e.getMessage());
            e.printStackTrace();
        } finally {
            scanner.close();
        }
    }
        
    

        
        
      
       
    
    
}

