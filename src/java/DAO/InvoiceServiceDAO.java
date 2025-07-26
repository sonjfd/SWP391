/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Appointment;
import Model.Breed;
import Model.Doctor;
import Model.InvoiceService;
import Model.InvoiceServiceItem;
import Model.Pet;
import Model.Service;
import Model.Specie;
import Model.User;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 *
 * @author Dell
 */
public class InvoiceServiceDAO {

    public List<InvoiceService> getAllInvoice() {
        List<InvoiceService> invoices = new ArrayList<>();

        String sql = """
    SELECT 
      i.id AS invoice_id, 
      i.payment_status, 
      i.payment_method, 
      i.paid_at, 
      i.created_at, 
      i.updated_at, 
      a.appointment_time, 
      a.start_time, 
      a.end_time, 
      a.notes, 
      p.name AS pet_name, 
      p.pet_code, 
      cus.full_name AS customer_name, 
      cus.phone AS phone, 
      cus.address AS address, 
      doc.full_name AS doctor_name, 
      s.name AS service_name, 
      aps.price AS service_price,  -- ✅ lấy giá tại thời điểm thực hiện
      breed.name AS breed_name, 
      specie.name AS specie_name 
    FROM invoices i
    JOIN appointments a ON i.appointment_id = a.id
    JOIN pets p ON a.pet_id = p.id
    JOIN breeds breed ON p.breeds_id = breed.id
    JOIN species specie ON breed.species_id = specie.id
    JOIN users cus ON a.customer_id = cus.id
    JOIN doctors d ON a.doctor_id = d.user_id
    JOIN users doc ON d.user_id = doc.id
    JOIN appointment_services aps ON a.id = aps.appointment_id
    JOIN services s ON aps.service_id = s.id
                     order by created_at desc
    """;

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            Map<String, InvoiceService> invoiceMap = new LinkedHashMap<>();

            while (rs.next()) {
                String invoiceId = rs.getString("invoice_id");
                InvoiceService invoice = invoiceMap.get(invoiceId);

                if (invoice == null) {
                    invoice = new InvoiceService();
                    invoice.setId(invoiceId);
                    invoice.setPaymentStatus(rs.getString("payment_status"));
                    invoice.setPaymentMethod(rs.getString("payment_method"));
                    invoice.setPaidAt(rs.getTimestamp("paid_at"));
                    invoice.setCreateDate(rs.getTimestamp("created_at"));
                    invoice.setUpdateDate(rs.getTimestamp("updated_at"));

                    // Appointment
                    Appointment app = new Appointment();
                    app.setAppointmentDate(rs.getTimestamp("appointment_time"));
                    app.setStartTime(rs.getTime("start_time").toLocalTime());
                    app.setEndTime(rs.getTime("end_time").toLocalTime());
                    app.setNote(rs.getString("notes"));

                    // Pet
                    Pet pet = new Pet();
                    pet.setName(rs.getString("pet_name"));
                    pet.setPet_code(rs.getString("pet_code"));

                    Breed breed = new Breed();
                    breed.setName(rs.getString("breed_name"));

                    Specie specie = new Specie();
                    specie.setName(rs.getString("specie_name"));
                    breed.setSpecie(specie);

                    pet.setBreed(breed);
                    app.setPet(pet);

                    // Customer
                    User user = new User();
                    user.setFullName(rs.getString("customer_name"));
                    user.setPhoneNumber(rs.getString("phone"));
                    user.setAddress(rs.getString("address"));
                    app.setUser(user);

                    // Doctor
                    User doctorUser = new User();
                    doctorUser.setFullName(rs.getString("doctor_name"));
                    Doctor doctor = new Doctor();
                    doctor.setUser(doctorUser);
                    app.setDoctor(doctor);

                    invoice.setAppointment(app);
                    invoice.setServices(new ArrayList<>());

                    invoiceMap.put(invoiceId, invoice);
                }

                // Thêm hoặc tăng số lượng dịch vụ
                String serviceName = rs.getString("service_name");
                double servicePrice = rs.getDouble("service_price");

                List<InvoiceServiceItem> serviceList = invoice.getServices();
                InvoiceServiceItem existingItem = null;

                for (InvoiceServiceItem item : serviceList) {
                    if (item.getName().equals(serviceName)) {
                        existingItem = item;
                        break;
                    }
                }

                if (existingItem != null) {
                    existingItem.increaseQuantity();
                } else {
                    serviceList.add(new InvoiceServiceItem(serviceName, servicePrice, 1));
                }
            }

            // Tính lại totalAmount cho từng invoice
            for (InvoiceService invoice : invoiceMap.values()) {
                double total = 0;
                for (InvoiceServiceItem item : invoice.getServices()) {
                    total += item.getPrice() * item.getQuantity();
                }
                invoice.setTotalAmount(total);
            }

            return new ArrayList<>(invoiceMap.values());

        } catch (Exception e) {
            e.printStackTrace();
        }

