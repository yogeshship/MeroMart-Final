package com.meromart.dao;

import com.meromart.model.CartItemModel;
import com.meromart.util.DBConfig;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * CartDAO — Data Access Object for the 'cart' and 'cart_items' tables.
 */
public class CartDAO {

    /**
     * Returns the cart_id for the given user.
     * If no cart exists, creates one and returns the new cart_id.
     */
    public int getOrCreateCart(int userId) {
        String selectSql = "SELECT cart_id FROM cart WHERE user_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(selectSql)) {

            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) return rs.getInt("cart_id");
            }

            // No cart exists — create one
            String insertSql = "INSERT INTO cart (user_id) VALUES (?)";
            try (PreparedStatement insert = conn.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS)) {
                insert.setInt(1, userId);
                insert.executeUpdate();
                try (ResultSet keys = insert.getGeneratedKeys()) {
                    if (keys.next()) return keys.getInt(1);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    /** Adds a product to the cart or increments quantity if it already exists. */
    public boolean addToCart(int userId, int productId, int quantity) {
        int cartId = getOrCreateCart(userId);
        if (cartId == -1) return false;

        // Check if item already exists in cart
        String checkSql = "SELECT cart_item_id, quantity FROM cart_items WHERE cart_id = ? AND product_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement check = conn.prepareStatement(checkSql)) {

            check.setInt(1, cartId);
            check.setInt(2, productId);
            try (ResultSet rs = check.executeQuery()) {
                if (rs.next()) {
                    // Already in cart — update quantity
                    int newQty = rs.getInt("quantity") + quantity;
                    String updateSql = "UPDATE cart_items SET quantity = ? WHERE cart_item_id = ?";
                    try (PreparedStatement update = conn.prepareStatement(updateSql)) {
                        update.setInt(1, newQty);
                        update.setInt(2, rs.getInt("cart_item_id"));
                        return update.executeUpdate() > 0;
                    }
                }
            }

            // Not in cart — insert new row
            String insertSql = "INSERT INTO cart_items (cart_id, product_id, quantity) VALUES (?, ?, ?)";
            try (PreparedStatement insert = conn.prepareStatement(insertSql)) {
                insert.setInt(1, cartId);
                insert.setInt(2, productId);
                insert.setInt(3, quantity);
                return insert.executeUpdate() > 0;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /** Returns all items in the user's cart (joined with product details). */
    public List<CartItemModel> getCartItems(int userId) {
        List<CartItemModel> items = new ArrayList<>();
        String sql = "SELECT ci.*, p.product_name, p.price, p.image_path, p.unit, p.stock_quantity "
                   + "FROM cart_items ci "
                   + "JOIN cart c ON ci.cart_id = c.cart_id "
                   + "JOIN products p ON ci.product_id = p.product_Id "
                   + "WHERE c.user_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    CartItemModel item = new CartItemModel();
                    item.setCartItemId(rs.getInt("cart_item_id"));
                    item.setCartId(rs.getInt("cart_id"));
                    item.setProductId(rs.getInt("product_id"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setProductName(rs.getString("product_name"));
                    item.setProductPrice(rs.getBigDecimal("price"));
                    item.setProductImage(rs.getString("image_path"));
                    item.setProductUnit(rs.getString("unit"));
                    item.setStockQuantity(rs.getInt("stock_quantity"));
                    items.add(item);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }

    /** Updates the quantity of a specific cart item. */
    public boolean updateCartItemQuantity(int cartItemId, int quantity) {
        String sql = "UPDATE cart_items SET quantity = ? WHERE cart_item_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, quantity);
            stmt.setInt(2, cartItemId);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /** Removes a single item from the cart. */
    public boolean removeCartItem(int cartItemId) {
        String sql = "DELETE FROM cart_items WHERE cart_item_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, cartItemId);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /** Clears all items from a user's cart. */
    public boolean clearCart(int userId) {
        int cartId = getOrCreateCart(userId);
        if (cartId == -1) return false;

        String sql = "DELETE FROM cart_items WHERE cart_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, cartId);
            stmt.executeUpdate();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /** Returns the number of items in a user's cart. */
    public int getCartItemCount(int userId) {
        String sql = "SELECT COUNT(*) FROM cart_items ci "
                   + "JOIN cart c ON ci.cart_id = c.cart_id "
                   + "WHERE c.user_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
