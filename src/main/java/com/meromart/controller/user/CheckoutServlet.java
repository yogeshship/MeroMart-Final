package com.meromart.controller.user;

import com.meromart.dao.CartDAO;
import com.meromart.dao.OrderDAO;
import com.meromart.model.CartItemModel;
import com.meromart.model.OrderItemModel;
import com.meromart.model.OrderModel;
import com.meromart.model.UserModel;
import com.meromart.util.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final CartDAO cartDAO = new CartDAO();
    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserModel user = SessionUtil.getCurrentUser(request);

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<CartItemModel> cartItems = cartDAO.getCartItems(user.getId());
        BigDecimal total = calculateTotal(cartItems);

        request.setAttribute("activePage", "cart");
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("total", total);

        request.getRequestDispatcher("/pages/user/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserModel user = SessionUtil.getCurrentUser(request);

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<CartItemModel> cartItems = cartDAO.getCartItems(user.getId());

        if (cartItems == null || cartItems.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        String deliveryAddress = request.getParameter("address");

        if (deliveryAddress == null || deliveryAddress.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Delivery address is required.");
            request.setAttribute("cartItems", cartItems);
            request.setAttribute("total", calculateTotal(cartItems));
            request.getRequestDispatcher("/pages/user/checkout.jsp").forward(request, response);
            return;
        }

        BigDecimal total = calculateTotal(cartItems);

        OrderModel order = new OrderModel();
        order.setUserId(user.getId());
        order.setTotalAmount(total);
        order.setDeliveryAddress(deliveryAddress.trim());

        List<OrderItemModel> orderItems = new ArrayList<>();

        for (CartItemModel cartItem : cartItems) {
            OrderItemModel orderItem = new OrderItemModel();
            orderItem.setProductId(cartItem.getProductId());
            orderItem.setQuantity(cartItem.getQuantity());
            orderItem.setPrice(cartItem.getProductPrice());

            orderItems.add(orderItem);
        }

        int orderId = orderDAO.placeOrder(order, orderItems);

        if (orderId > 0) {
            cartDAO.clearCart(user.getId());
            response.sendRedirect(request.getContextPath() + "/order-history?success=true");
        } else {
            request.setAttribute("errorMessage", "Order could not be placed. Please try again.");
            request.setAttribute("cartItems", cartItems);
            request.setAttribute("total", total);
            request.getRequestDispatcher("/pages/user/checkout.jsp").forward(request, response);
        }
    }

    private BigDecimal calculateTotal(List<CartItemModel> cartItems) {
        BigDecimal total = BigDecimal.ZERO;

        if (cartItems == null) {
            return total;
        }

        for (CartItemModel item : cartItems) {
            if (item.getSubtotal() != null) {
                total = total.add(item.getSubtotal());
            }
        }

        return total;
    }
}