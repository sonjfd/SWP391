package DAO;

import Model.ProductVariant;
import Model.ProductVariantFlavor;
import Model.ProductVariantWeight;
import java.sql.*;
import java.util.*;

public class ProductVariantDAO extends DBContext {

    private ProductVariant extractFromResultSet(ResultSet rs) throws SQLException {
        ProductVariant pv = new ProductVariant();
        pv.setProductVariantId(rs.getInt("product_variant_id"));
        pv.setProductName(rs.getString("product_name"));
        pv.setCategoryName(rs.getString("category_name"));
        pv.setWeight(rs.getDouble("weight"));
        pv.setFlavorName(rs.getString("flavor"));
        pv.setPrice(rs.getDouble("price"));
        pv.setStockQuantity(rs.getInt("stock_quantity"));
        pv.setImage(rs.getString("image"));
        pv.setStatus(rs.getBoolean("status"));
        pv.setCreatedAt(rs.getTimestamp("created_at"));
        pv.setUpdatedAt(rs.getTimestamp("updated_at"));
        return pv;
    }

    public List<ProductVariant> getAllVariants() {
        List<ProductVariant> list = new ArrayList<>();
        String sql = "SELECT pv.product_variant_id, p.product_name, c.category_name, w.weight, f.flavor, pv.price, pv.stock_quantity, pv.image, pv.status, pv.created_at, pv.updated_at FROM product_variants pv JOIN products p ON pv.product_id = p.product_id JOIN categories c ON p.category_id = c.category_id JOIN product_variant_weights w ON pv.weight_id = w.weight_id JOIN product_variant_flavors f ON pv.flavor_id = f.flavor_id";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(extractFromResultSet(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<ProductVariant> search(String name, Boolean status, int page, int pageSize) {
        List<ProductVariant> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT pv.product_variant_id, p.product_name, c.category_name, w.weight, f.flavor, pv.price, pv.stock_quantity, pv.image, pv.status, pv.created_at, pv.updated_at FROM product_variants pv JOIN products p ON pv.product_id = p.product_id JOIN categories c ON p.category_id = c.category_id JOIN product_variant_weights w ON pv.weight_id = w.weight_id JOIN product_variant_flavors f ON pv.flavor_id = f.flavor_id WHERE 1=1");

        if (name != null && !name.isEmpty()) {
            sql.append(" AND p.product_name LIKE ?");
        }
        if (status != null) {
            sql.append(" AND pv.status = ?");
        }
        sql.append(" ORDER BY pv.product_variant_id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            int index = 1;
            if (name != null && !name.isEmpty()) {
                ps.setString(index++, "%" + name + "%");
            }
            if (status != null) {
                ps.setBoolean(index++, status);
            }
            ps.setInt(index++, (page - 1) * pageSize);
            ps.setInt(index, pageSize);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(extractFromResultSet(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countSearch(String name, Boolean status) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM product_variants pv JOIN products p ON pv.product_id = p.product_id JOIN categories c ON p.category_id = c.category_id JOIN product_variant_weights w ON pv.weight_id = w.weight_id JOIN product_variant_flavors f ON pv.flavor_id = f.flavor_id WHERE 1=1");

        if (name != null && !name.isEmpty()) {
            sql.append(" AND p.product_name LIKE ?");
        }
        if (status != null) {
            sql.append(" AND pv.status = ?");
        }

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            int index = 1;
            if (name != null && !name.isEmpty()) {
                ps.setString(index++, "%" + name + "%");
            }
            if (status != null) {
                ps.setBoolean(index++, status);
            }
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public void add(ProductVariant pv) {
        String sql = "INSERT INTO product_variants (product_id, weight_id, flavor_id, price, stock_quantity, status, image, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, GETDATE(), GETDATE())";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, pv.getProductId());
            ps.setInt(2, pv.getWeightId());
            ps.setInt(3, pv.getFlavorId());
            ps.setDouble(4, pv.getPrice());
            ps.setInt(5, pv.getStockQuantity());
            ps.setBoolean(6, pv.isStatus());
            ps.setString(7, pv.getImage());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void update(ProductVariant pv) {
        String sql = "UPDATE product_variants SET weight_id = ?, flavor_id = ?, price = ?, stock_quantity = ?, status = ?, image = ?, updated_at = GETDATE() WHERE product_variant_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, pv.getWeightId());
            ps.setInt(2, pv.getFlavorId());
            ps.setDouble(3, pv.getPrice());
            ps.setInt(4, pv.getStockQuantity());
            ps.setBoolean(5, pv.isStatus());
            ps.setString(6, pv.getImage());
            ps.setInt(7, pv.getProductVariantId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void delete(int id) {
        String sql = "DELETE FROM product_variants WHERE product_variant_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ProductVariant getById(int id) {
        String sql = "SELECT pv.*, p.product_name, c.category_name, w.weight, f.flavor FROM product_variants pv JOIN products p ON pv.product_id = p.product_id JOIN categories c ON p.category_id = c.category_id JOIN product_variant_weights w ON pv.weight_id = w.weight_id JOIN product_variant_flavors f ON pv.flavor_id = f.flavor_id WHERE pv.product_variant_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                ProductVariant pv = new ProductVariant();
                pv.setProductVariantId(rs.getInt("product_variant_id"));
                pv.setProductId(rs.getInt("product_id"));
                pv.setWeightId(rs.getInt("weight_id"));
                pv.setFlavorId(rs.getInt("flavor_id"));
                pv.setPrice(rs.getDouble("price"));
                pv.setStockQuantity(rs.getInt("stock_quantity"));
                pv.setStatus(rs.getBoolean("status"));
                pv.setImage(rs.getString("image"));
                pv.setCreatedAt(rs.getTimestamp("created_at"));
                pv.setUpdatedAt(rs.getTimestamp("updated_at"));
                pv.setProductName(rs.getString("product_name"));
                pv.setCategoryName(rs.getString("category_name"));
                pv.setWeight(rs.getDouble("weight"));
                pv.setFlavorName(rs.getString("flavor"));
                return pv;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean isDuplicateVariant(int productId, int weightId, int flavorId) {
        String sql = "SELECT 1 FROM product_variants WHERE product_id = ? AND weight_id = ? AND flavor_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ps.setInt(2, weightId);
            ps.setInt(3, flavorId);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean isDuplicateVariantExcludeId(int productId, int weightId, int flavorId, int excludeId) {
        String sql = "SELECT 1 FROM product_variants WHERE product_id = ? AND weight_id = ? AND flavor_id = ? AND product_variant_id != ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ps.setInt(2, weightId);
            ps.setInt(3, flavorId);
            ps.setInt(4, excludeId);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<ProductVariant> filterProductVariants(Integer categoryId, String[] weights, String[] flavors, String[] priceRanges, String sort, int page, int limit) {
        List<ProductVariant> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(buildBaseQuery());
        List<Object> params = new ArrayList<>();

        appendCategoryFilter(sql, params, categoryId);
        appendWeightFilter(sql, params, weights);
        appendFlavorFilter(sql, params, flavors);
        appendPriceFilter(sql, params, priceRanges);
        appendSortClause(sql, sort);

        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add((page - 1) * limit);
        params.add(limit);

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductVariant v = new ProductVariant();
                v.setProductVariantId(rs.getInt("product_variant_id"));
                v.setProductId(rs.getInt("product_id"));
                v.setWeightId(rs.getInt("weight_id"));
                v.setFlavorId(rs.getInt("flavor_id"));
                v.setPrice(rs.getDouble("price"));
                v.setStockQuantity(rs.getInt("stock_quantity"));
                v.setStatus(rs.getBoolean("status"));
                v.setImage(rs.getString("image"));
                v.setCreatedAt(rs.getTimestamp("created_at"));
                v.setUpdatedAt(rs.getTimestamp("updated_at"));
                v.setProductName(rs.getString("productName"));
                v.setWeight(rs.getDouble("weight"));
                v.setFlavorName(rs.getString("flavorName"));
                v.setCategoryName(rs.getString("categoryName"));
                list.add(v);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public int countFilteredVariants(Integer categoryId, String[] weights, String[] flavors, String[] priceRanges) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM product_variants pv\n"
                + " JOIN products p ON pv.product_id = p.product_id\n"
                + " JOIN categories c ON p.category_id = c.category_id\n"
                + " JOIN product_variant_weights w ON pv.weight_id = w.weight_id\n"
                + " JOIN product_variant_flavors f ON pv.flavor_id = f.flavor_id\n"
                + " WHERE pv.status = 1");
        List<Object> params = new ArrayList<>();

        appendCategoryFilter(sql, params, categoryId);
        appendWeightFilter(sql, params, weights);
        appendFlavorFilter(sql, params, flavors);
        appendPriceFilter(sql, params, priceRanges);

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    private String buildBaseQuery() {
        return "SELECT pv.*, p.product_name AS productName, w.weight, f.flavor AS flavorName, c.category_name AS categoryName\n"
                + " FROM product_variants pv\n"
                + " JOIN products p ON pv.product_id = p.product_id\n"
                + " JOIN categories c ON p.category_id = c.category_id\n"
                + " JOIN product_variant_weights w ON pv.weight_id = w.weight_id\n"
                + " JOIN product_variant_flavors f ON pv.flavor_id = f.flavor_id\n"
                + " WHERE pv.status = 1";
    }

    private void appendCategoryFilter(StringBuilder sql, List<Object> params, Integer categoryId) {
        if (categoryId != null) {
            sql.append(" AND c.category_id = ?");
            params.add(categoryId);
        }
    }

    private void appendWeightFilter(StringBuilder sql, List<Object> params, String[] weights) {
        if (weights != null && weights.length > 0) {
            sql.append(" AND pv.weight_id IN (");
            for (int i = 0; i < weights.length; i++) {
                sql.append("?");
                if (i < weights.length - 1) {
                    sql.append(",");
                }
                params.add(Integer.parseInt(weights[i]));
            }
            sql.append(")");
        }
    }

    private void appendFlavorFilter(StringBuilder sql, List<Object> params, String[] flavors) {
        if (flavors != null && flavors.length > 0) {
            sql.append(" AND pv.flavor_id IN (");
            for (int i = 0; i < flavors.length; i++) {
                sql.append("?");
                if (i < flavors.length - 1) {
                    sql.append(",");
                }
                params.add(Integer.parseInt(flavors[i]));
            }
            sql.append(")");
        }
    }

    private void appendPriceFilter(StringBuilder sql, List<Object> params, String[] priceRanges) {
        if (priceRanges != null && priceRanges.length > 0) {
            sql.append(" AND (");
            for (int i = 0; i < priceRanges.length; i++) {
                String[] range = priceRanges[i].split("-");
                boolean hasMin = !range[0].isEmpty();
                boolean hasMax = range.length > 1 && !range[1].isEmpty();

                if (i > 0) {
                    sql.append(" OR ");
                }
                if (hasMin && hasMax) {
                    sql.append("(pv.price >= ? AND pv.price <= ?)");
                    params.add(Integer.parseInt(range[0]));
                    params.add(Integer.parseInt(range[1]));
                } else if (hasMin) {
                    sql.append("(pv.price >= ?)");
                    params.add(Integer.parseInt(range[0]));
                } else if (hasMax) {
                    sql.append("(pv.price <= ?)");
                    params.add(Integer.parseInt(range[1]));
                }
            }
            sql.append(")");
        }
    }

    private void appendSortClause(StringBuilder sql, String sort) {
        if ("asc".equalsIgnoreCase(sort)) {
            sql.append(" ORDER BY pv.price ASC");
        } else if ("desc".equalsIgnoreCase(sort)) {
            sql.append(" ORDER BY pv.price DESC");
        } else {
            sql.append(" ORDER BY pv.created_at DESC");
        }
    }

    public List<ProductVariant> getVariantsByProductId(int productId) {
        List<ProductVariant> list = new ArrayList<>();
        String sql = "SELECT pv.*, p.product_name AS productName, w.weight, f.flavor AS flavorName, c.category_name AS categoryName "
                + "FROM product_variants pv "
                + "JOIN products p ON pv.product_id = p.product_id "
                + "JOIN categories c ON p.category_id = c.category_id "
                + "JOIN product_variant_weights w ON pv.weight_id = w.weight_id "
                + "JOIN product_variant_flavors f ON pv.flavor_id = f.flavor_id "
                + "WHERE pv.product_id = ? AND pv.status = 1";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ProductVariant v = new ProductVariant();
                v.setProductVariantId(rs.getInt("product_variant_id"));
                v.setProductId(rs.getInt("product_id"));
                v.setWeightId(rs.getInt("weight_id"));
                v.setFlavorId(rs.getInt("flavor_id"));
                v.setPrice(rs.getDouble("price"));
                v.setStockQuantity(rs.getInt("stock_quantity"));
                v.setStatus(rs.getBoolean("status"));
                v.setImage(rs.getString("image"));
                v.setCreatedAt(rs.getTimestamp("created_at"));
                v.setUpdatedAt(rs.getTimestamp("updated_at"));

                v.setProductName(rs.getString("productName"));
                v.setWeight(rs.getDouble("weight"));
                v.setFlavorName(rs.getString("flavorName"));
                v.setCategoryName(rs.getString("categoryName"));

                list.add(v);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public ProductVariant getVariantByProductIdWeightFlavor(int productId,int weightId, int flavorId) {
        String sql = """
                 SELECT 
                     pv.*, 
                     p.product_name AS product_name, 
                     c.category_name AS category_name, 
                     w.weight, 
                     f.flavor
                 FROM 
                     product_variants pv
                 JOIN 
                     products p ON pv.product_id = p.product_id
                 JOIN 
                     categories c ON p.category_id = c.category_id
                 JOIN 
                     product_variant_weights w ON pv.weight_id = w.weight_id
                 JOIN 
                     product_variant_flavors f ON pv.flavor_id = f.flavor_id
                 WHERE 
                     pv.product_id=? and
                     pv.weight_id = ? 
                     AND pv.flavor_id = ?;
                 """;

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ps.setInt(2, weightId);
            ps.setInt(3, flavorId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    ProductVariant variant = new ProductVariant();

                    variant.setProductVariantId(rs.getInt("product_variant_id"));
                    variant.setProductId(rs.getInt("product_id"));
                    variant.setWeightId(rs.getInt("weight_id"));
                    variant.setFlavorId(rs.getInt("flavor_id"));
                    variant.setPrice(rs.getDouble("price"));
                    variant.setStockQuantity(rs.getInt("stock_quantity"));
                    variant.setStatus(rs.getBoolean("status"));
                    variant.setImage(rs.getString("image"));
                  
                    variant.setProductName(rs.getString("product_name"));
                    variant.setCategoryName(rs.getString("category_name"));
                    variant.setWeight(rs.getDouble("weight"));
                    variant.setFlavorName(rs.getString("flavor"));

                    return variant;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
    
    public List<ProductVariantFlavor> getFlavorsByProductId(int productId) {
    List<ProductVariantFlavor> flavors = new ArrayList<>();
    String sql = "SELECT DISTINCT f.flavor_id, f.flavor " +
                 "FROM product_variants v " +
                 "JOIN product_variant_flavors f ON v.flavor_id = f.flavor_id " +
                 "WHERE v.product_id = ?";
    try (Connection conn = DBContext.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setInt(1, productId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            ProductVariantFlavor flavor = new ProductVariantFlavor();
            flavor.setFlavorId(rs.getInt("flavor_id"));
            flavor.setFlavor(rs.getString("flavor"));
            flavors.add(flavor);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return flavors;
}

    
    

    
  public List<ProductVariantWeight> getWeightsByProductIdAndFlavor(int productId, int flavorId) {
    List<ProductVariantWeight> weights = new ArrayList<>();
    String sql = "SELECT DISTINCT w.weight_id, w.weight " +
                 "FROM product_variants v " +
                 "JOIN product_variant_weights w ON v.weight_id = w.weight_id " +
                 "WHERE v.product_id = ? AND v.flavor_id = ?";

    try (Connection conn = DBContext.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setInt(1, productId);
        ps.setInt(2, flavorId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            ProductVariantWeight weight = new ProductVariantWeight();
            weight.setWeightId(rs.getInt("weight_id"));
            weight.setWeight(rs.getDouble("weight")); // vì là double
            weights.add(weight);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return weights;
}

  public ProductVariant getFirstVariantByProductId(int productId) {
    String sql = "SELECT TOP 1 * FROM product_variant WHERE product_id = ?";
    try (Connection conn = DBContext.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, productId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
              ProductVariant variant = new ProductVariant();

                    variant.setProductVariantId(rs.getInt("product_variant_id"));
                    variant.setProductId(rs.getInt("product_id"));
                    variant.setWeightId(rs.getInt("weight_id"));
                    variant.setFlavorId(rs.getInt("flavor_id"));
                    variant.setPrice(rs.getDouble("price"));
                    variant.setStockQuantity(rs.getInt("stock_quantity"));
                    variant.setStatus(rs.getBoolean("status"));
                    variant.setImage(rs.getString("image"));
                  
                    variant.setProductName(rs.getString("product_name"));
                    variant.setCategoryName(rs.getString("category_name"));
                    variant.setWeight(rs.getDouble("weight"));
                    variant.setFlavorName(rs.getString("flavor"));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return null;
}
  
    // ➕ 1. Lấy đường dẫn ảnh cũ (để xoá khi upload mới)
    public String getImagePathById(int variantId) {
        String sql = "SELECT image FROM product_variants WHERE product_variant_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, variantId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("image");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

// ➕ 2. Cập nhật ảnh mới (khi chỉ muốn thay ảnh)
    public boolean updateImageById(int variantId, String imagePath) {
        String sql = "UPDATE product_variants SET image = ?, updated_at = GETDATE() WHERE product_variant_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, imagePath);
            ps.setInt(2, variantId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }





    public static void main(String[] args) {
        // Giả sử productId là 1 để kiểm tra
        int productId = 1;

        // Tạo đối tượng ProductVariantService để gọi các phương thức
                ProductVariantDAO dao=new ProductVariantDAO();
        // Test hàm getFlavorsByProductId
        List<ProductVariantFlavor> flavors = dao.getFlavorsByProductId(productId);
        System.out.println("Flavors for product ID " + productId + ":");
        for (ProductVariantFlavor flavor : flavors) {
            System.out.println(flavor);
        }

        // Test hàm getWeightsByProductId
        List<ProductVariantWeight> weights = dao.getWeightsByProductIdAndFlavor(productId,1);
        System.out.println("\nWeights for product ID " + productId + ":");
        for (ProductVariantWeight weight : weights) {
            System.out.println(weight);
        }
    }
}
