/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package GoogleLogin;

import java.time.LocalDateTime;

/**
 *
 * @author Admin
 */
public class TokenForgetPassword {
    private int id;
    private boolean isUsed;
    private String  userId , token;
    private String type;
    private LocalDateTime expiryTime;

    public TokenForgetPassword() {
    }

    public TokenForgetPassword(int id, boolean isUsed, String userId, String token, String type, LocalDateTime expiryTime) {
        this.id = id;
        this.isUsed = isUsed;
        this.userId = userId;
        this.token = token;
        this.type = type;
        this.expiryTime = expiryTime;
    }
    

    public TokenForgetPassword(int id, boolean isUsed, String userId, String token, LocalDateTime expiryTime) {
        this.id = id;
        this.isUsed = isUsed;
        this.userId = userId;
        this.token = token;
        this.expiryTime = expiryTime;
    }

    

    public TokenForgetPassword(String userId, boolean isUsed, String token, LocalDateTime expiryTime) {
        this.userId = userId;
        this.isUsed = isUsed;
        this.token = token;
        this.expiryTime = expiryTime;
    }
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

   

    public boolean isIsUsed() {
        return isUsed;
    }

    public void setIsUsed(boolean isUsed) {
        this.isUsed = isUsed;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public LocalDateTime getExpiryTime() {
        return expiryTime;
    }

    public void setExpiryTime(LocalDateTime expiryTime) {
        this.expiryTime = expiryTime;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    @Override
    public String toString() {
        return "TokenForgetPassword{" + "id=" + id + ", userId=" + userId + ", isUsed=" + isUsed + ", token=" + token + ", expiryTime=" + expiryTime + '}';
    }
}
