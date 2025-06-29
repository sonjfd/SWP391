/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.Date;

/**
 *
 * @author Admin
 */
public class Messages {
    private String id;
    private Conversation conversation;
    private User sender;
    private String content;
    private Date sent_at;

    public Messages() {
    }

    public Messages(String id, Conversation conversation, User sender, String content, Date sent_at) {
        this.id = id;
        this.conversation = conversation;
        this.sender = sender;
        this.content = content;
        this.sent_at = sent_at;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Conversation getConversation() {
        return conversation;
    }

    public void setConversation(Conversation conversation) {
        this.conversation = conversation;
    }

    public User getSender() {
        return sender;
    }

    public void setSender(User sender) {
        this.sender = sender;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getSent_at() {
        return sent_at;
    }

    public void setSent_at(Date sent_at) {
        this.sent_at = sent_at;
    }

    @Override
    public String toString() {
        return "Messages{" + "id=" + id + ", conversation=" + conversation + ", sender=" + sender + ", content=" + content + ", sent_at=" + sent_at + '}';
    }
    
}
