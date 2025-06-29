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
@WebServlet(name="UpdateClinicInfo", urlPatterns={"/admin-update-clinic-info"})
public class UpdateClinicInfo extends HttpServlet {
   private static final String UPLOAD_DIR = "C:/MyUploads/avatars";
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
            request.getRequestDispatcher("admin-list-clinic-info").forward(request, response);
            return;
        }

        try {
            AdminDao adminDAO = new AdminDao();
            ClinicInfo clinic = adminDAO.getClinicInfoById(id);
            if (clinic == null) {
                request.setAttribute("message", "Clinic not found!");
                request.setAttribute("messageType", "error");
                request.getRequestDispatcher("admin-list-clinic-info").forward(request, response);
                return;
            }
            request.setAttribute("clinic", clinic);
            request.getRequestDispatcher("view/admin/content/UpdateClinicInfo.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("message", "Error loading clinic: " + e.getMessage());
            request.setAttribute("messageType", "error");
            request.getRequestDispatcher("admin-list-clinic-info").forward(request, response);
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

    String logoPath = null;
    AdminDao adminDAO = new AdminDao();

    try {
        ClinicInfo existingClinic = adminDAO.getClinicInfoById(id);

        if (filePart != null && filePart.getSize() > 0) {
            String fileName = filePart.getSubmittedFileName().toLowerCase();

            // Validate file extension
            if (!fileName.endsWith(".png") && !fileName.endsWith(".jpg") && !fileName.endsWith(".jpeg")) {
                request.setAttribute("message", "Only PNG, JPG, JPEG files are allowed!");
                request.setAttribute("messageType", "error");
                reloadClinic(request, response, id);
                return;
            }

            // Validate file size
            if (filePart.getSize() > MAX_FILE_SIZE) {
                request.setAttribute("message", "File size must be less than 5MB!");
                request.setAttribute("messageType", "error");
                reloadClinic(request, response, id);
                return;
            }

            // Ensure upload directory exists
            File uploadDir = new File(UPLOAD_DIR);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // Delete old file if exists
            if (existingClinic != null && existingClinic.getLogo() != null && existingClinic.getLogo().contains("/image-loader/")) {
                String oldFileName = existingClinic.getLogo().substring(existingClinic.getLogo().lastIndexOf("/") + 1);
                File oldFile = new File(uploadDir, oldFileName);
                if (oldFile.exists()) {
                    oldFile.delete();
                }
            }

            // Save new file
            String fileExtension = fileName.substring(fileName.lastIndexOf("."));
            String uniqueFileName = java.util.UUID.randomUUID().toString() + fileExtension;
            File savedFile = new File(uploadDir, uniqueFileName);
            filePart.write(savedFile.getAbsolutePath());

            // Set logo path for DB
            logoPath = request.getContextPath() + "/image-loader/" + uniqueFileName;
            clinic.setLogo(logoPath);
        } else {
            // No file uploaded → keep existing logo
            if (existingClinic != null) {
                clinic.setLogo(existingClinic.getLogo());
            }
        }

        // Update clinic info in DB
        boolean success = adminDAO.updateClinicInfo(clinic);

        if (success) {
            request.setAttribute("message", "Clinic updated successfully!");
            request.setAttribute("messageType", "success");
            response.sendRedirect("admin-list-clinic-info");
        } else {
            request.setAttribute("message", "Failed to update clinic!");
            request.setAttribute("messageType", "error");
            reloadClinic(request, response, id);
        }

    } catch (Exception e) {
        e.printStackTrace();
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
            request.getRequestDispatcher("admin-list-clinic-info").forward(request, response);
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
