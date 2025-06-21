/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package DoctorController;

import DAO.DoctorDAO;
import DAO.UserDAO;
import Model.Doctor;
import Model.User;
import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
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
import java.util.List;
import java.util.Map;

/**
 *
 * @author ASUS
 */
@MultipartConfig
@WebServlet("/doctor-profile-setting")
public class DoctorProfileSetting extends HttpServlet {

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
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("user");
        String userId = u.getId();

        // Lấy dữ liệu từ form
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

        // Cloudinary config
        Cloudinary cloudinary = new Cloudinary(ObjectUtils.asMap(
                "cloud_name", "dsqeyweqb",
                "api_key", "583198628135895",
                "api_secret", "rgJklktFD-bD-4npUu1WE1IX__o",
                "secure", true
        ));

        String avatarUrl = null;
        String newPublicId = null;

        try {
            if (part != null && part.getSize() > 0) {
                // Lấy public_id cũ từ DB
                UserDAO userDao = new UserDAO();
                String oldPublicId = userDao.getCloudinaryPublicIdByUserId(userId);
                if (oldPublicId != null && !oldPublicId.isEmpty()) {
                    try {
                        cloudinary.uploader().destroy(oldPublicId, ObjectUtils.emptyMap());
                    } catch (Exception e) {
                        e.printStackTrace(); // Nếu lỗi vẫn tiếp tục
                    }
                }

                // Upload ảnh mới
                File tempFile = File.createTempFile("upload", ".tmp");
                try (var input = part.getInputStream(); var out = new java.io.FileOutputStream(tempFile)) {
                    input.transferTo(out);
                }

                Map uploadResult = cloudinary.uploader().upload(tempFile, ObjectUtils.emptyMap());
                avatarUrl = (String) uploadResult.get("secure_url");
                newPublicId = (String) uploadResult.get("public_id");
                tempFile.delete();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        UserDAO userDAO = new UserDAO();
        DoctorDAO doctorDAO = new DoctorDAO();

        // Nếu không có avatar mới thì dùng avatar cũ
        if (avatarUrl == null || avatarUrl.isEmpty()) {
            User userFromDb = userDAO.getUserById(userId);
            avatarUrl = userFromDb.getAvatar();
            newPublicId = userDAO.getCloudinaryPublicIdByUserId(userId);
        }

        // Cập nhật thông tin user và doctor
        boolean isUserUpdated = userDAO.updateUser(userId, fullName, address, email, phone, avatarUrl);
        boolean isDoctorUpdated = doctorDAO.updateDoctor(userId, specialty, certificates, qualifications, yearsOfExperience, biography);

        if (isUserUpdated && isDoctorUpdated) {
            userDAO.updateCloudinaryPublicId(userId, newPublicId);

            session.setAttribute("alertMessage", "Cập nhật thông tin thành công!");
            session.setAttribute("alertType", "success");

            User updatedUser = userDAO.getUserById(userId);
            session.setAttribute("user", updatedUser);
        } else {
            session.setAttribute("alertMessage", "Cập nhật thông tin không thành công!");
            session.setAttribute("alertType", "error");
        }

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
