/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.CartItem;
import Model.Product;
import Model.ProductVariant;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Dell
 */
public class CartItemDAO {

    public int insertCartItem(int cardId, int variantId, int quantity) {
        String sql = "INSERT INTO [dbo].[cart_items]\n"
                + "           ([cart_id]\n"
                + "           ,[product_variant_id]\n"
                + "           ,[quantity])\n"
                + "     VALUES\n"
                + "         (?,?,?)";
        int result = -1;
        try {
            Connection conn = DBContext.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, cardId);
            stm.setInt(2, variantId);
            stm.setInt(3, quantity);
            result = stm.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public boolean checkItemExists(int cartId, int variantId) {
        String sql = "SELECT 1 FROM cart_items WHERE cart_id = ? AND product_variant_id = ?";
        try (Connection con = DBContext.getConnection(); PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setInt(1, cartId);
            stmt.setInt(2, variantId);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public int updateQuantity(int cartId, int variantId, int addQuantity) {
        String sql = "UPDATE cart_items SET quantity = quantity + ? WHERE cart_id = ? AND product_variant_id = ?";
        try (Connection con = DBContext.getConnection(); PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setInt(1, addQuantity);
            stmt.setInt(2, cartId);
            stmt.setInt(3, variantId);
            return stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<CartItem> getItemsByCartId(int cartId) {
        List<CartItem> list = new ArrayList<>();
        String sql = """
                     SELECT 
                         ci.id AS cart_item_id,
                         ci.quantity,
                         
                         pv.product_variant_id,
                         pv.price,
                         pv.stock_quantity,
                         pv.image,
                         
                         p.product_id,
                         p.product_name ,
                         
                         weight,
                         f.flavor AS flavor_name,
                         c.category_name AS category_name
                     FROM cart_items ci
                     JOIN product_variants pv 
                         ON ci.product_variant_id = pv.product_variant_id
                     JOIN products p 
                         ON pv.product_id = p.product_id
                     LEFT JOIN product_variant_weights w 
                         ON pv.weight_id = w.weight_id
                     LEFT JOIN product_variant_flavors f 
                         ON pv.flavor_id = f.flavor_id
                     LEFT JOIN categories c 
                         ON p.category_id = c.category_id
                     
                     WHERE ci.cart_id = ?
                     """;

        try (Connection con = DBContext.getConnection(); PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setInt(1, cartId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                CartItem item = new CartItem();
                item.setId(rs.getInt("cart_item_id"));
                item.setQuantity(rs.getInt("quantity"));

                ProductVariant variant = new ProductVariant();
                variant.setProductVariantId(rs.getInt("product_variant_id"));
                variant.setPrice(rs.getDouble("price"));
                variant.setStockQuantity(rs.getInt("stock_quantity"));
                variant.setImage(rs.getString("image"));

                variant.setProductId(rs.getInt("product_id"));
                variant.setProductName(rs.getString("product_name"));
                variant.setWeight(rs.getDouble("weight"));
                variant.setFlavorName(rs.getString("flavor_name"));
                variant.setCategoryName(rs.getString("category_name"));

                item.setVariant(variant);
                list.add(item);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public boolean deleteCartItemById(int cartItemId) {
    String sql = "DELETE FROM cart_items WHERE id = ?";
    try (Connection con = DBContext.getConnection();
         PreparedStatement stmt = con.prepareStatement(sql)) {
        stmt.setInt(1, cartItemId);
        return stmt.executeUpdate() > 0;
    } catch (Exception e) {
        e.printStackTrace();
        return false;
    }
}

    
    public boolean deleteItemsByCartId(int cartId) {
    String sql = "DELETE FROM cart_items WHERE cart_id = ?";
    try (Connection con = DBContext.getConnection();
         PreparedStatement stmt = con.prepareStatement(sql)) {
        stmt.setInt(1, cartId);
        return stmt.executeUpdate() > 0;
    } catch (Exception e) {
        e.printStackTrace();
        return false;
    }
}


    public static void main(String[] args) {
     
        
    }
}
