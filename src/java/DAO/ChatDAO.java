package DAO;

import Model.Conversation;
import Model.Messages;
import Model.Role;
import Model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ChatDAO {

    public Conversation getConversationByCustomerId(String customerId) {
        String sql = "SELECT * FROM conversations WHERE customer_id = ?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, customerId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Conversation c = new Conversation();
                c.setId(rs.getString("conversation_id"));
                c.setCustomer(new User(rs.getString("customer_id")));
                c.setStaff(new User(rs.getString("staff_id")));
                c.setCreated_at(rs.getTimestamp("created_at"));
                c.setLast_masage_time(rs.getTimestamp("last_message_time"));
                return c;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Conversation> getAssignConsultingStaffId() {
        List<Conversation> list = new ArrayList<>();
        String sql
                = "select * from conversations";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Conversation conv = new Conversation();
                conv.setId(rs.getString("conversation_id"));
                // Tạo User cho staff
                User staff = new User();
                staff.setId(rs.getString("staff_id"));
                conv.setStaff(staff);
                conv.setLast_masage_time(rs.getTimestamp("last_message_time"));
                list.add(conv);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateNewConsultingStaff(String oldStaffId, String newStaffId) {
        String updateConversations = "UPDATE conversations SET staff_id = ? WHERE staff_id = ?";
        String updateMessages = "UPDATE messages "
                + "SET sender_id = ? "
                + "WHERE sender_id = ? "
                + "AND conversation_id IN (SELECT conversation_id FROM conversations WHERE staff_id = ?)";

        try (Connection conn = DBContext.getConnection()) {
            conn.setAutoCommit(false); // Bắt đầu transaction

            // Cập nhật bảng conversations
            try (PreparedStatement ps1 = conn.prepareStatement(updateConversations)) {
                ps1.setString(1, newStaffId);
                ps1.setString(2, oldStaffId);
                ps1.executeUpdate();
            }

            // Cập nhật bảng messages
            try (PreparedStatement ps2 = conn.prepareStatement(updateMessages)) {
                ps2.setString(1, newStaffId);
                ps2.setString(2, oldStaffId);
                ps2.setString(3, newStaffId); // Sau khi update conversations, staff_id = newStaffId
                ps2.executeUpdate();
            }

            conn.commit(); // Commit nếu thành công
            System.out.println("Chỉ định nhân viên tư vấn mới thành công!");

        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Lỗi khi chỉ định nhân viên tư vấn mới: " + e.getMessage());
        }
        return false;
    }

    // Lấy tất cả tin nhắn theo conversationId
    public List<Messages> getMessagesByConversation(String conversationId) {
        List<Messages> list = new ArrayList<>();
        String sql = "SELECT m.message_id, m.content, m.sent_at, u.id, u.full_name FROM messages m "
                + " JOIN users u ON m.sender_id = u.id WHERE m.conversation_id = ? ORDER BY m.sent_at ASC";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, conversationId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Messages m = new Messages();
                m.setId(rs.getString("message_id"));
                m.setContent(rs.getString("content"));
                m.setSent_at(rs.getTimestamp("sent_at"));
                User sender = new User();
                sender.setId(rs.getString("id"));
                sender.setFullName(rs.getString("full_name"));
                m.setSender(sender);

                list.add(m);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lưu tin nhắn mới
    public void saveMessage(Messages msg) {
        String sql = "INSERT INTO messages (conversation_id, sender_id, content) VALUES (?, ?, ?)";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, msg.getConversation().getId());
            ps.setString(2, msg.getSender().getId());
            ps.setString(3, msg.getContent());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Conversation getConversationById(String id) {
        String sql = "SELECT * FROM conversations WHERE conversation_id = ?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Conversation c = new Conversation();
                c.setId(rs.getString("conversation_id"));
                c.setCustomer(new User(rs.getString("customer_id")));
                c.setStaff(new User(rs.getString("staff_id")));
                c.setCreated_at(rs.getTimestamp("created_at"));
                c.setLast_masage_time(rs.getTimestamp("last_message_time"));
                return c;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean assignNewConsultingStaff(String staffId) {
        String checkSql = "SELECT COUNT(*) FROM consulting_staff";
        String updateSql = "UPDATE consulting_staff SET staff_id = ?, assigned_at = GETDATE()";
        String insertSql = "INSERT INTO consulting_staff (staff_id) VALUES (?)";

        try (Connection conn = DBContext.getConnection(); PreparedStatement checkStmt = conn.prepareStatement(checkSql); ResultSet rs = checkStmt.executeQuery()) {

            if (rs.next() && rs.getInt(1) > 0) {
                try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                    updateStmt.setString(1, staffId);
                    return updateStmt.executeUpdate() > 0;
                }
            } else {
                try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                    insertStmt.setString(1, staffId);
                    return insertStmt.executeUpdate() > 0;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public String getCurrentConsultingStaffId() {
        String sql = "SELECT staff_id FROM consulting_staff";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getString("staff_id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Chưa có nhân viên tư vấn nào
    }

    public boolean assignNewConsultingStaffDirect(String newStaffId) {
        String sql = "UPDATE conversations SET staff_id = ?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, newStaffId);
            int affectedRows = ps.executeUpdate();

            return affectedRows > 0;  // Trả về true nếu có ít nhất 1 dòng bị ảnh hưởng

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public void createConversation(String conversationId, String customerId, String staffId) {
        String sql = "INSERT INTO conversations (conversation_id, customer_id, staff_id) VALUES (?, ?, ?)";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, conversationId);
            ps.setString(2, customerId);
            ps.setString(3, staffId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Conversation> searchConversations(String keyword) throws SQLException {
        List<Conversation> list = new ArrayList<>();
        String sql = "SELECT c.conversation_id, u.full_name, u.phone "
                + "FROM conversations c "
                + "JOIN users u ON c.customer_id = u.id "
                + "WHERE u.full_name LIKE ? OR u.phone LIKE ? "
                + "ORDER BY c.created_at DESC";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Conversation c = new Conversation();
                c.setId(rs.getString("conversation_id"));
                c.setCustomer(new User(rs.getString("full_name")));
                c.getCustomer().setPhoneNumber(rs.getString("phone"));
                list.add(c);
            }
        }
        return list;
    }

    public List<Conversation> getConversationsForStaff(String staffId, String keyword) {
        List<Conversation> list = new ArrayList<>();
        String sql
                = "SELECT c.conversation_id, u.id AS customer_id, u.full_name, c.last_message_time "
                + "FROM conversations c "
                + "JOIN users u ON c.customer_id = u.id "
                + "WHERE c.staff_id = ? "
                + "AND c.staff_id != c.customer_id "
                + (keyword != null && !keyword.isEmpty()
                ? "AND (u.full_name LIKE ? OR u.phone LIKE ?) " : "")
                + "ORDER BY c.last_message_time DESC";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, staffId);
            if (keyword != null && !keyword.isEmpty()) {
                ps.setString(2, "%" + keyword + "%");
                ps.setString(3, "%" + keyword + "%");
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Conversation conv = new Conversation();
                conv.setId(rs.getString("conversation_id"));

                // Tạo User cho customer
                User customer = new User();
                customer.setId(rs.getString("customer_id"));
                customer.setFullName(rs.getString("full_name"));
                conv.setCustomer(customer);

                conv.setLast_masage_time(rs.getTimestamp("last_message_time"));

                list.add(conv);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

}
