package DAO;

import Model.ClinicInfo;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClinicInfoDAO {

    // Lấy thông tin phòng khám từ cơ sở dữ liệu
    public ClinicInfo getClinicInfo() throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        ClinicInfo clinicInfo = null;

        try {
            conn = DBContext.getConnection();
            String sql = "SELECT id, name, address, phone, email, website, working_hours, description, logo, googlemap, created_at, updated_at FROM clinic_info";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            if (rs.next()) {
                clinicInfo = new ClinicInfo();
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
            }
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
        return clinicInfo;
    }
    
    public static void main(String[] args) throws ClassNotFoundException, SQLException {
        ClinicInfo c = new ClinicInfoDAO().getClinicInfo();
        System.out.println(c.getGoogleMap());
    }
}
