package com.meromart.controller.user;

import com.meromart.dao.OrderDAO;
import com.meromart.model.UserModel;
import com.meromart.util.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * OrderHistoryServlet — shows a user's past orders.
 */
@WebServlet("/order-history")
public class OrderHistoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserModel user = SessionUtil.getCurrentUser(request);
        if (user == null) { response.sendRedirect(request.getContextPath() + "/login"); return; }

        request.setAttribute("orders", orderDAO.getOrdersByUser(user.getId()));
        if ("true".equals(request.getParameter("success"))) {
            request.setAttribute("successMessage", "Your order has been placed successfully!");
        }
        request.getRequestDispatcher("/pages/user/order-history.jsp").forward(request, response);
    }
}
