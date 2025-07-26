package AminController;

import DAO.BreedDAO;
import Model.Breed;
import Model.Specie;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "UpdateBreed", urlPatterns = {"/admin-update-breed"})
public class UpdateBreed extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        BreedDAO breedDAO = new BreedDAO();
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Breed breed = breedDAO.getBreedById(id);
            List<Specie> specieList = breedDAO.getAllSpecies();

            if (breed != null) {
                request.setAttribute("breed", breed);
                request.setAttribute("specieList", specieList);
                request.getRequestDispatcher("view/admin/content/UpdateBreed.jsp").forward(request, response);
            } else {
                List<Breed> breedList = breedDAO.getAllBreeds();
                request.setAttribute("breedList", breedList);
                request.setAttribute("message", "Breed not found.");
                request.getRequestDispatcher("view/admin/content/ListBreed.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            List<Breed> breedList = breedDAO.getAllBreeds();
            request.setAttribute("breedList", breedList);
            request.setAttribute("message", "Failed to load update breed form.");
            request.getRequestDispatcher("view/admin/content/ListBreed.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        BreedDAO breedDAO = new BreedDAO();

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name").trim();
            int speciesId = Integer.parseInt(request.getParameter("speciesId"));

            // Lấy breed hiện tại trong DB
            Breed currentBreed = breedDAO.getBreedById(id);

            // Nếu tên mới khác tên hiện tại, kiểm tra trùng
            if (!currentBreed.getName().equalsIgnoreCase(name) || currentBreed.getSpecie().getId() != speciesId) {
                boolean isDuplicate = breedDAO.checkDuplicateBreedName(name, speciesId);
                if (isDuplicate) {
                    Specie specie = new Specie();
                    specie.setId(speciesId);
                    Breed breed = new Breed(id, name, specie);
                    List<Specie> specieList = breedDAO.getAllSpecies();

                    request.setAttribute("breed", breed);
                    request.setAttribute("specieList", specieList);
                    request.setAttribute("message", "Tên giống loài đã tồn tại trong loài này!");
                    request.getRequestDispatcher("view/admin/content/UpdateBreed.jsp").forward(request, response);
                    return;
                }
            }

            // Cập nhật nếu không trùng
            Breed breed = new Breed();
            breed.setId(id);
            breed.setName(name);
            Specie specie = new Specie();
            specie.setId(speciesId);
            breed.setSpecie(specie);

            boolean success = breedDAO.updateBreed(breed);

            List<Breed> breedList = breedDAO.getAllBreeds();
            request.setAttribute("breedList", breedList);
            request.setAttribute("message", success ? "Cập nhật thành công" : "Cập nhật thất bại");

            request.getRequestDispatcher("view/admin/content/ListBreed.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            List<Breed> breedList = breedDAO.getAllBreeds();
            request.setAttribute("breedList", breedList);
            request.setAttribute("message", "Đã xảy ra lỗi khi cập nhật.");
            request.getRequestDispatcher("view/admin/content/ListBreed.jsp").forward(request, response);
        }
    }
}
