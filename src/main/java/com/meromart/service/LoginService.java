package com.meromart.service;

import com.meromart.dao.UserDAO;
import com.meromart.model.UserModel;
import com.meromart.util.PasswordUtil;

public class LoginService {
    private final UserDAO userDAO = new UserDAO();

    public UserModel authenticate(String email, String plainPassword) {
        if (email == null || email.isBlank() || plainPassword == null || plainPassword.isBlank()) {
            return null;
        }
        return userDAO.getUserByEmailAndPassword(email.trim(), PasswordUtil.hashPassword(plainPassword));
    }

    public boolean hasAnyAdminUsers() {
        return userDAO.hasAnyAdminUsers();
    }
}
