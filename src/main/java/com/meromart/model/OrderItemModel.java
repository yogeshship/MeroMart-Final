package com.meromart.model;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * OrderItemModel — maps to the 'order_items' table in mero_mart_db.
 */
public class OrderItemModel implements Serializable {
    private static final long serialVersionUID = 1L;

    private int orderItemId;
    private int orderId;
    private int productId;
    private int quantity;
    private BigDecimal price;

    // Transient display fields (joined from products table)
    private String productName;
    private String productImage;

    public OrderItemModel() {}

    public int getOrderItemId()                          { return orderItemId; }
    public void setOrderItemId(int orderItemId)           { this.orderItemId = orderItemId; }

    public int getOrderId()                              { return orderId; }
    public void setOrderId(int orderId)                   { this.orderId = orderId; }

    public int getProductId()                            { return productId; }
    public void setProductId(int productId)               { this.productId = productId; }

    public int getQuantity()                             { return quantity; }
    public void setQuantity(int quantity)                 { this.quantity = quantity; }

    public BigDecimal getPrice()                          { return price; }
    public void setPrice(BigDecimal price)                { this.price = price; }

    public String getProductName()                       { return productName; }
    public void setProductName(String productName)       { this.productName = productName; }

    public String getProductImage()                      { return productImage; }
    public void setProductImage(String productImage)     { this.productImage = productImage; }

    /** Calculated subtotal: price × quantity */
    public BigDecimal getSubtotal() {
        if (price == null) return BigDecimal.ZERO;
        return price.multiply(BigDecimal.valueOf(quantity));
    }
}
