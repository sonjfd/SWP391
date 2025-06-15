/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package StaffController;

import DAO.MedicalRecordDAO;
import DAO.UserDAO;
import Model.MedicalRecord;
import Model.Pet;
import Model.User;
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
@WebServlet(name = "ListPetAndOwner", urlPatterns = {"/list-pet-and-owner"})
public class ListPetAndOwner extends HttpServlet {

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
            out.println("<title>Servlet ListPetAndOwner</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListPetAndOwner at " + request.getContextPath() + "</h1>");
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
        UserDAO udao = new UserDAO();
        List<User> users = udao.getAllCustomer();
        request.setAttribute("listuser", users);

        String ownerId = request.getParameter("ownerId");
        List<Pet> pets;
        if (ownerId != null && !ownerId.isEmpty()) {
            pets = udao.getPetsByUser(ownerId);
        } else {
            pets = udao.getAllPet();
        }

        String pageRaw = request.getParameter("page");
        int page = (pageRaw != null && !pageRaw.isEmpty()) ? Integer.parseInt(pageRaw) : 1;
        int pageSize = 10;
        int totalItems = pets.size();
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);
        int start = (page - 1) * pageSize;
        int end = Math.min(start + pageSize, totalItems);
        List<Pet> petsPage = pets.subList(start, end);

        MedicalRecordDAO mrdao = new MedicalRecordDAO();
        for (Pet pet : petsPage) {
            List<MedicalRecord> history = mrdao.getMedicalRecordsByPetId(pet.getId());
            pet.setMedicalRecords(history);
        }

        request.setAttribute("listpet", petsPage);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("ownerId", ownerId);

        request.getRequestDispatcher("view/staff/content/ListPetAndOwner.jsp").forward(request, response);
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
