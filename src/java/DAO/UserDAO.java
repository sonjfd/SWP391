/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import static GoogleLogin.PasswordUtils.hashPassword;
import Model.Breed;
import Model.Pet;
import Model.Role;
import Model.Specie;
import Model.User;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 *
 * @author Admin
 */
public class UserDAO {

    public boolean updatePassword(String userId, String newPassword) {
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = DBContext.getConnection();
            String sql = "UPDATE Users SET password = ? WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, newPassword);
            stmt.setString(2, userId);
            int check = stmt.executeUpdate();
            if (check > 0) {
                return true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] bytes = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : bytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (Exception e) {
            throw new RuntimeException("Lỗi mã hóa mật khẩu", e);
        }
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
        String sql = "UPDATE users SET full_name=?, address=?, email=?, phone=?, avatar=? WHERE id=?";

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

    public User getUserByEmail(String email) {
        String sql = "SELECT * FROM Users WHERE email = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
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
                user.setRole(new RoleDAO().getRoleById(roleId));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateUserProfileFirtTime(User user) {
        String sql = "UPDATE users SET full_name = ?, phone = ?, address = ? WHERE id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getFullName());
            ps.setString(2, user.getPhoneNumber());
            ps.setString(3, user.getAddress());
            ps.setString(4, user.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Pet> getPetsByUser(String userId) {
        List<Pet> petList = new ArrayList<>();
        String sql = "SELECT * FROM pets WHERE owner_id = ? and isDelete = 0";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, userId);
            ResultSet rs = ps.executeQuery();

            UserDAO userDao = new UserDAO();

            while (rs.next()) {
                User user = userDao.getUserById(rs.getString("owner_id"));
                Breed breed = userDao.getBreedById(rs.getInt("breeds_id"));

                Pet pet = new Pet(
                        rs.getString("id"),
                        rs.getString("pet_code"),
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
        } catch (Exception e) {
            e.printStackTrace();
        }
        return petList;
    }

    public List<Pet> getPetsByUser(String userId, String petName, String status, int page, int pageSize) {
        List<Pet> petList = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM pets WHERE owner_id = ? AND isDelete = 0");

        // Thêm điều kiện động
        if (petName != null && !petName.trim().isEmpty()) {
            sql.append(" AND name LIKE ?");
        }
        if (status != null && !status.trim().isEmpty()) {
            sql.append(" AND status = ?");
        }

        sql.append(" ORDER BY created_at DESC"); // Sắp xếp theo ngày tạo
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"); // Phân trang

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int paramIndex = 1;
            ps.setString(paramIndex++, userId);

            if (petName != null && !petName.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + petName.trim() + "%");
            }
            if (status != null && !status.trim().isEmpty()) {
                ps.setString(paramIndex++, status);
            }

            int offset = (page - 1) * pageSize;
            ps.setInt(paramIndex++, offset);
            ps.setInt(paramIndex++, pageSize);

            ResultSet rs = ps.executeQuery();

            UserDAO userDao = new UserDAO();

            while (rs.next()) {
                User user = userDao.getUserById(rs.getString("owner_id"));
                Breed breed = userDao.getBreedById(rs.getInt("breeds_id"));

                Pet pet = new Pet(
                        rs.getString("id"),
                        rs.getString("pet_code"),
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
        } catch (Exception e) {
            e.printStackTrace();
        }
        return petList;
    }

    public int countPetsByUser(String userId, String petName, String status) {
        int count = 0;
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM pets WHERE owner_id = ? AND isDelete = 0");

        if (petName != null && !petName.trim().isEmpty()) {
            sql.append(" AND name LIKE ?");
        }
        if (status != null && !status.trim().isEmpty()) {
            sql.append(" AND status = ?");
        }

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int paramIndex = 1;
            ps.setString(paramIndex++, userId);

            if (petName != null && !petName.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + petName.trim() + "%");
            }
            if (status != null && !status.trim().isEmpty()) {
                ps.setString(paramIndex++, status);
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
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
                        rs.getString("pet_code"),
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

    public List<Pet> getAllPet() {
        String sql = "select * from pets";
        List<Pet> list = new ArrayList<>();
        try (Connection conn = DBContext.getConnection(); PreparedStatement stm = conn.prepareStatement(sql);) {
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                UserDAO userDao = new UserDAO();
                User user = userDao.getUserById(rs.getString("owner_id"));

                Breed breed = userDao.getBreedById(rs.getInt("breeds_id"));

                Pet pet = new Pet(
                        rs.getString("id"),
                        rs.getString("pet_code"),
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
                list.add(pet);

            }

        } catch (SQLException e) {
            e.printStackTrace();

        }
        return list;
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
        Role Nurse = getRoleByName("nurse");
        if (id == Admin.getId()) {
            return Admin;
        } else if (id == Customer.getId()) {
            return Customer;
        } else if (id == Staff.getId()) {
            return Staff;
        } else if (id == Doctor.getId()) {
            return Doctor;
        } else if (id == Nurse.getId()) {
            return Nurse;
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

                return new User(
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
                        rs.getDate("updated_at"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

private String getSafeString(String value) {
        return value != null ? value : "";
    }

   public User loginCheck(String identifier, String password) {
        String sql = "SELECT * FROM users WHERE (username = ? OR email = ?) AND password = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, identifier);
            stmt.setString(2, identifier);
            stmt.setString(3, password);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Role role = getRoleById(rs.getInt("role_id"));

                return new User(
                        getSafeString(rs.getString("id")),
                        getSafeString(rs.getString("username")),
                        getSafeString(rs.getString("email")),
                        getSafeString(rs.getString("password")),
                        getSafeString(rs.getString("full_name")),
                        getSafeString(rs.getString("phone")),
                        getSafeString(rs.getString("address")),
                        getSafeString(rs.getString("avatar")),
                        rs.getInt("status"),
                        role,
                        rs.getDate("created_at"),
                        rs.getDate("updated_at")
                );
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

    public List<Breed> getBreedsBySpecies(String speciesId) throws SQLException {
        List<Breed> list = new ArrayList<>();
        String sql = "SELECT * FROM breeds WHERE species_id = ?";
        try (Connection con = DBContext.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, speciesId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                UserDAO specieDAO = new UserDAO();
                Specie specie = specieDAO.getSpecieById(rs.getInt("species_id"));
                Breed breed = new Breed(
                        rs.getInt("id"),
                        specie,
                        rs.getString("name"));
                list.add(breed);

            }
        }
        return list;
    }

    public boolean addPet(String pet_code, String ownerid, String name, int breedid, String gender, String avatar, String desc) {
        Connection con = null;
        PreparedStatement ps = null;
        int rowsAffected = 0;
        try {
            con = DBContext.getConnection();

            String sql = "INSERT INTO Pets (id, pet_code, owner_id, name, breeds_id, gender, avatar, description, status, created_at, updated_at) "
                    + "VALUES (NEWID(), ?, ?, ?, ?, ?, ?, ? ,'active' ,CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)";

            ps = con.prepareStatement(sql);
            ps.setString(1, pet_code);
            ps.setString(2, ownerid);
            ps.setString(3, name);
            ps.setInt(4, breedid);
            ps.setString(5, gender);
            ps.setString(6, avatar);
            ps.setString(7, desc);

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
        String sql = "Update pets set isDelete = 1 where id =? ;";
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

    public User getUserById(int userId) {
        String sql = "Select * from [Users] where id = ?";
        try {
            Connection conn = DBContext.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                return new User(
                        rs.getString("id"),
                        rs.getString("userName"),
                        rs.getString("email"),
                        rs.getString("password"));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public boolean updatePassword(User user) {
        String sql = "UPDATE [dbo].[users] SET [password] = ? WHERE [email] = ?";
        try {
            Connection conn = DBContext.getConnection();
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, user.getPassword());
            st.setString(2, user.getEmail());
            int rowsAffected = st.executeUpdate();

            // Nếu không có dòng nào bị ảnh hưởng => không tìm thấy email
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Update
    public void insertUser(User user) {
        String sql = "INSERT INTO Users(id, username,email, full_name,password) VALUES(?,?, ?,?,?)";
        try (Connection con = DBContext.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            String generatedPassword = generateRandomPassword(10);
            String uuid = UUID.randomUUID().toString();
            ps.setString(1, uuid);  // id
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getFullName());

            ps.setString(5, hashPassword(generatedPassword));
            System.out.println(">> UserDAO.insertUser: chuẩn bị chèn " + user.getEmail());
            int rows = ps.executeUpdate();
            System.out.println(">> UserDAO.insertUser: có " + rows + " dòng bị ảnh hưởng.");
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public String generateRandomPassword(int length) {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@#$%";
        SecureRandom random = new SecureRandom();
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < length; i++) {
            int index = random.nextInt(chars.length());
            sb.append(chars.charAt(index));
        }
        return sb.toString();
    }

    public List<Pet> getPetsByStatus(String status, String userId) {
        List<Pet> petList = new ArrayList<>();
        String sql = "SELECT * FROM Pets WHERE status = ? and owner_id =? and isDelete = 0";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setString(2, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                UserDAO userDao = new UserDAO();
                User user = userDao.getUserById(rs.getString("owner_id"));
                UserDAO breedDao = new UserDAO();
                Breed breed = breedDao.getBreedById(rs.getInt("breeds_id"));
                Pet pet = new Pet(
                        rs.getString("id"),
                        rs.getString("pet_code"),
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
        } catch (Exception e) {
            e.printStackTrace();
        }
        return petList;
    }

    public List<Pet> getPetsByName(String keyWord, String userId) {
        List<Pet> petList = new ArrayList<>();
        String sql = "SELECT * FROM Pets WHERE name LIKE ? and owner_id =? and isDelete = 0";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + keyWord + "%");
            ps.setString(2, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                UserDAO userDao = new UserDAO();
                User user = userDao.getUserById(rs.getString("owner_id"));
                UserDAO breedDao = new UserDAO();
                Breed breed = breedDao.getBreedById(rs.getInt("breeds_id"));
                Pet pet = new Pet(
                        rs.getString("id"),
                        rs.getString("pet_code"),
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
        } catch (Exception e) {
            e.printStackTrace();
        }
        return petList;
    }

    public boolean updatePet(String id, String name, String gender, Date birthDate, int breedId,
            String status, String description, String avatar) {
        String sql = "UPDATE pets SET "
                + "name = ?, "
                + "gender = ?, "
                + "birth_date = ?, "
                + "breeds_id = ?, "
                + "status = ?, "
                + "description = ?, "
                + "avatar = ?, "
                + "updated_at = CURRENT_TIMESTAMP "
                + "WHERE id = ?";

        try {
            Connection conn = DAO.DBContext.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setString(1, name);
            stmt.setString(2, gender);
            stmt.setDate(3, (java.sql.Date) birthDate);  // đã là java.sql.Date
            stmt.setInt(4, breedId);
            stmt.setString(5, status);
            stmt.setString(6, description);
            stmt.setString(7, avatar);
            stmt.setString(8, id);

            int check = stmt.executeUpdate();
            if (check > 0) {
                return true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<User> getAllCustomer() {
        String sql = "select * from users\n"
                + "where role_id=1";
        List<User> list = new ArrayList<>();
        try (Connection conn = DBContext.getConnection(); PreparedStatement stm = conn.prepareStatement(sql);) {
            ResultSet rs = stm.executeQuery();
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
                        rs.getDate("updated_at"));
                list.add(user);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<User> getAllStaff() {
        String sql = "select * from users\n"
                + "where role_id=4";
        List<User> list = new ArrayList<>();
        try (Connection conn = DBContext.getConnection(); PreparedStatement stm = conn.prepareStatement(sql);) {
            ResultSet rs = stm.executeQuery();
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
                        rs.getDate("updated_at"));
                list.add(user);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int updateOwner(String petId, String ownerId) {
        String sql = "update pets\n"
                + "set owner_id=?\n"
                + "where id=?";
        int result = -1;
        try (Connection conn = DBContext.getConnection(); PreparedStatement stm = conn.prepareStatement(sql);) {
            stm.setString(1, ownerId);
            stm.setString(2, petId);
            result = stm.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public boolean isEmailExists(String email) {
        String sql = "SELECT 1 FROM users WHERE email = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement stm = conn.prepareStatement(sql);) {
            stm.setString(1, email);
            ResultSet rs = stm.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void updateUserStatus(String userId, int status) {
        String sql = "UPDATE users SET status = ? WHERE id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement stm = conn.prepareStatement(sql);) {

            stm.setInt(1, status);
            stm.setString(2, userId);
            stm.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

   
    public static void main(String[] args) throws SQLException, ClassNotFoundException {

        UserDAO dao = new UserDAO();
        String ps = dao.hashPassword("hashed_pw");
        System.out.println(ps);
    }

}
