/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.DoctorSchedule;
import Model.Shift;
import java.util.Date;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ASUS
 */
public class DoctorScheduleDAO {

    // Lấy tất cả ca làm của bác sĩ theo ngày (cả nghỉ và làm)
    public List<DoctorSchedule> getDoctorScheduleByDoctorAndDate(String doctorId, Date date) {
        List<DoctorSchedule> list = new ArrayList<>();
        String sql = "SELECT ds.*, s.name AS shift_name, s.start_time, s.end_time "
                + "FROM doctor_schedule ds "
                + "JOIN shift s ON ds.shift_id = s.shift_id "
                + "WHERE ds.doctor_id = ? AND ds.work_date = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, doctorId);
            ps.setDate(2, new java.sql.Date(date.getTime()));
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                // Map dữ liệu
                Shift shift = new Shift(
                        rs.getInt("shift_id"),
                        rs.getString("shift_name"),
                        rs.getTime("start_time").toLocalTime(),
                        rs.getTime("end_time").toLocalTime()
                );
                DoctorSchedule ds = new DoctorSchedule(
                        rs.getInt("schedule_id"),
                        null, // doctor bạn có thể join thêm nếu cần
                        rs.getDate("work_date"),
                        shift,
                        rs.getInt("is_available")
                );
                list.add(ds);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Date> getAllWorkDatesOfDoctorInWeek(String doctorId, Date weekStart, Date weekEnd) {
        List<Date> list = new ArrayList<>();
        String sql = "SELECT DISTINCT work_date FROM doctor_schedule WHERE doctor_id = ? AND work_date BETWEEN ? AND ? ORDER BY work_date";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, doctorId);
            ps.setDate(2, new java.sql.Date(weekStart.getTime()));
            ps.setDate(3, new java.sql.Date(weekEnd.getTime()));
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(rs.getDate("work_date"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

}
