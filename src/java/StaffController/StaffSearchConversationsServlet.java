package StaffController;

import DAO.ChatDAO;
import Model.Conversation;
import Model.User;

import com.google.gson.Gson;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/staff-search-conversations")
public class StaffSearchConversationsServlet extends HttpServlet {

    private final ChatDAO chatDAO = new ChatDAO();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword").trim();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        String staffId = user.getId();
        try {
            if (keyword.isEmpty()||keyword == null||keyword.isBlank()) {
                List<Conversation> conversations = chatDAO.getConversationsForStaff(staffId, keyword);
                response.setContentType("application/json");
                PrintWriter out = response.getWriter();
                out.print(gson.toJson(conversations));
                out.flush();
            } else {
                List<Conversation> conversations = chatDAO.searchConversations(keyword);
                response.setContentType("application/json");
                PrintWriter out = response.getWriter();
                out.print(gson.toJson(conversations));
                out.flush();
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500);
        }
    }
}
