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
    public List<Breed> getAllBreedsWithSpecie() {
    List<Breed> breeds = new ArrayList<>();
    String sql = "SELECT b.id as breed_id, b.name as breed_name, s.id as specie_id, s.name as specie_name "
               + "FROM breeds b JOIN species s ON b.species_id = s.id";
    try (Connection conn = DBContext.getConnection();
         PreparedStatement st = conn.prepareStatement(sql);
         ResultSet rs = st.executeQuery()) {
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
