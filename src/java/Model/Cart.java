/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.Date;

/**
 *
 * @author Dell
 */
public class Cart {
    private int id;
    private User user;
    private Date createdAt;
    private Date updateAt;

    public Cart() {
    }

    public Cart(int id, User user, Date createdAt, Date updateAt) {
        this.id = id;
        this.user = user;
        this.createdAt = createdAt;
        this.updateAt = updateAt;
    }

    public Cart(int id, User user) {
        this.id = id;
        this.user = user;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdateAt() {
        return updateAt;
    }

    public void setUpdateAt(Date updateAt) {
        this.updateAt = updateAt;
    }

    @Override
    public String toString() {
        return "Card{" + "id=" + id + ", user=" + user + ", createdAt=" + createdAt + ", updateAt=" + updateAt + '}';
    }
    
    
}
