package AminController;

import DAO.RatingDAO;
import Model.Rating;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminListRating", urlPatterns = {"/admin-listratings"})
public class AdminListRating extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String customerName = request.getParameter("search");
        String status = request.getParameter("status");
        String pageStr = request.getParameter("page");

        int page = 1;
        int pageSize = 5;

        try {
            if (pageStr != null) {
                page = Integer.parseInt(pageStr);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        RatingDAO rd = new RatingDAO();
        List<Rating> rlist = rd.getRatings(customerName, status, page, pageSize);
        int totalRecords = rd.countRatings(customerName, status);
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        request.setAttribute("RateList", rlist);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("search", customerName);
        request.setAttribute("status", status);

        request.getRequestDispatcher("view/admin/content/ManageRatings.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String ratingId = request.getParameter("ratingId");
        String status = request.getParameter("status");

        RatingDAO dao = new RatingDAO();

        if (dao.updateRatingStatus(ratingId, status)) {
            request.getSession().setAttribute("SuccessMessage", "Cập nhật trạng thái thành công");
        } else {
            request.getSession().setAttribute("FailMessage", "Cập nhật trạng thái không thành công");
        }

        response.sendRedirect("admin-listratings");
    }
}
