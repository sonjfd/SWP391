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
