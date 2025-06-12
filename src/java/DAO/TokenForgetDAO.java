/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import GoogleLogin.TokenForgetPassword;
import Model.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.sql.Connection;

/**
 *
 * @author Admin
 */
public class TokenForgetDAO {

    Connection connection;

    public TokenForgetDAO() {
        DBContext db = new DBContext();
        this.connection = db.getConnection();
    }

    // Format LocalDateTime để lưu vào DB
    private String getFormatDate(java.time.LocalDateTime time) {
        return time.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }

    // ✅ Thêm token bao gồm cả type (ví dụ: ACTIVATE, RESET)
    public boolean insertTokenForget(TokenForgetPassword tokenForget) {
        String sql = "INSERT INTO [dbo].[tokenForgetPassword] ([token], [expiryTime], [isUsed], [userId], [type]) VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, tokenForget.getToken());
            ps.setTimestamp(2, Timestamp.valueOf(getFormatDate(tokenForget.getExpiryTime())));
            ps.setBoolean(3, tokenForget.isIsUsed());
            ps.setString(4, tokenForget.getUserId());
            ps.setString(5, tokenForget.getType());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public TokenForgetPassword getTokenPassword(String token) {
        String sql = "SELECT * FROM tokenForgetPassword WHERE token = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, token);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                TokenForgetPassword tokenObj = new TokenForgetPassword(
                        rs.getString("userId"),
                        rs.getBoolean("isUsed"),
                        rs.getString("token"),
                        rs.getTimestamp("expiryTime").toLocalDateTime()
                );
                tokenObj.setId(rs.getInt("id"));
                tokenObj.setType(rs.getString("type"));
                return tokenObj;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

   
    public void updateStatus(TokenForgetPassword token) {
        String sql = "UPDATE [dbo].[tokenForgetPassword] SET [isUsed] = ? WHERE token = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setBoolean(1, token.isIsUsed());
            st.setString(2, token.getToken());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("UpdateStatus error: " + e.getMessage());
        }
    }

    public static void main(String[] args) {
        TokenForgetDAO dao = new TokenForgetDAO();

        TokenForgetPassword token = new TokenForgetPassword();
        token.setToken("test-token-123");
        token.setExpiryTime(LocalDateTime.now().plusMinutes(3));
        token.setIsUsed(false);
        token.setUserId("2A6D3712-7C97-4FA3-BFA0-068AD2B468AC");
        token.setType("RESET");  // hoặc "RESET"

        boolean success = dao.insertTokenForget(token);

        if (success) {
            System.out.println("✅ Insert token thành công!");
        } else {
            System.out.println("❌ Insert token thất bại!");
        }
    }

}
