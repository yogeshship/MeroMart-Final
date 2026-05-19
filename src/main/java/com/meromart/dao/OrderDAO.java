package com.meromart.dao;

import com.meromart.model.OrderItemModel;
import com.meromart.model.OrderModel;
import com.meromart.util.DBConfig;

import java.sql.*;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

/**
 * OrderDAO — Data Access Object for 'orders' and 'order_items' tables.
 */
public class OrderDAO {

    public int placeOrder(OrderModel order, List<OrderItemModel> items) {
        Connection conn = null;
        try {
            conn = DBConfig.getConnection();
            conn.setAutoCommit(false);

            String orderSql = "INSERT INTO orders (user_id, total_amount, order_status, delivery_address) VALUES (?, ?, 'pending', ?)";
            int orderId;
            try (PreparedStatement stmt = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS)) {
                stmt.setInt(1, order.getUserId());
                stmt.setBigDecimal(2, order.getTotalAmount());
                stmt.setString(3, order.getDeliveryAddress());
                stmt.executeUpdate();
                try (ResultSet keys = stmt.getGeneratedKeys()) {
                    if (keys.next()) orderId = keys.getInt(1);
                    else { conn.rollback(); return -1; }
                }
            }

            String itemSql = "INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(itemSql)) {
                for (OrderItemModel item : items) {
                    stmt.setInt(1, orderId);
                    stmt.setInt(2, item.getProductId());
                    stmt.setInt(3, item.getQuantity());
                    stmt.setBigDecimal(4, item.getPrice());
                    stmt.addBatch();
                }
                stmt.executeBatch();
            }

            String stockSql = "UPDATE products SET stock_quantity = stock_quantity - ? WHERE product_Id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(stockSql)) {
                for (OrderItemModel item : items) {
                    stmt.setInt(1, item.getQuantity());
                    stmt.setInt(2, item.getProductId());
                    stmt.addBatch();
                }
                stmt.executeBatch();
            }

            conn.commit();
            return orderId;
        } catch (SQLException e) {
            e.printStackTrace();
            if (conn != null) { try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); } }
            return -1;
        } finally {
            if (conn != null) { try { conn.setAutoCommit(true); conn.close(); } catch (SQLException ex) { ex.printStackTrace(); } }
        }
    }

    public List<OrderModel> getOrdersByUser(int userId) {
        List<OrderModel> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY order_date DESC";
        try (Connection conn = DBConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) { while (rs.next()) orders.add(mapOrderRow(rs)); }
        } catch (SQLException e) { e.printStackTrace(); }
        return orders;
    }

    public List<OrderModel> getAllOrders() {
        List<OrderModel> orders = new ArrayList<>();
        String sql = "SELECT o.*, u.full_name AS customer_name, u.email AS customer_email FROM orders o JOIN users u ON o.user_id = u.user_id ORDER BY o.order_date DESC";
        try (Connection conn = DBConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                OrderModel order = mapOrderRow(rs);
                order.setCustomerName(rs.getString("customer_name"));
                order.setCustomerEmail(rs.getString("customer_email"));
                orders.add(order);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return orders;
    }

    public OrderModel getOrderById(int orderId) {
        String sql = "SELECT o.*, u.full_name AS customer_name, u.email AS customer_email FROM orders o JOIN users u ON o.user_id = u.user_id WHERE o.order_id = ?";
        try (Connection conn = DBConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    OrderModel order = mapOrderRow(rs);
                    order.setCustomerName(rs.getString("customer_name"));
                    order.setCustomerEmail(rs.getString("customer_email"));
                    return order;
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public List<OrderItemModel> getOrderItems(int orderId) {
        List<OrderItemModel> items = new ArrayList<>();
        String sql = "SELECT oi.*, p.product_name, p.image_path FROM order_items oi JOIN products p ON oi.product_id = p.product_Id WHERE oi.order_id = ?";
        try (Connection conn = DBConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    OrderItemModel item = new OrderItemModel();
                    item.setOrderItemId(rs.getInt("order_item_id"));
                    item.setOrderId(rs.getInt("order_id"));
                    item.setProductId(rs.getInt("product_id"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setPrice(rs.getBigDecimal("price"));
                    item.setProductName(rs.getString("product_name"));
                    item.setProductImage(rs.getString("image_path"));
                    items.add(item);
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return items;
    }

    public boolean updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE orders SET order_status = ? WHERE order_id = ?";
        try (Connection conn = DBConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status); stmt.setInt(2, orderId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public int getTotalOrders() {
        String sql = "SELECT COUNT(*) FROM orders";
        try (Connection conn = DBConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    public BigDecimal getTotalRevenue() {
        String sql = "SELECT COALESCE(SUM(total_amount), 0) FROM orders WHERE order_status != 'cancelled'";
        try (Connection conn = DBConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) return rs.getBigDecimal(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return BigDecimal.ZERO;
    }

    private OrderModel mapOrderRow(ResultSet rs) throws SQLException {
        OrderModel order = new OrderModel();
        order.setOrderId(rs.getInt("order_id"));
        order.setUserId(rs.getInt("user_id"));
        order.setTotalAmount(rs.getBigDecimal("total_amount"));
        order.setOrderStatus(rs.getString("order_status"));
        order.setDeliveryAddress(rs.getString("delivery_address"));
        order.setOrderDate(rs.getTimestamp("order_date"));
        return order;
    }
}
