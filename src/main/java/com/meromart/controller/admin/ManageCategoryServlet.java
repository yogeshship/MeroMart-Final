package com.meromart.controller.admin;

import com.meromart.model.CategoryModel;
import com.meromart.service.CategoryService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/managecategory")
public class ManageCategoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final CategoryService categoryService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = trim(request.getParameter("q"));
        String editId = request.getParameter("editId");
        List<CategoryModel> categories = categoryService.searchCategories(query);

        request.setAttribute("activePage", "categories");
        request.setAttribute("searchQuery", query == null ? "" : query);
        request.setAttribute("categoryStats", categoryService.buildCategoryStats());
        request.setAttribute("categories", categories);
        request.setAttribute("categoryCount", categories.size());

        if (editId != null && !editId.isBlank()) {
            try {
                CategoryModel editCategory = categoryService.getCategoryById(Integer.parseInt(editId));
                request.setAttribute("editCategory", editCategory);
            } catch (NumberFormatException ignored) {
                request.setAttribute("formError", "Unable to load the selected category.");
            }
        }

        request.getRequestDispatcher("/WEB-INF/pages/admin/manage-categories.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("delete".equalsIgnoreCase(action)) {
            handleDelete(request, response);
            return;
        }

        handleSave(request, response);
    }

    private void handleSave(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String idValue = trim(request.getParameter("categoryId"));
        String name = trim(request.getParameter("categoryName"));
        String description = trim(request.getParameter("description"));
        Integer categoryId = parseInteger(idValue);
        description = description == null ? "" : description;

        if (name == null || name.isBlank()) {
            renderFormError(request, response, "Category name is required.", categoryId, name, description);
            return;
        }

        if (categoryService.categoryNameExists(name, categoryId)) {
            renderFormError(request, response, "A category with this name already exists.", categoryId, name, description);
            return;
        }

        CategoryModel category = new CategoryModel();
        category.setName(name);
        category.setLabel(name);
        category.setDescription(description);

        boolean success;
        if (categoryId == null) {
            success = categoryService.addCategory(category);
            if (success) {
                response.sendRedirect(request.getContextPath() + "/managecategory?msg=added");
                return;
            }
            renderFormError(request, response, "Unable to add the category right now.", null, name, description);
        } else {
            category.setId(categoryId);
            success = categoryService.updateCategory(category);
            if (success) {
                response.sendRedirect(request.getContextPath() + "/managecategory?msg=updated");
                return;
            }
            renderFormError(request, response, "Unable to update the category right now.", categoryId, name, description);
        }
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Integer categoryId = parseInteger(request.getParameter("id"));
        if (categoryId == null) {
            response.sendRedirect(request.getContextPath() + "/managecategory?error=missing");
            return;
        }

        if (categoryService.hasLinkedProducts(categoryId)) {
            response.sendRedirect(request.getContextPath() + "/managecategory?error=linked");
            return;
        }

        boolean deleted = categoryService.deleteCategory(categoryId);
        response.sendRedirect(request.getContextPath() + (deleted ? "/managecategory?msg=deleted" : "/managecategory?error=delete"));
    }

    private void renderFormError(HttpServletRequest request, HttpServletResponse response, String message, Integer categoryId, String name, String description)
            throws ServletException, IOException {
        CategoryModel draft = new CategoryModel();
        if (categoryId != null) {
            draft.setId(categoryId);
        }
        draft.setName(name);
        draft.setLabel(name);
        draft.setDescription(description);

        request.setAttribute("activePage", "categories");
        request.setAttribute("searchQuery", "");
        request.setAttribute("categoryStats", categoryService.buildCategoryStats());
        List<CategoryModel> categories = categoryService.getAllCategories();
        request.setAttribute("categories", categories);
        request.setAttribute("categoryCount", categories.size());
        request.setAttribute("editCategory", draft);
        request.setAttribute("formError", message);
        request.getRequestDispatcher("/WEB-INF/pages/admin/manage-categories.jsp").forward(request, response);
    }

    private Integer parseInteger(String value) {
        try {
            return value == null || value.isBlank() ? null : Integer.parseInt(value);
        } catch (NumberFormatException e) {
            return null;
        }
    }

    private String trim(String value) {
        return value == null ? null : value.trim();
    }
}
