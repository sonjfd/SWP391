/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package AminController;

import DAO.AdminDao;
import Model.ClinicInfo;
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

/**
 *
 * @author FPT
 */
@MultipartConfig
@WebServlet(name="UpdateClinicInfo", urlPatterns={"/updateclinicinfo"})
public class UpdateClinicInfo extends HttpServlet {
   private static final String IMAGE_DIR = "assets/images";
    private static final long MAX_FILE_SIZE = 5 * 1024 * 1024; // 5MB
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
            out.println("<title>Servlet UpdateClinicInfo</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateClinicInfo at " + request.getContextPath () + "</h1>");
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
        if (id == null || id.isEmpty()) {
            request.setAttribute("message", "Invalid clinic ID!");
            request.setAttribute("messageType", "error");
            request.getRequestDispatcher("listclinicinfo").forward(request, response);
            return;
        }

        try {
            AdminDao adminDAO = new AdminDao();
            ClinicInfo clinic = adminDAO.getClinicInfoById(id);
            if (clinic == null) {
                request.setAttribute("message", "Clinic not found!");
                request.setAttribute("messageType", "error");
                request.getRequestDispatcher("listclinicinfo").forward(request, response);
                return;
            }
            request.setAttribute("clinic", clinic);
            request.getRequestDispatcher("view/admin/content/UpdateClinicInfo.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("message", "Error loading clinic: " + e.getMessage());
            request.setAttribute("messageType", "error");
            request.getRequestDispatcher("listclinicinfo").forward(request, response);
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
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String website = request.getParameter("website");
        String workingHours = request.getParameter("workingHours");
        String description = request.getParameter("description");
        String googleMap = request.getParameter("googleMap");
        Part filePart = request.getPart("logo");

        if (name == null || name.trim().isEmpty()) {
            request.setAttribute("message", "Name is required!");
            request.setAttribute("messageType", "error");
            reloadClinic(request, response, id);
            return;
        }

        ClinicInfo clinic = new ClinicInfo();
        clinic.setId(id);
        clinic.setName(name);
        clinic.setAddress(address);
        clinic.setPhone(phone);
        clinic.setEmail(email);
        clinic.setWebsite(website);
        clinic.setWorkingHours(workingHours);
        clinic.setDescription(description);
        clinic.setGoogleMap(googleMap);

        // Handle file upload
        String logoPath = null;
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = filePart.getSubmittedFileName();
            if (!fileName.endsWith(".png") && !fileName.endsWith(".jpg") && !fileName.endsWith(".jpeg")) {
                request.setAttribute("message", "Only PNG, JPG, JPEG files are allowed!");
                request.setAttribute("messageType", "error");
                reloadClinic(request, response, id);
                return;
            }
            if (filePart.getSize() > MAX_FILE_SIZE) {
                request.setAttribute("message", "File size must be less than 5MB!");
                request.setAttribute("messageType", "error");
                reloadClinic(request, response, id);
                return;
            }

            String uploadPath = getServletContext().getRealPath("") + File.separator + IMAGE_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();
            String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
            logoPath = IMAGE_DIR + File.separator + uniqueFileName;
            filePart.write(uploadPath + File.separator + uniqueFileName);
            clinic.setLogo(logoPath.replace("\\", "/")); // Normalize path
        }

        try {
            AdminDao adminDAO = new AdminDao();
            ClinicInfo existingClinic = adminDAO.getClinicInfoById(id);
            if (existingClinic == null) {
                request.setAttribute("message", "Clinic not found!");
                request.setAttribute("messageType", "error");
                request.getRequestDispatcher("listclinicinfo").forward(request, response);
                return;
            }

            // Keep old logo if no new file uploaded
            if (logoPath == null) {
                clinic.setLogo(existingClinic.getLogo());
            }

            boolean success = adminDAO.updateClinicInfo(clinic);
            if (success) {
                request.setAttribute("message", "Clinic updated successfully!");
                request.setAttribute("messageType", "success");
                response.sendRedirect("listclinicinfo");
            } else {
                request.setAttribute("message", "Failed to update clinic!");
                request.setAttribute("messageType", "error");
                reloadClinic(request, response, id);
            }
        } catch (Exception e) {
            request.setAttribute("message", "Error updating clinic: " + e.getMessage());
            request.setAttribute("messageType", "error");
            reloadClinic(request, response, id);
        }
    }
        
        private void reloadClinic(HttpServletRequest request, HttpServletResponse response, String id) throws ServletException, IOException {
        try {
            AdminDao adminDAO = new AdminDao();
            ClinicInfo clinic = adminDAO.getClinicInfoById(id);
            request.setAttribute("clinic", clinic);
            request.getRequestDispatcher("view/admin/content/UpdateClinicInfo.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("message", "Error loading clinic: " + e.getMessage());
            request.setAttribute("messageType", "error");
            request.getRequestDispatcher("listclinicinfo").forward(request, response);
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
