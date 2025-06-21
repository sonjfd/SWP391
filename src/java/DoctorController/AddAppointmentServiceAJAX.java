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
import jakarta.servlet.annotation.MultipartConfig;
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
@MultipartConfig
@WebServlet("/add-appointment-service")
public class AddAppointmentServiceAJAX extends HttpServlet {

    

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String appointmentId = request.getParameter("appointmentId");
        String serviceId = request.getParameter("serviceId");
        String priceStr = request.getParameter("price");

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        if (appointmentId == null || serviceId == null || priceStr == null || appointmentId.isEmpty() || serviceId.isEmpty() || priceStr.isEmpty()) {
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Vui lòng điền đầy đủ thông tin.\"}");
            return;
        }

        try {
            double price = Double.parseDouble(priceStr);
            AppointmentServiceDAO apmdao = new AppointmentServiceDAO();
            boolean result = apmdao.addAppointmentService(appointmentId, serviceId, price);

            if (result) {
                response.getWriter().write("{\"status\":\"success\",\"message\":\"Thêm dịch vụ thành công!\"}");
            } else {
                response.getWriter().write("{\"status\":\"error\",\"message\":\"Có lỗi xảy ra khi thêm dịch vụ.\"}");
            }
        } catch (NumberFormatException e) {
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Giá dịch vụ không hợp lệ.\"}");
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
