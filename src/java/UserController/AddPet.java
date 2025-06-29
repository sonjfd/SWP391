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
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Path;
import java.time.LocalDate;
import java.sql.Date;
import java.util.List;
import java.util.Random;

@WebServlet(name = "AddPet", urlPatterns = {"/customer-addpet"})
@MultipartConfig
public class AddPet extends HttpServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO dao = new UserDAO();
        SpecieDAO sd = new SpecieDAO();
        List<Breed> breedList = dao.getBreeds();
        List<Specie> specieList = sd.getAllSpecies();
        request.setAttribute("breedList", breedList);
        request.setAttribute("specieList", specieList);
        request.getRequestDispatcher("view/profile/AddPet.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String ownerID = request.getParameter("id");
        String name = request.getParameter("name");
        String gender = request.getParameter("gender");

        int breedId = Integer.parseInt(request.getParameter("breed_id"));
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
        if (part != null && part.getSize() > 0) {
            // Tạo tên ngẫu nhiên cho file
            String fileExtension = part.getSubmittedFileName().substring(part.getSubmittedFileName().lastIndexOf("."));
            randomFileName = java.util.UUID.randomUUID().toString() + fileExtension;

            // Ghi file
            File newFile = new File(uploadDir, randomFileName);
            part.write(newFile.getAbsolutePath());

            // Gán đường dẫn lưu DB
            avatarPath = request.getContextPath() + "/image-loader/" + randomFileName;
        } else {
            avatarPath = "/assets/images/species/default_pet.png";
        }
        User user = new User(ownerID);
        Breed breed = new Breed(breedId);

        UserDAO dao = new UserDAO();
        Random random = new Random();
        int randomNumber = random.nextInt(100000);
        String pet_code = String.format("PET%05d", randomNumber);
        boolean a = dao.addPet(pet_code, ownerID, name, breedId, gender, avatarPath, description);
        if (a) {
            request.getSession().setAttribute("SuccessMessage", "Thêm Pet thành công!");

        } else {
            request.getSession().setAttribute("FailMessage", "Thêm Pet không thành công!");
        }
        response.sendRedirect("customer-viewlistpet");

    }

    @Override
    public String getServletInfo() {
        return "Add new pet";
    }

}
