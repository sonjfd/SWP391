/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package CommonController;

import DAO.BlogDAO;
import DAO.BreedDAO;
import DAO.ClinicInfoDAO;
import DAO.DoctorDAO;
import DAO.RatingDAO;
import DAO.ServiceDAO;
import DAO.SliderDAO;
import DAO.SpecieDAO;
import DAO.UserDAO;
import Model.Blog;
import Model.Breed;
import Model.ClinicInfo;
import Model.Doctor;
import Model.Rating;
import Model.Service;
import Model.Slider;
import Model.Specie;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ASUS
 */
@WebServlet("/homepage")
public class HomePage extends HttpServlet {

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
            out.println("<title>Servlet HomePage</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomePage at " + request.getContextPath() + "</h1>");
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
        BlogDAO blogDAO = new BlogDAO();
        List<Blog> blogs = blogDAO.getAllBlogs(); // Lấy tất cả blog
        request.setAttribute("blogs", blogs); // Đặt vào request attribute
        ClinicInfo clinicInfo = new ClinicInfo();
        SliderDAO dao = new SliderDAO();
        List<Service> services = new ServiceDAO().getAllServices();
        List<Slider> sliders = dao.getActiveSliders();
        List<Doctor> doctors = new DoctorDAO().getDoctorLimit(5);
        try {
            ClinicInfoDAO clinicInfoDAO = new ClinicInfoDAO();
            clinicInfo = clinicInfoDAO.getClinicInfo();  // Lấy thông tin phòng khám từ database
        } catch (Exception e) {
            e.printStackTrace();  // Xử lý lỗi
        }
        HttpSession ss = request.getSession();
        ss.setAttribute("services", services);
//        request.setAttribute("services", services);

        request.setAttribute("sliders", sliders);
        ss.setAttribute("clinicInfo", clinicInfo);
        request.setAttribute("doctors", doctors);

//        ui phan specie , breed
        SpecieDAO specieDAO = new SpecieDAO();
        BreedDAO breedDAO = new BreedDAO();

        List<Specie> speciesList = specieDAO.getAllSpecies();
        List<Breed> breedList = breedDAO.getAllBreedsWithSpecie();

        for (Specie specie : speciesList) {
            List<Breed> breedsOfThisSpecie = new ArrayList<>();
            for (Breed breed : breedList) {
                if (breed.getSpecie().getId() == specie.getId()) {
                    breedsOfThisSpecie.add(breed);
                }
            }
            // Thêm setter List<Breed> breeds vào Specie nếu chưa có
            specie.setBreeds(breedsOfThisSpecie);
        }

        List<Rating> listRate = new RatingDAO().getAllRatingsPosted();
        request.setAttribute("listRate", listRate);

        request.setAttribute("speciesList", speciesList);
        request.getRequestDispatcher("/view/home/content/Home.jsp").forward(request, response);
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
