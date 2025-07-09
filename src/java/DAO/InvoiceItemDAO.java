/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.InvoiceItem;

import java.sql.*;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class InvoiceItemDAO extends DBContext {

    public List<InvoiceItem> getItemsByInvoiceId(String invoiceId) {
        List<InvoiceItem> items = new ArrayList<>();
        String sql = "SELECT \n"
                + "    sii.id,\n"
                + "    sii.invoice_id,\n"
                + "    sii.product_variant_id,\n"
                + "    sii.quantity,\n"
                + "    sii.price,\n"
                + "    p.product_name\n"
                + "FROM sales_invoice_items sii\n"
                + "JOIN product_variants pv ON sii.product_variant_id = pv.product_variant_id\n"
                + "JOIN products p ON pv.product_id = p.product_id\n"
                + "WHERE sii.invoice_id = ? ";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, invoiceId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                InvoiceItem item = new InvoiceItem();
                item.setId(rs.getInt("id"));
                item.setInvoiceId(rs.getString("invoice_id"));
                item.setProductVariantId(rs.getInt("product_variant_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setPrice(rs.getDouble("price"));
                item.setProductName(rs.getString("product_name"));
                items.add(item);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return items;
    }


}
