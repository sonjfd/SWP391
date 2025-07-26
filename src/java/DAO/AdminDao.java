/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Doctor;
import Model.User;
import DAO.DBContext;
import static GoogleLogin.PasswordUtils.hashPassword;
import Model.ClinicInfo;
import Model.Department;
import Model.Nurse;
import Model.Role;
import java.sql.Timestamp;
import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 *
 * @author FPT
 */
public class AdminDao {

    public boolean createAccount(User user, Nurse nurse, Integer departmentId) {
        try (Connection conn = DBContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(
                "INSERT INTO users (id, username, email, password, full_name, phone, address, status, role_id, created_at, updated_at) "
                + "VALUES (NEWID(), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")) {
            stmt.setString(1, user.getUserName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword()); // Nên mã hóa password
            stmt.setString(4, user.getFullName());
            stmt.setString(5, user.getPhoneNumber());
            stmt.setString(6, user.getAddress());
            
            stmt.setInt(7, user.getStatus());
            stmt.setInt(8, user.getRole().getId());
            stmt.setTimestamp(9, new java.sql.Timestamp(user.getCreateDate().getTime()));
            stmt.setTimestamp(10, new java.sql.Timestamp(user.getUpdateDate().getTime()));
            stmt.executeUpdate();

            if (user.getRole().getId() == 3 ) {
                try (PreparedStatement doctorStmt = conn.prepareStatement(
                        "INSERT INTO doctors (user_id) "
                        + "VALUES ((SELECT id FROM users WHERE username = ?))")) {
                    doctorStmt.setString(1, user.getUserName());
                    
                    doctorStmt.executeUpdate();
                }
            }
            if (user.getRole().getId() == 5 && nurse != null && departmentId != null) {
                try (PreparedStatement nurseStmt = conn.prepareStatement(
                        "INSERT INTO nurses (user_id, department_id) "
                        + "VALUES ((SELECT id FROM users WHERE username = ?), ?)")) {
                    nurseStmt.setString(1, user.getUserName());
                    nurseStmt.setInt(2, departmentId);
                    nurseStmt.executeUpdate();
                }
            }
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    

    public List<User> getAllAccounts() {
        List<User> users = new ArrayList<>();
        try (Connection conn = DBContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(
                "SELECT u.id, u.username, u.email, u.full_name, u.phone, u.address, u.avatar, u.status, u.role_id, u.created_at, u.updated_at, r.name "
                + "FROM users u JOIN roles r ON u.role_id = r.id WHERE u.role_id IN (1,3,4,5) order by created_at desc")) {
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
        try (Connection conn = DBContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(
                "SELECT u.id, u.username, u.email, u.full_name, u.phone, u.address, u.avatar, u.role_id, u.created_at, u.updated_at, r.name "
                + "FROM users u JOIN roles r ON u.role_id = r.id WHERE u.id = ?")) {
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
        try (Connection conn = DBContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(
                "SELECT user_id, specialty, certificates, qualifications, years_of_experience, biography "
                + "FROM doctors WHERE user_id = ?")) {
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
public List<Department> getAllDepartments() {
        List<Department> departments = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = DBContext.getConnection();
            String sql = "SELECT id, name FROM departments";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                Department dept = new Department();
                dept.setId(rs.getInt("id"));
                dept.setName(rs.getString("name"));
                departments.add(dept);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) {}
            try { if (stmt != null) stmt.close(); } catch (SQLException e) {}
            try { if (conn != null) conn.close(); } catch (SQLException e) {}
        }
        return departments;
    }

    public boolean updateAccount(User user, Integer departmentId) {
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            conn.setAutoCommit(false);

            // Cập nhật bảng users
            String userSql = "UPDATE users SET username = ?, email = ?, full_name = ?, phone = ?, role_id = ?, updated_at = ? WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(userSql);
            stmt.setString(1, user.getUserName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getFullName());
            stmt.setString(4, user.getPhoneNumber());
            stmt.setInt(5, user.getRole().getId());
            stmt.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
            stmt.setString(7, user.getId());
            stmt.executeUpdate();
            stmt.close();

            // Xóa dữ liệu y tá cũ nếu có
            String deleteNurseSql = "DELETE FROM nurses WHERE user_id = ?";
            PreparedStatement deleteNurseStmt = conn.prepareStatement(deleteNurseSql);
            deleteNurseStmt.setString(1, user.getId());
            deleteNurseStmt.executeUpdate();
            deleteNurseStmt.close();

            // Nếu là y tá và có departmentId -> thêm vào bảng nurses
            if (user.getRole().getId() == 5) {
                if (departmentId != null) {
                    String insertNurseSql = "INSERT INTO nurses (user_id, department_id) VALUES (?, ?)";
                    PreparedStatement nurseStmt = conn.prepareStatement(insertNurseSql);
                    nurseStmt.setString(1, user.getId());
                    nurseStmt.setInt(2, departmentId);
                    nurseStmt.executeUpdate();
                    nurseStmt.close();
                } else {
                    // Nếu là y tá mà thiếu departmentId thì coi là lỗi
                    throw new SQLException("Y tá phải có departmentId");
                }
            }

            conn.commit();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
           return false; 
        }
    }

    public boolean isUsernameTaken(String username) {
        try (Connection conn = DBContext.getConnection(); PreparedStatement stmt = conn.prepareStatement("SELECT 1 FROM users WHERE username = ?")) {
            stmt.setString(1, username);
            return stmt.executeQuery().next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean isEmailTaken(String email) {
        try (Connection conn = DBContext.getConnection(); PreparedStatement stmt = conn.prepareStatement("SELECT 1 FROM users WHERE email = ?")) {
            stmt.setString(1, email);
            return stmt.executeQuery().next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    
    public boolean updateStatus(String id, int status) {
    try {
        Connection conn = DBContext.getConnection();
        PreparedStatement stmt = conn.prepareStatement("UPDATE users SET status = ? WHERE id = ?");
        stmt.setInt(1, status);
        stmt.setString(2, id);
        int rows = stmt.executeUpdate();
        return rows > 0;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}


    public List<User> searchAccountsByFullName(String search) throws SQLException, ClassNotFoundException {
        List<User> users = new ArrayList<>();
        String sql = "SELECT u.id, u.username, u.full_name, u.status, r.name "
                + "FROM users u JOIN roles r ON u.role_id = r.id "
                + "WHERE u.full_name LIKE ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
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
        String sql = "SELECT id, name, address, phone, email, website, working_hours, description, logo, googlemap, created_at, updated_at "
                + "FROM clinic_info";
        try (Connection conn = DBContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
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
        String sql = "SELECT id, name, address, phone, email, website, working_hours, description, logo, googlemap, created_at, updated_at "
                + "FROM clinic_info WHERE id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
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
        String sql = "UPDATE clinic_info SET name = ?, address = ?, phone = ?, email = ?, website = ?, working_hours = ?, "
                + "description = ?, logo = ?, googlemap = ?, updated_at = GETDATE() WHERE id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
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
        // Tạo đối tượng User đại diện cho admin
        User admin = new User();
        admin.setUserName("admin123");
        admin.setEmail("admin01@gmail.com");
        admin.setPassword(hashPassword("admin123")); // Nên mã hóa trong thực tế
        admin.setFullName("Quản trị viên");
        admin.setPhoneNumber("0123456789");
        admin.setAddress("Hà Nội");
        admin.setAvatar("/image-loader/default_user.png");
        admin.setStatus(1);

        // Gán role admin
        Role role = new Role();
        role.setId(2); // 2 = Admin
        admin.setRole(role);

        // Ngày tạo + cập nhật
        Date now = new Date();
        admin.setCreateDate(now);
        admin.setUpdateDate(now);

        AdminDao dao=new AdminDao();
       

        
    }

      
    }

    
