/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Role;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ASUS
 */
public class RoleDAO {
    
    public Role getRoleByName(String name) {
        String sql = "select  * from roles where name = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement stm = conn.prepareStatement(sql)) {

            stm.setString(1, name);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return new Role(rs.getInt("id"), rs.getString("name"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;

    }

    public Role getRoleById(int id) {
        Role Admin = getRoleByName("admin");
        Role Customer = getRoleByName("customer");
        Role Staff = getRoleByName("staff");
        Role Doctor = getRoleByName("doctor");
        if(id==Admin.getId()){
            return Admin;
        }else if(id==Customer.getId()){
            return Customer;
        }else if(id==Staff.getId()){
            return Staff;
        }else if(id==Doctor.getId()){
            return Doctor;
        }
        return null;
    }
    
    public List<Role> getAllRoles() {
        List<Role> roles = new ArrayList<>();
        String sql = "SELECT id, name FROM roles";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Role role = new Role();
                role.setId(rs.getInt("id"));
                role.setName(rs.getString("name"));
                roles.add(role);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return roles;
    }
    
}
