/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package DoctorController;

import DAO.AppointmentServiceDAO;
import DAO.ServiceDAO;
import Model.AppointmentService;
import Model.Service;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.List;

/**
 *
 * @author ASUS
 */
@WebServlet("/add-appointment-service")
public class AddAppointmentService extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ServiceDAO sdao = new ServiceDAO();
        List<Service> l = sdao.getAllActiveServices();
        request.setAttribute("services", l);
        request.getRequestDispatcher("/view/doctor/content/AddAppointmentServices.jsp").forward(request, response);
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
        String appointmentId = request.getParameter("appointmentId");
        String serviceId = request.getParameter("serviceId");
        String priceStr = request.getParameter("price");
 // Luôn lấy lại danh sách dịch vụ đã thêm cho cuộc hẹn này
    AppointmentServiceDAO apmdao = new AppointmentServiceDAO();
    List<AppointmentService> addedServices = apmdao.getAppointmentServicesByAppointmentId(appointmentId);

    ServiceDAO sdao = new ServiceDAO();
    List<Service> l = sdao.getAllActiveServices();
    request.setAttribute("services", l);
    request.setAttribute("addedServices", addedServices);
    request.setAttribute("appointmentId", appointmentId); // Để giữ lại mã cuộc hẹn cho JSP
        if (appointmentId == null || serviceId == null || priceStr == null) {
            request.setAttribute("errorMessage", "Vui lòng điền đầy đủ thông tin.");
            request.getRequestDispatcher("/view/doctor/content/AddAppointmentServices.jsp").forward(request, response);
            return;
        }

        try {
            double price = Double.parseDouble(priceStr);
            
            if (apmdao.isServiceAlreadyAdded(appointmentId, serviceId)) {
                request.setAttribute("errorMessage", "Dịch vụ này đã được thêm vào cho cuộc hẹn.");
                request.getRequestDispatcher("/view/doctor/content/AddAppointmentServices.jsp").forward(request, response);
                return;
            }
            boolean result = apmdao.addAppointmentService(appointmentId, serviceId, price);

            if (result) {
                // Thành công: redirect lại chính trang này kèm query ?appointmentId=...&success=1
                request.getSession().setAttribute("serviceAddSuccess", true);
                response.sendRedirect("add-appointment-service?appointmentId=" + appointmentId);
                return;
            } else {
                request.setAttribute("errorMessage", "Có lỗi xảy ra khi thêm dịch vụ.");
                request.getRequestDispatcher("/view/doctor/content/AddAppointmentServices.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Giá dịch vụ không hợp lệ.");
            request.getRequestDispatcher("/view/doctor/content/AddAppointmentServices.jsp").forward(request, response);
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
