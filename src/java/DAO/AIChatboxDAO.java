/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.ChatHistory;
import Model.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.sql.Connection;
import java.util.UUID;

/**
 *
 * @author Dell
 */
public class AIChatboxDAO {

    public void insertMessage(String sessionId, String userId, String senderType, String messageText) {
        String sql = "INSERT INTO ChatHistory (session_id, user_id, sender_type, message_text, created_at) VALUES (?, ?, ?, ?, GETDATE())";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, sessionId);
            ps.setString(2, userId);
            ps.setString(3, senderType);
            ps.setString(4, messageText);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<ChatHistory> getChatHistoryByUserId(String userId) {
        List<ChatHistory> list = new ArrayList<>();
        String sql = "select chat_id,session_id,u.id,c.sender_type,c.message_text,c.created_at,u.avatar\n"
                + "from ChatHistory c\n"
                + "join users u\n"
                + "on c.user_id=u.id\n"
                + "where c.user_id=? \n"
                + "order by c.created_at asc";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ChatHistory chat = new ChatHistory();
                chat.setId(rs.getInt("chat_id"));
                chat.setSessionId(rs.getString("session_id"));
                chat.setSenderType(rs.getString("sender_type"));
                chat.setMessageText(rs.getString("message_text"));
                chat.setCreated_at(rs.getTimestamp("created_at").toLocalDateTime());

                User u = new User();
                u.setId(String.valueOf(userId));
                u.setAvatar(rs.getString("avatar"));
                chat.setUser(u);

                list.add(chat);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<ChatHistory> getChatHistoryBySession(String sessionId) {
        List<ChatHistory> list = new ArrayList<>();
        String sql = "SELECT * FROM ChatHistory WHERE session_id = ? AND user_id IS NULL ORDER BY created_at ASC";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, sessionId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ChatHistory chat = new ChatHistory();
                chat.setSessionId(rs.getString("session_id"));
                chat.setSenderType(rs.getString("sender_type"));
                chat.setMessageText(rs.getString("message_text"));
                chat.setCreated_at(rs.getTimestamp("created_at").toLocalDateTime());

                list.add(chat);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<ChatHistory> getChatHistory(String sessionId, String userId) {
        List<ChatHistory> list = new ArrayList<>();
        String sql = "SELECT * FROM ChatHistory WHERE session_id = ? OR user_id = ? ORDER BY created_at ASC";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, sessionId);
            ps.setString(2, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToChat(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    private ChatHistory mapResultSetToChat(ResultSet rs) {
        ChatHistory chat = new ChatHistory();
        try {
            chat.setSessionId(rs.getString("session_id"));
            chat.setSenderType(rs.getString("sender_type"));
            chat.setMessageText(rs.getString("message_text"));
            chat.setCreated_at(rs.getTimestamp("created_at").toLocalDateTime());

            String uid = rs.getString("user_id");
            if (uid != null && !uid.trim().isEmpty()) {
                User u = new User();
                u.setId(uid);
                chat.setUser(u);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return chat;
    }

    public void updateMessagesWithUserId(String sessionId, String userId) {
        String sql = "UPDATE ChatHistory SET user_id = ? WHERE session_id = ? AND user_id IS NULL";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, userId);
            ps.setString(2, sessionId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    public static void main(String[] args) {
        AIChatboxDAO dao = new AIChatboxDAO();
        String userId = "C72B501D-715B-4C3C-A770-0572AC939261";
        List<ChatHistory> list = dao.getChatHistoryByUserId(userId);

        System.out.println("===== Chat History của user ID: " + userId + " =====");
        for (ChatHistory chat : list) {
            String sender = chat.getSenderType();
            String message = chat.getMessageText();
            String time = chat.getCreated_at().toString();
            System.out.println("[" + time + "] " + sender.toUpperCase() + ": " + message);
        }
    }

}
