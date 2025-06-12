package DAO;

import Model.Appointment;
import Model.Doctor;
import Model.ExaminationPrice;
import Model.Pet;
import Model.User;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AppointmentDAO {

    public List<Appointment> getAllAppointment() {
        String sql = "SELECT * FROM appointments";
        List<Appointment> list = new ArrayList<>();
        try (Connection conn = DBContext.getConnection(); PreparedStatement stm = conn.prepareStatement(sql); ResultSet rs = stm.executeQuery()) {

            while (rs.next()) {
                Appointment appointment = new Appointment();

                appointment.setId(rs.getString("id"));
                appointment.setStatus(rs.getString("status"));
                appointment.setPaymentStatus(rs.getString("payment_status"));
                appointment.setPaymentMethod(rs.getString("payment_method"));
                appointment.setNote(rs.getString("notes"));
                appointment.setPrice(rs.getDouble("price"));
                appointment.setAppointmentDate(rs.getTimestamp("appointment_time"));
                appointment.setStartTime(rs.getTime("start_time").toLocalTime());
                appointment.setEndTime(rs.getTime("end_time").toLocalTime());
                String customerId = rs.getString("customer_id");
                UserDAO udao = new UserDAO();
                User user = udao.getUserById(customerId);
                appointment.setUser(user);

                String petId = rs.getString("pet_id");
                Pet pet = udao.getPetsById(petId);
                appointment.setPet(pet);

                String doctorId = rs.getString("doctor_id");
                StaffDAO sdao = new StaffDAO();
                Doctor doctor = sdao.getDoctorById(doctorId);
                appointment.setDoctor(doctor);
                appointment.setChekinStatus(rs.getString("checkin_status"));
                list.add(appointment);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Appointment> getAppointmentsByDoctorAndDate(String doctorId, Date date) {
        List<Appointment> list = new ArrayList<>();
        String sql = "SELECT id, start_time, end_time ,status "
                + "FROM appointments "
                + "WHERE doctor_id = ? AND  appointment_time = ?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement stm = conn.prepareStatement(sql)) {

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

    public String insert(Appointment appointment) {
        String sql = "INSERT INTO appointments "
                + "(id, customer_id, pet_id, doctor_id, appointment_time, start_time, end_time,payment_method, notes, price) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        String generatedId = UUID.randomUUID().toString();
        appointment.setId(generatedId);

        try (Connection conn = DBContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, appointment.getId());
            stmt.setString(2, appointment.getUser().getId());
            stmt.setString(3, appointment.getPet().getId());
            stmt.setString(4, appointment.getDoctor().getUser().getId());
            java.sql.Timestamp appointmentDateTime = new java.sql.Timestamp(appointment.getAppointmentDate().getTime());
            stmt.setTimestamp(5, appointmentDateTime);

            stmt.setTime(6, Time.valueOf(appointment.getStartTime()));
            stmt.setTime(7, Time.valueOf(appointment.getEndTime()));

            stmt.setString(8, appointment.getPaymentMethod());

            stmt.setString(9, appointment.getNote() != null ? appointment.getNote() : "");

            stmt.setDouble(10, appointment.getPrice());

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                return appointment.getId();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public int addNewBoking(Appointment appointment) {
        String sql = "INSERT INTO appointments "
                + "( customer_id, pet_id, doctor_id, appointment_time, start_time, end_time,status,payment_status,payment_method, notes, price) "
                + "VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?,?,?)";

        int result = -1;

        try (Connection conn = DBContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, appointment.getUser().getId());
            stmt.setString(2, appointment.getPet().getId());
            stmt.setString(3, appointment.getDoctor().getUser().getId());
            Timestamp appointmentDateTime = new java.sql.Timestamp(appointment.getAppointmentDate().getTime());
            stmt.setTimestamp(4, appointmentDateTime);

            stmt.setTime(5, Time.valueOf(appointment.getStartTime()));
            stmt.setTime(6, Time.valueOf(appointment.getEndTime()));
            stmt.setString(7, appointment.getStatus());
            stmt.setString(8, appointment.getPaymentStatus());
            stmt.setString(9, appointment.getPaymentMethod());
            
            stmt.setString(10, appointment.getNote() != null ? appointment.getNote() : "");

            stmt.setDouble(11, appointment.getPrice());

            result = stmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public boolean updatePaymentStatus(Appointment appointment) {
        String sql = "UPDATE appointments SET payment_status = ?, status = ? WHERE id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, appointment.getPaymentStatus());
            stmt.setString(2, appointment.getStatus());
            stmt.setString(3, appointment.getId());

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Appointment getAppointmentById(String appointmentId) {
        Appointment appointment = null;
        String sql = "select * from appointments\n"
                + "where id=? ";
        try (Connection con = DBContext.getConnection(); PreparedStatement stmt = con.prepareStatement(sql);) {

            stmt.setString(1, appointmentId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                appointment = new Appointment();
                appointment.setId(rs.getString("id"));
                appointment.setUser(new UserDAO().getUserById(rs.getString("customer_id"))); // Lấy thông tin người dùng
                appointment.setPet(new UserDAO().getPetsById(rs.getString("pet_id"))); // Lấy thông tin thú cưng
                appointment.setDoctor(new DoctorDAO().getDoctorById(rs.getString("doctor_id"))); // Lấy thông tin bác sĩ
                appointment.setAppointmentDate(rs.getDate("appointment_time"));
                appointment.setStartTime(rs.getTime("start_time").toLocalTime());
                appointment.setEndTime(rs.getTime("end_time").toLocalTime());
                appointment.setStatus(rs.getString("status"));
                appointment.setPaymentStatus(rs.getString("payment_status"));
                appointment.setPaymentMethod(rs.getString("payment_method"));
                appointment.setNote(rs.getString("notes"));
                appointment.setPrice(rs.getDouble("price"));
                appointment.setChekinStatus(rs.getString("checkin_status"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AppointmentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return appointment;
    }

    public Double getPriceByDate() {
        Double price = null;
        String sql = "SELECT TOP 1 price FROM examination_prices ";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    price = rs.getDouble("price");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return price != null ? price : 100000.0;

    }

    public ExaminationPrice getExaminationPrice() {

        String sql = "SELECT * FROM examination_prices ";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    ExaminationPrice e = new ExaminationPrice(rs.getString(1), rs.getDouble(2));
                    return e;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateExaminationPrice(ExaminationPrice examPrice) {
        String selectSql = "SELECT COUNT(*) FROM examination_prices WHERE id = ?";
        String updateSql = "UPDATE examination_prices SET price = ? WHERE id = ?";
        String insertSql = "INSERT INTO examination_prices (id, price) VALUES (?, ?)";

        try (Connection conn = DBContext.getConnection(); PreparedStatement selectPs = conn.prepareStatement(selectSql)) {
            selectPs.setString(1, examPrice.getId());
            ResultSet rs = selectPs.executeQuery();
            rs.next();
            boolean exists = rs.getInt(1) > 0;

            if (exists) {
                try (PreparedStatement updatePs = conn.prepareStatement(updateSql)) {
                    updatePs.setDouble(1, examPrice.getPrice());
                    updatePs.setString(2, examPrice.getId());
                    int rows = updatePs.executeUpdate();
                    return rows > 0;
                }
            } else {
                try (PreparedStatement insertPs = conn.prepareStatement(insertSql)) {
                    insertPs.setString(1, examPrice.getId());
                    insertPs.setDouble(2, examPrice.getPrice());
                    int rows = insertPs.executeUpdate();
                    return rows > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Appointment> filterAppointments(int slotId, Date appointmentDate, String doctorId) {
        List<Appointment> appointments = new ArrayList<>();

        try (Connection conn = DBContext.getConnection()) {

            StringBuilder sql = new StringBuilder("SELECT a.* FROM appointments a WHERE 1=1");

            String startTime = null;
            String endTime = null;

            if (slotId != 0) {
                String sqlShift = "SELECT start_time, end_time FROM shift WHERE shift_id = ?";
                try (PreparedStatement psShift = conn.prepareStatement(sqlShift)) {
                    psShift.setInt(1, slotId);
                    ResultSet rsShift = psShift.executeQuery();
                    if (rsShift.next()) {
                        startTime = rsShift.getString("start_time");
                        endTime = rsShift.getString("end_time");
                    }
                }

                if (startTime != null && endTime != null) {
                    sql.append(" AND a.start_time = ? AND a.end_time = ?");
                }
            }

            if (appointmentDate != null) {
                sql.append(" AND a.appointment_time = ?");
            }

            if (doctorId != null && !doctorId.isEmpty()) {
                sql.append(" AND a.doctor_id = ?");
            }

            PreparedStatement ps = conn.prepareStatement(sql.toString());

            int index = 1;

            if (startTime != null && endTime != null) {
                ps.setString(index++, startTime);
                ps.setString(index++, endTime);
            }

            if (appointmentDate != null) {
                java.sql.Date sqlDate = new java.sql.Date(appointmentDate.getTime());
                ps.setDate(index++, sqlDate);
            }

            if (doctorId != null && !doctorId.isEmpty()) {
                ps.setString(index++, doctorId);
            }

            ResultSet rs = ps.executeQuery();

            UserDAO udao = new UserDAO();
            StaffDAO sdao = new StaffDAO();

            while (rs.next()) {
                Appointment appointment = new Appointment();

                appointment.setId(rs.getString("id"));
                appointment.setStatus(rs.getString("status"));
                appointment.setPaymentStatus(rs.getString("payment_status"));
                appointment.setPaymentMethod(rs.getString("payment_method"));
                appointment.setNote(rs.getString("notes"));
                appointment.setPrice(rs.getDouble("price"));
                appointment.setAppointmentDate(rs.getTimestamp("appointment_time"));
                appointment.setStartTime(rs.getTime("start_time").toLocalTime());
                appointment.setEndTime(rs.getTime("end_time").toLocalTime());

                String customerId = rs.getString("customer_id");
                User user = udao.getUserById(customerId);
                appointment.setUser(user);

                String petId = rs.getString("pet_id");
                Pet pet = udao.getPetsById(petId);
                appointment.setPet(pet);

                String doctorIdTable = rs.getString("doctor_id");
                Doctor doctor = sdao.getDoctorById(doctorIdTable);
                appointment.setDoctor(doctor);

                appointment.setChekinStatus(rs.getString("checkin_status"));

                appointments.add(appointment);
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return appointments;
    }

    public boolean updateAppointment(Appointment appointment) {
        String sql = "UPDATE appointments SET doctor_id = ?, appointment_time = ?, start_time = ?, end_time = ?, status = ?, payment_status = ? WHERE id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, appointment.getDoctor().getUser().getId());
            ps.setTimestamp(2, new Timestamp(appointment.getAppointmentDate().getTime()));
            ps.setTime(3, Time.valueOf(appointment.getStartTime()));
            ps.setTime(4, Time.valueOf(appointment.getEndTime()));
            ps.setString(5, appointment.getStatus());
            ps.setString(6, appointment.getPaymentStatus());
            ps.setString(7, appointment.getId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean updateCheckinStatus(String appointmentId, String status) {
    String sql = "UPDATE appointments SET checkin_status = ? WHERE id = ?";
    try (Connection conn = DBContext.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, status);
        ps.setString(2, appointmentId);
        return ps.executeUpdate() > 0;
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}

    public static void main(String[] args) {
        AppointmentDAO dao = new AppointmentDAO();
        String appointmentId = "B6192EC2-D431-41C1-BD17-09BF1077ECA0";
       

        
       

        boolean success = dao.updateCheckinStatus(appointmentId, "checkin");

        if (success) {
            System.out.println("✅ Cập nhật giờ hẹn thành công!");
        } else {
            System.out.println("❌ Cập nhật giờ hẹn thất bại.");
        }
    }

}
