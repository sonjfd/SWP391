/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package UserController;

import DAO.AppointmentDAO;
import DAO.DoctorScheduleDAO;
import DAO.ShiftDAO;
import Model.Appointment;
import Model.Shift;
import Model.Slot;
import Model.SlotService;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Dell
 */
@WebServlet(name = "GetSlotsServlet", urlPatterns = {"/get-slot"})
public class GetSlotsServlet extends HttpServlet {

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
            out.println("<title>Servlet GetSlotsServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet GetSlotsServlet at " + request.getContextPath() + "</h1>");
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
        String dateStr = request.getParameter("date");
        String doctorId = request.getParameter("doctorId");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            Date date = sdf.parse(dateStr);

            List<Shift> shifts = new ShiftDAO().getShiftByDoctorAndDate(doctorId, date);
            if (shifts == null || shifts.isEmpty()) {
                out.print("[]");
                out.flush();
                return;
            }

            List<Appointment> appointments = new AppointmentDAO().getAppointmentsByDoctorAndDate(doctorId, date);

            List<Slot> allSlots = new ArrayList<>();
            for (Shift shift : shifts) {
                List<Slot> slots = SlotService.generateSlots(shift, appointments, 30);
                allSlots.addAll(slots);
            }

           JsonArray jsonSlots = new JsonArray();

            for (Slot slot : allSlots) {
                
                JsonObject obj = new JsonObject();
                obj.addProperty("start", slot.getStart().toString());
                obj.addProperty("end", slot.getEnd().toString());
                
                obj.addProperty("booked", !slot.isAvailable());

                jsonSlots.add(obj);
            }

            out.print(jsonSlots.toString());
            out.flush();

        } catch (ParseException ex) {
            ex.printStackTrace();
            
        }
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
