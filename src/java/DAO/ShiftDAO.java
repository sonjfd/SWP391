/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Shift;
import java.util.Date;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Dell
 */
public class ShiftDAO {

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
    
     public static List<Shift> getAllShifts() {
        List<Shift> list = new ArrayList<>();
        String sql = "SELECT * FROM shift ORDER BY start_time";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Shift(rs.getInt(1), rs.getString(2), rs.getTime(3).toLocalTime(), rs.getTime(4).toLocalTime()));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
