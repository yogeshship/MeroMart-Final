package com.meromart.controller.admin;

import com.meromart.model.UserModel;
import com.meromart.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/manageuser")
public class ManageUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = trim(request.getParameter("q"));
        String editId = request.getParameter("editId");
        List<UserModel> users = userService.searchUsers(query);

        request.setAttribute("activePage", "users");
        request.setAttribute("searchQuery", query == null ? "" : query);
        request.setAttribute("users", users);
        request.setAttribute("userCount", users.size());
        request.setAttribute("userStats", userService.buildUserStats());

        if (editId != null && !editId.isBlank()) {
            try {
                UserModel editUser = userService.getUserById(Integer.parseInt(editId));
                request.setAttribute("editUser", editUser);
            } catch (NumberFormatException ignored) {
                request.setAttribute("formError", "Unable to load the selected user.");
            }
        }

        request.getRequestDispatcher("/WEB-INF/pages/admin/manage-user.jsp").forward(request, response);
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
        Integer userId = parseInteger(request.getParameter("userId"));
        String fullName = trim(request.getParameter("fullName"));
        String email = trim(request.getParameter("email"));
        String phone = trim(request.getParameter("phone"));
        String password = trim(request.getParameter("password"));
        String role = trim(request.getParameter("role"));
        String address = trim(request.getParameter("address"));

        if (fullName == null || fullName.isBlank()) {
            renderFormError(request, response, "Full name is required.", userId, fullName, email, phone, role, address);
            return;
        }
        if (email == null || email.isBlank()) {
            renderFormError(request, response, "Email is required.", userId, fullName, email, phone, role, address);
            return;
        }
        if (role == null || role.isBlank()) {
            renderFormError(request, response, "Please choose an access level.", userId, fullName, email, phone, role, address);
            return;
        }
        if (userService.emailExists(email, userId)) {
            renderFormError(request, response, "A user with this email already exists.", userId, fullName, email, phone, role, address);
            return;
        }
        if (userId == null && (password == null || password.isBlank())) {
            renderFormError(request, response, "Password is required when creating a new user.", null, fullName, email, phone, role, address);
            return;
        }

        UserModel user = new UserModel();
        if (userId != null) {
            user.setId(userId);
        }
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPhone(phone == null ? "" : phone);
        user.setRole(role);
        user.setAddress(address == null ? "" : address);

        boolean success;
        if (userId == null) {
            success = userService.addUser(user, password);
            if (success) {
                response.sendRedirect(request.getContextPath() + "/manageuser?msg=added");
                return;
            }
            renderFormError(request, response, "Unable to add this user right now.", null, fullName, email, phone, role, address);
        } else {
            success = userService.updateUser(user, password);
            if (success) {
                response.sendRedirect(request.getContextPath() + "/manageuser?msg=updated");
                return;
            }
            renderFormError(request, response, "Unable to update this user right now.", userId, fullName, email, phone, role, address);
        }
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Integer userId = parseInteger(request.getParameter("id"));
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/manageuser?error=missing");
            return;
        }

        boolean deleted = userService.deleteUser(userId);
        response.sendRedirect(request.getContextPath() + (deleted ? "/manageuser?msg=deleted" : "/manageuser?error=delete"));
    }

    private void renderFormError(HttpServletRequest request, HttpServletResponse response, String message, Integer userId,
                                 String fullName, String email, String phone, String role, String address)
            throws ServletException, IOException {
        UserModel draft = new UserModel();
        if (userId != null) {
            draft.setId(userId);
        }
        draft.setFullName(fullName);
        draft.setEmail(email);
        draft.setPhone(phone);
        draft.setRole(role);
        draft.setAddress(address);

        List<UserModel> users = userService.getAllUsers();
        request.setAttribute("activePage", "users");
        request.setAttribute("searchQuery", "");
        request.setAttribute("users", users);
        request.setAttribute("userCount", users.size());
        request.setAttribute("userStats", userService.buildUserStats());
        request.setAttribute("editUser", draft);
        request.setAttribute("formError", message);
        request.getRequestDispatcher("/WEB-INF/pages/admin/manage-user.jsp").forward(request, response);
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
