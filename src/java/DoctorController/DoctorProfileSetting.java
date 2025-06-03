/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package DoctorController;

import DAO.DoctorDAO;
import DAO.UserDAO;
import Model.Doctor;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Path;

/**
 *
 * @author ASUS
 */
@MultipartConfig
@WebServlet("/doctor-profile-setting")
public class DoctorProfileSetting extends HttpServlet {

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
            out.println("<title>Servlet DoctorProfileSetting</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DoctorProfileSetting at " + request.getContextPath() + "</h1>");
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
        DoctorDAO ddao = new DoctorDAO();
        HttpSession ss = request.getSession();
        User u = (User) ss.getAttribute("user");
        String uuid = u.getId();
        Doctor d = ddao.getDoctorById(uuid);
        ss.setAttribute("doctor", d);

        request.getRequestDispatcher("/view/doctor/content/DoctorProfileSetting.jsp").forward(request, response);
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
        // Nhận dữ liệu từ form
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String specialty = request.getParameter("specialty");
        String qualifications = request.getParameter("qualifications");
        String certificates = request.getParameter("certificates");
        int yearsOfExperience = Integer.parseInt(request.getParameter("yearsOfExperience"));
        String biography = request.getParameter("biography");
        Part part = request.getPart("avatar");

        // Lấy đường dẫn thư mục lưu ảnh
        String realPath = request.getServletContext().getRealPath("/assets/images");
        File uploads = new File(realPath);
        if (!uploads.exists()) {
            uploads.mkdirs();
        }

        String filename = Path.of(part.getSubmittedFileName()).getFileName().toString();
        String filePath = "/assets/images/" + filename;
        DoctorDAO ddao = new DoctorDAO();
        HttpSession ss = request.getSession();
        User u = (User) ss.getAttribute("user");
        
        
        

        // Nếu không có ảnh mới, giữ ảnh cũ
        if (filename.isEmpty()) {
            try {
                UserDAO userDao = new UserDAO();
                User user = userDao.getUserById(u.getId());
                filePath = user.getAvatar(); // Giữ lại ảnh cũ
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            // Nếu có ảnh mới, lưu ảnh mới vào thư mục uploads
            File file = new File(uploads, filename);
            part.write(file.getAbsolutePath());
        }

        // Cập nhật thông tin người dùng và bác sĩ
        UserDAO userDAO = new UserDAO();
        DoctorDAO doctorDAO = new DoctorDAO();

        boolean isUserUpdated = userDAO.updateUser(u.getId(), fullName, address, email, phone, filePath);
        boolean isDoctorUpdated = doctorDAO.updateDoctor(u.getId(), specialty, certificates, qualifications, yearsOfExperience, biography);

        if (isUserUpdated && isDoctorUpdated) {
            // Nếu thành công, set thông báo thành công vào session
            request.getSession().setAttribute("alertMessage", "Cập nhật thông tin thành công!");
            request.getSession().setAttribute("alertType", "success");
            User updatedUser = userDAO.getUserById(u.getId());

        
            request.getSession().setAttribute("user", updatedUser);
        } else {
            // Nếu thất bại, set thông báo thất bại vào session
            request.getSession().setAttribute("alertMessage", "Cập nhật thông tin không thành công!");
            request.getSession().setAttribute("alertType", "error");
        }

        // Điều hướng lại đến trang chỉnh sửa profile sau khi thực hiện cập nhật
        response.sendRedirect("doctor-profile-setting");
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