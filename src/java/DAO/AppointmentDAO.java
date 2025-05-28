package DAO;

import Model.Appointment;
import Model.Pet;
import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class AppointmentDAO {
    
    public List<Appointment> getAppointmentsByDoctorAndDate(String doctorId, Date date) {
        List<Appointment> list = new ArrayList<>();
        String sql = "SELECT * FROM appointments WHERE doctor_id = ? AND CONVERT(date, start_time) = ? AND status IN ('registered','confirmed')";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, doctorId);
            ps.setDate(2, new java.sql.Date(date.getTime()));
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Appointment appt = new Appointment();
                appt.setId(rs.getString("id"));
                // Bạn có thể set doctor/pet/customer object nếu cần (DAO khác)
                appt.setStartTime(rs.getTimestamp("start_time"));
                appt.setEndTime(rs.getTimestamp("end_time"));
                appt.setStatus(rs.getString("status"));
                list.add(appt);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
    
 


    // Hàm lấy tất cả các cuộc hẹn theo ID bác sĩ
    public List<Appointment> getAppointmentsByDoctorId(String doctorId) throws ClassNotFoundException {
        List<Appointment> appointments = new ArrayList<>();
        String sql = "SELECT * FROM appointments WHERE doctor_id = ?";

        try (Connection conn = DBContext.getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            // Gán giá trị cho tham số
            stmt.setString(1, doctorId);

            // Thực thi truy vấn và lấy kết quả
            ResultSet rs = stmt.executeQuery();

            // Lặp qua các dòng kết quả và thêm vào danh sách
            while (rs.next()) {
                UserDAO u = new UserDAO();
                DoctorDAO d = new DoctorDAO();
                Appointment appointment = new Appointment();
                appointment.setId(rs.getString("id"));
                
                appointment.setUser(u.getUserById(rs.getString("customer_id")));
                appointment.setPet(u.getPetsById(rs.getString("pet_id")).get(0));
                appointment.setDoctor(d.getDoctorById(rs.getString("doctor_id")));
                appointment.setStartTime(rs.getTimestamp("start_time"));
                appointment.setEndTime(rs.getTimestamp("end_time"));
                appointment.setStatus(rs.getString("status"));
                appointment.setNote(rs.getString("notes"));
                appointment.setCreatedAt(rs.getTimestamp("created_at"));
                appointment.setUpdatedAt(rs.getTimestamp("updated_at"));

                appointments.add(appointment);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return appointments;
    }
    public static void main(String[] args) throws ClassNotFoundException {
        Appointment a = new AppointmentDAO().getAppointmentsByDoctorId("2D50D5B1-265C-48BA-B06C-24270D718A66").get(0);
        System.out.println(a);
    }

}
