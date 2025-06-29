/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Breed;
import Model.Specie;
import java.util.ArrayList;
import java.util.List;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author ASUS
 */
public class SpecieDAO {

    private Connection getConnection() throws SQLException {
        // Thay bằng code kết nối DB thực tế từ SliderDAO.java
        return null; // TODO: Thêm code kết nối DB
    }

    public List<Specie> getAllSpecies() {
        List<Specie> list = new ArrayList<>();
        String sql = "SELECT id, name, image_url FROM species"; // thêm imageUrl vào SELECT
        try (Connection conn = DBContext.getConnection(); PreparedStatement st = conn.prepareStatement(sql); ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                list.add(new Specie(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("image_url") // truyền thêm imageUrl vào constructor
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    private List<Breed> getBreedsBySpecieId(int specieId) {
        List<Breed> breeds = new ArrayList<>();
        String sql = "SELECT b.id, b.species_id, b.name, s.name AS specie_name "
                + "FROM breeds b JOIN species s ON b.species_id = s.id "
                + "WHERE b.species_id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, specieId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Specie specie = new Specie();
                    specie.setId(rs.getInt("species_id"));
                    specie.setName(rs.getString("specie_name"));

                    Breed breed = new Breed();
                    breed.setId(rs.getInt("id"));
                    breed.setSpecie(specie);
                    breed.setName(rs.getString("name"));
                    breeds.add(breed);
                }
                System.out.println("Specie ID: " + specieId + ", Found " + breeds.size() + " breeds");
            }
        } catch (SQLException e) {
            System.err.println("Error in getBreedsBySpecieId for specieId " + specieId + ": " + e.getMessage());
            e.printStackTrace();
        }
        return breeds;
    }

    public boolean addSpecie(Specie specie) {
        String sql = "INSERT INTO species (name, image_url) VALUES (?, ?)";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, specie.getName());
            ps.setString(2, specie.getImageUrl());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Specie getSpecieById(int id) {
        String sql = "SELECT id, name, image_url FROM species WHERE id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Specie specie = new Specie();
                    specie.setId(rs.getInt("id"));
                    specie.setName(rs.getString("name"));
                    specie.setImageUrl(rs.getString("image_url"));
                    specie.setBreeds(getBreedsBySpecieId(id));
                    return specie;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateSpecie(Specie specie) {
        String sql = "UPDATE species SET name = ?, image_url = ? WHERE id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, specie.getName());
            ps.setString(2, specie.getImageUrl());
            ps.setInt(3, specie.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteSpecie(int id) {
    String[] queries = {
        // 1. Xóa hồ sơ y tế trước
        "DELETE FROM medical_records WHERE pet_id IN (SELECT id FROM pets WHERE breeds_id IN (SELECT id FROM breeds WHERE species_id = ?)) " +
        "OR appointment_id IN (SELECT id FROM appointments WHERE pet_id IN (SELECT id FROM pets WHERE breeds_id IN (SELECT id FROM breeds WHERE species_id = ?)))",

        // 2. Xóa symptoms trước khi xóa appointments
        "DELETE FROM appointment_symptoms WHERE appointment_id IN (SELECT id FROM appointments WHERE pet_id IN (SELECT id FROM pets WHERE breeds_id IN (SELECT id FROM breeds WHERE species_id = ?)))",

        // 3. Xóa hóa đơn
        "DELETE FROM invoices WHERE appointment_id IN (SELECT id FROM appointments WHERE pet_id IN (SELECT id FROM pets WHERE breeds_id IN (SELECT id FROM breeds WHERE species_id = ?)))",

        // 4. Xóa lịch hẹn
        "DELETE FROM appointments WHERE pet_id IN (SELECT id FROM pets WHERE breeds_id IN (SELECT id FROM breeds WHERE species_id = ?))",

        // 5. Xóa thú cưng
        "DELETE FROM pets WHERE breeds_id IN (SELECT id FROM breeds WHERE species_id = ?)",

        // 6. Xóa giống loài
        "DELETE FROM breeds WHERE species_id = ?",

        // 7. Xóa loài
        "DELETE FROM species WHERE id = ?"
    };

    try (Connection conn = DBContext.getConnection()) {
        conn.setAutoCommit(false);

        for (String sql : queries) {
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, id);
                if (sql.chars().filter(ch -> ch == '?').count() > 1) {
                    ps.setInt(2, id); // nếu có 2 dấu ?
                }
                ps.executeUpdate();
            }
        }

        conn.commit();
        return true;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}
    
     
     public static void main(String[] args) {
        // Tạo đối tượng DAO
        SpecieDAO dao = new SpecieDAO();

        // Tạo một đối tượng Specie cần cập nhật
        Specie specie = new Specie();
        specie.setId(12); // ID của species cần cập nhật (đảm bảo ID này tồn tại trong DB)
        specie.setName("Chó cảnh thôi mà ");
        specie.setImageUrl("images/1231212");

        // Gọi hàm cập nhật
        boolean result = dao.updateSpecie(specie);

        // In kết quả
        if (result) {
            System.out.println("✅ Cập nhật species thành công!");
        } else {
            System.out.println("❌ Cập nhật species thất bại!");
        }
    }
}
