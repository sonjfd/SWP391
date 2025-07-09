package DAO;

import Model.Medicine;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MedicineDAO {

    private Connection getConnection() throws SQLException {

        return null;
    }

    public List<Medicine> getAllMedicines() {
        List<Medicine> medicineList = new ArrayList<>();
        String sql = "SELECT id, name, description, status FROM medicines";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Medicine medicine = new Medicine();
                medicine.setId(rs.getString("id"));
                medicine.setName(rs.getString("name"));
                medicine.setDescripton(rs.getString("description"));
                medicine.setStatus(rs.getInt("status"));
                medicineList.add(medicine);
            }
        } catch (SQLException e) {
            System.err.println("Error in getAllMedicines: " + e.getMessage());
            e.printStackTrace();
        }
        return medicineList;
    }

    public boolean addMedicine(Medicine medicine) {
        String sql = "INSERT INTO medicines (id, name, description, status) VALUES (NEWID(), ?, ?, ?)";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, medicine.getName());
            ps.setString(2, medicine.getDescripton());
            ps.setInt(3, medicine.getStatus());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error in addMedicine: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public Medicine getMedicineById(String id) {
        String sql = "SELECT id, name, description, status FROM medicines WHERE id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Medicine medicine = new Medicine();
                    medicine.setId(rs.getString("id"));
                    medicine.setName(rs.getString("name"));
                    medicine.setDescripton(rs.getString("description"));
                    medicine.setStatus(rs.getInt("status"));
                    return medicine;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error in getMedicineById: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateMedicine(Medicine medicine) {
        String sql = "UPDATE medicines SET name = ?, description = ?, status = ? WHERE id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, medicine.getName());
            ps.setString(2, medicine.getDescripton());
            ps.setInt(3, medicine.getStatus());
            ps.setString(4, medicine.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error in updateMedicine: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteMedicine(String id) {
        String sql = "DELETE FROM medicines WHERE id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error in deleteMedicine: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean isMedicineNameExists(String Name, String excludeId) {
        String sql = "SELECT COUNT(*) FROM medicines WHERE LOWER(name) = ?";
        if (excludeId != null && !excludeId.isEmpty()) {
            sql += " AND id <> ?";
        }
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, Name.trim().toLowerCase());
            if (excludeId != null && !excludeId.isEmpty()) {
                ps.setString(2, excludeId);
            }
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateMedicineStatus(String medicineId, int newStatus) {
        String sql = "UPDATE medicines SET status = ? WHERE id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, newStatus);
            ps.setString(2, medicineId);
            int affected = ps.executeUpdate();
            return affected > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public static void main(String[] args) {
        // Giả sử bạn có class DAO tên là MedicineDAO
        MedicineDAO dao = new MedicineDAO();

        // Nhập ID của thuốc cần cập nhật (nên chắc chắn là ID này đã tồn tại trong CSDL)
        String testMedicineId = "D80F5675-ED97-403A-B1EB-DD1D2323D074"; // Thay bằng id thuốc thực tế trong CSDL
        int newStatus = 1; // 1: Active, 0: Inactive (tuỳ logic của bạn)

        // Gọi hàm cập nhật
        boolean result = dao.updateMedicineStatus(testMedicineId, newStatus);

        // In kết quả
        if (result) {
            System.out.println("Cập nhật trạng thái thuốc thành công.");
        } else {
            System.out.println("Cập nhật trạng thái thuốc thất bại.");
        }
    }
    
}
