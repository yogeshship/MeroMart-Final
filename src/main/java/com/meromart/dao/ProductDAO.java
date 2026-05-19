package com.meromart.dao;

import com.meromart.model.ProductModel;
import com.meromart.util.DBConfig;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    // CREATE
    public boolean addProduct(ProductModel p) {
        String sql = "INSERT INTO products (product_name, description, price, stock_quantity, unit, image_path, category_id, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getProductName());
            ps.setString(2, p.getDescription());
            ps.setDouble(3, p.getPrice());
            ps.setInt(4, p.getStockQuantity());
            ps.setString(5, p.getUnit());
            ps.setString(6, p.getImagePath());
            ps.setInt(7, p.getCategoryId());
            ps.setString(8, p.getStatus());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // READ ALL
    public List<ProductModel> getAllProducts() {
        List<ProductModel> list = new ArrayList<>();
        String sql = "SELECT p.product_Id AS id, p.product_name, p.description, p.price, p.stock_quantity, p.unit, p.image_path, p.category_id, p.status, c.category_name " +
                "FROM products p LEFT JOIN categories c ON p.category_id = c.category_id ORDER BY p.product_Id DESC";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapResultSetToProduct(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // READ ONE
    public ProductModel getProductById(int id) {
        String sql = "SELECT p.product_Id AS id, p.product_name, p.description, p.price, p.stock_quantity, p.unit, p.image_path, p.category_id, p.status, c.category_name " +
                "FROM products p LEFT JOIN categories c ON p.category_id = c.category_id WHERE p.product_Id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapResultSetToProduct(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // UPDATE
    public boolean updateProduct(ProductModel p) {
        String sql = "UPDATE products SET product_name=?, category_id=?, price=?, stock_quantity=?, unit=?, status=?, description=?, image_path=? WHERE product_Id=?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getProductName());
            ps.setInt(2, p.getCategoryId());
            ps.setDouble(3, p.getPrice());
            ps.setInt(4, p.getStockQuantity());
            ps.setString(5, p.getUnit());
            ps.setString(6, p.getStatus());
            ps.setString(7, p.getDescription());
            ps.setString(8, p.getImagePath());
            ps.setInt(9, p.getId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // DELETE
    public boolean deleteProduct(int id) {
        String sql = "DELETE FROM products WHERE product_Id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private ProductModel mapResultSetToProduct(ResultSet rs) throws Exception {
        ProductModel p = new ProductModel();
        p.setId(rs.getInt("id"));
        p.setProductName(rs.getString("product_name"));
        p.setCategoryId(rs.getInt("category_id"));
        p.setCategoryName(rs.getString("category_name"));
        p.setPrice(rs.getDouble("price"));
        p.setStockQuantity(rs.getInt("stock_quantity"));
        p.setUnit(rs.getString("unit"));
        p.setStatus(rs.getString("status"));
        p.setDescription(rs.getString("description"));
        p.setImagePath(normalizeImagePath(rs.getString("image_path")));
        return p;
    }

    private String normalizeImagePath(String imagePath) {
        if (imagePath == null || imagePath.isBlank()) {
            return "assets/images/placeholder.png";
        }

        String normalized = imagePath.replace("\\", "/").trim();
        if (normalized.startsWith("assets/")) {
            return normalized;
        }

        return "assets/images/products/" + normalized;
    }
}
