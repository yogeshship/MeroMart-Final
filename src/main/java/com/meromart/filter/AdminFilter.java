package com.meromart.filter;

import com.meromart.model.UserModel;
import com.meromart.service.LoginService;
import com.meromart.util.SessionUtil;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebFilter(urlPatterns = {
        "/admindashboard",
        "/manageproducts",
        "/addproduct",
        "/editproduct",
        "/deleteproduct",
        "/manageuser",
        "/managecategory",
        "/manageorder"
})
public class AdminFilter extends HttpFilter implements Filter {
    private static final long serialVersionUID = 1L;
    private final LoginService loginService = new LoginService();

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        setNoCacheHeaders(httpResponse);

        if (!loginService.hasAnyAdminUsers()) {
            chain.doFilter(request, response);
            return;
        }

        Object sessionUser = SessionUtil.getAttribute(httpRequest, "user");
        if (sessionUser instanceof UserModel user && user.isAdmin()) {
            chain.doFilter(request, response);
            return;
        }

        if (sessionUser != null) {
            request.setAttribute("deniedMessage", "You are logged in, but this area is reserved for admin accounts.");
            request.getRequestDispatcher("/pages/common/access-denied.jsp").forward(request, response);
            return;
        }

        httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
    }

    @Override
    public void destroy() {
    }

    private void setNoCacheHeaders(HttpServletResponse response) {
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
    }
}
