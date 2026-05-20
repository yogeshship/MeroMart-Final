package com.meromart.controller.admin;

import com.meromart.dao.OrderDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

// Handles admin order listing and order status update
@WebServlet({"/admin/orders", "/manageorder"})
public class ManageOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final OrderDAO orderDAO = new OrderDAO();

    // Shows all customer orders in the admin Manage Orders page
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("activePage", "orders");
        request.setAttribute("orders", orderDAO.getAllOrders());

        request.getRequestDispatcher("/WEB-INF/pages/admin/manage-orders.jsp").forward(request, response);
    }

    // Updates order status from the admin side
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String orderIdValue = request.getParameter("orderId");
            String status = request.getParameter("status");

            if (orderIdValue == null || orderIdValue.isBlank()
                    || status == null || status.isBlank()) {

                response.sendRedirect(request.getContextPath() + "/manageorder?error=update");
                return;
            }

            int orderId = Integer.parseInt(orderIdValue);
            boolean updated = orderDAO.updateOrderStatus(orderId, status.trim());

            if (updated) {
                response.sendRedirect(request.getContextPath() + "/manageorder?msg=updated");
            } else {
                response.sendRedirect(request.getContextPath() + "/manageorder?error=update");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/manageorder?error=update");
        }
    }
}