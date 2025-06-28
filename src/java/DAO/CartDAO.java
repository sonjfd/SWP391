/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author Dell
 */
public class CartDAO {

    public int getCartIdByUserId(String userId) {
        int cartId = -1;
        String sql = "SELECT cart_id FROM cart WHERE user_id = ?";

        try (Connection con = DBContext.getConnection(); PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setString(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                cartId = rs.getInt("cart_id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return cartId;
    }
    
    
    public int createCartForUser(String userId) {
    int newCartId = -1;

    String insertSql = "INSERT INTO cart (user_id, created_at, updated_at) VALUES (?, GETDATE(), GETDATE())";
    String selectSql = "SELECT TOP 1 cart_id FROM cart WHERE user_id = ? ORDER BY created_at DESC";

    try (Connection con = DBContext.getConnection()) {
        try (PreparedStatement insertStmt = con.prepareStatement(insertSql)) {
            insertStmt.setString(1, userId);
            insertStmt.executeUpdate();
        }
        try (PreparedStatement selectStmt = con.prepareStatement(selectSql)) {
            selectStmt.setString(1, userId);
            try (ResultSet rs = selectStmt.executeQuery()) {
                if (rs.next()) {
                    newCartId = rs.getInt("cart_id");
                }
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    return newCartId;
}

 public static void main(String[] args) {
    // Giả lập user ID (UUID phải đúng và tồn tại trong bảng users)
    String testUserId = "C72B501D-715B-4C3C-A770-0572AC939261";

    CartDAO dao = new CartDAO();

    // Bước 1: Kiểm tra cart hiện có
    int cartId = dao.getCartIdByUserId(testUserId);

    if (cartId != -1) {
        System.out.println("Cart đã tồn tại. Cart ID: " + cartId);
    } else {
        System.out.println("Chưa có cart cho user này. Tạo mới...");

        // Bước 2: Tạo mới cart
        int newCartId = dao.createCartForUser(testUserId);
        if (newCartId != -1) {
            System.out.println("Tạo cart thành công. Cart ID mới: " + newCartId);
        } else {
            System.out.println("Tạo cart thất bại.");
        }
    }
}

    
}
