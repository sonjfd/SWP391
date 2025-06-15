package Payment;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
import DAO.AppointmentDAO;
import Mail.SendEmail;
import Model.Appointment;
import Model.User;
import Payment.Config;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author HP
 */
@WebServlet(name = "VnpayReturnServlet", urlPatterns = {"/vnpayReturn"})

public class VnpayReturn extends HttpServlet {

    AppointmentDAO dao = new AppointmentDAO();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            Map fields = new HashMap();
            for (Enumeration params = request.getParameterNames(); params.hasMoreElements();) {
                String fieldName = URLEncoder.encode((String) params.nextElement(), StandardCharsets.US_ASCII.toString());
                String fieldValue = URLEncoder.encode(request.getParameter(fieldName), StandardCharsets.US_ASCII.toString());
                if ((fieldValue != null) && (fieldValue.length() > 0)) {
                    fields.put(fieldName, fieldValue);
                }
            }

            String vnp_SecureHash = request.getParameter("vnp_SecureHash");
            if (fields.containsKey("vnp_SecureHashType")) {
                fields.remove("vnp_SecureHashType");
            }
            if (fields.containsKey("vnp_SecureHash")) {
                fields.remove("vnp_SecureHash");
            }
            String signValue = Config.hashAllFields(fields);
            if (signValue.equals(vnp_SecureHash)) {
                String paymentCode = request.getParameter("vnp_TransactionNo");

                String appointmentId = request.getParameter("vnp_TxnRef");

                Appointment appointment = new Appointment();
                appointment.setId(appointmentId);

                boolean transSuccess = false;
                if ("00".equals(request.getParameter("vnp_TransactionStatus"))) {

                    appointment.setStatus("completed");
                    appointment.setPaymentStatus("paid");

                    Appointment fullAppointment = dao.getAppointmentById(appointmentId);

                    String email = fullAppointment.getUser().getEmail();
                    String name = fullAppointment.getUser().getFullName();
                    String phone = fullAppointment.getUser().getPhoneNumber();
                    String address = fullAppointment.getUser().getAddress();
                    String petName = fullAppointment.getPet().getName();
                    String appointmentDate = new SimpleDateFormat("dd/MM/yyyy").format(fullAppointment.getAppointmentDate());
                    String doctorName = fullAppointment.getDoctor().getUser().getFullName();

                    String slotStart = fullAppointment.getStartTime().toString();
                    String slotEnd = fullAppointment.getEndTime().toString();
                    double totalBill = fullAppointment.getPrice();
                    String paymentMethod = "Thanh Toán Qua Vnpay";

                    SendEmail email1 = new SendEmail();
                    email1.sendEmailAfterBooking(email, name, phone, address, petName,
                            appointmentDate, doctorName, slotStart, slotEnd, totalBill, paymentMethod);
                    transSuccess = true;
                } else {
                    appointment.setStatus("canceled");
                    appointment.setPaymentStatus("unpaid");
                }
                dao.updatePaymentStatus(appointment);
                request.setAttribute("transResult", transSuccess);
                request.getRequestDispatcher("view/home/content/PaymentResult.jsp").forward(request, response);
            } else {
                //RETURN PAGE ERROR
                System.out.println("GD KO HOP LE (invalid signature)");
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
