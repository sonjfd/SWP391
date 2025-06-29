/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package UserController;

import DAO.SpecieDAO;
import DAO.UserDAO;
import Model.Breed;
import Model.Pet;
import Model.Specie;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Path;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
@WebServlet(name = "UpdatePet", urlPatterns = {"/customer-updatepet"})
@MultipartConfig
public class UpdatePet extends HttpServlet {

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
            out.println("<title>Servlet UpdatePet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdatePet at " + request.getContextPath() + "</h1>");
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
        String petID = request.getParameter("petID");
        UserDAO dao = new UserDAO();
        SpecieDAO sdao = new SpecieDAO();
        List<Specie> specieList = sdao.getAllSpecies();
        List<Breed> breedList = dao.getBreeds();
        request.setAttribute("breedList", breedList);
        request.setAttribute("specieList", specieList);

        Pet pet = null;
        try {
            pet = dao.getPetsById(petID);
        } catch (SQLException ex) {
            Logger.getLogger(UpdatePet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UpdatePet.class.getName()).log(Level.SEVERE, null, ex);
        }
        request.setAttribute("pet", pet);
        request.getRequestDispatcher("view/profile/UpdatePet.jsp").forward(request, response);
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
        String petId = request.getParameter("petId");
        String name = request.getParameter("name");
        String gender = request.getParameter("gender");
        String birthDateStr = request.getParameter("dateOfBirth");
        Date birthDate = null;
        if (birthDateStr != null && !birthDateStr.isEmpty()) {
            birthDate = Date.valueOf(birthDateStr);
        }
        int breedId = Integer.parseInt(request.getParameter("breed_id"));
        String status = request.getParameter("status");
        String description = request.getParameter("description");
         Part part = request.getPart("avatar");

        // Thư mục lưu ảnh ngoài project
        String uploadDirPath = "C:/MyUploads/avatars";
        File uploadDir = new File(uploadDirPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        String avatarPath = null;
        String randomFileName = null;
        UserDAO userDAO = new UserDAO();

        if (part != null && part.getSize() > 0) {
            // Xóa ảnh cũ nếu có
            String oldAvatarPath = null;
            try {
                oldAvatarPath = userDAO.getPetsById(petId).getAvatar(); // eg: /swp391/image-loader/abc.jpg
            } catch (SQLException ex) {
                Logger.getLogger(UpdatePet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(UpdatePet.class.getName()).log(Level.SEVERE, null, ex);
            }
            if (oldAvatarPath != null && oldAvatarPath.contains("/image-loader/")) {
                String oldFileName = oldAvatarPath.substring((request.getContextPath() + "/image-loader/").length());
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
            avatarPath = request.getContextPath() + "/image-loader/" + randomFileName;
        } else {
            try {
                // Không upload ảnh mới → giữ nguyên ảnh cũ
                avatarPath = userDAO.getPetsById(petId).getAvatar();
            } catch (SQLException ex) {
                Logger.getLogger(UpdatePet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(UpdatePet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        UserDAO ud = new UserDAO();
        if (ud.updatePet(petId, name, gender, birthDate, breedId, status, description, avatarPath)) {
            request.getSession().setAttribute("SuccessMessage", "Cập nhật thông tin thú cưng thành công!");
        } else {
            request.getSession().setAttribute("FailMessage", "Cập nhật thông tin thú cưng không thành công!");
        }

        response.sendRedirect("customer-viewlistpet");
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
