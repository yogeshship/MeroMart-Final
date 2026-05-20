package com.meromart.controller.user;

import com.meromart.dao.CartDAO;
import com.meromart.model.UserModel;
import com.meromart.util.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * CartServlet — manages the shopping cart.
 * It supports viewing, adding, updating and removing cart items.
 */
@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final CartDAO cartDAO = new CartDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserModel user = SessionUtil.getCurrentUser(request);

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        request.setAttribute("activePage", "cart");
        request.setAttribute("cartItems", cartDAO.getCartItems(user.getId()));

        request.getRequestDispatcher("/WEB-INF/pages/user/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserModel user = SessionUtil.getCurrentUser(request);

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            Integer productId = resolveProductId(request.getParameter("productId"));

            if (productId == null) {
                response.sendRedirect(request.getContextPath() + "/product?error=invalid-product");
                return;
            }

            int quantity = 1;
            String qtyParam = request.getParameter("quantity");

            if (qtyParam != null && !qtyParam.isBlank()) {
                try {
                    quantity = Integer.parseInt(qtyParam);
                } catch (NumberFormatException e) {
                    quantity = 1;
                }
            }

            if (quantity < 1) {
                quantity = 1;
            }

            cartDAO.addToCart(user.getId(), productId, quantity);
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        if ("update".equals(action)) {
            try {
                int cartItemId = Integer.parseInt(request.getParameter("cartItemId"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));

                if (quantity <= 0) {
                    cartDAO.removeCartItem(cartItemId);
                } else {
                    cartDAO.updateCartItemQuantity(cartItemId, quantity);
                }

            } catch (Exception e) {
                e.printStackTrace();
            }

            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        if ("remove".equals(action)) {
            try {
                int cartItemId = Integer.parseInt(request.getParameter("cartItemId"));
                cartDAO.removeCartItem(cartItemId);
            } catch (Exception e) {
                e.printStackTrace();
            }

            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        response.sendRedirect(request.getContextPath() + "/cart");
    }

    /**
     * Converts product ID from the product detail page into database product ID.
     *
     * Example:
     * P-1001 becomes 1
     * P-1002 becomes 2
     * 1 stays 1
     */
    private Integer resolveProductId(String rawProductId) {
        if (rawProductId == null || rawProductId.isBlank()) {
            return null;
        }

        try {
            if (rawProductId.startsWith("P-")) {
                int staticId = Integer.parseInt(rawProductId.substring(2));
                return staticId - 1000;
            }

            return Integer.parseInt(rawProductId);

        } catch (NumberFormatException e) {
            return null;
        }
    }
}