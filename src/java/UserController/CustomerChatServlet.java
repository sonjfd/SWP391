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
import java.util.List;
import java.util.UUID;

@WebServlet("/customer-chat")
public class CustomerChatServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            ChatDAO cd = new ChatDAO();
            Conversation conv = cd.getConversationByCustomerId(currentUser.getId());
            if (conv == null) {
                
                // Nếu chưa có, tạo conversation mới với staff chỉ định
                
                String assignStaffId = cd.getCurrentConsultingStaffId();
                String conversationId = UUID.randomUUID().toString();
                cd.createConversation(conversationId, currentUser.getId(), assignStaffId);
                request.setAttribute("conversationId", conversationId);
                request.setAttribute("messages", new ArrayList<Messages>());  // chưa có tin nhắn
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