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
@WebServlet(name = "UpdatePet", urlPatterns = {"/updatepet"})
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

        String realPath = request.getServletContext().getRealPath("/assets/images");
        File uploads = new File(realPath);
        if (!uploads.exists()) {
            uploads.mkdirs();
        }

        String filename = Path.of(part.getSubmittedFileName()).getFileName().toString();
        String filePath = "/assets/images/" + filename;

        // Nếu không có ảnh mới, giữ ảnh cũ
        if (filename.isEmpty()) {

            try {
                UserDAO userDao = new UserDAO();
                Pet pet = userDao.getPetsById(petId);
                filePath = pet.getAvatar(); // Giữ lại ảnh cũ
            } catch (Exception e) {
                e.printStackTrace();
            }

        } else {
            String originalFilename = Path.of(part.getSubmittedFileName()).getFileName().toString();
            String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
            String randomFilename = System.currentTimeMillis() + "_" + (int) (Math.random() * 10000) + fileExtension;

            filePath = "/assets/images/" + randomFilename;
            File file = new File(uploads, randomFilename);
            part.write(file.getAbsolutePath());
        }
        UserDAO ud = new UserDAO();
        if (ud.updatePet(petId, name, gender, birthDate, breedId, status, description, filePath)) {
            request.getSession().setAttribute("SuccessMessage", "Cập nhật thông tin thú cưng thành công!");
        } else {
            request.getSession().setAttribute("FailMessage", "Cập nhật thông tin thú cưng không thành công!");
        }

        response.sendRedirect("viewlistpet");
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
