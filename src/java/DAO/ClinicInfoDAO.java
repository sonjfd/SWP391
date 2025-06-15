package DAO;

import Model.ClinicInfo;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClinicInfoDAO {

    // Lấy thông tin phòng khám từ cơ sở dữ liệu
    public ClinicInfo getClinicInfo()  {
   
            String sql = "SELECT id, name, address, phone, email, website, working_hours, description, logo, googlemap, created_at, updated_at FROM clinic_info";
      
       

        try( Connection conn =DBContext.getConnection();
                PreparedStatement ps=conn.prepareStatement(sql)) {
         
            
           ResultSet rs = ps.executeQuery();

            if (rs.next()) {
              ClinicInfo  clinicInfo = new ClinicInfo();
                clinicInfo.setId(rs.getString("id"));
                clinicInfo.setName(rs.getString("name"));
                clinicInfo.setAddress(rs.getString("address"));
                clinicInfo.setPhone(rs.getString("phone"));
                clinicInfo.setEmail(rs.getString("email"));
                clinicInfo.setWebsite(rs.getString("website"));
                clinicInfo.setWorkingHours(rs.getString("working_hours"));
                clinicInfo.setDescription(rs.getString("description"));
                clinicInfo.setLogo(rs.getString("logo"));
                clinicInfo.setGoogleMap(rs.getString("googlemap"));
                clinicInfo.setCreatedAt(rs.getDate("created_at"));
                clinicInfo.setUpdatedAt(rs.getDate("updated_at"));
                return clinicInfo;
            }
        }catch(Exception e){
            e.printStackTrace();
        } 
        return null;
    }
    
    public static void main(String[] args) throws ClassNotFoundException, SQLException {
        ClinicInfo c = new ClinicInfoDAO().getClinicInfo();
        System.out.println(c.getGoogleMap());
    }
}
