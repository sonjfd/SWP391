/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

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
public class SpecieDAO {
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
   
}
