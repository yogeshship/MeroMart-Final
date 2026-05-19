package com.meromart.controller.auth;

import com.meromart.model.UserModel;
import com.meromart.service.LoginService;
import com.meromart.util.CookieUtil;
import com.meromart.util.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * LoginServlet handles both admin and normal user login.
 * Admin users are redirected to the admin dashboard.
 * Normal users are redirected to the home page after login.
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final int SESSION_TIMEOUT_SECONDS = 60 * 30;
    private static final int EMAIL_COOKIE_SECONDS = 60 * 60 * 24 * 14;

    private final LoginService loginService = new LoginService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        populateViewModel(request);
        request.getRequestDispatcher("/pages/auth/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = trim(request.getParameter("email"));
        String password = request.getParameter("password");

        // Basic validation before checking database
        if (email == null || email.isBlank() || password == null || password.isBlank()) {
            request.setAttribute("loginError", "Enter both email and password to continue.");
            request.setAttribute("submittedEmail", email == null ? "" : email);

            populateViewModel(request);
            request.getRequestDispatcher("/pages/auth/login.jsp").forward(request, response);
            return;
        }

        // Authenticate user using LoginService
        UserModel user = loginService.authenticate(email, password);

        if (user == null) {
            request.setAttribute("loginError", "We could not match that email and password.");
            request.setAttribute("submittedEmail", email);

            populateViewModel(request);
            request.getRequestDispatcher("/pages/auth/login.jsp").forward(request, response);
            return;
        }

        // Store logged-in user in session
        SessionUtil.setAttribute(request, "user", user, SESSION_TIMEOUT_SECONDS);

        // Store last used email for convenience
        CookieUtil.addCookie(response, "meroMartLastEmail", user.getEmail(), EMAIL_COOKIE_SECONDS);

        // Redirect based on role
        if (user.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/admindashboard");
        } else {
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }

    /**
     * Sends remembered email and bootstrap mode information to login.jsp.
     */
    private void populateViewModel(HttpServletRequest request) {
        String rememberedEmail = CookieUtil.getCookieValue(request, "meroMartLastEmail");

        request.setAttribute("rememberedEmail", rememberedEmail == null ? "" : rememberedEmail);
        request.setAttribute("bootstrapMode", !loginService.hasAnyAdminUsers());
    }

    private String trim(String value) {
        return value == null ? null : value.trim();
    }
}