/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package CommonController;

import DAO.AppointmentDAO;
import DAO.DoctorDAO;
import DAO.DoctorScheduleDAO;
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
import jakarta.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Dell
 */
@WebServlet(name = "AIBookWithDoctor", urlPatterns = {"/chat-ai-book-with-doctor"})
public class AIBookWithDoctor extends HttpServlet {

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
            out.println("<title>Servlet AIBookWithDoctor</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AIBookWithDoctor at " + request.getContextPath() + "</h1>");
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
    response.setContentType("text/plain; charset=UTF-8");
    request.setCharacterEncoding("UTF-8");

    HttpSession session = request.getSession();
    User user = (User) session.getAttribute("user");

   

    String doctorId = request.getParameter("doctorId");
    String dateStr = request.getParameter("date");
    String petId = request.getParameter("petId");

  

    try {
        Date appointmentDate = new SimpleDateFormat("yyyy-MM-dd").parse(dateStr);

        StaffDAO staffDAO = new StaffDAO();
        Doctor doctor = staffDAO.getDoctorById(doctorId);
        UserDAO userDAO = new UserDAO();
        Pet pet = userDAO.getPetsById(petId);
   
        ShiftDAO shiftDAO = new ShiftDAO();
        AppointmentDAO apptDAO = new AppointmentDAO();

        List<Shift> shifts = shiftDAO.getShiftByDoctorAndDate(doctorId, appointmentDate);
        List<Appointment> appointments = apptDAO.getAppointmentsByDoctorAndDate(doctorId, appointmentDate);

        Slot selectedSlot = null;
        for (Shift shift : shifts) {
            List<Slot> slots = SlotService.generateSlots(shift, appointments, 30);
            for (Slot slot : slots) {
                if (slot.isAvailable()) {
                    selectedSlot = slot;
                    break;
                }
            }
            if (selectedSlot != null) break;
        }

        if (selectedSlot == null) {
            response.getWriter().write("Bác sĩ " +doctor.getUser().getFullName()+" không có lịch làm việc hôm nay!Xin hãy thử lại");
            return;
        }

        Appointment appt = new Appointment();
        appt.setUser(user);
        appt.setDoctor(doctor);
        appt.setPet(pet);
        appt.setAppointmentDate(appointmentDate);
        appt.setStartTime(selectedSlot.getStart());
        appt.setEndTime(selectedSlot.getEnd());
        appt.setStatus("booked");
        appt.setChekinStatus("noshow");
        appt.setPaymentStatus("unpaid");
        appt.setPaymentMethod("cash");

        double price = apptDAO.getPriceByDate(); 
        appt.setPrice(price);

        int result = apptDAO.addNewBoking(appt);
        if (result > 0) {
            SendEmail sendMail = new SendEmail();
            sendMail.sendEmailAfterBooking(
                    user.getEmail(),
                    user.getFullName(),
                    user.getPhoneNumber(),
                    user.getAddress(),
                    pet.getName(),
                    dateStr,
                    doctor.getUser().getFullName(),
                    selectedSlot.getStart().toString(),
                    selectedSlot.getEnd().toString(),
                    price,
                    "Thanh Toán Trực tiếp"
            );

            String msg = "Đã đặt lịch thành công lúc " + selectedSlot.getStart()
                    + " ngày " + dateStr + " với bác sĩ " + doctor.getUser().getFullName();
            response.getWriter().write(msg);
        } else {
            response.getWriter().write("Đặt lịch thất bại. Vui lòng thử lại sau.");
        }

    } catch (Exception e) {
        e.printStackTrace();
        response.getWriter().write("Đã xảy ra lỗi khi đặt lịch.");
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
