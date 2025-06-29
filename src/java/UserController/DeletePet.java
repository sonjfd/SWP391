/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package UserController;

import DAO.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
@WebServlet(name = "DeletePet", urlPatterns = {"/customer-deletepet"})
public class DeletePet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("view/profile/ListPet.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idpet = (String) request.getParameter("id");
        if (idpet == null) {
            response.sendRedirect("customer-viewlistpet");
            return;
        }
        UserDAO ud = new UserDAO();
        if (ud.deletePet(idpet)) {
            request.getSession().setAttribute("SuccessMessage", "Xóa Pet thành công");
            response.sendRedirect("customer-viewlistpet");
        } else {
            request.getSession().setAttribute("FailMessage", "Xóa Pet thất bại");
            response.sendRedirect("customer-viewlistpet");
        }
    }

    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
