/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package CommonController;

import DAO.BlogDAO;
import DAO.ClinicInfoDAO;
import DAO.DoctorDAO;
import DAO.ServiceDAO;
import DAO.SliderDAO;
import Model.Blog;
import Model.ClinicInfo;
import Model.Doctor;
import Model.Service;
import Model.Slider;
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
 * @author ASUS
 */

@WebServlet("/homeblog")
public class HomeBlog extends HttpServlet {
   
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
            out.println("<title>Servlet HomeBlog</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomeBlog at " + request.getContextPath () + "</h1>");
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
         BlogDAO blogDAO = new BlogDAO();
         // Lấy tất cả blog từ cơ sở dữ liệu
         // Lưu vào request
        ClinicInfo clinicInfo = new ClinicInfo();
        SliderDAO dao = new SliderDAO();
        List<Service> services = new ServiceDAO().getAllServices();
        
        
        try {
            ClinicInfoDAO clinicInfoDAO = new ClinicInfoDAO();
            clinicInfo = clinicInfoDAO.getClinicInfo();  // Lấy thông tin phòng khám từ database
        } catch (Exception e) {
            e.printStackTrace();  // Xử lý lỗi
        }
        request.setAttribute("services", services);

        
        request.setAttribute("clinicInfo", clinicInfo);
        

        
        String index_raw = request.getParameter("index");
        int index =0;
        if(index_raw==null){
            index=1;
        }else{
        index = Integer.parseInt(index_raw);}
        
        List<Blog> blogsAll = blogDAO.getAllBlogs();
        List<Blog> blogs = blogDAO.getPaginationBlog(index);
        int endP = blogsAll.size()/6;
        if(blogsAll.size()%6!=0){
            endP+=1;
        }
        request.setAttribute("endP", endP);
        
        request.setAttribute("blogs", blogs);
        request.getRequestDispatcher("/view/home/content/Blog.jsp").forward(request, response);
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
        processRequest(request, response);
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
