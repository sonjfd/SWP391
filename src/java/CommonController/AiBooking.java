/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package CommonController;

import DAO.AIChatboxDAO;
import DAO.AppointmentDAO;
import DAO.DoctorDAO;
import DAO.ShiftDAO;
import DAO.StaffDAO;
import DAO.UserDAO;
import Mail.SendEmail;
import Model.Appointment;
import Model.Doctor;
import Model.Pet;
import Model.Shift;
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
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Dell
 */
@WebServlet(name = "AiBooking", urlPatterns = {"/ai-booking"})
public class AiBooking extends HttpServlet {

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
            out.println("<title>Servlet AiBooking</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AiBooking at " + request.getContextPath() + "</h1>");
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
        response.setContentType("text/plain;charset=UTF-8");

        String petId = request.getParameter("petId");
        String dateStr = request.getParameter("date");
        User user = (User) request.getSession().getAttribute("user");

        Date appointmentDate = null;
        try {
            appointmentDate = new SimpleDateFormat("yyyy-MM-dd").parse(dateStr);
        } catch (Exception e) {
            e.printStackTrace();
        }

        try {
            DoctorDAO doctorDao = new DoctorDAO();
            AppointmentDAO apptDAO = new AppointmentDAO();
            ShiftDAO shiftDAO = new ShiftDAO();
            List<Doctor> availableDoctors = doctorDao.getDoctorsByDate(appointmentDate);

            for (Doctor doctor : availableDoctors) {
                List<Shift> shifts = shiftDAO.getShiftByDoctorAndDate(doctor.getUser().getId(), appointmentDate);
                List<Appointment> appointments = apptDAO.getAppointmentsByDoctorAndDate(doctor.getUser().getId(), appointmentDate);
                for (Shift shift : shifts) {
                    List<Slot> slots = SlotService.generateSlots(shift, appointments, 30);
                    for (Slot slot : slots) {
                        if (slot.isAvailable()) {
                            Appointment appt = new Appointment();
                            Pet pet = new UserDAO().getPetsById(petId);
                            appt.setPet(pet);
                            doctor = new StaffDAO().getDoctorById(doctor.getUser().getId());
                            appt.setDoctor(doctor);
                            appt.setUser(user);
                            appt.setAppointmentDate(appointmentDate);
                            appt.setStartTime(slot.getStart());
                            appt.setEndTime(slot.getEnd());
                            appt.setStatus("booked");
                            appt.setChekinStatus("noshow");
                            appt.setPaymentStatus("unpaid");
                            appt.setPaymentMethod("cash");
                            double price = new AppointmentDAO().getPriceByDate();
                            appt.setPrice(price);
                            int result = apptDAO.addNewBoking(appt);
                            if (result > 0) {
                                SendEmail sendMail = new SendEmail();
                                sendMail.sendEmailAfterBooking(appt.getUser().getEmail(), appt.getUser().getFullName(),
                                        appt.getUser().getPhoneNumber(), appt.getUser().getAddress(), appt.getPet().getName(),
                                        appt.getAppointmentDate().toString(), appt.getDoctor().getUser().getFullName(),
                                        appt.getStartTime().toString(), appt.getEndTime().toString(), appt.getPrice(),
                                        "Thanh Toán Trực tiếp");
                            }

                            String successMessage = "Đã đặt lịch thành công lúc " + slot.getStart()
                                    + " ngày " + dateStr + " với bác sĩ " + doctor.getUser().getFullName()
                                    + ". Hãy kiểm tra email để biết chi tiết.";

                            new AIChatboxDAO().insertMessage(null, user.getId(), "ai", successMessage);

                            response.getWriter().write(successMessage);
                            return;
                        }
                    }

                }

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        String failMessage = "Xin lỗi, không còn ca khám trống nào trong ngày đã chọn. Vui lòng chọn lại!";
       
            new AIChatboxDAO().insertMessage(null, user.getId(), "ai", failMessage);
        
        response.getWriter().write(failMessage);

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
