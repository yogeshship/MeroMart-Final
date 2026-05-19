package com.meromart.dao;

import com.meromart.model.CategoryModel;
import com.meromart.util.DBConfig;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {

    public List<CategoryModel> getAllCategories() {
        return searchCategories(null);
    }

    public List<CategoryModel> searchCategories(String query) {
        List<CategoryModel> categories = new ArrayList<>();
        String sql = """
                SELECT c.category_id,
                       c.category_name,
                       c.description,
                       COUNT(p.product_Id) AS product_count
                FROM categories c
                LEFT JOIN products p ON c.category_id = p.category_id
                WHERE (? IS NULL OR ? = '' OR c.category_name LIKE ? OR c.description LIKE ?)
                GROUP BY c.category_id, c.category_name, c.description
                ORDER BY c.category_name ASC
                """;

        String keyword = query == null ? null : "%" + query.trim() + "%";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, query);
            ps.setString(2, query);
            ps.setString(3, keyword);
            ps.setString(4, keyword);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    categories.add(mapCategory(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return categories;
    }

    public CategoryModel getCategoryById(int id) {
        String sql = """
                SELECT c.category_id,
                       c.category_name,
                       c.description,
                       COUNT(p.product_Id) AS product_count
                FROM categories c
                LEFT JOIN products p ON c.category_id = p.category_id
                WHERE c.category_id = ?
                GROUP BY c.category_id, c.category_name, c.description
                """;

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapCategory(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public boolean addCategory(CategoryModel category) {
        String sql = "INSERT INTO categories (category_name, description) VALUES (?, ?)";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, category.getName());
            ps.setString(2, category.getDescription());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateCategory(CategoryModel category) {
        String sql = "UPDATE categories SET category_name = ?, description = ? WHERE category_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, category.getName());
            ps.setString(2, category.getDescription());
            ps.setInt(3, category.getId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteCategory(int id) {
        String sql = "DELETE FROM categories WHERE category_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean categoryNameExists(String categoryName, Integer excludeId) {
        String sql = "SELECT COUNT(*) FROM categories WHERE LOWER(category_name) = LOWER(?)"
                + (excludeId != null ? " AND category_id <> ?" : "");

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, categoryName);
            if (excludeId != null) {
                ps.setInt(2, excludeId);
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean hasLinkedProducts(int categoryId) {
        String sql = "SELECT COUNT(*) FROM products WHERE category_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, categoryId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    private CategoryModel mapCategory(ResultSet rs) throws Exception {
        CategoryModel category = new CategoryModel();
        category.setId(rs.getInt("category_id"));
        category.setName(rs.getString("category_name"));
        category.setLabel(rs.getString("category_name"));
        category.setDescription(rs.getString("description"));
        category.setProductCount(rs.getInt("product_count"));
        category.setStatus(category.getProductCount() > 0 ? "Active" : "Unused");
        category.setStatusClass(category.getProductCount() > 0 ? "status-success" : "status-soft-warning");
        category.setIcon(buildIcon(category.getName()));
        return category;
    }

    private String buildIcon(String categoryName) {
        if (categoryName == null || categoryName.isBlank()) {
            return "CT";
        }

        String[] words = categoryName.trim().split("\\s+");
        StringBuilder icon = new StringBuilder();
        for (String word : words) {
            if (!word.isBlank()) {
                icon.append(Character.toUpperCase(word.charAt(0)));
            }
            if (icon.length() == 2) {
                break;
            }
        }

        if (icon.length() == 1 && categoryName.length() > 1) {
            icon.append(Character.toUpperCase(categoryName.charAt(1)));
        }

        return icon.toString();
    }
}
