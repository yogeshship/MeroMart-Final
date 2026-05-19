package com.meromart.model;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * CartModel — maps to the 'cart' table in mero_mart_db.
 */
public class CartModel implements Serializable {
    private static final long serialVersionUID = 1L;

    private int cartId;
    private int userId;
    private Timestamp createdAt;

    public CartModel() {}

    public int getCartId()                          { return cartId; }
    public void setCartId(int cartId)                { this.cartId = cartId; }

    public int getUserId()                           { return userId; }
    public void setUserId(int userId)                { this.userId = userId; }

    public Timestamp getCreatedAt()                  { return createdAt; }
    public void setCreatedAt(Timestamp createdAt)    { this.createdAt = createdAt; }
}
