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

@WebServlet(name = "AddPet", urlPatterns = {"/addpet"})
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
        String birthDateStr = request.getParameter("birthDate");
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
        String filePath;
        if (part.getSize() > 0) {
            String originalFilename = Path.of(part.getSubmittedFileName()).getFileName().toString();
            String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
            String randomFilename = System.currentTimeMillis() + "_" + (int) (Math.random() * 10000) + fileExtension;

            filePath = "/assets/images/" + randomFilename;
            File file = new File(uploads, randomFilename);
            part.write(file.getAbsolutePath());
        } else {
            filePath = "/assets/images/default-avatar.jpg";
        }
        User user = new User(ownerID);
        Breed breed = new Breed(breedId);

        UserDAO dao = new UserDAO();
        Random random = new Random();
        int randomNumber = random.nextInt(100000); 
        String pet_code = String.format("PET%05d", randomNumber); 
        boolean a = dao.addPet(pet_code, ownerID, name, birthDate, breedId, gender, filePath, description, status);
        if (a) {
            request.getSession().setAttribute("SuccessMessage", "Thêm Pet thành công!");

        } else {
            request.getSession().setAttribute("FailMessage", "Thêm Pet không thành công!");
        }
        response.sendRedirect("viewlistpet");

    }

    @Override
    public String getServletInfo() {
        return "Add new pet";
    }

}
