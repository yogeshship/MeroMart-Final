package com.meromart.model;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * CartItemModel — maps to the 'cart_items' table in mero_mart_db.
 */
public class CartItemModel implements Serializable {
    private static final long serialVersionUID = 1L;

    private int cartItemId;
    private int cartId;
    private int productId;
    private int quantity;

    // Transient display fields (joined from products table)
    private String productName;
    private BigDecimal productPrice;
    private String productImage;
    private String productUnit;
    private int stockQuantity;

    public CartItemModel() {}

    public int getCartItemId()                           { return cartItemId; }
    public void setCartItemId(int cartItemId)             { this.cartItemId = cartItemId; }

    public int getCartId()                               { return cartId; }
    public void setCartId(int cartId)                     { this.cartId = cartId; }

    public int getProductId()                            { return productId; }
    public void setProductId(int productId)               { this.productId = productId; }

    public int getQuantity()                             { return quantity; }
    public void setQuantity(int quantity)                 { this.quantity = quantity; }

    public String getProductName()                       { return productName; }
    public void setProductName(String productName)       { this.productName = productName; }

    public BigDecimal getProductPrice()                   { return productPrice; }
    public void setProductPrice(BigDecimal productPrice)  { this.productPrice = productPrice; }

    public String getProductImage()                      { return productImage; }
    public void setProductImage(String productImage)     { this.productImage = productImage; }

    public String getProductUnit()                       { return productUnit; }
    public void setProductUnit(String productUnit)       { this.productUnit = productUnit; }

    public int getStockQuantity()                        { return stockQuantity; }
    public void setStockQuantity(int stockQuantity)      { this.stockQuantity = stockQuantity; }

    /** Calculated subtotal: price × quantity */
    public BigDecimal getSubtotal() {
        if (productPrice == null) return BigDecimal.ZERO;
        return productPrice.multiply(BigDecimal.valueOf(quantity));
    }
}
