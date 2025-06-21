/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package NurseController;

import DAO.FileUploadedDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author ASUS
 */
@MultipartConfig
@WebServlet("/nurse-deleteuploadedfileajax")
public class DeleteUploadedFileAjax extends HttpServlet {
   
    
    

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        boolean success = false;
    String fileId = request.getParameter("id");
    if (fileId != null) {
        success = new FileUploadedDAO().deleteById(fileId);
    }
    response.setContentType("application/json");
    response.getWriter().write("{\"success\":" + success + "}");
    }

    
}
