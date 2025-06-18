/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package StaffController;

import DAO.AppointmentDAO;
import DAO.StaffDAO;
import DAO.UserDAO;
import Mail.SendEmail;
import Model.Appointment;
import Model.Doctor;
import Model.Pet;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.time.LocalTime;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Dell
 */
@WebServlet(name = "AddNewBooking", urlPatterns = {"/staff-add-new-booking"})
public class AddNewBooking extends HttpServlet {

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
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddNewBooking</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddNewBooking at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        UserDAO udao = new UserDAO();
        List<User> users = udao.getAllCustomer();

        request.setAttribute("users", users);

        AppointmentDAO adao = new AppointmentDAO();

        Date today = new Date();

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String todayStr = sdf.format(today);

        double defaultPrice = adao.getPriceByDate();

        request.setAttribute("defaultDate", todayStr);
        request.setAttribute("defaultPrice", defaultPrice);
        request.getRequestDispatcher("view/staff/content/CreateNewBooking.jsp").forward(request, response);
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

        request.setCharacterEncoding("UTF-8");

        String userId = request.getParameter("userId");
        String petId = request.getParameter("petId");
        String doctorId = request.getParameter("doctorId");
        String appointmentDateStr = request.getParameter("appointmentDate");
        String slotStartStr = request.getParameter("slotStart");
        String slotEndStr = request.getParameter("slotEnd");
        String note = request.getParameter("appointmentNote");

        double price = Double.parseDouble(request.getParameter("totalBill"));

        Appointment appointment = new Appointment();
        appointment.setNote(note);
        appointment.setPaymentMethod("cash");
        appointment.setPaymentStatus("paid");
        appointment.setPrice(price);

        try {
            UserDAO userDAO = new UserDAO();
            Pet pet = userDAO.getPetsById(petId);
            User user = userDAO.getUserById(userId);
            appointment.setPet(pet);
            appointment.setUser(user);
            
            StaffDAO staffDAO = new StaffDAO();
            Doctor doctor = staffDAO.getDoctorById(doctorId);
            appointment.setDoctor(doctor);

            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date parsedDate = dateFormat.parse(appointmentDateStr);
            appointment.setAppointmentDate(new java.sql.Date(parsedDate.getTime()));
            appointment.setStartTime(LocalTime.parse(slotStartStr));
            appointment.setEndTime(LocalTime.parse(slotEndStr));
            appointment.setStatus("completed");
            appointment.setPaymentStatus("unpaid");
            AppointmentDAO appointmentDAO = new AppointmentDAO();
            int result = appointmentDAO.addNewBoking(appointment);

            if (result > 0) {

                SendEmail sendMail = new SendEmail();
                sendMail.sendEmailAfterBooking(
                        user.getEmail(),
                        user.getFullName(),
                        user.getPhoneNumber(),
                        user.getAddress(),
                        pet.getName(),
                        appointment.getAppointmentDate().toString(),
                        doctor.getUser().getFullName(),
                        slotStartStr,
                        slotEndStr,
                        price,
                        "Thanh toán trực tiếp"
                );

                response.sendRedirect("staff-list-appointment?success=1");
            } else {
                request.setAttribute("error", "Đặt lịch thất bại. Vui lòng thử lại.");
                request.getRequestDispatcher("view/staff/content/CreateNewBooking.jsp").forward(request, response);

            }

        } catch (Exception ex) {
            ex.printStackTrace();
           
        }
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
