package DAO;

import Model.Category;
import Model.Product;

import java.sql.*;
import java.util.*;

public class ProductDAO extends DBContext {

    public List<Product> getAllActiveProducts() {
        List<Product> list = new ArrayList<>();
        String sql = """
            SELECT p.product_id, p.category_id, p.product_name, p.description, 
                   p.created_at, p.updated_at,
                   c.category_name, 
                   c.description AS category_description, 
                   c.status AS category_status
            FROM products p
            JOIN categories c ON p.category_id = c.category_id
            WHERE p.status = 1
        """;

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Category category = new Category();
                category.setCategoryId(rs.getInt("category_id"));
                category.setCategoryName(rs.getString("category_name"));
                category.setDescription(rs.getString("category_description"));
                category.setStatus(rs.getBoolean("category_status"));

                Product product = new Product();
                product.setProductId(rs.getInt("product_id"));
                product.setProductName(rs.getString("product_name"));
                product.setDescription(rs.getString("description"));
                product.setCreatedAt(rs.getTimestamp("created_at"));
                product.setUpdatedAt(rs.getTimestamp("updated_at"));
                product.setCategory(category);

                list.add(product);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean insertProduct(Product product) {
        String sql = """
            INSERT INTO products (category_id, product_name, description, status, created_at, updated_at)
            VALUES (?, ?, ?, 1, GETDATE(), GETDATE())
        """;

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, product.getCategory().getCategoryId());
            ps.setString(2, product.getProductName());
            ps.setString(3, product.getDescription());
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateProduct(Product product) {
        String sql = """
            UPDATE products 
            SET category_id = ?, product_name = ?, description = ?, updated_at = GETDATE()
            WHERE product_id = ?
        """;

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, product.getCategory().getCategoryId());
            ps.setString(2, product.getProductName());
            ps.setString(3, product.getDescription());
            ps.setInt(4, product.getProductId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean softDeleteProduct(int id) {
        String sql = "UPDATE products SET status = 0, updated_at = GETDATE() WHERE product_id = ?";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Product getProductById(int id) {
        String sql = """
            SELECT p.product_id, p.category_id, p.product_name, p.description, 
                   p.created_at, p.updated_at,
                   c.category_name, 
                   c.description AS category_description, 
                   c.status AS category_status
            FROM products p
            JOIN categories c ON p.category_id = c.category_id
            WHERE p.product_id = ?
        """;

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Category category = new Category();
                    category.setCategoryId(rs.getInt("category_id"));
                    category.setCategoryName(rs.getString("category_name"));
                    category.setDescription(rs.getString("category_description"));
                    category.setStatus(rs.getBoolean("category_status"));

                    Product product = new Product();
                    product.setProductId(rs.getInt("product_id"));
                    product.setProductName(rs.getString("product_name"));
                    product.setDescription(rs.getString("description"));
                    product.setCreatedAt(rs.getTimestamp("created_at"));
                    product.setUpdatedAt(rs.getTimestamp("updated_at"));
                    product.setCategory(category);

                    return product;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public int countProductsByName(String keyword) {
        String sql = "SELECT COUNT(*) FROM products WHERE product_name LIKE ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Product> searchProductsByName(String keyword, int page, int pageSize) {
        List<Product> list = new ArrayList<>();
        String sql = """
        SELECT p.product_id, p.category_id, p.product_name, p.description,
               p.created_at, p.updated_at,
               c.category_name, c.description AS category_description, c.status AS category_status
        FROM products p
        JOIN categories c ON p.category_id = c.category_id
        WHERE p.product_name LIKE ?
        ORDER BY p.product_id
        OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
        """;

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ps.setInt(2, (page - 1) * pageSize);
            ps.setInt(3, pageSize);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Category category = new Category();
                    category.setCategoryId(rs.getInt("category_id"));
                    category.setCategoryName(rs.getString("category_name"));
                    category.setDescription(rs.getString("category_description"));
                    category.setStatus(rs.getBoolean("category_status"));

                    Product product = new Product();
                    product.setProductId(rs.getInt("product_id"));
                    product.setProductName(rs.getString("product_name"));
                    product.setDescription(rs.getString("description"));
                    product.setCreatedAt(rs.getTimestamp("created_at"));
                    product.setUpdatedAt(rs.getTimestamp("updated_at"));
                    product.setCategory(category);

                    list.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countAllProducts() {
        String sql = "SELECT COUNT(*) FROM products WHERE status = 1";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Product> getProductsByPage(int page, int pageSize) {
        List<Product> list = new ArrayList<>();
        String sql = """
        SELECT p.product_id, p.category_id, p.product_name, p.description,
               p.created_at, p.updated_at,
               c.category_name, c.description AS category_description, c.status AS category_status
        FROM products p
        JOIN categories c ON p.category_id = c.category_id
        WHERE p.status = 1
        ORDER BY p.product_id
        OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
        """;

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, (page - 1) * pageSize);
            ps.setInt(2, pageSize);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Category category = new Category();
                    category.setCategoryId(rs.getInt("category_id"));
                    category.setCategoryName(rs.getString("category_name"));
                    category.setDescription(rs.getString("category_description"));
                    category.setStatus(rs.getBoolean("category_status"));

                    Product product = new Product();
                    product.setProductId(rs.getInt("product_id"));
                    product.setProductName(rs.getString("product_name"));
                    product.setDescription(rs.getString("description"));
                    product.setCreatedAt(rs.getTimestamp("created_at"));
                    product.setUpdatedAt(rs.getTimestamp("updated_at"));
                    product.setCategory(category);

                    list.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}