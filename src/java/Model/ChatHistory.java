/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.time.LocalDateTime;

/**
 *
 * @author Dell
 */
public class ChatHistory {
    private int id;
    private String sessionId;
    private User user;
    private String senderType;
        private String messageText;

    public ChatHistory(String sessionId, User user, String senderType, String messageText) {
        this.sessionId = sessionId;
        this.user = user;
        this.senderType = senderType;
        this.messageText = messageText;
    }

    public ChatHistory(String sessionId, String senderType, String messageText) {
        this.sessionId = sessionId;
        this.senderType = senderType;
        this.messageText = messageText;
    }

    public String getMessageText() {
        return messageText;
    }

    public void setMessageText(String messageText) {
        this.messageText = messageText;
    }
    private LocalDateTime created_at;

    public ChatHistory() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getSessionId() {
        return sessionId;
    }

    public void setSessionId(String sessionId) {
        this.sessionId = sessionId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getSenderType() {
        return senderType;
    }

    public void setSenderType(String senderType) {
        this.senderType = senderType;
    }

    public LocalDateTime getCreated_at() {
        return created_at;
    }

    public void setCreated_at(LocalDateTime created_at) {
        this.created_at = created_at;
    }

    @Override
    public String toString() {
        return "ChatHistory{" + "id=" + id + ", sessionId=" + sessionId + ", user=" + user + ", senderType=" + senderType + ", created_at=" + created_at + '}';
    }
    
    

}
