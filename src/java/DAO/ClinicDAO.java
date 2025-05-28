/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.util.List;
import Model.ClinicInfo;
import java.util.ArrayList;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author ASUS
 */
public class ClinicDAO {

//    Lấy tất cả các clinic
    public List<ClinicInfo> getAllClinics() {
        List<ClinicInfo> list = new ArrayList<>();
        String sql = "SELECT * FROM clinic_info";
        try(Connection conn = DBContext.getConnection();
            PreparedStatement stm = conn.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();) 
        {

        } catch (Exception e) {
        }

        return list;

    }
}
