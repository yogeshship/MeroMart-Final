package com.meromart.filter;

import com.meromart.model.UserModel;
import com.meromart.util.SessionUtil;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebFilter(urlPatterns = {"/login", "/register"})
public class GuestFilter extends HttpFilter {
    private static final long serialVersionUID = 1L;

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        Object sessionUser = SessionUtil.getAttribute(httpRequest, "user");
        if (sessionUser instanceof UserModel user) {
            if (user.isAdmin()) {
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/admindashboard");
            } else {
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/product");
            }
            return;
        }

        chain.doFilter(request, response);
    }
}
