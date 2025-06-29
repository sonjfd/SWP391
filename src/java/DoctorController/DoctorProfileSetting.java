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
import java.util.List;
import java.util.Map;

/**
 *
 * @author ASUS
 */
@MultipartConfig
@WebServlet("/doctor-profile-setting")
public class DoctorProfileSetting extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DoctorDAO ddao = new DoctorDAO();
        HttpSession ss = request.getSession();
        User u = (User) ss.getAttribute("user");
        if(u== null){
            response.sendRedirect("login");
            return;
        }
        String uuid = u.getId();
        Doctor d = ddao.getDoctorById(u, uuid);

        ss.setAttribute("doctor", d);

        request.getRequestDispatcher("/view/doctor/content/DoctorProfileSetting.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("user");
        if(u== null){
            response.sendRedirect("login");
            return;
        }
        String userId = u.getId();

        // Dữ liệu từ form
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

        // Thư mục lưu ảnh ngoài project
        String uploadDirPath = "C:/MyUploads/Images";
        File uploadDir = new File(uploadDirPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        String avatarPath = null;
        String randomFileName = null;

        UserDAO userDAO = new UserDAO();
        DoctorDAO doctorDAO = new DoctorDAO();

        try {
            if (part != null && part.getSize() > 0) {
                // Xóa ảnh cũ nếu có
                String oldAvatarPath = userDAO.getUserById(userId).getAvatar(); // eg: /swp391/image-loader/abc.jpg
                if (oldAvatarPath != null && oldAvatarPath.contains("/image-loader/")) {
                    String oldFileName = oldAvatarPath.substring((request.getContextPath()+"/image-loader/").length());
                    File oldFile = new File(uploadDir, oldFileName);
                    if (oldFile.exists()) {
                        oldFile.delete();
                    }
                }

                // Tạo tên ngẫu nhiên cho file
                String fileExtension = part.getSubmittedFileName().substring(part.getSubmittedFileName().lastIndexOf("."));
                randomFileName = java.util.UUID.randomUUID().toString() + fileExtension;

                // Ghi file
                File newFile = new File(uploadDir, randomFileName);
                part.write(newFile.getAbsolutePath());

                // Gán đường dẫn lưu DB
                avatarPath = request.getContextPath()+"/image-loader/" + randomFileName;
            } else {
                // Không upload ảnh mới → giữ nguyên ảnh cũ
                avatarPath = userDAO.getUserById(userId).getAvatar();
            }

            // Cập nhật DB
            boolean isUserUpdated = userDAO.updateUser(userId, fullName, address, email, phone, avatarPath);
            boolean isDoctorUpdated = doctorDAO.updateDoctor(userId, specialty, certificates, qualifications, yearsOfExperience, biography);

            if (isUserUpdated && isDoctorUpdated) {
                session.setAttribute("alertMessage", "Cập nhật thành công!");
                session.setAttribute("alertType", "success");
                session.setAttribute("user", userDAO.getUserById(userId));
            } else {
                session.setAttribute("alertMessage", "Cập nhật không thành công!");
                session.setAttribute("alertType", "error");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("alertMessage", "Lỗi: " + e.getMessage());
            session.setAttribute("alertType", "error");
        }

        response.sendRedirect("doctor-profile-setting");
    }

}
