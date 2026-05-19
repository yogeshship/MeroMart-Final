package com.meromart.filter;

import com.meromart.model.UserModel;
import com.meromart.util.SessionUtil;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

// Filter for protecting private pages and allowing public pages
@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // No setup required
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri = req.getRequestURI();

        // Allow public pages and static resources
        if (isPublicResource(uri)) {
            chain.doFilter(request, response);
            return;
        }

        // Check current logged-in user
        UserModel currentUser = SessionUtil.getCurrentUser(req);

        if (currentUser == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Protect admin pages
        if (uri.startsWith(req.getContextPath() + "/admin")
                || uri.contains("/pages/admin/")) {

            if (!currentUser.isAdmin()) {
                res.sendRedirect(req.getContextPath() + "/pages/common/access-denied.jsp");
                return;
            }
        }

        // Prevent cached private pages after logout
        res.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        res.setHeader("Pragma", "no-cache");
        res.setDateHeader("Expires", 0);

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // No cleanup required
    }

    // Public pages that can be opened without login
    private boolean isPublicResource(String uri) {

        return uri.endsWith("/")
            || uri.endsWith("/index.jsp")

            // Static assets
            || uri.contains("/assets/")

            // Authentication pages
            || uri.endsWith("/login")
            || uri.endsWith("/register")
            || uri.contains("/pages/auth/login.jsp")
            || uri.contains("/pages/auth/register.jsp")

            // Public common pages
            || uri.endsWith("/home")
            || uri.endsWith("/about")
            || uri.endsWith("/contact")
            || uri.contains("/pages/common/home.jsp")
            || uri.contains("/pages/common/about.jsp")
            || uri.contains("/pages/common/contact.jsp")
            || uri.contains("/pages/common/navbar.jsp")
            || uri.contains("/pages/common/footer.jsp")
            || uri.contains("/pages/common/access-denied.jsp")
            || uri.contains("/pages/common/error.jsp")

            // Public product browsing pages
            || uri.endsWith("/product")
            || uri.endsWith("/products")
            || uri.endsWith("/productdetail")
            || uri.endsWith("/product-detail")
            || uri.contains("/pages/user/products.jsp")
            || uri.contains("/pages/user/product-details.jsp");
    }
}