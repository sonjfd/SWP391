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

/**
 *
 * @author ASUS
 */
public class BreedDAO {

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

}
