/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Shift;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.sql.Time;
/**
 *
 * @author Dell
 */
public class ShiftDAO {
    private Connection getConnection() throws SQLException {
        return DBContext.getConnection();
    }
    
    public List<Shift> getShiftByDoctorAndDate(String doctorId, Date date) {
        List<Shift> list = new ArrayList<>();
        String sql = "select * \n"
                + "from doctor_schedule ds\n"
                + "join shift s on ds.shift_id=s.shift_id\n"
                + "where doctor_id=? and work_date=?";
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBContext.getConnection();
            stm = conn.prepareStatement(sql);
            stm.setString(1, doctorId);
            java.sql.Date sqlDate = new java.sql.Date(date.getTime());
            stm.setDate(2, sqlDate);
            rs = stm.executeQuery();
            while (rs.next()) {
                Shift shift = new Shift();
                 shift.setId(rs.getInt("shift_id"));
                shift.setStart_time(rs.getTime("start_time").toLocalTime());
                shift.setEnd_time(rs.getTime("end_time").toLocalTime());
                list.add(shift);

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<Shift> getAllShifts() {
        List<Shift> shiftList = new ArrayList<>();
        String sql = "SELECT shift_id, name, start_time, end_time FROM shift";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Shift shift = new Shift();
                shift.setId(rs.getInt("shift_id"));
                shift.setName(rs.getString("name"));
                shift.setStart_time(LocalTime.parse(rs.getString("start_time")));
                shift.setEnd_time(LocalTime.parse(rs.getString("end_time")));
                shiftList.add(shift);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return shiftList;
    }

    public Shift getShiftById(int id) {
        String sql = "SELECT shift_id, name, start_time, end_time FROM shift WHERE shift_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Shift shift = new Shift();
                    shift.setId(rs.getInt("shift_id"));
                    shift.setName(rs.getString("name"));
                    shift.setStart_time(LocalTime.parse(rs.getString("start_time")));
                    shift.setEnd_time(LocalTime.parse(rs.getString("end_time")));
                    return shift;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean addShift(Shift shift) {
        String sql = "INSERT INTO shift (name, start_time, end_time) VALUES (?, ?, ?)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, shift.getName());
            ps.setString(2, shift.getStart_time().toString());
            ps.setString(3, shift.getEnd_time().toString());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateShift(Shift shift) {
        String sql = "UPDATE shift SET name = ?, start_time = ?, end_time = ? WHERE shift_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, shift.getName());
            ps.setString(2, shift.getStart_time().toString());
            ps.setString(3, shift.getEnd_time().toString());
            ps.setInt(4, shift.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteShift(int id) {
        String sql = "DELETE FROM shift WHERE shift_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean isShiftInUse(int shiftId) {
    String sql1 = "SELECT COUNT(*) FROM weekly_schedule_template WHERE shift_id = ?";
    String sql2 = "SELECT COUNT(*) FROM doctor_schedule WHERE shift_id = ?";

    try (Connection conn = DBContext.getConnection()) {
        try (
            PreparedStatement ps1 = conn.prepareStatement(sql1);
            PreparedStatement ps2 = conn.prepareStatement(sql2)
        ) {
            ps1.setInt(1, shiftId);
            ps2.setInt(1, shiftId);

            ResultSet rs1 = ps1.executeQuery();
            ResultSet rs2 = ps2.executeQuery();

            rs1.next(); rs2.next();
            int count1 = rs1.getInt(1);
            int count2 = rs2.getInt(1);

            return (count1 + count2) > 0; // Nếu có ít nhất 1 bản ghi thì đang được dùng
        }
    } catch (SQLException e) {
        e.printStackTrace();
        return true; // Nếu lỗi, coi như đang dùng để tránh xóa
    }
}
    public boolean isDuplicateName(String name) {
    String sql = "SELECT COUNT(*) FROM shift WHERE name = ?";
    try (Connection conn = DBContext.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, name);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt(1) > 0;
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}
    public boolean isOverlappingShift(LocalTime newStart, LocalTime newEnd) {
    String sql = "SELECT start_time, end_time FROM shift";
    try (Connection conn = DBContext.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            LocalTime existingStart = rs.getTime("start_time").toLocalTime();
            LocalTime existingEnd = rs.getTime("end_time").toLocalTime();

            // Nếu có chồng lấn khoảng thời gian
            if (newStart.isBefore(existingEnd) && newEnd.isAfter(existingStart)) {
                return true;
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}
    public boolean isDuplicateNameExcludeId(String name, int id) {
    String sql = "SELECT COUNT(*) FROM shift WHERE name = ? AND shift_id <> ?";
    try (Connection con = DBContext.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setString(1, name);
        ps.setInt(2, id);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt(1) > 0;
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}
    
    public boolean isOverlappingShiftExcludeId(LocalTime newStart, LocalTime newEnd, int id) {
    String sql = "SELECT start_time, end_time FROM shift WHERE shift_id <> ?";
    try (Connection con = DBContext.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            LocalTime existingStart = rs.getTime("start_time").toLocalTime();
            LocalTime existingEnd = rs.getTime("end_time").toLocalTime();
            if (newStart.isBefore(existingEnd) && newEnd.isAfter(existingStart)) {
                return true;
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}
    
   public static void main(String[] args) {
        int idToDelete = 6; // Thay bằng ID thực tế trong DB của bạn

        ShiftDAO dao = new ShiftDAO();
        boolean result = dao.deleteShift(idToDelete);

        if (result) {
            System.out.println("✅ Xóa ca làm việc có ID " + idToDelete + " thành công.");
        } else {
            System.out.println("❌ Xóa ca làm việc thất bại hoặc không tìm thấy ID.");
        }
    }
     
}
