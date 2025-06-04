package DAO;

import Model.Appointment;
import Model.Pet;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class AppointmentDAO {
    
    public List<Appointment> getAppointmentsByDoctorAndDate(String doctorId, Date date) {
        List<Appointment> list = new ArrayList<>();
        String sql = "SELECT id, start_time, end_time ,status " +
                     "FROM appointments " +
                     "WHERE doctor_id = ? AND  appointment_time = ?";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement stm = conn.prepareStatement(sql)) {

            stm.setString(1, doctorId);
            java.sql.Date sqlDate = new java.sql.Date(date.getTime());
            stm.setDate(2, sqlDate);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Appointment appt = new Appointment();
                appt.setId(rs.getString("id"));
                appt.setStartTime(rs.getTime("start_time").toLocalTime());
                appt.setEndTime(rs.getTime("end_time").toLocalTime());
                appt.setStatus(rs.getString("status"));
                list.add(appt);
            }

        } catch (Exception e) {
            e.printStackTrace(); 
        }

        return list;
    }
    
    public static void main(String[] args) throws ParseException {
        AppointmentDAO dao=new AppointmentDAO();
        SimpleDateFormat sfm=new SimpleDateFormat("yyyy-mm-dd");
        String date1 ="2025-06-05";
        Date date=sfm.parse(date1);
        List<Appointment> list=dao.getAppointmentsByDoctorAndDate("D229EEAA-FC91-47BC-833A-EF6D07F7F635", date);
        System.out.println(list);
    }


}
