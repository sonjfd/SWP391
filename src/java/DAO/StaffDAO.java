/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Appointment;
import Model.Contact;
import Model.Doctor;
import Model.DoctorSchedule;
import Model.Role;
import Model.Shift;
import Model.Slot;
import Model.User;
import java.sql.CallableStatement;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.sql.Time;

/**
 *
 * @author Dell
 */
public class StaffDAO {

    //Role DAO
    public Role getRoleByName(String name) {
        String sql = "select  * from roles where name = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement stm = conn.prepareStatement(sql)) {

            stm.setString(1, name);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return new Role(rs.getInt("id"), rs.getString("name"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;

    }

    public Role getRoleById(int id) {
        String sql = "SELECT * FROM roles WHERE id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement stm = conn.prepareStatement(sql)) {

            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return new Role(rs.getInt("id"), rs.getString("name"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;

    }

    //UserDao
    public List<User> getUserByRoleID(int rid) {
        String sql = "select * from users\n"
                + "where role_id=?";
        List<User> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBContext.getConnection();
            stm = conn.prepareStatement(sql);
            stm.setInt(1, rid);
            rs = stm.executeQuery();
            while (rs.next()) {
                Role role = getRoleById(rs.getInt("role_id"));
                User user = new User(rs.getString(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7),
                        rs.getString(8), rs.getInt(9), role, rs.getDate(11), rs.getDate(12));
                list.add(user);
            }
        } catch (Exception e) {
        }
        return list;

    }

    public List<Doctor> getAllDoctors() {
        List<Doctor> doctors = new ArrayList<>();
        String sql = "select  * from doctors";

        try (Connection conn = DBContext.getConnection(); PreparedStatement stm = conn.prepareStatement(sql); ResultSet rs = stm.executeQuery()) {
            Role doctorRole = getRoleByName("doctor");
            List<User> users = getUserByRoleID(doctorRole.getId());

            while (rs.next()) {

                String userIdInDoctor = rs.getString("user_id");
                User userToFind = null;
                for (User u : users) {
                    if (u.getId().equalsIgnoreCase(userIdInDoctor)) {
                        userToFind = u;
                        break;
                    }

                }
                Doctor doctor = new Doctor(userToFind, rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getInt(5), rs.getString(6));
                doctors.add(doctor);

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return doctors;
    }

    public User getUserById(String id) {
        String sql = "SELECT * FROM users WHERE id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getString("id"));
                user.setUserName(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setFullName(rs.getString("full_name"));
                user.setPhoneNumber(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setAvatar(rs.getString("avatar"));
                user.setStatus(rs.getInt("status"));
                user.setCreateDate(rs.getTimestamp("created_at"));
                user.setUpdateDate(rs.getTimestamp("updated_at"));
                int roleId = rs.getInt("role_id");

                Role role = getRoleById(roleId);

                user.setRole(role);

                return user;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    //Contact
    public List getAllContact() {
        String sql = "SELECT  * FROM [dbo].[contacts]";
        List<Contact> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBContext.getConnection();
            stm = conn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                Contact contact = new Contact(rs.getString(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getString(5),
                        rs.getString(6), rs.getDate(7));
                list.add(contact);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (stm != null) {
                    stm.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }

        return list;

    }

    public int addContact(Contact c) {
        String sql = "INSERT INTO [dbo].[contacts]\n"
                + "           ([name]\n"
                + "           ,[email]\n"
                + "           ,[phone]\n"
                + "           ,[message]\n"
                + "           ,[created_at])\n"
                + "     VALUES\n"
                + "           (?,?,?,?,?)";

        int resutl = -1;
        Connection conn = null;
        PreparedStatement stm = null;

        try {
            conn = DBContext.getConnection();
            stm = conn.prepareStatement(sql);
            stm.setString(1, c.getName());
            stm.setString(2, c.getEmail());
            stm.setString(3, c.getPhone());
            stm.setString(4, c.getMessage());
            stm.setTimestamp(5, new java.sql.Timestamp(c.getCreatedAt().getTime()));
            resutl = stm.executeUpdate();

        } catch (Exception e) {
            System.out.println(e);
        } finally {
            try {
                if (stm != null) {
                    stm.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
        return resutl;
    }

    public int updateStatusContact(String id, String status) {
        String sql = "UPDATE [dbo].[contacts]\n"
                + "   SET [status] = ?\n"
                + "      \n"
                + " WHERE id=?";
        Connection conn = null;
        PreparedStatement stm = null;
        int result = -1;
        try {
            conn = DBContext.getConnection();
            stm = conn.prepareStatement(sql);
            stm.setString(1, status);
            stm.setString(2, id);
            result = stm.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public List searchContactByName(String name) {
        String sql = "select * from contacts\n"
                + "where name like ?";
        List<Contact> list = new ArrayList<>();
        String query = "%" + name.trim().toLowerCase() + "%";
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            conn = DBContext.getConnection();
            stm = conn.prepareStatement(sql);
            stm.setString(1, query);
            rs = stm.executeQuery();
            while (rs.next()) {
                Contact contact = new Contact(rs.getString(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getString(5),
                        rs.getString(6), rs.getDate(7));
                list.add(contact);

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List filterByStatus(String status) {
        String sql = "select * from contacts\n"
                + "where status like ?";
        List<Contact> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBContext.getConnection();
            stm = conn.prepareStatement(sql);
            stm.setString(1, status);
            rs = stm.executeQuery();
            while (rs.next()) {
                Contact contact = new Contact(rs.getString(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getString(5),
                        rs.getString(6), rs.getDate(7));
                list.add(contact);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    //SHiftDAO
    public Shift getShiftByID(int id) {
        String sql = "Select * from Shift  where shift_id =?";
        Connection conn = null;

        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            conn = DBContext.getConnection();
            stm = conn.prepareStatement(sql);
            stm.setInt(1, id);
            rs = stm.executeQuery();
            if (rs.next()) {
                Shift s = new Shift(rs.getInt(1), rs.getString(2), rs.getTime(3).toLocalTime(),
                        rs.getTime(4).toLocalTime());
                return s;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;

    }

    public List<Shift> getAllShift() {
        String sql = "Select * from Shift";
        Connection conn = null;
        List<Shift> list = new ArrayList<>();
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            conn = DBContext.getConnection();
            stm = conn.prepareStatement(sql);

            rs = stm.executeQuery();
            while (rs.next()) {
                Shift s = new Shift(rs.getInt(1), rs.getString(2), rs.getTime(3).toLocalTime(),
                        rs.getTime(4).toLocalTime());
                list.add(s);

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;

    }

    //Scheduletemplate
    public int AddWeeklySchedule(String doctorId, int weekDay, Shift shift) throws ClassNotFoundException {
        String sql = "INSERT INTO [dbo].[weekly_schedule_template] "
                + "([doctor_id], [weekday], [shift_id]) "
                + "VALUES (?, ?, ?)";

        int result = -1;
        try (Connection conn = DBContext.getConnection(); PreparedStatement stm = conn.prepareStatement(sql)) {

            stm.setString(1, doctorId);
            stm.setInt(2, weekDay);
            stm.setInt(3, shift.getId());

            result = stm.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return result;
    }

    public boolean isDuplicateWeeklySchedule(String doctorId, int weekday, int shiftId) throws ClassNotFoundException {
        String sql = "SELECT COUNT(*) FROM weekly_schedule_template WHERE doctor_id = ? AND weekday = ? AND shift_id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, doctorId);
            stmt.setInt(2, weekday);
            stmt.setInt(3, shiftId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    //DoctorScheduleDAO
    public void generateMonthlySchedule(int month, String doctorId) throws ClassNotFoundException {
        String sql = "{CALL sp_generate_doctor_schedule(?, ?)}";
        try (Connection conn = DBContext.getConnection(); CallableStatement stmt = conn.prepareCall(sql)) {

            stmt.setInt(1, month);
            stmt.setString(2, doctorId);

            stmt.execute();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Doctor getDoctorById(String doctorId) throws ClassNotFoundException {
        Doctor doctor = null;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBContext.getConnection();
            String sql = "SELECT user_id, specialty, certificates, qualifications, years_of_experience, biography "
                    + "FROM doctors WHERE user_id = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, doctorId);
            rs = ps.executeQuery();

            if (rs.next()) {
                doctor = new Doctor();
                doctor.setSpecialty(rs.getString("specialty"));
                doctor.setCertificates(rs.getString("certificates"));
                doctor.setQualifications(rs.getString("qualifications"));
                doctor.setYearsOfExperience(rs.getInt("years_of_experience"));
                doctor.setBiography(rs.getString("biography"));
                
                User user = getUserById(rs.getString("user_id"));
                doctor.setUser(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return doctor;
    }

    public List<DoctorSchedule> getAllDoctorSchedule() {
        List<DoctorSchedule> list = new ArrayList<>();
        String sql = "SELECT * FROM doctor_schedule";

        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            conn = DBContext.getConnection();
            stm = conn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                int scheduleId = rs.getInt("schedule_id");
                String doctorId = rs.getString("doctor_id");
                Date workDate = rs.getDate("work_date");
                int shiftId = rs.getInt("shift_id");
                int isAvailable = rs.getInt("is_available");

                Shift shift = getShiftByID(shiftId);

                User doctor = getUserById(doctorId);

                Doctor d = getDoctorById(doctor.getId());
                DoctorSchedule ds = new DoctorSchedule(scheduleId, d, workDate, shift, isAvailable);

                list.add(ds);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public int deleteDoctorWorkShedule(String doctorId, Date date) {
        String sql = "DELETE FROM doctor_schedule\n"
                + "WHERE doctor_id = ?\n"
                + "  AND work_date = ?";
        Connection conn = null;
        PreparedStatement stm = null;
        int result = -1;
        try {
            conn = DBContext.getConnection();
            stm = conn.prepareStatement(sql);
            stm.setString(1, doctorId);
            stm.setDate(2, date);
            result = stm.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public int updateDoctorWorkShedule(int sheduleId, Date workDate, int shiftid) {
        String sql = "UPDATE doctor_schedule\n"
                + "SET work_date = ?, shift_id = ?\n"
                + "WHERE schedule_id = ? ";
        Connection conn = null;
        PreparedStatement stm = null;
        int result = -1;
        try {
            conn = DBContext.getConnection();
            stm = conn.prepareStatement(sql);
            stm.setDate(1, workDate);
            stm.setInt(2, shiftid);
            stm.setInt(3, sheduleId);

            result = stm.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    //check trung lich lam viec
    public boolean isDuplicateSchedule(String doctorId, Date workDate, int shiftId, int currentScheduleId) {
        String sql = "SELECT COUNT(*) AS total FROM doctor_schedule "
                + "WHERE doctor_id = ? AND work_date = ? AND shift_id = ? AND schedule_id != ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement stm = conn.prepareStatement(sql)) {

            stm.setString(1, doctorId);
            stm.setDate(2, workDate);
            stm.setInt(3, shiftId);
            stm.setInt(4, currentScheduleId);

            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("total") > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public DoctorSchedule getOneDoctorSchedule(int id) {
        String sql = "select * from doctor_schedule\n"
                + "where schedule_id=?";
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBContext.getConnection();
            stm = conn.prepareStatement(sql);
            stm.setInt(1, id);
            rs = stm.executeQuery();
            if (rs.next()) {
                int scheduleId = rs.getInt("schedule_id");
                String doctorId = rs.getString("doctor_id");
                Date workDate = rs.getDate("work_date");
                int shiftId = rs.getInt("shift_id");
                int isAvailable = rs.getInt("is_available");

                Shift shift = getShiftByID(shiftId);

                User doctor = getUserById(doctorId);

                Doctor d = getDoctorById(doctor.getId());
                DoctorSchedule ds = new DoctorSchedule(scheduleId, d, workDate, shift, isAvailable);
                return ds;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<DoctorSchedule> filterDoctorSchedules(String doctorId, Integer month, Integer shiftId) {
        List<DoctorSchedule> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM doctor_schedule WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (doctorId != null && !doctorId.isEmpty()) {
            sql.append(" AND doctor_id = ?");
            params.add(doctorId);
        }
        if (month != null && month >= 1 && month <= 12) {
            sql.append(" AND MONTH(work_date) = ?");
            params.add(month);
        }
        if (shiftId != null && shiftId > 0) {
            sql.append(" AND shift_id = ?");
            params.add(shiftId);
        }

        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            conn = DBContext.getConnection();
            stm = conn.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                Object p = params.get(i);
                if (p instanceof String) {
                    stm.setString(i + 1, (String) p);
                } else if (p instanceof Integer) {
                    stm.setInt(i + 1, (Integer) p);
                }
            }

            rs = stm.executeQuery();

            while (rs.next()) {
                int scheduleId = rs.getInt("schedule_id");
                String dId = rs.getString("doctor_id");
                Date workDate = rs.getDate("work_date");
                int sId = rs.getInt("shift_id");
                int isAvailable = rs.getInt("is_available");

                Shift shift = getShiftByID(sId);
                User doctorUser = getUserById(dId);
                Doctor doctor = getDoctorById(doctorUser.getId());

                DoctorSchedule ds = new DoctorSchedule(scheduleId, doctor, workDate, shift, isAvailable);
                list.add(ds);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int deleteSchedulesByDoctorAndMonth(String doctorId, int month) {
        String deleteDoctorSchedule = "DELETE FROM doctor_schedule WHERE doctor_id = ? AND MONTH(work_date) = ?";

        Connection conn = null;
        PreparedStatement psDoctorSchedule = null;
        int rowsAffected = 0;

        try {
            conn = DBContext.getConnection();

            psDoctorSchedule = conn.prepareStatement(deleteDoctorSchedule);
            psDoctorSchedule.setString(1, doctorId);
            psDoctorSchedule.setInt(2, month);
            rowsAffected = psDoctorSchedule.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (psDoctorSchedule != null) {
                    psDoctorSchedule.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return rowsAffected;
    }

    
    
    
    
    
    public static void main(String[] args) throws SQLException, ClassNotFoundException {
        
     
    }
}
