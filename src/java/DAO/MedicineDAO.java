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
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
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
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
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
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
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
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
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
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error in deleteMedicine: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    public static void main(String[] args) {
        MedicineDAO medicineDAO = new MedicineDAO(); // Lớp chứa phương thức getAllMedicines()
        List<Medicine> medicines = medicineDAO.getAllMedicines();

        if (medicines.isEmpty()) {
            System.out.println("Không có thuốc nào được tìm thấy.");
        } else {
            for (Medicine m : medicines) {
                System.out.println("ID: " + m.getId());
                System.out.println("Tên thuốc: " + m.getName());
                System.out.println("Mô tả: " + m.getDescripton());
                System.out.println("Trạng thái: " + (m.getStatus() == 1 ? "Đang bán" : "Ngừng bán"));
                System.out.println("----------------------------");
            }
        }
    }
}