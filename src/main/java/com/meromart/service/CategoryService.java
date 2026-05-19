package com.meromart.service;

import com.meromart.dao.CategoryDAO;
import com.meromart.model.CategoryModel;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class CategoryService {
    private final CategoryDAO categoryDAO = new CategoryDAO();

    public List<CategoryModel> getAllCategories() {
        return categoryDAO.getAllCategories();
    }

    public List<CategoryModel> searchCategories(String query) {
        return categoryDAO.searchCategories(query);
    }

    public CategoryModel getCategoryById(int id) {
        return categoryDAO.getCategoryById(id);
    }

    public boolean addCategory(CategoryModel category) {
        return categoryDAO.addCategory(category);
    }

    public boolean updateCategory(CategoryModel category) {
        return categoryDAO.updateCategory(category);
    }

    public boolean deleteCategory(int id) {
        return categoryDAO.deleteCategory(id);
    }

    public boolean categoryNameExists(String categoryName, Integer excludeId) {
        return categoryDAO.categoryNameExists(categoryName, excludeId);
    }

    public boolean hasLinkedProducts(int categoryId) {
        return categoryDAO.hasLinkedProducts(categoryId);
    }

    public List<Map<String, Object>> buildCategoryStats() {
        List<CategoryModel> categories = getAllCategories();
        int totalCategories = categories.size();
        int activeCategories = 0;
        int unusedCategories = 0;
        int linkedProducts = 0;

        for (CategoryModel category : categories) {
            if (category.getProductCount() > 0) {
                activeCategories++;
            } else {
                unusedCategories++;
            }
            linkedProducts += category.getProductCount();
        }

        return List.of(
                stat("grid", "Total Categories", String.valueOf(totalCategories), "Live store taxonomy"),
                stat("check", "Active Categories", String.valueOf(activeCategories), "Categories with products"),
                stat("leaf", "Unused Categories", String.valueOf(unusedCategories), "Ready for new items"),
                stat("star", "Products Linked", String.valueOf(linkedProducts), "Catalog items assigned")
        );
    }

    private Map<String, Object> stat(String icon, String title, String value, String description) {
        Map<String, Object> stat = new LinkedHashMap<>();
        stat.put("icon", icon);
        stat.put("title", title);
        stat.put("value", value);
        stat.put("description", description);
        return stat;
    }
}
