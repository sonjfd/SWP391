/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package CommonController;

import DAO.DoctorDAO;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author ASUS
 */

@WebServlet("/update-profile-first-time")
public class UpdateProfileFirstTime extends HttpServlet {
   
    

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
       request.getRequestDispatcher("view/profile/UpdateProfileFirstTime.jsp").forward(request, response);
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
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("login");
            return;
        }
            String specialty = request.getParameter("specialty");
            String qualifications = request.getParameter("qualifications");
            String certificates = request.getParameter("certificates");
            String biography = request.getParameter("biography");
            int years = Integer.parseInt(request.getParameter("yearsOfExperience"));

            DoctorDAO doctorDAO = new DoctorDAO();
            doctorDAO.updateDoctor(user.getId(), specialty, qualifications, certificates, years, biography);
        

        
        request.getSession().setAttribute("user", user);

        response.sendRedirect("homepage");
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
