/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Appointment;
import Model.AppointmentService;
import Model.Breed;
import Model.Doctor;
import Model.Pet;
import Model.Service;
import Model.User;
import java.sql.Timestamp;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.sql.Date;

/**
 *
 * @author ASUS
 */
public class AppointmentServiceDAO {
    // Phương thức để lấy AppointmentService theo ID và join các bảng Appointment và Service
// Phương thức để lấy AppointmentService theo ID và join các bảng Appointment và Service

    public AppointmentService getAppointmentServiceById(String id) {
        String query = "SELECT asrv.id AS service_assigned_id, a.id AS appointment_id, s.id AS service_id, "
                + "asrv.price, asrv.status, asrv.created_at, asrv.updated_at, "
                + "a.customer_id, a.pet_id, a.appointment_time, a.start_time, a.end_time, "
                + "s.name AS service_name, s.description AS service_description "
                + "FROM appointment_services asrv "
                + "JOIN appointments a ON asrv.appointment_id = a.id "
                + "JOIN services s ON asrv.service_id = s.id "
                + "WHERE asrv.id = ?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // Tạo đối tượng AppointmentService
                AppointmentService appointmentService = new AppointmentService();
                appointmentService.setId(rs.getString("service_assigned_id"));

                // Tạo đối tượng Appointment và gán vào trường appointment
                Appointment appointment = new Appointment();
                appointment.setId(rs.getString("appointment_id"));
                User u = new User();
                u.setId(rs.getString("customer_id"));
                appointment.setUser(u);
                Pet pet = new Pet();
                pet.setId(rs.getString("pet_id"));
                appointment.setPet(pet);
                appointment.setAppointmentDate(rs.getTimestamp("appointment_time"));
                appointment.setStartTime(rs.getTime("start_time").toLocalTime());
                appointment.setEndTime(rs.getTime("end_time").toLocalTime());
                appointmentService.setAppointment(appointment);

                // Tạo đối tượng Service và gán vào trường service
                Service service = new Service();
                service.setId(rs.getString("service_id"));
                service.setName(rs.getString("service_name"));
                service.setDescription(rs.getString("service_description"));
                appointmentService.setService(service);

                // Gán các trường còn lại
                appointmentService.setPrice(rs.getDouble("price"));
                appointmentService.setStatus(rs.getString("status"));
                appointmentService.setCreatedAt(rs.getTimestamp("created_at"));
                appointmentService.setUpdatedAt(rs.getTimestamp("updated_at"));

                return appointmentService;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

// Phương thức lấy tất cả AppointmentServices
    // Lấy danh sách AppointmentService với bộ lọc theo trạng thái và thời gian
    public List<AppointmentService> getFilteredAppointmentServices(String status, Date startDate, Date endDate, int offset, int pageSize) {
        List<AppointmentService> appointmentServices = new ArrayList<>();

        // SQL để lọc theo trạng thái và khoảng thời gian và phân trang
        String sql = "SELECT asrv.id as asrv_id, asrv.price, asrv.status as service_status, asrv.created_at, asrv.updated_at, " +
             "a.id as app_id, a.appointment_time, a.start_time, a.end_time, " +
             "u.id as user_id, u.full_name as user_fullname, u.avatar as user_avatar,u.email as user_email,u.phone as user_phone, " +
             "p.id as pet_id, p.name as pet_name, p.avatar as pet_avatar, p.gender as pet_gender, p.pet_code, p.description as pet_description,b.name as breed_name, " +
             "d.user_id as doctor_id, d.specialty as doctor_specialty, d.qualifications as doctor_qualifications, d.years_of_experience as doctor_experience, " +
             "s.id as service_id, s.name as service_name, s.description as service_description, s.price as service_price " +
             "FROM appointment_services asrv " +
             "JOIN appointments a ON asrv.appointment_id = a.id " +
             "JOIN users u ON a.customer_id = u.id " +
             "JOIN pets p ON a.pet_id = p.id " +
             "JOIN breeds b ON b.id = p.breeds_id " +
             "JOIN doctors d ON a.doctor_id = d.user_id " +
             "JOIN services s ON asrv.service_id = s.id " +
             "WHERE 1=1";

        // Thêm điều kiện lọc nếu có
        if (status != null && !status.isEmpty()) {
            sql += " AND asrv.status = ?";
        }
        if (startDate != null) {
            sql += " AND a.appointment_time >= ?";
        }
        if (endDate != null) {
            sql += " AND a.appointment_time <= ?";
        }

        // Phân trang sử dụng OFFSET-FETCH
        sql += " ORDER BY a.appointment_time DESC " +
               "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"; // OFFSET-FETCH để phân trang

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            int index = 1;

            // Set các tham số vào PreparedStatement
            if (status != null && !status.isEmpty()) {
                ps.setString(index++, status);
            }
            if (startDate != null) {
                ps.setDate(index++, startDate);
            }
            if (endDate != null) {
                ps.setDate(index++, endDate);
            }

            // Set tham số phân trang
            ps.setInt(index++, offset);
            ps.setInt(index++, pageSize);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                AppointmentService appointmentService = new AppointmentService();
                appointmentService.setId(rs.getString("asrv_id"));
                appointmentService.setPrice(rs.getDouble("price"));
                appointmentService.setStatus(rs.getString("service_status"));
                appointmentService.setCreatedAt(rs.getTimestamp("created_at"));
                appointmentService.setUpdatedAt(rs.getTimestamp("updated_at"));

                // Gán Appointment
                Appointment appointment = new Appointment();
                appointment.setId(rs.getString("app_id"));
                appointment.setAppointmentDate(rs.getTimestamp("appointment_time"));
                appointment.setStartTime(rs.getTime("start_time").toLocalTime());
                appointment.setEndTime(rs.getTime("end_time").toLocalTime());

                // Gán Pet
                Breed breed = new Breed();
                breed.setName(rs.getString("breed_name"));
                Pet pet = new Pet();
                pet.setBreed(breed);
                pet.setId(rs.getString("pet_id"));
                pet.setName(rs.getString("pet_name"));
                pet.setAvatar(rs.getString("pet_avatar"));
                pet.setGender(rs.getString("pet_gender"));
                pet.setPet_code(rs.getString("pet_code"));
                pet.setDescription(rs.getString("pet_description"));
                appointment.setPet(pet);

                // Gán User (Customer)
                User user = new User();
                user.setId(rs.getString("user_id"));
                user.setFullName(rs.getString("user_fullname"));
                user.setAvatar(rs.getString("user_avatar"));
                user.setEmail(rs.getString("user_email"));
                user.setPhoneNumber(rs.getString("user_phone"));
                appointment.setUser(user);

                // Gán Doctor
                Doctor doctor = new Doctor();
                doctor.setUser(user);
                doctor.setSpecialty(rs.getString("doctor_specialty"));
                doctor.setQualifications(rs.getString("doctor_qualifications"));
                doctor.setYearsOfExperience(rs.getInt("doctor_experience"));
                appointment.setDoctor(doctor);

                // Gán Service
                Service service = new Service();
                service.setId(rs.getString("service_id"));
                service.setName(rs.getString("service_name"));
                service.setDescription(rs.getString("service_description"));
                service.setPrice(rs.getDouble("service_price"));
                appointmentService.setService(service);

                appointmentService.setAppointment(appointment);
                appointmentServices.add(appointmentService);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return appointmentServices;
    }

    // Lấy tổng số bản ghi để tính số trang
    public int getTotalAppointmentServices(String status, Date startDate, Date endDate) {
        int total = 0;
        String sql = "SELECT COUNT(*) " +
                     "FROM appointment_services asrv " +
                     "JOIN appointments a ON asrv.appointment_id = a.id " +
                     "WHERE 1=1";

        // Thêm điều kiện lọc nếu có
        if (status != null && !status.isEmpty()) {
            sql += " AND asrv.status = ?";
        }
        if (startDate != null) {
            sql += " AND a.appointment_time >= ?";
        }
        if (endDate != null) {
            sql += " AND a.appointment_time <= ?";
        }

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            int index = 1;

            if (status != null && !status.isEmpty()) {
                ps.setString(index++, status);
            }
            if (startDate != null) {
                ps.setDate(index++, startDate);
            }
            if (endDate != null) {
                ps.setDate(index++, endDate);
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return total;
    }

    // Phương thức cập nhật service_id cho AppointmentService
    public boolean updateServiceId(String appointmentServiceId, String newServiceId) {
        String query = "UPDATE appointment_services SET service_id = ?, updated_at = ? WHERE id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {

            // Cập nhật service_id mới và thời gian cập nhật
            stmt.setString(1, newServiceId);
            stmt.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
            stmt.setString(3, appointmentServiceId);

            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    // Phương thức cập nhật status cho AppointmentService

    public boolean updateStatus(String appointmentServiceId, String newStatus) {
        String query = "UPDATE appointment_services SET status = ?, updated_at = ? WHERE id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {

            // Cập nhật trạng thái mới và thời gian cập nhật
            stmt.setString(1, newStatus);
            stmt.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
            stmt.setString(3, appointmentServiceId);

            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
// Phương thức để thêm một AppointmentService mới vào cơ sở dữ liệu

     public boolean addAppointmentService(String appointmentId, String serviceId, double price) {
        String sql = "INSERT INTO appointment_services (appointment_id, service_id, price, status, created_at, updated_at) "
                   + "VALUES (?, ?, ?, 'pending', GETDATE(), GETDATE())";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, appointmentId);
            ps.setString(2, serviceId);
            ps.setDouble(3, price);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0; // Nếu có ít nhất 1 bản ghi bị ảnh hưởng, trả về true
        } catch (Exception e) {
            e.printStackTrace();
            return false; // Nếu có lỗi, trả về false
        }
    }

    // Phương thức để xóa một AppointmentService khỏi cơ sở dữ liệu
    public boolean deleteAppointmentService(String appointmentServiceId) {
        String query = "DELETE FROM appointment_services WHERE id = ?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {

            // Cài đặt tham số cho câu truy vấn DELETE
            stmt.setString(1, appointmentServiceId); // appointmentServiceId là id của AppointmentService cần xóa

            // Thực thi câu lệnh DELETE
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
     public List<AppointmentService> getAppointmentServicesByAppointmentId(String appointmentId) {
        List<AppointmentService> list = new ArrayList<>();
        String sql = """
            SELECT aps.id, aps.price, aps.status, 
                   sv.id as service_id,sv.name AS service_name
            FROM appointment_services aps
            JOIN services sv ON aps.service_id = sv.id
            WHERE aps.appointment_id = ?
            ORDER BY aps.created_at
        """;

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, appointmentId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                AppointmentService aps = new AppointmentService();
                aps.setId(rs.getString("id"));
                aps.setPrice(rs.getDouble("price"));
                aps.setStatus(rs.getString("status"));
                Service s = new Service();
                s.setId(rs.getString("service_id"));
                s.setName(rs.getString("service_name"));
                aps.setService(s);
                list.add(aps);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

     public boolean isServiceAlreadyAdded(String appointmentId, String serviceId) {
    String sql = "SELECT COUNT(*) FROM appointment_services WHERE appointment_id = ? AND service_id = ?";
    try (Connection conn = DBContext.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, appointmentId);
        ps.setString(2, serviceId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt(1) > 0;
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}

     
     /// PHẦN NÀY CHO NURSE
     // Hàm lấy danh sách + đếm tổng cho phân trang (SQL Server)
    public List<AppointmentService> getPendingForNurse(
        String petName, String ownerName, String serviceId,
        Date fromDate, Date toDate,
        int offset, int pageSize,
        int[] totalCountOut) {

        List<AppointmentService> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT " +
            "aps.id AS aps_id, aps.price, aps.status, aps.created_at, aps.updated_at, " +
            "ap.id AS ap_id, ap.appointment_time, ap.created_at AS ap_created_at, " +
            "p.id AS pet_id, p.pet_code, p.name AS pet_name, p.avatar AS pet_avatar, " +
            "u.id AS owner_id, u.full_name AS owner_name, " +
            "s.id AS service_id, s.name AS service_name " +
            "FROM appointment_services aps " +
            "JOIN appointments ap ON aps.appointment_id = ap.id " +
            "JOIN pets p ON ap.pet_id = p.id " +
            "JOIN users u ON p.owner_id = u.id " +
            "JOIN services s ON aps.service_id = s.id " +
            "WHERE aps.status = 'pending' "
        );

        List<Object> params = new ArrayList<>();
        if (petName != null && !petName.isEmpty()) {
            sql.append(" AND p.name LIKE ? ");
            params.add("%" + petName + "%");
        }
        if (ownerName != null && !ownerName.isEmpty()) {
            sql.append(" AND u.full_name LIKE ? ");
            params.add("%" + ownerName + "%");
        }
        if (serviceId != null && !serviceId.isEmpty()) {
            sql.append(" AND s.id = ? ");
            params.add(serviceId);
        }
        if (fromDate != null) {
            sql.append(" AND aps.created_at >= ? ");
            params.add(fromDate);
        }
        if (toDate != null) {
            sql.append(" AND aps.created_at <= ? ");
            params.add(toDate);
        }

        // SQL Server: phân trang bằng OFFSET ... FETCH NEXT
        sql.append(" ORDER BY aps.created_at DESC ");
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY ");

        params.add(offset);
        params.add(pageSize);

        try (Connection conn = DBContext.getConnection()) {
            // Query đếm tổng bản ghi (phục vụ phân trang)
            StringBuilder countSql = new StringBuilder(
                "SELECT COUNT(*) FROM appointment_services aps " +
                "JOIN appointments ap ON aps.appointment_id = ap.id " +
                "JOIN pets p ON ap.pet_id = p.id " +
                "JOIN users u ON p.owner_id = u.id " +
                "JOIN services s ON aps.service_id = s.id " +
                "WHERE aps.status = 'pending' "
            );
            List<Object> countParams = new ArrayList<>();
            if (petName != null && !petName.isEmpty()) {
                countSql.append(" AND p.name LIKE ? ");
                countParams.add("%" + petName + "%");
            }
            if (ownerName != null && !ownerName.isEmpty()) {
                countSql.append(" AND u.full_name LIKE ? ");
                countParams.add("%" + ownerName + "%");
            }
            if (serviceId != null && !serviceId.isEmpty()) {
                countSql.append(" AND s.id = ? ");
                countParams.add(serviceId);
            }
            if (fromDate != null) {
                countSql.append(" AND aps.created_at >= ? ");
                countParams.add(fromDate);
            }
            if (toDate != null) {
                countSql.append(" AND aps.created_at <= ? ");
                countParams.add(toDate);
            }
            try (PreparedStatement countSt = conn.prepareStatement(countSql.toString())) {
                for (int i = 0; i < countParams.size(); i++) {
                    countSt.setObject(i + 1, countParams.get(i));
                }
                try (ResultSet rsCount = countSt.executeQuery()) {
                    if (rsCount.next()) {
                        totalCountOut[0] = rsCount.getInt(1);
                    }
                }
            }

            // Query dữ liệu chính
            try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {
                for (int i = 0; i < params.size(); i++) {
                    ps.setObject(i + 1, params.get(i));
                }
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        // Service
                        Service service = new Service();
                        service.setId(rs.getString("service_id"));
                        service.setName(rs.getString("service_name"));

                        // Owner
                        User owner = new User();
                        owner.setId(rs.getString("owner_id"));
                        owner.setFullName(rs.getString("owner_name"));

                        // Pet
                        Pet pet = new Pet();
                        pet.setId(rs.getString("pet_id"));
                        pet.setPet_code(rs.getString("pet_code"));
                        pet.setName(rs.getString("pet_name"));
                        pet.setAvatar(rs.getString("pet_avatar"));
                        pet.setUser(owner); // mapping owner vào pet

                        // Appointment
                        Appointment appointment = new Appointment();
                        appointment.setId(rs.getString("ap_id"));
                        appointment.setPet(pet);
                        appointment.setCreatedAt(rs.getTimestamp("ap_created_at"));
                        appointment.setAppointmentDate(rs.getTimestamp("appointment_time"));
                        appointment.setUser(owner);

                        // AppointmentService
                        AppointmentService aps = new AppointmentService();
                        aps.setId(rs.getString("aps_id"));
                        aps.setAppointment(appointment);
                        aps.setService(service);
                        aps.setPrice(rs.getDouble("price"));
                        aps.setStatus(rs.getString("status"));
                        aps.setCreatedAt(rs.getTimestamp("created_at"));
                        aps.setUpdatedAt(rs.getTimestamp("updated_at"));

                        list.add(aps);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    /// HẾT PHẦN NURSE
}


