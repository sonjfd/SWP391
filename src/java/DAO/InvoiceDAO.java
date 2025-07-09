/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Invoice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class InvoiceDAO extends DBContext {

    public List<Invoice> getInvoicesByFilter(Date searchDate, String paymentStatus, int page, int pageSize) throws Exception {
        List<Invoice> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM sales_invoices WHERE 1=1 ");

        // Thêm điều kiện nếu có searchDate
        if (searchDate != null) {
            sql.append("AND CAST(created_at AS DATE) = ? ");
        }

        // Thêm điều kiện nếu có paymentStatus
        if (paymentStatus != null && !paymentStatus.isEmpty()) {
            sql.append("AND payment_status = ? ");
        }

        sql.append("ORDER BY created_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int paramIndex = 1;

            if (searchDate != null) {
                ps.setDate(paramIndex++, new java.sql.Date(searchDate.getTime()));
            }

            if (paymentStatus != null && !paymentStatus.isEmpty()) {
                ps.setString(paramIndex++, paymentStatus);
            }

            ps.setInt(paramIndex++, (page - 1) * pageSize);
            ps.setInt(paramIndex, pageSize);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Invoice invoice = new Invoice();
                invoice.setInvoiceId(rs.getString("invoice_id"));
                invoice.setStaffId(rs.getString("staff_id"));
                invoice.setTotalAmount(rs.getDouble("total_amount"));
                invoice.setPaymentMethod(rs.getString("payment_method"));
                invoice.setPaymentStatus(rs.getString("payment_status"));
                invoice.setCreatedAt(rs.getTimestamp("created_at"));
                invoice.setUpdatedAt(rs.getTimestamp("updated_at"));
                list.add(invoice);
            }
        }
        return list;
    }

    public int countInvoicesByFilter(Date searchDate, String paymentStatus) throws Exception {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM sales_invoices WHERE 1=1 ");

        if (searchDate != null) {
            sql.append("AND CAST(created_at AS DATE) = ? ");
        }

        if (paymentStatus != null && !paymentStatus.isEmpty()) {
            sql.append("AND payment_status = ? ");
        }

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int paramIndex = 1;

            if (searchDate != null) {
                ps.setDate(paramIndex++, new java.sql.Date(searchDate.getTime()));
            }

            if (paymentStatus != null && !paymentStatus.isEmpty()) {
                ps.setString(paramIndex++, paymentStatus);
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public boolean updateInvoicePayment(String invoiceId, String paymentMethod, String payment_status, String StaffId) throws Exception {
        String sql = "UPDATE sales_invoices \n"
                + "SET payment_method = ?, payment_status = ?, staff_id = ?, updated_at = GETDATE()\n"
                + "WHERE invoice_id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, paymentMethod);
            ps.setString(2, payment_status);
            ps.setString(4, invoiceId);
            ps.setString(3, StaffId);

            return ps.executeUpdate() > 0;
        }
    }

    public Invoice getInvoiceById(String invoiceId) {
        String sql = "SELECT invoice_id, total_amount, payment_method FROM sales_invoices WHERE invoice_id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, invoiceId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Invoice invoice = new Invoice();
                invoice.setInvoiceId(rs.getString("invoice_id"));
                invoice.setTotalAmount(rs.getDouble("total_amount"));
                invoice.setPaymentMethod(rs.getString("payment_method"));
                return invoice;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

}
