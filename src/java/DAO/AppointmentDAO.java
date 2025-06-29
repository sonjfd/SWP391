package DAO;

import Model.Appointment;
import Model.Breed;
import Model.Doctor;
import Model.ExaminationPrice;
import Model.Pet;
import Model.Rating;
import Model.Role;
import Model.Specie;
import Model.User;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AppointmentDAO {

    public List<Appointment> getAllAppointment() {
        String sql = """
     SELECT a.*, 
              u.id AS user_id, u.username, u.email, u.full_name, u.phone, 
              u.address, u.avatar, u.status AS user_status, u.role_id,
              p.id AS pet_id, p.pet_code, p.name AS pet_name, p.birth_date, p.gender,
              b.id AS breeds_id, b.name AS breed_name,
              s.id AS species_id, s.name AS species_name,
              d.user_id AS doctor_id, d.specialty, d.certificates, d.qualifications, 
              d.years_of_experience, d.biography,
              docu.full_name AS doctor_name
       FROM appointments a
       JOIN users u ON a.customer_id = u.id
       JOIN pets p ON a.pet_id = p.id
       JOIN breeds b ON p.breeds_id = b.id
       JOIN species s ON b.species_id = s.id
       JOIN doctors d ON a.doctor_id = d.user_id
       JOIN users docu ON d.user_id = docu.id
   	order by created_at desc
""";

        List<Appointment> list = new ArrayList<>();

        try (Connection conn = DBContext.getConnection(); PreparedStatement stm = conn.prepareStatement(sql); ResultSet rs = stm.executeQuery()) {

            while (rs.next()) {
                // Tạo Specie
                Specie specie = new Specie(
                        rs.getInt("species_id"),
                        rs.getString("species_name")
                );

                // Tạo Breed
                Breed breed = new Breed(
                        rs.getInt("breeds_id"),
                        specie,
                        rs.getString("breed_name")
                );

                // Tạo User (customer)
                User user = new User();
                user.setId(rs.getString("user_id"));
                user.setUserName(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setFullName(rs.getString("full_name"));
                user.setPhoneNumber(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setAvatar(rs.getString("avatar"));
                user.setStatus(rs.getInt("user_status"));
                user.setRole(new Role(rs.getInt("role_id"), null)); // nếu cần lấy tên role thì JOIN thêm bảng roles

                Pet pet = new Pet();
                pet.setId(rs.getString("pet_id"));
                pet.setPet_code(rs.getString("pet_code"));
                pet.setName(rs.getString("pet_name"));
                pet.setBirthDate(rs.getDate("birth_date"));
                pet.setGender(rs.getString("gender"));
                pet.setBreed(breed);
                pet.setUser(user);

                User doctorUser = new User();
                doctorUser.setId(rs.getString("doctor_id"));
                doctorUser.setFullName(rs.getString("doctor_name"));

                Doctor doctor = new Doctor();
                doctor.setUser(doctorUser);
                doctor.setSpecialty(rs.getString("specialty"));
                doctor.setCertificates(rs.getString("certificates"));
                doctor.setQualifications(rs.getString("qualifications"));
                doctor.setYearsOfExperience(rs.getInt("years_of_experience"));
                doctor.setBiography(rs.getString("biography"));

                // Tạo Appointment
                Appointment appointment = new Appointment();
                appointment.setId(rs.getString("id"));
                appointment.setUser(user);
                appointment.setPet(pet);
                appointment.setDoctor(doctor);
                appointment.setAppointmentDate(rs.getTimestamp("appointment_time"));
                appointment.setStartTime(rs.getTime("start_time") != null ? rs.getTime("start_time").toLocalTime() : null);
                appointment.setEndTime(rs.getTime("end_time") != null ? rs.getTime("end_time").toLocalTime() : null);
                appointment.setStatus(rs.getString("status"));
                appointment.setChekinStatus(rs.getString("checkin_status"));
                appointment.setPaymentStatus(rs.getString("payment_status"));
                appointment.setPaymentMethod(rs.getString("payment_method"));
                appointment.setNote(rs.getString("notes"));
                appointment.setPrice(rs.getDouble("price"));
                appointment.setCreatedAt(rs.getTimestamp("created_at"));
                appointment.setUpdatedAt(rs.getTimestamp("updated_at"));

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
                + "(id, customer_id, pet_id, doctor_id, appointment_time, start_time, end_time,status,payment_method, notes, price) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?)";

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
            stmt.setString(8, appointment.getStatus());
            stmt.setString(9, appointment.getPaymentMethod());

            stmt.setString(10, appointment.getNote() != null ? appointment.getNote() : "");

            stmt.setDouble(11, appointment.getPrice());

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

            String shiftStartTime = null;
            String shiftEndTime = null;

            if (slotId != 0) {
                String sqlShift = "SELECT start_time, end_time FROM shift WHERE shift_id = ?";
                try (PreparedStatement psShift = conn.prepareStatement(sqlShift)) {
                    psShift.setInt(1, slotId);
                    ResultSet rsShift = psShift.executeQuery();
                    if (rsShift.next()) {
                        shiftStartTime = rsShift.getString("start_time");
                        shiftEndTime = rsShift.getString("end_time");
                    }
                }

                if (shiftStartTime != null && shiftEndTime != null) {
                    sql.append(" AND a.start_time >= ? AND a.end_time <= ?");
                }
            }

            if (appointmentDate != null) {
                sql.append(" AND CAST(a.appointment_time AS DATE) = ?");
            }

            if (doctorId != null && !doctorId.isEmpty()) {
                sql.append(" AND a.doctor_id = ?");
            }
            sql.append(" ORDER BY created_at DESC");

            PreparedStatement ps = conn.prepareStatement(sql.toString());

            int index = 1;

            if (shiftStartTime != null && shiftEndTime != null) {
                ps.setString(index++, shiftStartTime);
                ps.setString(index++, shiftEndTime);
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

    public List<Appointment> getAppointmentByStatus(String customerId, String status) {
        List<Appointment> list = new ArrayList<>();
        String sql = "SELECT \n"
                + "    a.id AS appointment_id, a.appointment_time, a.start_time, a.end_time, a.status, a.price,\n"
                + "    a.payment_status, a.payment_method, a.notes, a.created_at, a.updated_at,\n"
                + "\n"
                + "    -- Customer\n"
                + "    u.id AS customer_id, u.full_name AS customer_name, u.email AS customer_email, u.avatar AS customer_avatar,\n"
                + "\n"
                + "    -- Pet\n"
                + "    p.id AS pet_id, p.name AS pet_name, p.pet_code, p.gender, p.birth_date, p.description, p.avatar AS pet_avatar,\n"
                + "    b.id AS breed_id, b.name AS breed_name,\n"
                + "    s.id AS specie_id, s.name AS specie_name,\n"
                + "    p.status AS pet_status,\n"
                + "\n"
                + "    -- Doctor\n"
                + "    d.id AS doctor_id, d.full_name AS doctor_name, d.avatar AS doctor_avatar,\n"
                + "    doc.specialty, doc.certificates, doc.qualifications, doc.years_of_experience, doc.biography\n"
                + "\n"
                + "FROM appointments a\n"
                + "JOIN users u ON a.customer_id = u.id\n"
                + "JOIN pets p ON a.pet_id = p.id\n"
                + "LEFT JOIN breeds b ON p.breeds_id = b.id\n"
                + "LEFT JOIN species s ON b.species_id = s.id\n"
                + "LEFT JOIN users d ON a.doctor_id = d.id\n"
                + "LEFT JOIN doctors doc ON d.id = doc.user_id\n"
                + "WHERE a.customer_id = ? and a.status =?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, customerId);
            ps.setString(2, status);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                // Customer
                User customer = new User();
                customer.setId(rs.getString("customer_id"));
                customer.setFullName(rs.getString("customer_name"));
                customer.setEmail(rs.getString("customer_email"));
                customer.setAvatar(rs.getString("customer_avatar"));

                // Breed & Specie
                Specie specie = new Specie();
                specie.setId(rs.getInt("specie_id"));
                specie.setName(rs.getString("specie_name"));

                Breed breed = new Breed();
                breed.setId(rs.getInt("breed_id"));
                breed.setName(rs.getString("breed_name"));
                breed.setSpecie(specie);

                // Pet
                Pet pet = new Pet();
                pet.setId(rs.getString("pet_id"));
                pet.setName(rs.getString("pet_name"));
                pet.setPet_code(rs.getString("pet_code"));
                pet.setGender(rs.getString("gender"));
                pet.setBirthDate(rs.getDate("birth_date"));
                pet.setDescription(rs.getString("description"));
                pet.setAvatar(rs.getString("pet_avatar"));
                pet.setStatus(rs.getString("pet_status"));
                pet.setBreed(breed);
                pet.setUser(customer);

                // Doctor
                Doctor doctor = new Doctor();
                User doctorUser = new User();
                doctorUser.setId(rs.getString("doctor_id"));
                doctorUser.setFullName(rs.getString("doctor_name"));
                doctorUser.setAvatar(rs.getString("doctor_avatar"));
                doctor.setUser(doctorUser);
                doctor.setSpecialty(rs.getString("specialty"));
                doctor.setCertificates(rs.getString("certificates"));
                doctor.setQualifications(rs.getString("qualifications"));
                doctor.setYearsOfExperience(rs.getInt("years_of_experience"));
                doctor.setBiography(rs.getString("biography"));

                // Appointment
                Appointment appointment = new Appointment();
                appointment.setId(rs.getString("appointment_id"));
                appointment.setUser(customer);
                appointment.setPet(pet);
                appointment.setDoctor(doctor);
                appointment.setAppointmentDate(rs.getTimestamp("appointment_time"));
                appointment.setStartTime(rs.getTime("start_time").toLocalTime());
                appointment.setEndTime(rs.getTime("end_time") != null ? rs.getTime("end_time").toLocalTime() : null);
                appointment.setStatus(rs.getString("status"));
                appointment.setPrice(rs.getDouble("price"));
                appointment.setPaymentStatus(rs.getString("payment_status"));
                appointment.setPaymentMethod(rs.getString("payment_method"));
                appointment.setNote(rs.getString("notes"));
                appointment.setCreatedAt(rs.getTimestamp("created_at"));
                appointment.setUpdatedAt(rs.getTimestamp("updated_at"));

                list.add(appointment);
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public List<Appointment> getAppointmentByPetName(String customerId, String name) {
        List<Appointment> list = new ArrayList<>();
        String sql = "SELECT \n"
                + "    a.id AS appointment_id, a.appointment_time, a.start_time, a.end_time, a.status, a.price,\n"
                + "    a.payment_status, a.payment_method, a.notes, a.created_at, a.updated_at,\n"
                + "\n"
                + "    -- Customer\n"
                + "    u.id AS customer_id, u.full_name AS customer_name, u.email AS customer_email, u.avatar AS customer_avatar,\n"
                + "\n"
                + "    -- Pet\n"
                + "    p.id AS pet_id, p.name AS pet_name, p.pet_code, p.gender, p.birth_date, p.description, p.avatar AS pet_avatar,\n"
                + "    b.id AS breed_id, b.name AS breed_name,\n"
                + "    s.id AS specie_id, s.name AS specie_name,\n"
                + "    p.status AS pet_status,\n"
                + "\n"
                + "    -- Doctor\n"
                + "    d.id AS doctor_id, d.full_name AS doctor_name, d.avatar AS doctor_avatar,\n"
                + "    doc.specialty, doc.certificates, doc.qualifications, doc.years_of_experience, doc.biography\n"
                + "\n"
                + "FROM appointments a\n"
                + "JOIN users u ON a.customer_id = u.id\n"
                + "JOIN pets p ON a.pet_id = p.id\n"
                + "LEFT JOIN breeds b ON p.breeds_id = b.id\n"
                + "LEFT JOIN species s ON b.species_id = s.id\n"
                + "LEFT JOIN users d ON a.doctor_id = d.id\n"
                + "LEFT JOIN doctors doc ON d.id = doc.user_id\n"
                + "WHERE a.customer_id = ? and p.name =?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, customerId);
            ps.setString(2, name);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                // Customer
                User customer = new User();
                customer.setId(rs.getString("customer_id"));
                customer.setFullName(rs.getString("customer_name"));
                customer.setEmail(rs.getString("customer_email"));
                customer.setAvatar(rs.getString("customer_avatar"));

                // Breed & Specie
                Specie specie = new Specie();
                specie.setId(rs.getInt("specie_id"));
                specie.setName(rs.getString("specie_name"));

                Breed breed = new Breed();
                breed.setId(rs.getInt("breed_id"));
                breed.setName(rs.getString("breed_name"));
                breed.setSpecie(specie);

                // Pet
                Pet pet = new Pet();
                pet.setId(rs.getString("pet_id"));
                pet.setName(rs.getString("pet_name"));
                pet.setPet_code(rs.getString("pet_code"));
                pet.setGender(rs.getString("gender"));
                pet.setBirthDate(rs.getDate("birth_date"));
                pet.setDescription(rs.getString("description"));
                pet.setAvatar(rs.getString("pet_avatar"));
                pet.setStatus(rs.getString("pet_status"));
                pet.setBreed(breed);
                pet.setUser(customer);

                // Doctor
                Doctor doctor = new Doctor();
                User doctorUser = new User();
                doctorUser.setId(rs.getString("doctor_id"));
                doctorUser.setFullName(rs.getString("doctor_name"));
                doctorUser.setAvatar(rs.getString("doctor_avatar"));
                doctor.setUser(doctorUser);
                doctor.setSpecialty(rs.getString("specialty"));
                doctor.setCertificates(rs.getString("certificates"));
                doctor.setQualifications(rs.getString("qualifications"));
                doctor.setYearsOfExperience(rs.getInt("years_of_experience"));
                doctor.setBiography(rs.getString("biography"));

                // Appointment
                Appointment appointment = new Appointment();
                appointment.setId(rs.getString("appointment_id"));
                appointment.setUser(customer);
                appointment.setPet(pet);
                appointment.setDoctor(doctor);
                appointment.setAppointmentDate(rs.getTimestamp("appointment_time"));
                appointment.setStartTime(rs.getTime("start_time").toLocalTime());
                appointment.setEndTime(rs.getTime("end_time") != null ? rs.getTime("end_time").toLocalTime() : null);
                appointment.setStatus(rs.getString("status"));
                appointment.setPrice(rs.getDouble("price"));
                appointment.setPaymentStatus(rs.getString("payment_status"));
                appointment.setPaymentMethod(rs.getString("payment_method"));
                appointment.setNote(rs.getString("notes"));
                appointment.setCreatedAt(rs.getTimestamp("created_at"));
                appointment.setUpdatedAt(rs.getTimestamp("updated_at"));

                list.add(appointment);
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public List<Appointment> getAppointmentByDate(String customerId, Date dateFrom, Date dateTo) {
        List<Appointment> list = new ArrayList<>();
        String sql = "SELECT \n"
                + "    a.id AS appointment_id, a.appointment_time, a.start_time, a.end_time, a.status, a.price,\n"
                + "    a.payment_status, a.payment_method, a.notes, a.created_at, a.updated_at,\n"
                + "\n"
                + "    -- Customer\n"
                + "    u.id AS customer_id, u.full_name AS customer_name, u.email AS customer_email, u.avatar AS customer_avatar,\n"
                + "\n"
                + "    -- Pet\n"
                + "    p.id AS pet_id, p.name AS pet_name, p.pet_code, p.gender, p.birth_date, p.description, p.avatar AS pet_avatar,\n"
                + "    b.id AS breed_id, b.name AS breed_name,\n"
                + "    s.id AS specie_id, s.name AS specie_name,\n"
                + "    p.status AS pet_status,\n"
                + "\n"
                + "    -- Doctor\n"
                + "    d.id AS doctor_id, d.full_name AS doctor_name, d.avatar AS doctor_avatar,\n"
                + "    doc.specialty, doc.certificates, doc.qualifications, doc.years_of_experience, doc.biography\n"
                + "\n"
                + "FROM appointments a\n"
                + "JOIN users u ON a.customer_id = u.id\n"
                + "JOIN pets p ON a.pet_id = p.id\n"
                + "LEFT JOIN breeds b ON p.breeds_id = b.id\n"
                + "LEFT JOIN species s ON b.species_id = s.id\n"
                + "LEFT JOIN users d ON a.doctor_id = d.id\n"
                + "LEFT JOIN doctors doc ON d.id = doc.user_id\n"
                + "WHERE a.customer_id = ? AND (? IS NULL OR CAST(appointment_time AS DATE) >= ?) AND (? IS NULL OR CAST(appointment_time AS DATE) < ?)";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, customerId);

            ps.setObject(2, dateFrom);
            ps.setObject(3, dateFrom);
            ps.setObject(4, dateTo);
            ps.setObject(5, dateTo);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                // Customer
                User customer = new User();
                customer.setId(rs.getString("customer_id"));
                customer.setFullName(rs.getString("customer_name"));
                customer.setEmail(rs.getString("customer_email"));
                customer.setAvatar(rs.getString("customer_avatar"));

                // Breed & Specie
                Specie specie = new Specie();
                specie.setId(rs.getInt("specie_id"));
                specie.setName(rs.getString("specie_name"));

                Breed breed = new Breed();
                breed.setId(rs.getInt("breed_id"));
                breed.setName(rs.getString("breed_name"));
                breed.setSpecie(specie);

                // Pet
                Pet pet = new Pet();
                pet.setId(rs.getString("pet_id"));
                pet.setName(rs.getString("pet_name"));
                pet.setPet_code(rs.getString("pet_code"));
                pet.setGender(rs.getString("gender"));
                pet.setBirthDate(rs.getDate("birth_date"));
                pet.setDescription(rs.getString("description"));
                pet.setAvatar(rs.getString("pet_avatar"));
                pet.setStatus(rs.getString("pet_status"));
                pet.setBreed(breed);
                pet.setUser(customer);

                // Doctor
                Doctor doctor = new Doctor();
                User doctorUser = new User();
                doctorUser.setId(rs.getString("doctor_id"));
                doctorUser.setFullName(rs.getString("doctor_name"));
                doctorUser.setAvatar(rs.getString("doctor_avatar"));
                doctor.setUser(doctorUser);
                doctor.setSpecialty(rs.getString("specialty"));
                doctor.setCertificates(rs.getString("certificates"));
                doctor.setQualifications(rs.getString("qualifications"));
                doctor.setYearsOfExperience(rs.getInt("years_of_experience"));
                doctor.setBiography(rs.getString("biography"));

                // Appointment
                Appointment appointment = new Appointment();
                appointment.setId(rs.getString("appointment_id"));
                appointment.setUser(customer);
                appointment.setPet(pet);
                appointment.setDoctor(doctor);
                appointment.setAppointmentDate(rs.getTimestamp("appointment_time"));
                appointment.setStartTime(rs.getTime("start_time").toLocalTime());
                appointment.setEndTime(rs.getTime("end_time") != null ? rs.getTime("end_time").toLocalTime() : null);
                appointment.setStatus(rs.getString("status"));
                appointment.setPrice(rs.getDouble("price"));
                appointment.setPaymentStatus(rs.getString("payment_status"));
                appointment.setPaymentMethod(rs.getString("payment_method"));
                appointment.setNote(rs.getString("notes"));
                appointment.setCreatedAt(rs.getTimestamp("created_at"));
                appointment.setUpdatedAt(rs.getTimestamp("updated_at"));

                list.add(appointment);
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public boolean updateAppointment(Appointment appointment) {
        String sql = "UPDATE appointments SET doctor_id = ?, appointment_time = ?, start_time = ?, end_time = ?,  payment_status = ? WHERE id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, appointment.getDoctor().getUser().getId());
            ps.setTimestamp(2, new Timestamp(appointment.getAppointmentDate().getTime()));
            ps.setTime(3, Time.valueOf(appointment.getStartTime()));
            ps.setTime(4, Time.valueOf(appointment.getEndTime()));
            ps.setString(5, appointment.getPaymentStatus());
            ps.setString(6, appointment.getId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateCheckinStatus(String appointmentId) {
        String sql = "UPDATE appointments SET checkin_status = 'checkin' WHERE id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, appointmentId);
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Appointment> getAppointmentByCustomer(String customerId) {
        List<Appointment> list = new ArrayList<>();
        String sql = "SELECT \n"
                + "    a.id AS appointment_id, a.appointment_time, a.start_time, a.end_time, a.status, a.price,\n"
                + "    a.payment_status, a.payment_method, a.notes, a.created_at, a.updated_at,\n"
                + "\n"
                + "    -- Customer\n"
                + "    u.id AS customer_id, u.full_name AS customer_name, u.email AS customer_email, u.avatar AS customer_avatar,\n"
                + "\n"
                + "    -- Pet\n"
                + "    p.id AS pet_id, p.name AS pet_name, p.pet_code, p.gender, p.birth_date, p.description, p.avatar AS pet_avatar,\n"
                + "    b.id AS breed_id, b.name AS breed_name,\n"
                + "    s.id AS specie_id, s.name AS specie_name,\n"
                + "    p.status AS pet_status,\n"
                + "\n"
                + "    -- Doctor\n"
                + "    d.id AS doctor_id, d.full_name AS doctor_name, d.avatar AS doctor_avatar,\n"
                + "    doc.specialty, doc.certificates, doc.qualifications, doc.years_of_experience, doc.biography\n"
                + "\n"
                + "FROM appointments a\n"
                + "JOIN users u ON a.customer_id = u.id\n"
                + "JOIN pets p ON a.pet_id = p.id\n"
                + "LEFT JOIN breeds b ON p.breeds_id = b.id\n"
                + "LEFT JOIN species s ON b.species_id = s.id\n"
                + "LEFT JOIN users d ON a.doctor_id = d.id\n"
                + "LEFT JOIN doctors doc ON d.id = doc.user_id\n"
                + "WHERE a.customer_id = ?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, customerId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                // Customer
                User customer = new User();
                customer.setId(rs.getString("customer_id"));
                customer.setFullName(rs.getString("customer_name"));
                customer.setEmail(rs.getString("customer_email"));
                customer.setAvatar(rs.getString("customer_avatar"));

                // Breed & Specie
                Specie specie = new Specie();
                specie.setId(rs.getInt("specie_id"));
                specie.setName(rs.getString("specie_name"));

                Breed breed = new Breed();
                breed.setId(rs.getInt("breed_id"));
                breed.setName(rs.getString("breed_name"));
                breed.setSpecie(specie);

                // Pet
                Pet pet = new Pet();
                pet.setId(rs.getString("pet_id"));
                pet.setName(rs.getString("pet_name"));
                pet.setPet_code(rs.getString("pet_code"));
                pet.setGender(rs.getString("gender"));
                pet.setBirthDate(rs.getDate("birth_date"));
                pet.setDescription(rs.getString("description"));
                pet.setAvatar(rs.getString("pet_avatar"));
                pet.setStatus(rs.getString("pet_status"));
                pet.setBreed(breed);
                pet.setUser(customer);

                // Doctor
                Doctor doctor = new Doctor();
                User doctorUser = new User();
                doctorUser.setId(rs.getString("doctor_id"));
                doctorUser.setFullName(rs.getString("doctor_name"));
                doctorUser.setAvatar(rs.getString("doctor_avatar"));
                doctor.setUser(doctorUser);
                doctor.setSpecialty(rs.getString("specialty"));
                doctor.setCertificates(rs.getString("certificates"));
                doctor.setQualifications(rs.getString("qualifications"));
                doctor.setYearsOfExperience(rs.getInt("years_of_experience"));
                doctor.setBiography(rs.getString("biography"));

                // Appointment
                Appointment appointment = new Appointment();
                appointment.setId(rs.getString("appointment_id"));
                appointment.setUser(customer);
                appointment.setPet(pet);
                appointment.setDoctor(doctor);
                appointment.setAppointmentDate(rs.getTimestamp("appointment_time"));
                appointment.setStartTime(rs.getTime("start_time").toLocalTime());
                appointment.setEndTime(rs.getTime("end_time") != null ? rs.getTime("end_time").toLocalTime() : null);
                appointment.setStatus(rs.getString("status"));
                appointment.setPrice(rs.getDouble("price"));
                appointment.setPaymentStatus(rs.getString("payment_status"));
                appointment.setPaymentMethod(rs.getString("payment_method"));
                appointment.setNote(rs.getString("notes"));
                appointment.setCreatedAt(rs.getTimestamp("created_at"));
                appointment.setUpdatedAt(rs.getTimestamp("updated_at"));

                list.add(appointment);
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }
        // CỦA ĐẠI
    

    
    //Lấy tổng cuộc họp theo ca của ngày của bác si
    public int getTotalAppointments(String doctorId, Date workDate, int shiftId) {
        int total = 0;
        String sql = """
    SELECT COUNT(*) 
    FROM appointments a
    JOIN doctor_schedule ds ON a.doctor_id = ds.doctor_id
    JOIN shift s ON ds.shift_id = s.shift_id
    WHERE a.doctor_id = ?
      AND ds.work_date = ?
      AND ds.shift_id = ?
      AND CONVERT(DATE, a.appointment_time) = ds.work_date
      AND a.start_time BETWEEN s.start_time AND s.end_time
    """;
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, doctorId);
            ps.setDate(2, new java.sql.Date(workDate.getTime()));
            ps.setInt(3, shiftId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1); // Get the count of appointments
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }

    

    
   
    

    public List<Appointment> getAppointmentDetailsByDoctorAndAppointment( String appointmentId) {
        List<Appointment> list = new ArrayList<>();
        String sql = """
        SELECT
            a.status as a_status, notes, a.appointment_time as app_time, start_time, end_time,       
            u.full_name AS owner_name, u.avatar as u_avatar,
            u.phone AS owner_phone,
            u.email AS owner_email,
            u.address AS owner_address,
            p.pet_code AS pet_code,p.id as pet_id,  -- Mã pet để phân biệt pet trùng tên
            p.name AS pet_name,p.description as p_desc,a.doctor_id,
            p.gender AS pet_gender,
            p.birth_date AS pet_birth_date,
            p.avatar AS pet_avatar,
            b.name AS breed_name,
            s.name AS species_name
        FROM appointments a
        JOIN users u ON a.customer_id = u.id
        JOIN pets p ON a.pet_id = p.id
        JOIN breeds b ON p.breeds_id = b.id
        JOIN species s ON b.species_id = s.id
        WHERE a.id = ?;
        """;

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, appointmentId);      // Set appointment_id vào câu lệnh SQL

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                // Lấy thông tin của chủ pet
                User user = new User();
                user.setFullName(rs.getString("owner_name"));
                user.setPhoneNumber(rs.getString("owner_phone"));
                user.setEmail(rs.getString("owner_email"));
                user.setAddress(rs.getString("owner_address"));
                user.setAvatar(rs.getString("u_avatar"));

                // Lấy thông tin giống loài
                Breed breed = new Breed();
                breed.setName(rs.getString("breed_name"));
                // Lấy thông tin loài
                Specie species = new Specie();
                species.setName(rs.getString("species_name"));
                breed.setSpecie(species);

                // Lấy thông tin pet
                Pet pet = new Pet();
                pet.setPet_code(rs.getString("pet_code"));
                pet.setName(rs.getString("pet_name"));
                pet.setGender(rs.getString("pet_gender"));
                pet.setBirthDate(rs.getDate("pet_birth_date"));
                pet.setAvatar(rs.getString("pet_avatar"));
                pet.setBreed(breed);
                pet.setDescription(rs.getString("p_desc"));
                pet.setUser(user);
                pet.setId(rs.getString("pet_id"));
                

                // Tạo đối tượng Appointment và gắn thông tin
                Appointment appt = new Appointment();
                appt.setUser(user);
                appt.setPet(pet);
                appt.setNote(rs.getString("notes"));
                appt.setStartTime(rs.getTime("start_time").toLocalTime());
                appt.setEndTime(rs.getTime("end_time").toLocalTime());
                appt.setAppointmentDate(rs.getDate("app_time"));
                appt.setStatus(rs.getString("a_status"));
                User doc = new User(rs.getString("doctor_id"));
                Doctor doctor = new Doctor();
                doctor.setUser(doc);
                appt.setDoctor(doctor);
                // Thêm vào danh sách kết quả
                list.add(appt);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

/// API LẤY CUỘC HẸN THEO TUẦN
    public List<Appointment> getAppointmentsByWeek(String doctorId, Date startOfWeek, Date endOfWeek) {
        List<Appointment> list = new ArrayList<>();
        String sql = """
        SELECT 
            a.id as a_id,a.status as a_status,start_time,end_time,notes,appointment_time,a.doctor_id,a.checkin_status,      
            u.id as user_id, u.full_name, u.avatar as user_avatar,address,phone,email,
            p.id as pet_id, p.birth_date as pet_birth, p.avatar as pet_avatar, p.pet_code as pet_code,p.name as pet_name,
            p.gender as pet_gender,p.description as pet_description,
            b.name as breed_name,
            s.name AS species_name
        FROM appointments a
        JOIN users u ON a.customer_id = u.id
        JOIN pets p ON a.pet_id = p.id
        JOIN breeds b ON p.breeds_id = b.id
        JOIN species s ON b.species_id = s.id
        WHERE a.doctor_id = ? 
        AND a.appointment_time BETWEEN ? AND ?
        ORDER BY a.appointment_time
        """;

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, doctorId);
            ps.setTimestamp(2, new Timestamp(startOfWeek.getTime()));
            ps.setTimestamp(3, new Timestamp(endOfWeek.getTime()));

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getString("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setAvatar(rs.getString("user_avatar"));
                user.setAddress(rs.getString("address"));
                user.setPhoneNumber(rs.getString("phone"));
                user.setEmail(rs.getString("email"));

                // Lấy thông tin giống loài
                Breed breed = new Breed();
                breed.setName(rs.getString("breed_name"));
                Specie specie = new Specie();

                // Lấy thông tin pet
                Pet pet = new Pet();
                pet.setId(rs.getString("pet_id"));
                pet.setGender(rs.getString("pet_gender"));
                pet.setAvatar(rs.getString("pet_avatar"));
                pet.setPet_code(rs.getString("pet_code"));
                pet.setDescription(rs.getString("pet_description"));
                pet.setBirthDate(rs.getDate("pet_birth"));
                pet.setBreed(breed);
                pet.setUser(user);
                pet.setName(rs.getString("pet_name"));

                // Tạo đối tượng Appointment
                Appointment appt = new Appointment();
                appt.setId(rs.getString("a_id"));
                User doctor = new User();
                doctor.setId(doctorId);
                Doctor d =new Doctor();
                d.setUser(doctor);
                appt.setDoctor(d);
                appt.setUser(user);
                appt.setPet(pet);
                appt.setAppointmentDate(rs.getTimestamp("appointment_time"));
                appt.setStartTime(rs.getTime("start_time").toLocalTime());
                appt.setEndTime(rs.getTime("end_time").toLocalTime());
                appt.setStatus(rs.getString("a_status"));
                appt.setNote(rs.getString("notes"));
                appt.setChekinStatus(rs.getString("checkin_status"));

                // Thêm vào danh sách
                list.add(appt);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public boolean updateStatus(String appointmentId, String status) {
        String sql = "UPDATE appointments SET status = ? WHERE id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setString(2, appointmentId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
// HẾT CỦA ĐẠI

    public int countAppointments() {
        String sql = "SELECT COUNT(*) FROM appointments";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public boolean requestCancelWithAdmin(String id) {
        String sql = "Update appointments set status ='cancel_requested' where id =? ;";
        try {
            Connection conn = DAO.DBContext.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, id);

            int check = stmt.executeUpdate();
            if (check > 0) {
                return true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean apprpoveBooking(String id) {
        String sql = "UPDATE appointments SET status = 'canceled' WHERE id = ?";
        try (Connection con = DBContext.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, id);
            int row = ps.executeUpdate();
            return row > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

public void autoCancelAppointments() {
    String sql = """
        UPDATE appointments
        SET status = 'canceled'
        WHERE appointment_time < GETDATE()
          AND status = 'booked'
          AND checkin_status = 'noshow'
    """;

    try (Connection conn = DBContext.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
}


public List<Appointment> getAppointmentByCustomer(String customerId, String petName, String status, Date fromDate, Date toDate, int page, int pageSize) {
        List<Appointment> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder("""
        SELECT 
            a.id AS appointment_id, a.appointment_time, a.start_time, a.end_time, a.status, a.price,
            a.payment_status, a.payment_method, a.notes, a.created_at, a.updated_at,

            u.id AS customer_id, u.full_name AS customer_name, u.email AS customer_email, u.avatar AS customer_avatar,

            p.id AS pet_id, p.name AS pet_name, p.pet_code, p.gender, p.birth_date, p.description, p.avatar AS pet_avatar,
            b.id AS breed_id, b.name AS breed_name,
            s.id AS specie_id, s.name AS specie_name,
            p.status AS pet_status,

            d.id AS doctor_id, d.full_name AS doctor_name, d.avatar AS doctor_avatar,
            doc.specialty, doc.certificates, doc.qualifications, doc.years_of_experience, doc.biography

        FROM appointments a
        JOIN users u ON a.customer_id = u.id
        JOIN pets p ON a.pet_id = p.id
        LEFT JOIN breeds b ON p.breeds_id = b.id
        LEFT JOIN species s ON b.species_id = s.id
        LEFT JOIN users d ON a.doctor_id = d.id
        LEFT JOIN doctors doc ON d.id = doc.user_id
        WHERE a.customer_id = ?
    """);

        // Xử lý các filter động
        if (petName != null && !petName.trim().isEmpty()) {
            sql.append(" AND p.name LIKE ? ");
        }
        if (status != null && !status.trim().isEmpty()) {
            sql.append(" AND a.status = ? ");
        }
        if (fromDate != null) {
            sql.append(" AND a.appointment_time >= ? ");
        }
        if (toDate != null) {
            sql.append(" AND a.appointment_time <= ? ");
        }

        sql.append(" ORDER BY a.created_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY ");

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int paramIndex = 1;
            ps.setString(paramIndex++, customerId);

            if (petName != null && !petName.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + petName + "%");
            }
            if (status != null && !status.trim().isEmpty()) {
                ps.setString(paramIndex++, status);
            }
            if (fromDate != null) {
                ps.setDate(paramIndex++, new java.sql.Date(fromDate.getTime()));
            }
            if (toDate != null) {
                ps.setDate(paramIndex++, new java.sql.Date(toDate.getTime()));
            }

            // Phân trang
            int offset = (page - 1) * pageSize;
            ps.setInt(paramIndex++, offset);
            ps.setInt(paramIndex, pageSize);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                // Customer
                User customer = new User();
                customer.setId(rs.getString("customer_id"));
                customer.setFullName(rs.getString("customer_name"));
                customer.setEmail(rs.getString("customer_email"));
                customer.setAvatar(rs.getString("customer_avatar"));

                // Breed & Specie
                Specie specie = new Specie();
                specie.setId(rs.getInt("specie_id"));
                specie.setName(rs.getString("specie_name"));

                Breed breed = new Breed();
                breed.setId(rs.getInt("breed_id"));
                breed.setName(rs.getString("breed_name"));
                breed.setSpecie(specie);

                // Pet
                Pet pet = new Pet();
                pet.setId(rs.getString("pet_id"));
                pet.setName(rs.getString("pet_name"));
                pet.setPet_code(rs.getString("pet_code"));
                pet.setGender(rs.getString("gender"));
                pet.setBirthDate(rs.getDate("birth_date"));
                pet.setDescription(rs.getString("description"));
                pet.setAvatar(rs.getString("pet_avatar"));
                pet.setStatus(rs.getString("pet_status"));
                pet.setBreed(breed);
                pet.setUser(customer);

                // Doctor
                Doctor doctor = new Doctor();
                User doctorUser = new User();
                doctorUser.setId(rs.getString("doctor_id"));
                doctorUser.setFullName(rs.getString("doctor_name"));
                doctorUser.setAvatar(rs.getString("doctor_avatar"));
                doctor.setUser(doctorUser);
                doctor.setSpecialty(rs.getString("specialty"));
                doctor.setCertificates(rs.getString("certificates"));
                doctor.setQualifications(rs.getString("qualifications"));
                doctor.setYearsOfExperience(rs.getInt("years_of_experience"));
                doctor.setBiography(rs.getString("biography"));

                // Appointment
                Appointment appointment = new Appointment();
                appointment.setId(rs.getString("appointment_id"));
                appointment.setUser(customer);
                appointment.setPet(pet);
                appointment.setDoctor(doctor);
                appointment.setAppointmentDate(rs.getTimestamp("appointment_time"));
                appointment.setStartTime(rs.getTime("start_time").toLocalTime());
                appointment.setEndTime(rs.getTime("end_time") != null ? rs.getTime("end_time").toLocalTime() : null);
                appointment.setStatus(rs.getString("status"));
                appointment.setPrice(rs.getDouble("price"));
                appointment.setPaymentStatus(rs.getString("payment_status"));
                appointment.setPaymentMethod(rs.getString("payment_method"));
                appointment.setNote(rs.getString("notes"));
                appointment.setCreatedAt(rs.getTimestamp("created_at"));
                appointment.setUpdatedAt(rs.getTimestamp("updated_at"));

                list.add(appointment);
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }


public int countAppointmentByCustomer(String customerId, String petName, String status, Date fromDate, Date toDate) {
        int count = 0;

        StringBuilder sql = new StringBuilder("""
        SELECT COUNT(*) AS total
        FROM appointments a
        JOIN pets p ON a.pet_id = p.id
        WHERE a.customer_id = ?
    """);

        List<Object> params = new ArrayList<>();
        params.add(customerId);

        if (petName != null && !petName.trim().isEmpty()) {
            sql.append(" AND p.name LIKE ? ");
            params.add("%" + petName.trim() + "%");
        }
        if (status != null && !status.trim().isEmpty()) {
            sql.append(" AND a.status = ? ");
            params.add(status.trim());
        }
        if (fromDate != null) {
            sql.append(" AND a.appointment_time >= ? ");
            params.add(new java.sql.Timestamp(fromDate.getTime()));
        }
        if (toDate != null) {
            sql.append(" AND a.appointment_time <= ? ");
            params.add(new java.sql.Timestamp(toDate.getTime()));
        }

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt("total");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    public static void main(String[] args) {
        AppointmentDAO dao = new AppointmentDAO(); // hoặc tên DAO thật sự bạn đang dùng
        List<Appointment> appointments = dao.getAllAppointment();

        for (Appointment appt : appointments) {
            System.out.println("==== Appointment ID: " + appt.getId() + " ====");
            System.out.println("Customer: " + appt.getUser().getFullName() + " (" + appt.getUser().getEmail() + ")");
            System.out.println("Pet: " + appt.getPet().getName() + " - Breed: " + appt.getPet().getBreed().getName());
            System.out.println("Species: " + appt.getPet().getBreed().getSpecie().getName());
            System.out.println("Doctor: " + appt.getDoctor().getUser().getFullName() + " - Specialty: " + appt.getDoctor().getSpecialty());
            System.out.println("Date: " + appt.getAppointmentDate());
            System.out.println("Time: " + appt.getStartTime() + " - " + appt.getEndTime());
            System.out.println("Status: " + appt.getStatus());
            System.out.println("Payment: " + appt.getPaymentStatus() + " via " + appt.getPaymentMethod());
            System.out.println("Note: " + appt.getNote());
            System.out.println("Check-in: " + appt.getChekinStatus());
            System.out.println("Price: " + appt.getPrice());
            System.out.println("----------------------------------------");
        }

        if (appointments.isEmpty()) {
            System.out.println("No appointments found.");
        }
    }
}
