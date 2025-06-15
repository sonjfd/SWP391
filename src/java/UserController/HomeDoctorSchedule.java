/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package UserController;

import DAO.AppointmentDAO;
import DAO.DoctorDAO;
import DAO.DoctorScheduleDAO;
import DAO.StaffDAO;
import DAO.UserDAO;
import Mail.SendEmail;
import Model.Appointment;
import Model.Doctor;
import Model.DoctorSchedule;
import Model.Pet;
import Model.Slot;
import Model.SlotService;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 *
 * @author ASUS
 */
@WebServlet(urlPatterns={"/booking-by-doctor"})
public class HomeDoctorSchedule extends HttpServlet {

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
            out.println("<title>Servlet HomeDoctorSchedule</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomeDoctorSchedule at " + request.getContextPath() + "</h1>");
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
        UserDAO udao=new UserDAO();
        HttpSession session=request.getSession();
        User u=(User)session.getAttribute("user");
         if (u == null) {
            response.sendRedirect("login");
            return;
        }
        String uid=u.getId();
        List<Pet>pets=udao.getPetsByUser(uid);
        request.setAttribute("pets", pets);
        String doctorId=request.getParameter("doctorId");
       DoctorDAO doctordao=new DoctorDAO();
        Doctor doctor=doctordao.getDoctorById(doctorId);
        request.setAttribute("doctor", doctor);
         AppointmentDAO adao=new AppointmentDAO();
        
          

        Date today = new Date();

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String todayStr = sdf.format(today);

        double defaultPrice = adao.getPriceByDate();

        request.setAttribute("defaultDate", todayStr);
        request.setAttribute("defaultPrice", defaultPrice);
        
        
       request.getRequestDispatcher("view/home/content/BookingByDoctor.jsp").forward(request, response);
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
         HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("homepage");
            return;
        }
        String petId = request.getParameter("petId");
        String doctorId = request.getParameter("doctorId");
        String appointmentDateStr = request.getParameter("appointmentDate");
        String slotStartStr = request.getParameter("slotStart");
        String slotEndStr = request.getParameter("slotEnd");
        String note = request.getParameter("appointmentNote");
        double price = Double.parseDouble(request.getParameter("totalBill"));
        Appointment appointment = new Appointment();
        appointment.setUser(user);
        appointment.setPrice(price);
        appointment.setNote(note);
        appointment.setPaymentMethod("cash");
        appointment.setPaymentStatus("unpaid");
        appointment.setStatus("completed");
        UserDAO udao = new UserDAO();
        Pet pet;
        try {
            pet = udao.getPetsById(petId);
            appointment.setPet(pet);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Booking.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(Booking.class.getName()).log(Level.SEVERE, null, ex);
        }

        Doctor doctor = new StaffDAO().getDoctorById(doctorId);
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
        AppointmentDAO adao = new AppointmentDAO();
        int result = adao.addNewBoking(appointment);

        if (result > 0) {

            SendEmail sendMail = new SendEmail();
            sendMail.sendEmailAfterBooking(appointment.getUser().getEmail(), appointment.getUser().getFullName(),
                    appointment.getUser().getPhoneNumber(), appointment.getUser().getAddress(), appointment.getPet().getName(),
                    appointment.getAppointmentDate().toString(), appointment.getDoctor().getUser().getFullName(),
                    appointment.getStartTime().toString(), appointment.getEndTime().toString(), appointment.getPrice(),
                    "Thanh Toán Trực tiếp");

            request.getRequestDispatcher("view/home/content/ThanhYou.jsp").forward(request, response);
           


        } else {
            request.setAttribute("error", "Đặt lịch thất bại!Xin vui lòng thử lại");
            request.getRequestDispatcher("view/home/content/BookingByDoctor.jsp").forward(request, response);
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
