package websocket;

import DAO.ChatDAO;
import Model.Conversation;
import Model.Messages;
import Model.User;

import jakarta.websocket.*;
import jakarta.websocket.server.PathParam;
import jakarta.websocket.server.ServerEndpoint;
import java.sql.SQLException;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

@ServerEndpoint(value = "/chat/{conversationId}/{userId}/{fullName}")
public class WebSocketChat {

    private static final Map<String, Session> sessions = new ConcurrentHashMap<>();
    private static final ChatDAO chatDAO = new ChatDAO();

    @OnOpen
    public void onOpen(Session session,
            @PathParam("conversationId") String conversationId,
            @PathParam("userId") String userId,
            @PathParam("fullName") String fullName) {

        session.getUserProperties().put("conversationId", conversationId);
        session.getUserProperties().put("userId", userId);
        session.getUserProperties().put("fullName", fullName);

        sessions.put(session.getId(), session);
        System.out.println("User " + fullName + " joined conversation " + conversationId);
    }

    @OnMessage
    public void onMessage(String message, Session session) {
        String conversationId = (String) session.getUserProperties().get("conversationId");
        String senderId = (String) session.getUserProperties().get("userId");
        String senderName = (String) session.getUserProperties().get("fullName");
        if (message.startsWith("READ:")) {
            chatDAO.markMessagesAsRead(conversationId, senderId); 
            System.out.println("Marked messages as read for conversation " + conversationId + " by user " + senderId);
            return;
        }
        // Lưu vào DB
        Messages msg = new Messages();
        msg.setContent(message);
        msg.setSent_at(new Date());

        User sender = new User();
        sender.setId(senderId);
        sender.setFullName(senderName);
        msg.setSender(sender);

        Conversation conv = new Conversation();
        conv.setId(conversationId);
        msg.setConversation(conv);

        chatDAO.saveMessage(msg);

        // Gửi realtime cho các client cùng conversation
        sessions.values().forEach(s -> {
            if (conversationId.equals(s.getUserProperties().get("conversationId")) && s.isOpen()) {
                try {
                    s.getBasicRemote().sendText(senderName + ": " + message);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        });
    }

    @OnError
    public void onError(Session session, Throwable throwable) {
        System.err.println("WebSocket Error - Session " + session.getId() + ": " + throwable.getMessage());
        throwable.printStackTrace();
    }

    @OnClose
    public void onClose(Session session) {
        sessions.remove(session.getId());
        System.out.println("User disconnected: " + session.getId());
    }
}
