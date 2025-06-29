package UserController;

import DAO.MedicalRecordDAO;
import Model.MedicalRecord;
import Model.User;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "ViewMedicalHistory", urlPatterns = {"/customer-viewmedicalhistory"})
public class ViewMedicalHistory extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        User user = (User) session.getAttribute("user");
        String petName = request.getParameter("search");
        String fromDateStr = request.getParameter("datefrom");
        String toDateStr = request.getParameter("dateto");
        String pageStr = request.getParameter("page");

        Date fromDate = null;
        Date toDate = null;
        int page = 1;
        int pageSize = 5;

        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            if (fromDateStr != null && !fromDateStr.isEmpty()) {
                fromDate = sdf.parse(fromDateStr);
            }
            if (toDateStr != null && !toDateStr.isEmpty()) {
                toDate = sdf.parse(toDateStr);
            }
            if (pageStr != null) {
                page = Integer.parseInt(pageStr);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        MedicalRecordDAO md = new MedicalRecordDAO();

        List<MedicalRecord> list = md.getMedicalRecordsByCustomerId(
                user.getId(), petName, fromDate, toDate, page, pageSize
        );

        int totalRecords = md.countMedicalRecordsByCustomer(user.getId(), petName, fromDate, toDate);
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        request.setAttribute("ListPetsMedical", list);
        
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("petName", petName);
        request.setAttribute("fromDate", fromDateStr);
        request.setAttribute("toDate", toDateStr);

        request.getRequestDispatcher("view/profile/ListMedicalHistory.jsp").forward(request, response);
    }
}
