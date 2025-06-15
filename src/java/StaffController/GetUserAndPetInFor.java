/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package StaffController;

import DAO.UserDAO;
import Model.Pet;
import Model.User;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Dell
 */
@WebServlet(name = "GetUserInFor", urlPatterns = {"/get-user-and-pet"})
public class GetUserAndPetInFor extends HttpServlet {

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
            out.println("<title>Servlet GetUserInFor</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet GetUserInFor at " + request.getContextPath() + "</h1>");
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

        String userId = request.getParameter("userId");

        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserById(userId);
        List<Pet> pets = userDAO.getPetsByUser(userId);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        JsonObject json = new JsonObject();

       
        JsonObject userJson = new JsonObject();
        userJson.addProperty("id", user.getId());
        userJson.addProperty("fullName", user.getFullName());
        userJson.addProperty("email", user.getEmail());
        userJson.addProperty("phoneNumber", user.getPhoneNumber());
        userJson.addProperty("address", user.getAddress());

        json.add("user", userJson);

        JsonArray petsArray = new JsonArray();
        for (Pet pet : pets) {
            JsonObject petJson = new JsonObject();
            petJson.addProperty("id", pet.getId());
            petJson.addProperty("name", pet.getName());
            petJson.addProperty("species", pet.getBreed().getSpecie().getName());
            petJson.addProperty("breed", pet.getBreed().getName());
           

            petsArray.add(petJson);
        }

        json.add("pets", petsArray);

        // Trả về response
        PrintWriter out = response.getWriter();
        out.print(json.toString());
        out.flush();
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
        processRequest(request, response);
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
