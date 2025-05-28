/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Breed;
import Model.Pet;
import Model.Role;
import Model.Specie;
import Model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Admin
 */
public class UserDAO {

    private static final String SELECT_ALL_USERS = "SELECT * FROM users;";
    private static final String DELETE_USER_SQL = "DELETE FROM users WHERE id = ?;";

    public List<User> getAllUsers() throws SQLException, ClassNotFoundException {
        List<User> userList = new ArrayList<>();
        Connection conn = DBContext.getConnection();
        if (conn == null) {
            return userList;
        }
        String query = SELECT_ALL_USERS;
        try (PreparedStatement ps = conn.prepareStatement(query); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Role role = new Role();
                role.setId(rs.getInt("role_id"));

                User user = new User(
                        rs.getString("id"),
                        rs.getString("username"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("full_Name"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getString("avatar"),
                        rs.getInt("status"),
                        role,
                        rs.getDate("created_at"),
                        rs.getDate("updated_at")
                );
                userList.add(user);
            }
        } finally {
            conn.close();
        }
        return userList;
    }

    public User getUserById(String id) {
        String sql = "SELECT * FROM users WHERE id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getString("id"));
                user.setUserName(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setFullName(rs.getString("full_name"));
                user.setPhoneNumber(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setAvatar(rs.getString("avatar"));
                user.setStatus(rs.getInt("status"));
                user.setCreateDate(rs.getTimestamp("created_at"));
                user.setUpdateDate(rs.getTimestamp("updated_at"));
                int roleId = rs.getInt("role_id");
                RoleDAO roleDAO = new RoleDAO();
                Role role = roleDAO.getRoleById(roleId);
                user.setRole(role);
                return user;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean deleteUser(String id) {
        String sql = "Delete users where id =? ;";
        try {
            Connection conn = DAO.DBContext.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, id);
            int check = stmt.executeUpdate();
            if (check > 0) {
                return true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateUser(String id, String fullName, String address, String email, String phone, String avatar) {
        // Sửa lại câu SQL để cập nhật đúng trường gender
        String sql = "UPDATE users SET full_name=?, address=?, email=?, phone=?, avatar=?, updated_at=CURRENT_TIMESTAMP WHERE id=?";

        try {
            // Tạo kết nối và chuẩn bị câu lệnh SQL
            Connection conn = DAO.DBContext.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);

            // Gán giá trị cho các tham số
            stmt.setString(1, fullName);
            stmt.setString(2, address);
            stmt.setString(3, email);
            stmt.setString(4, phone);
            stmt.setString(5, avatar);
            stmt.setString(6, id); // Cập nhật ID

            // Thực thi câu lệnh cập nhật
            int check = stmt.executeUpdate();
            if (check > 0) {
                return true; // Nếu cập nhật thành công, trả về true
            }

        } catch (Exception e) {
            e.printStackTrace(); // In ra lỗi nếu có
        }
        return false; // Nếu không thành công, trả về false
    }

    public List<Pet> getPetsByUser(String userId) throws SQLException, ClassNotFoundException {
        List<Pet> petList = new ArrayList<>();
        Connection conn = DBContext.getConnection();
        if (conn == null) {
            return petList;
        }
        String query = "select * from pets where owner_id =?;";
        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                UserDAO userDao = new UserDAO();
                User user = userDao.getUserById(rs.getString("owner_id"));

                UserDAO breedDao = new UserDAO();
                Breed breed = breedDao.getBreedById(rs.getInt("breeds_id"));

                Pet pet = new Pet(
                        rs.getString("id"),
                        user,
                        rs.getString("name"),
                        rs.getDate("birth_date"),
                        breed,
                        rs.getString("gender"),
                        rs.getString("avatar"),
                        rs.getString("description"),
                        rs.getString("status"),
                        rs.getDate("created_at"),
                        rs.getDate("updated_at")
                );
                petList.add(pet);
            }
        } finally {
            conn.close();
        }
        return petList;
    }
    
   public Pet getPetsById(String petId) throws SQLException, ClassNotFoundException {
        Connection conn = DBContext.getConnection();
        if (conn == null) {
            return null;
        }

        String query = "SELECT * FROM pets WHERE id = ?;";
        Pet pet = null; // khai báo pet ở ngoài để dùng trong finally

        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, petId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                UserDAO userDao = new UserDAO();
                User user = userDao.getUserById(rs.getString("owner_id"));

                Breed breed = userDao.getBreedById(rs.getInt("breeds_id"));

                pet = new Pet(
                        rs.getString("id"),
                        user,
                        rs.getString("name"),
                        rs.getDate("birth_date"),
                        breed,
                        rs.getString("gender"),
                        rs.getString("avatar"),
                        rs.getString("description"),
                        rs.getString("status"),
                        rs.getDate("created_at"),
                        rs.getDate("updated_at")
                );
            }
        } finally {
            conn.close();
        }

        return pet;
    }

    //UserDAO
    public Specie getSpecieById(int id) {
        String sql = "SELECT * FROM species WHERE id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement stm = conn.prepareStatement(sql)) {

            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return new Specie(
                        rs.getInt("id"),
                        rs.getString("name")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    //UserDAO
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
        if (id == Admin.getId()) {
            return Admin;
        } else if (id == Customer.getId()) {
            return Customer;
        } else if (id == Staff.getId()) {
            return Staff;
        } else if (id == Doctor.getId()) {
            return Doctor;
        }
        return null;
    }

    //UserDAO
    public Breed getBreedByName(String name) {
        String sql = "SELECT * FROM breeds WHERE name = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement stm = conn.prepareStatement(sql)) {

            stm.setString(1, name);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                // Lấy Specie từ UserDAO nếu cần
                UserDAO specieDAO = new UserDAO();
                Specie specie = specieDAO.getSpecieById(rs.getInt("species_id"));

                return new Breed(
                        rs.getInt("id"),
                        specie,
                        rs.getString("name")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public Breed getBreedById(int id) {
        String sql = "SELECT * FROM breeds WHERE id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement stm = conn.prepareStatement(sql)) {

            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                // Lấy Specie từ UserDAO nếu cần
                UserDAO specieDAO = new UserDAO();
                Specie specie = specieDAO.getSpecieById(rs.getInt("species_id"));

                return new Breed(
                        rs.getInt("id"),
                        specie,
                        rs.getString("name")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean addUserByRegister(String username, String email, String password,
            String full_name, String phone, String address) throws SQLException {
        String sql = "INSERT INTO [dbo].[users]\n"
                + "           (\n"
                + "           [username]\n"
                + "           ,[email]\n"
                + "           ,[password]\n"
                + "           ,[full_name]\n"
                + "           ,[phone]\n"
                + "           ,[address]\n"
                + "           )\n"
                + "     VALUES\n"
                + "           (?,?,?,?,?,?)";
        try (Connection conn = DBContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql);) {
            stmt.setString(1, username);
            stmt.setString(2, email);
            stmt.setString(3, password);
            stmt.setString(4, full_name);
            stmt.setString(5, phone);
            stmt.setString(6, address);
            int check = stmt.executeUpdate();
            return check > 0;

        } catch (SQLException e) {
            System.out.println("Lỗi khi thực hiện thêm user:");
            e.printStackTrace();
        }
        return false;
    }

    public User getUserNameDuplicate(String username) {
        String sql = "SELECT * FROM users WHERE username = ?";
        try (
                Connection conn = DBContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                  Role role = getRoleById(rs.getInt("role_id"));
                
                return new User(rs.getString("id"),
                        rs.getString("username"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("full_Name"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getString("avatar"),
                        rs.getInt("status"),
                        role,
                        rs.getDate("created_at"),
                        rs.getDate("updated_at"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public User loginCheck(String idenfier, String password) {
        String sql = "select *from users where (username = ? or email = ?) and password = ?";
        try {
            Connection conn = DBContext.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, idenfier);
            stmt.setString(2, idenfier);
            stmt.setString(3, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Role role = getRoleById(rs.getInt("role_id"));
               
                return new User(rs.getString("id"),
                        rs.getString("username"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("full_Name"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getString("avatar"),
                        rs.getInt("status"),
                        role,
                        rs.getDate("created_at"),
                        rs.getDate("updated_at"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public List<Breed> getBreeds() {
        List<Breed> breedList = new ArrayList<Breed>();
        String sql = "SELECT * FROM breeds";
        try (Connection conn = DBContext.getConnection(); PreparedStatement stm = conn.prepareStatement(sql)) {

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                UserDAO specieDAO = new UserDAO();
                Specie specie = specieDAO.getSpecieById(rs.getInt("species_id"));
                Breed breed = new Breed(
                        rs.getInt("id"),
                        specie,
                        rs.getString("name"));
                breedList.add(breed);

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return breedList;
    }
    
    public boolean addPet(String ownerid, String name, Date birthdate, int breedid, String gender, String avatar, String desc, String status) {
        Connection con = null;
        PreparedStatement ps = null;
        int rowsAffected = 0;
        try {
            con = DBContext.getConnection();

            String sql = "INSERT INTO Pets (id, owner_id, name, birth_date, breeds_id, gender, avatar, description, status, created_at, updated_at) "
                    + "VALUES (NEWID(), ?, ?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)";

            ps = con.prepareStatement(sql);
            ps.setString(1, ownerid);
            ps.setString(2, name);
            ps.setDate(3, (java.sql.Date) birthdate);
            ps.setInt(4, breedid);
            ps.setString(5, gender);
            ps.setString(6, avatar);
            ps.setString(7, desc);
            ps.setString(8, status);

            rowsAffected = ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
        return rowsAffected > 0;
    }
    
    public boolean deletePet(String id) {
        String sql = "Delete pets where id =? ;";
        try {
            Connection conn = DAO.DBContext.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, id);
            int check = stmt.executeUpdate();
            if (check > 0) {
                return true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public List<Pet> getPetsByName(String keyWord) throws SQLException, ClassNotFoundException {
        List<Pet> petList = new ArrayList<>();
        Connection conn = DBContext.getConnection();
        if (conn == null) {
            return petList;
        }
        String query = "SELECT * FROM Pets WHERE name LIKE ?";
        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, "%" + keyWord + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                UserDAO userDao = new UserDAO();
                User user = userDao.getUserById(rs.getString("owner_id"));

                UserDAO breedDao = new UserDAO();
                Breed breed = breedDao.getBreedById(rs.getInt("breeds_id"));

                Pet pet = new Pet(
                        rs.getString("id"),
                        user,
                        rs.getString("name"),
                        rs.getDate("birth_date"),
                        breed,
                        rs.getString("gender"),
                        rs.getString("avatar"),
                        rs.getString("description"),
                        rs.getString("status"),
                        rs.getDate("created_at"),
                        rs.getDate("updated_at")
                );
                petList.add(pet);
            }
        } finally {
            conn.close();
        }
        return petList;
    }
    
    public boolean updatePet(String id, String name, String gender, Date birthDate, int breedId,
            String status, String description, String avatar) throws SQLException, ClassNotFoundException {
        Connection conn = DBContext.getConnection();
        if (conn == null) {
            return false;
        }

        String sql = "UPDATE pets SET "
                + "name = ?, "
                + "gender = ?, "
                + "birth_date = ?, "
                + "breeds_id = ?, "
                + "status = ?, "
                + "description = ?, "
                + "avatar = ?, "
                + "updated_at = GETDATE() "
                + "WHERE id = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setString(2, gender);
            ps.setDate(3, (java.sql.Date) birthDate);
            ps.setInt(4, breedId);
            ps.setString(5, status);
            ps.setString(6, description);
            ps.setString(7, avatar);
            ps.setString(8, id);

            int rows = ps.executeUpdate();
            return rows > 0;
        } finally {
            conn.close();
        }
    }
    
    

    public static void main(String[] args) throws SQLException, ClassNotFoundException {
        UserDAO d = new UserDAO();

        d.addUserByRegister("hihi111231", "son@11", "1231231", "123123", "1123123", "Hanoi");

    }
}
