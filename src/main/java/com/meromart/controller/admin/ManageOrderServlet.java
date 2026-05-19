package com.meromart.controller.admin;

import com.meromart.dao.OrderDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

// Handles admin order listing and order status update
@WebServlet("/admin/orders")
public class ManageOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final OrderDAO orderDAO = new OrderDAO();

    // Shows all orders in admin manage orders page
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("activePage", "orders");
        request.setAttribute("orders", orderDAO.getAllOrders());

        request.getRequestDispatcher("/pages/admin/manage-orders.jsp").forward(request, response);
    }

    // Updates order status from admin page
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String status = request.getParameter("status");

            if (status != null && !status.trim().isEmpty()) {
                orderDAO.updateOrderStatus(orderId, status.trim());
            }

            response.sendRedirect(request.getContextPath() + "/admin/orders");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/orders?error=update");
        }
    }
}