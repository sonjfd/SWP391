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
import java.sql.SQLIntegrityConstraintViolationException;
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
    String sql = "DELETE FROM species WHERE id = ?";
    try (Connection conn = DBContext.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setInt(1, id);
        int affectedRows = ps.executeUpdate();
        return affectedRows > 0;

    } catch (SQLIntegrityConstraintViolationException fkEx) {
        System.out.println("Không thể xóa loài do ràng buộc khóa ngoại.");
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}
    public boolean isDuplicateSpecieName(String name) {
    String sql = "SELECT COUNT(*) FROM species WHERE LOWER(name) = LOWER(?)";
    try (Connection conn = DBContext.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setString(1, name);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            int count = rs.getInt(1);
            return count > 0; // true nếu trùng
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false; // không trùng hoặc lỗi
}
    public boolean isDuplicateNameExceptId(String name, int id) {
    String sql = "SELECT COUNT(*) FROM Species WHERE name = ? AND id != ?";
    try (Connection conn = DBContext.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, name);
        ps.setInt(2, id);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt(1) > 0;
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
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
