package com.meromart.util;

import com.meromart.model.UserModel;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class SessionUtil {

    private SessionUtil() {
    }

    // Store data in session
    public static void setAttribute(HttpServletRequest request, String name, Object value, int seconds) {
        HttpSession session = request.getSession(true);
        session.setAttribute(name, value);
        session.setMaxInactiveInterval(seconds);
    }

    // Get data from session
    public static Object getAttribute(HttpServletRequest request, String name) {
        HttpSession session = request.getSession(false);
        return session != null ? session.getAttribute(name) : null;
    }

    // Remove one value from session
    public static void removeAttribute(HttpServletRequest request, String name) {
        HttpSession session = request.getSession(false);

        if (session != null) {
            session.removeAttribute(name);
        }
    }

    // Destroy session during logout
    public static void invalidateSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);

        if (session != null) {
            session.invalidate();
        }
    }

    // Get logged-in user from session
    public static UserModel getCurrentUser(HttpServletRequest request) {
        Object user = getAttribute(request, "user");

        if (user instanceof UserModel) {
            return (UserModel) user;
        }

        return null;
    }
}