/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Payment;

import DAO.AppointmentDAO;
import Model.Appointment;
import Model.Doctor;
import Model.Pet;
import Model.User;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalTime;
import java.util.Date;
import java.util.UUID;

/**
 *
 * @author CTT VNPAY
 */
@WebServlet(urlPatterns = {"/payment"})
public class ajaxServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String bankCode = req.getParameter("bankCode");
        String totalBillStr = req.getParameter("totalBill");

        if (totalBillStr == null || totalBillStr.trim().isEmpty()) {
            resp.sendRedirect("homepage");
            return;
        }
        double amountDouble = Double.parseDouble(req.getParameter("totalBill"));

        HttpSession session = req.getSession();
        User u = (User) session.getAttribute("user");
        if (u == null) {
            resp.sendRedirect("login");
            return;
        }

        String petId = req.getParameter("petId");
        String doctorId = req.getParameter("doctorId");
        String appointmentDateStr = req.getParameter("appointmentDate");
        String slotStartStr = req.getParameter("slotStart");
        String slotEndStr = req.getParameter("slotEnd");
        String note = req.getParameter("appointmentNote");
        

        Appointment appointment = new Appointment();
        appointment.setUser(u);
        appointment.setPrice(amountDouble);
         appointment.setStatus("pending");
        appointment.setPaymentMethod("online");
       
        Pet pet = new Pet();
        pet.setId(petId);
        appointment.setPet(pet);

        Doctor doctor = new Doctor();
        User doctorUser = new User();
        doctorUser.setId(doctorId);
        doctor.setUser(doctorUser);
        appointment.setDoctor(doctor);

        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date parsedDate = dateFormat.parse(appointmentDateStr);
            appointment.setAppointmentDate(new java.sql.Date(parsedDate.getTime()));
            appointment.setStartTime(LocalTime.parse(slotStartStr));
            appointment.setEndTime(LocalTime.parse(slotEndStr));
        } catch (Exception ex) {
            ex.printStackTrace();
           
        }

        appointment.setNote(note);

        String appointmentID = new AppointmentDAO().insert(appointment);
        appointment.setId(appointmentID);
        String vnp_Version = "2.1.0";
        String vnp_Command = "pay";
        String orderType = "other";

        String vnp_TxnRef = appointmentID + "";

        long amount = (long) (amountDouble * 100);

        String vnp_IpAddr = Config.getIpAddress(req);

        String vnp_TmnCode = Config.vnp_TmnCode;

        Map<String, String> vnp_Params = new HashMap<>();
        vnp_Params.put("vnp_Version", vnp_Version);
        vnp_Params.put("vnp_Command", vnp_Command);
        vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
        vnp_Params.put("vnp_Amount", String.valueOf(amount));
        vnp_Params.put("vnp_CurrCode", "VND");

        if (bankCode != null && !bankCode.isEmpty()) {
            vnp_Params.put("vnp_BankCode", bankCode);
        }
        vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
        vnp_Params.put("vnp_OrderInfo", "Thanh toan don hang:" + vnp_TxnRef);
        vnp_Params.put("vnp_OrderType", orderType);

        String locate = req.getParameter("language");
        if (locate != null && !locate.isEmpty()) {
            vnp_Params.put("vnp_Locale", locate);
        } else {
            vnp_Params.put("vnp_Locale", "vn");
        }
        vnp_Params.put("vnp_ReturnUrl", Config.vnp_ReturnUrl);
        vnp_Params.put("vnp_IpAddr", vnp_IpAddr);

        Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        String vnp_CreateDate = formatter.format(cld.getTime());
        vnp_Params.put("vnp_CreateDate", vnp_CreateDate);

        cld.add(Calendar.MINUTE, 15);
        String vnp_ExpireDate = formatter.format(cld.getTime());
        vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);

        List fieldNames = new ArrayList(vnp_Params.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        StringBuilder query = new StringBuilder();
        Iterator itr = fieldNames.iterator();
        while (itr.hasNext()) {
            String fieldName = (String) itr.next();
            String fieldValue = (String) vnp_Params.get(fieldName);
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                //Build hash data
                hashData.append(fieldName);
                hashData.append('=');
                hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                //Build query
                query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString()));
                query.append('=');
                query.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                if (itr.hasNext()) {
                    query.append('&');
                    hashData.append('&');
                }
            }
        }
        String queryUrl = query.toString();
        String vnp_SecureHash = Config.hmacSHA512(Config.secretKey, hashData.toString());
        queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;
        String paymentUrl = Config.vnp_PayUrl + "?" + queryUrl;
        resp.sendRedirect(paymentUrl);
    }
}
