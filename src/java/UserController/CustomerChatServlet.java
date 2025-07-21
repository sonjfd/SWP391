package UserController;

import DAO.ChatDAO;
import Model.Conversation;
import Model.Messages;
import Model.User;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@WebServlet("/customer-chat")
public class CustomerChatServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null) {
            response.sendRedirect("login");
            return;
        }

        // Nếu là gọi để lấy JSON tin nhắn
        if ("true".equals(request.getParameter("ajax"))) {
            String conversationId = request.getParameter("conversationId");
            if (conversationId == null || conversationId.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing conversationId");
                return;
            }

            ChatDAO cd = new ChatDAO();
            List<Messages> messages = cd.getMessagesByConversation(conversationId);

            // Chuyển danh sách messages sang JSON
            List<Map<String, String>> result = new ArrayList<>();
            for (Messages m : messages) {
                Map<String, String> map = new HashMap<>();
                map.put("senderName", m.getSender().getFullName());
                map.put("content", m.getContent());
                map.put("senderId", m.getSender().getId());
                result.add(map);
            }

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            new com.google.gson.Gson().toJson(result, response.getWriter());
            return;
        }

        // Nếu không phải AJAX → xử lý render Chat.jsp như cũ
        try {
            ChatDAO cd = new ChatDAO();
            Conversation conv = cd.getConversationByCustomerId(currentUser.getId());

            if (conv == null) {
                String assignStaffId = cd.getCurrentConsultingStaffId();
                String conversationId = UUID.randomUUID().toString();
                cd.createConversation(conversationId, currentUser.getId(), assignStaffId);
                request.setAttribute("conversationId", conversationId);
                request.setAttribute("messages", new ArrayList<Messages>());
            } else {
                request.setAttribute("conversationId", conv.getId());
                List<Messages> messages = cd.getMessagesByConversation(conv.getId());
                request.setAttribute("messages", messages);
            }

            request.setAttribute("currentUser", currentUser);
            request.getRequestDispatcher("view/profile/Chat.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
