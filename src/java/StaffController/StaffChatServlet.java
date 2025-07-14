/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package StaffController;

import DAO.ChatDAO;
import Model.Conversation;
import Model.Messages;
import Model.User;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Admin
 */
@WebServlet(urlPatterns = {
    "/staff-conversations",         // hiển thị danh sách
    "/staff-search-conversations",  // tìm kiếm
    "/staff-get-messages"           // lấy tin nhắn
})
public class StaffChatServlet extends HttpServlet {
    private final ChatDAO chatDAO = new ChatDAO();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        switch (path) {
            case "/staff-conversations":
                handleConversationList(request, response, user);
                break;
            case "/staff-search-conversations":
                handleSearchConversations(request, response, user);
                break;
            case "/staff-get-messages":
                handleGetMessages(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void handleConversationList(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        List<Conversation> list = chatDAO.getConversationsForStaff(user.getId(), keyword);
        request.setAttribute("conversations", list);
        request.getRequestDispatcher("view/staff/content/ChatList.jsp").forward(request, response);
    }

    private void handleSearchConversations(HttpServletRequest request, HttpServletResponse response, User user)
            throws IOException {
        String keyword = request.getParameter("keyword") != null ? request.getParameter("keyword").trim() : "";
        List<Conversation> conversations = keyword.isBlank()
                ? chatDAO.getConversationsForStaff(user.getId(), keyword)
                : chatDAO.searchConversations(keyword);

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print(gson.toJson(conversations));
        out.flush();
    }

    private void handleGetMessages(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String conversationId = request.getParameter("conversationId");
        List<Messages> list = chatDAO.getMessagesByConversation(conversationId);

        List<Map<String, String>> result = new ArrayList<>();
        for (Messages m : list) {
            Map<String, String> map = new HashMap<>();
            map.put("senderName", m.getSender().getFullName());
            map.put("content", m.getContent());
            map.put("senderId", m.getSender().getId());
            result.add(map);
        }

        response.setContentType("application/json");
        gson.toJson(result, response.getWriter());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
    }
}

