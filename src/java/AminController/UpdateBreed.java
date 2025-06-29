/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package AminController;

import DAO.BreedDAO;
import Model.Breed;
import Model.Specie;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author FPT
 */
@WebServlet(name="UpdateBreed", urlPatterns={"/admin-update-breed"})
public class UpdateBreed extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet UpdateBreed</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateBreed at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
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

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        BreedDAO breedDAO = new BreedDAO();
        try {
            Breed breed = new Breed();
            breed.setId(Integer.parseInt(request.getParameter("id")));
            breed.setName(request.getParameter("name"));
            Specie specie = new Specie();
            specie.setId(Integer.parseInt(request.getParameter("speciesId")));
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
            request.setAttribute("message", "Update failed due to an error.");
            request.getRequestDispatcher("view/admin/content/ListBreed.jsp").forward(request, response);
        }
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
