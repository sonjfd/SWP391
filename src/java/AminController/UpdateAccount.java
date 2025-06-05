/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package AminController;

import DAO.AdminDao;
import Model.Doctor;
import Model.Role;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Date;

/**
 *
 * @author FPT
 */
public class UpdateAccount extends HttpServlet {
   
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
            out.println("<title>Servlet UpdateAccount</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateAccount at " + request.getContextPath () + "</h1>");
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
        
        String id = request.getParameter("id");
        AdminDao adminDAO = new AdminDao();
        User user = adminDAO.getUserById(id);
        Doctor doctor = adminDAO.getDoctorByUserId(id);
        request.setAttribute("user", user);
        request.setAttribute("doctor", doctor);
        request.getRequestDispatcher("view/admin/content/UpdateAccount.jsp").forward(request, response);
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
        String id = request.getParameter("id");
        int roleId = Integer.parseInt(request.getParameter("role_id"));
        String userName = request.getParameter("userName");
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        String avatar = request.getParameter("avatar");
//        int status = Integer.parseInt(request.getParameter("status"));

        AdminDao adminDAO = new AdminDao();
        User user = adminDAO.getUserById(id);
        if (user == null) {
            request.setAttribute("message", "User not found.");
            request.setAttribute("messageType", "error");
            response.sendRedirect("listaccount");
            return;
        }

        // Kiểm tra username/email trùng (ngoại trừ chính user này)
        if (!userName.equals(user.getUserName()) && adminDAO.isUsernameTaken(userName)) {
            request.setAttribute("message", "Username is already taken.");
            request.setAttribute("messageType", "error");
            request.getRequestDispatcher("view/admin/content/UpdateAccount.jsp").forward(request, response);
            return;
        }
        if (!email.equals(user.getEmail()) && adminDAO.isEmailTaken(email)) {
            request.setAttribute("message", "Email is already taken.");
            request.setAttribute("messageType", "error");
            request.getRequestDispatcher("view/admin/content/UpdateAccount.jsp").forward(request, response);
            return;
        }

        user.setUserName(userName);
        user.setEmail(email);
        user.setFullName(fullName);
        user.setPhoneNumber(phoneNumber);
        user.setAddress(address);
        user.setAvatar(avatar != null && !avatar.isEmpty() ? avatar : "/assets/images/default_user.png");
//        user.setStatus(status);
        Role role = new Role();
        role.setId(roleId);
        user.setRole(role);
        user.setUpdateDate(new Date());

        Doctor doctor = null;
        if (roleId == 3) {
            doctor = new Doctor();
            doctor.setUser(user);
            doctor.setSpecialty(request.getParameter("specialty"));
            doctor.setCertificates(request.getParameter("certificates"));
            doctor.setQualifications(request.getParameter("qualifications"));
            String yearsOfExperience = request.getParameter("yearsOfExperience");
            doctor.setYearsOfExperience(yearsOfExperience != null ? Integer.parseInt(yearsOfExperience) : 0);
            doctor.setBiography(request.getParameter("biography"));
            
        }

        boolean success = adminDAO.updateAccount(user, doctor);
        if (success) {
            request.setAttribute("message", "Account updated successfully!");
//            request.setAttribute("messageType", "success");
            response.sendRedirect("listaccount");
        } else {
            request.setAttribute("message", "Failed to update account. Please try again.");
//            request.setAttribute("messageType", "error");
            request.getRequestDispatcher("updateaccount").forward(request, response);
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