        return new ArrayList<>();
    }

    public List<InvoiceService> getInvoicesByDate(Date date) {
        List<InvoiceService> invoices = new ArrayList<>();

        String sql = """
        SELECT 
            i.id AS invoice_id, 
            i.payment_status, 
            i.payment_method, 
            i.paid_at, 
            i.created_at, 
            i.updated_at, 
            a.appointment_time, 
            a.start_time, 
            a.end_time, 
            a.notes, 
            p.name AS pet_name, 
            p.pet_code, 
            cus.full_name AS customer_name, 
            cus.phone AS phone, 
            cus.address AS address, 
            doc.full_name AS doctor_name, 
            s.name AS service_name, 
            aps.price AS service_price,
            breed.name AS breed_name,
            specie.name AS specie_name
        FROM invoices i
        JOIN appointments a ON i.appointment_id = a.id
        JOIN pets p ON a.pet_id = p.id
        JOIN breeds breed ON p.breeds_id = breed.id
        JOIN species specie ON breed.species_id = specie.id
        JOIN users cus ON a.customer_id = cus.id
        JOIN doctors d ON a.doctor_id = d.user_id
        JOIN users doc ON d.user_id = doc.id
        JOIN appointment_services aps ON a.id = aps.appointment_id
        JOIN services s ON aps.service_id = s.id
        WHERE CAST(a.appointment_time AS DATE) = ?
        order by created_at desc
        """;

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDate(1, new java.sql.Date(date.getTime()));

            try (ResultSet rs = ps.executeQuery()) {
                Map<String, InvoiceService> invoiceMap = new LinkedHashMap<>();

                while (rs.next()) {
                    String invoiceId = rs.getString("invoice_id");
                    InvoiceService invoice = invoiceMap.get(invoiceId);

                    if (invoice == null) {
                        invoice = new InvoiceService();
                        invoice.setId(invoiceId);
                        invoice.setPaymentStatus(rs.getString("payment_status"));
                        invoice.setPaymentMethod(rs.getString("payment_method"));
                        invoice.setPaidAt(rs.getTimestamp("paid_at"));
                        invoice.setCreateDate(rs.getTimestamp("created_at"));
                        invoice.setUpdateDate(rs.getTimestamp("updated_at"));

                        // Appointment
                        Appointment app = new Appointment();
                        app.setAppointmentDate(rs.getTimestamp("appointment_time"));
                        app.setStartTime(rs.getTime("start_time").toLocalTime());
                        app.setEndTime(rs.getTime("end_time").toLocalTime());
                        app.setNote(rs.getString("notes"));

                        // Pet
                        Pet pet = new Pet();
                        pet.setName(rs.getString("pet_name"));
                        pet.setPet_code(rs.getString("pet_code"));

                        Breed breed = new Breed();
                        breed.setName(rs.getString("breed_name"));

                        Specie specie = new Specie();
                        specie.setName(rs.getString("specie_name"));
                        breed.setSpecie(specie);

                        pet.setBreed(breed);
                        app.setPet(pet);

                        // Customer
                        User user = new User();
                        user.setFullName(rs.getString("customer_name"));
                        user.setPhoneNumber(rs.getString("phone"));
                        user.setAddress(rs.getString("address"));
                        app.setUser(user);

                        // Doctor
                        User doctorUser = new User();
                        doctorUser.setFullName(rs.getString("doctor_name"));
                        Doctor doctor = new Doctor();
                        doctor.setUser(doctorUser);
                        app.setDoctor(doctor);

                        invoice.setAppointment(app);
                        invoice.setServices(new ArrayList<>());
                        invoiceMap.put(invoiceId, invoice);
                    }

                    // Services
                    String serviceName = rs.getString("service_name");
                    double servicePrice = rs.getDouble("service_price");

                    List<InvoiceServiceItem> serviceList = invoice.getServices();
                    InvoiceServiceItem existingItem = null;

                    for (InvoiceServiceItem item : serviceList) {
                        if (item.getName().equals(serviceName)) {
                            existingItem = item;
                            break;
                        }
                    }

                    if (existingItem != null) {
                        existingItem.increaseQuantity();
                    } else {
                        serviceList.add(new InvoiceServiceItem(serviceName, servicePrice, 1));
                    }
                }

                // Tính tổng tiền
                for (InvoiceService invoice : invoiceMap.values()) {
                    double total = 0;
                    for (InvoiceServiceItem item : invoice.getServices()) {
                        total += item.getPrice() * item.getQuantity();
                    }
                    invoice.setTotalAmount(total);
                }

                invoices.addAll(invoiceMap.values());
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return invoices;
    }

    public static void main(String[] args) {
        InvoiceServiceDAO dao = new InvoiceServiceDAO();

        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date searchDate = sdf.parse("2025-06-17");

            List<InvoiceService> invoices = dao.getInvoicesByDate(searchDate);

            for (InvoiceService inv : invoices) {
                System.out.println("Invoice ID: " + inv.getId());
                System.out.println("Pet: " + inv.getAppointment().getPet().getName());
                System.out.println("Owner: " + inv.getAppointment().getUser().getFullName());
                System.out.println("Date: " + inv.getAppointment().getAppointmentDate());
                System.out.println("Doctor: " + inv.getAppointment().getDoctor().getUser().getFullName());
                System.out.println("Services:");
                for (InvoiceServiceItem item : inv.getServices()) {
                    System.out.println("  - " + item.getName() + " x" + item.getQuantity() + " : " + item.getPrice());
                }
                System.out.println("Tổng tiền: " + inv.getTotalAmount());
                System.out.println("----------------------------------");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
