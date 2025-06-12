package DAO;

import Model.Appointment;
import Model.Breed;
import Model.Doctor;
import Model.Pet;
import Model.Specie;
import Model.User;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class AppointmentDAO {

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

    // CỦA ĐẠI
    public List<Appointment> getAppointmentsBySchedule(String doctorId, Date workDate, int shiftId) {
        List<Appointment> list = new ArrayList<>();
        String sql = """
        SELECT a.*,      
               u.id as user_id, u.full_name, u.avatar as user_avatar,
               p.id as pet_id, p.birth_date as pet_birth, p.avatar as pet_avatar, p.pet_code as pet_code,
               p.gender as pet_gender,p.description as pet_description,
               b.name as breed_name,
               s.start_time as shift_start, s.end_time as shift_end
        FROM appointments a
        JOIN users u ON a.customer_id = u.id
        JOIN pets p ON a.pet_id = p.id
        JOIN breeds b ON b.id = p.breeds_id
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
            while (rs.next()) {
                // User
                User user = new User();
                user.setId(rs.getString("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setAvatar(rs.getString("user_avatar"));
                // Breed
                Breed breed = new Breed();
                breed.setName(rs.getString("breed_name"));
// Pet
                Pet pet = new Pet();
                pet.setId(rs.getString("pet_id"));
                pet.setGender(rs.getString("pet_gender"));
                pet.setAvatar(rs.getString("pet_avatar"));
                pet.setPet_code(rs.getString("pet_code"));
                pet.setDescription(rs.getString("pet_description"));
                pet.setBirthDate(rs.getDate("pet_birth"));
                pet.setBreed(breed);
                // Doctor (có thể lấy thêm nếu cần)

                // Appointment
                Appointment appt = new Appointment();
                appt.setId(rs.getString("id"));
                appt.setUser(user);
                appt.setPet(pet);
                appt.setAppointmentDate(rs.getTimestamp("appointment_time"));
                appt.setStartTime(rs.getTime("start_time").toLocalTime());
                appt.setEndTime(rs.getTime("end_time").toLocalTime());
                appt.setStatus(rs.getString("status"));
                appt.setNote(rs.getString("notes"));
                list.add(appt);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // LẤY DANH SÁCH PET THEO DOCTOR VÀ PET
    public List<Appointment> getAppointmentByDoctorAndDate(String doctorId, java.sql.Date date) {
        List<Appointment> list = new ArrayList<>();
        String sql = "SELECT DISTINCT p.*, u.full_name AS user_name, a.id AS apm_id, a.doctor_id AS doctor_id "
                + "FROM appointments a "
                + "JOIN pets p ON a.pet_id = p.id "
                + "JOIN users u ON u.id = p.owner_id "
                + "LEFT JOIN medical_records mr ON a.id = mr.appointment_id "
                + "WHERE a.doctor_id = ? "
                + "AND CAST(a.appointment_time AS DATE) = ? "
                + "AND mr.appointment_id IS NULL";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, doctorId);
            ps.setDate(2, date);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setFullName(rs.getString("user_name"));
                Pet pet = new Pet();
                pet.setUser(user);
                pet.setId(rs.getString("id"));
                pet.setPet_code(rs.getString("pet_code"));
                pet.setName(rs.getString("name"));
                pet.setGender(rs.getString("gender"));
                pet.setBirthDate(rs.getDate("birth_date"));
                pet.setDescription(rs.getString("description"));
                pet.setAvatar(rs.getString("avatar"));
                // Set owner, breed nếu bạn dùng đối tượng lồng (tùy thiết kế)
                Doctor d = new Doctor();
                user.setId(rs.getString("doctor_id"));
                Appointment a = new Appointment();
                a.setId(rs.getString("apm_id"));
                a.setDoctor(d);
                a.setPet(pet);
                list.add(a);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
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
                appointment.setPrice(rs.getInt("price"));
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
                appointment.setPrice(rs.getInt("price"));
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
                appointment.setPrice(rs.getInt("price"));
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
                appointment.setPrice(rs.getInt("price"));
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

    public boolean cancelBooking(String id) {
        String sql = "Update appointments set status ='canceled' where id =? ;";
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

    // HẾT CỦA ĐẠI
    public static void main(String[] args) throws ParseException {
        SimpleDateFormat dailo = new SimpleDateFormat("yyyy-MM-dd");

        Date dateto = dailo.parse("2025-06-20");
        List<Appointment> pets = new AppointmentDAO().getAppointmentByDate("573C2A95-E231-43C0-A784-7CA8DA43206E", null, dateto);
        for (Appointment pet : pets) {
            System.out.println(pet);
        }
    }

}
