package UserController;

import DAO.UserDAO;
import Model.Pet;
import Model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

@WebServlet(name = "ViewListPet", urlPatterns = {"/customer-viewlistpet"})
public class ViewListPet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        User user = (User) session.getAttribute("user");
        UserDAO udao = new UserDAO();

        String petName = request.getParameter("search");
        String status = request.getParameter("status");
        String pageStr = request.getParameter("page");

        int page = 1;
        int pageSize = 5; // Số lượng bản ghi mỗi trang

        try {
            if (pageStr != null) {
                page = Integer.parseInt(pageStr);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        List<Pet> listpet = udao.getPetsByUser(user.getId(), petName, status, page, pageSize);
        int totalRecords = udao.countPetsByUser(user.getId(), petName, status);
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        if (listpet.isEmpty()) {
            request.setAttribute("Message", "Bạn chưa thêm thú cưng nào hoặc không tìm thấy kết quả phù hợp!");
        }

        request.setAttribute("listpet", listpet);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("petName", petName);
        request.setAttribute("status", status);

        request.getRequestDispatcher("view/profile/ListPet.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        doGet(request, response); // Hỗ trợ form method="post" hoạt động
    }
}
