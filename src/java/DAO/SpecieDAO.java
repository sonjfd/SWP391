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
    String sql = "SELECT id, name FROM species";
    try (Connection conn = DBContext.getConnection();
         PreparedStatement st = conn.prepareStatement(sql);
         ResultSet rs = st.executeQuery()) {
        while (rs.next()) {
            list.add(new Specie(rs.getInt("id"), rs.getString("name")));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}
   
    private List<Breed> getBreedsBySpecieId(int specieId) {
        List<Breed> breeds = new ArrayList<>();
        String sql = "SELECT b.id, b.species_id, b.name, s.name AS specie_name " +
                     "FROM breeds b JOIN species s ON b.species_id = s.id " +
                     "WHERE b.species_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
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
        String sql = "INSERT INTO species (name) VALUES (?)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, specie.getName());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Specie getSpecieById(int id) {
        String sql = "SELECT id, name FROM species WHERE id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Specie specie = new Specie();
                    specie.setId(rs.getInt("id"));
                    specie.setName(rs.getString("name"));
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
        String sql = "UPDATE species SET name = ? WHERE id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, specie.getName());
            ps.setInt(2, specie.getId());
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
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    
    
    public static void main(String[] args) {
        SpecieDAO specieDao = new SpecieDAO();

        // ID của loài cần test (cập nhật theo dữ liệu trong DB của bạn)
        int specieId = 1;

        // Gọi phương thức getBreedsBySpecieId
        List<Breed> breedList = specieDao.getBreedsBySpecieId(specieId);

        // In ra kết quả
        System.out.println("Các giống loài thuộc species ID = " + specieId + ":");
        for (Breed breed : breedList) {
            System.out.println(" - Breed ID: " + breed.getId() +
                               ", Name: " + breed.getName() +
                               ", Specie Name: " + (breed.getSpecie() != null ? breed.getSpecie().getName() : "Unknown"));
        }

        if (breedList.isEmpty()) {
            System.out.println("❌ Không tìm thấy giống loài nào cho species ID = " + specieId);
        }
    }
}
