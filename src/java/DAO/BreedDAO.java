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
public class BreedDAO {
     private Connection getConnection() throws SQLException {
        return null;
    }

    public List<Breed> getAllBreedsWithSpecie(int speId) {
        List<Breed> breeds = new ArrayList<>();
        String sql = "SELECT b.id AS breed_id, b.name AS breed_name, "
                + "s.id AS specie_id, s.name AS specie_name "
                + "FROM breeds b "
                + "INNER JOIN species s ON b.species_id = s.id "
                + "WHERE s.id = ?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement st = conn.prepareStatement(sql)) {

            st.setInt(1, speId); // Set the species ID

            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    int specieId = rs.getInt("specie_id");
                    String specieName = rs.getString("specie_name");
                    Specie specie = new Specie(specieId, specieName);

                    int breedId = rs.getInt("breed_id");
                    String breedName = rs.getString("breed_name");
                    Breed breed = new Breed(breedId, specie, breedName);

                    breeds.add(breed);
                }
            }

        } catch (Exception e) {
            e.printStackTrace(); // Consider logging instead
        }

        return breeds;
    }

    public List<Breed> getAllBreedsWithSpecie() {
        List<Breed> breeds = new ArrayList<>();
        String sql = "SELECT b.id as breed_id, b.name as breed_name, s.id as specie_id, s.name as specie_name "
                + "FROM breeds b JOIN species s ON b.species_id = s.id";
        try (Connection conn = DBContext.getConnection(); PreparedStatement st = conn.prepareStatement(sql); ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                Specie specie = new Specie(rs.getInt("specie_id"), rs.getString("specie_name"));
                Breed breed = new Breed(rs.getInt("breed_id"), specie, rs.getString("breed_name"));
                breeds.add(breed);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return breeds;
    }
    
    public List<Breed> getAllBreeds() {
        List<Breed> breedList = new ArrayList<>();
        String sql = "SELECT b.id, b.species_id, b.name, s.name AS specie_name " +
                     "FROM breeds b JOIN species s ON b.species_id = s.id";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Specie specie = new Specie();
                specie.setId(rs.getInt("species_id"));
                specie.setName(rs.getString("specie_name"));

                Breed breed = new Breed();
                breed.setId(rs.getInt("id"));
                breed.setSpecie(specie);
                breed.setName(rs.getString("name"));
                breedList.add(breed);
            }
        } catch (SQLException e) {
            System.err.println("Error in getAllBreeds: " + e.getMessage());
            e.printStackTrace();
        }
        return breedList;
    }

    public boolean addBreed(Breed breed) {
        String sql = "INSERT INTO breeds (species_id, name) VALUES (?, ?)";
        try (Connection conn =  DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, breed.getSpecie().getId());
            ps.setString(2, breed.getName());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error in addBreed: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public Breed getBreedById(int id) {
        String sql = "SELECT b.id, b.species_id, b.name, s.name AS specie_name " +
                     "FROM breeds b JOIN species s ON b.species_id = s.id WHERE b.id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Specie specie = new Specie();
                    specie.setId(rs.getInt("species_id"));
                    specie.setName(rs.getString("specie_name"));

                    Breed breed = new Breed();
                    breed.setId(rs.getInt("id"));
                    breed.setSpecie(specie);
                    breed.setName(rs.getString("name"));
                    return breed;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error in getBreedById: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateBreed(Breed breed) {
        String sql = "UPDATE breeds SET species_id = ?, name = ? WHERE id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, breed.getSpecie().getId());
            ps.setString(2, breed.getName());
            ps.setInt(3, breed.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error in updateBreed: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteBreed(int id) {
        String sql = "DELETE FROM breeds WHERE id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error in deleteBreed: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Lấy danh sách species để hiển thị trong dropdown
    public List<Specie> getAllSpecies() {
        List<Specie> specieList = new ArrayList<>();
        String sql = "SELECT id, name FROM species";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Specie specie = new Specie();
                specie.setId(rs.getInt("id"));
                specie.setName(rs.getString("name"));
                specieList.add(specie);
            }
        } catch (SQLException e) {
            System.err.println("Error in getAllSpecies: " + e.getMessage());
            e.printStackTrace();
        }
        return specieList;
    }

}