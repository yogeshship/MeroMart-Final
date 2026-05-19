package com.meromart.service;

import com.meromart.dao.UserDAO;
import com.meromart.model.UserModel;
import com.meromart.util.PasswordUtil;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class UserService {
    private final UserDAO userDAO = new UserDAO();

    public List<UserModel> getAllUsers() {
        return userDAO.getAllUsers();
    }

    public List<UserModel> searchUsers(String query) {
        return userDAO.searchUsers(query);
    }

    public UserModel getUserById(int id) {
        return userDAO.getUserById(id);
    }

    public boolean addUser(UserModel user, String plainPassword) {
        user.setPassword(PasswordUtil.hashPassword(plainPassword));
        return userDAO.addUser(user);
    }

    public boolean updateUser(UserModel user, String plainPassword) {
        boolean updated = userDAO.updateUser(user);
        if (!updated) {
            return false;
        }

        if (plainPassword != null && !plainPassword.isBlank()) {
            return userDAO.updatePassword(user.getId(), PasswordUtil.hashPassword(plainPassword));
        }

        return true;
    }

    public boolean deleteUser(int id) {
        return userDAO.deleteUser(id);
    }

    public boolean emailExists(String email, Integer excludeId) {
        return userDAO.emailExists(email, excludeId);
    }

    public UserModel authenticate(String email, String plainPassword) {
        if (plainPassword == null || plainPassword.isBlank()) {
            return null;
        }
        return userDAO.getUserByEmailAndPassword(email, PasswordUtil.hashPassword(plainPassword));
    }

    public boolean hasAnyAdminUsers() {
        return userDAO.hasAnyAdminUsers();
    }

    public List<Map<String, Object>> buildUserStats() {
        List<UserModel> users = getAllUsers();
        int totalUsers = users.size();
        int adminCount = 0;
        int customerCount = 0;

        for (UserModel user : users) {
            if ("admin".equalsIgnoreCase(user.getRole())) {
                adminCount++;
            } else {
                customerCount++;
            }
        }

        return List.of(
                stat("user", "Total Users", String.valueOf(totalUsers), "All registered accounts"),
                stat("check", "Admin Users", String.valueOf(adminCount), "Internal management access"),
                stat("tag", "Customer Users", String.valueOf(customerCount), "Customer-facing accounts"),
                stat("bag", "New This Cycle", String.valueOf(totalUsers), "Current available records")
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
