package com.meromart.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

/**
 * OrderModel — maps to the 'orders' table in mero_mart_db.
 */
public class OrderModel implements Serializable {
    private static final long serialVersionUID = 1L;

    private int orderId;
    private int userId;
    private BigDecimal totalAmount;
    private String orderStatus;
    private String deliveryAddress;
    private Timestamp orderDate;

    // Transient display fields
    private String customerName;
    private String customerEmail;
    private List<OrderItemModel> orderItems;

    public OrderModel() {}

    public int getOrderId()                               { return orderId; }
    public void setOrderId(int orderId)                    { this.orderId = orderId; }

    public int getUserId()                                { return userId; }
    public void setUserId(int userId)                     { this.userId = userId; }

    public BigDecimal getTotalAmount()                     { return totalAmount; }
    public void setTotalAmount(BigDecimal totalAmount)     { this.totalAmount = totalAmount; }

    public String getOrderStatus()                        { return orderStatus; }
    public void setOrderStatus(String orderStatus)        { this.orderStatus = orderStatus; }

    public String getDeliveryAddress()                     { return deliveryAddress; }
    public void setDeliveryAddress(String deliveryAddress) { this.deliveryAddress = deliveryAddress; }

    public Timestamp getOrderDate()                        { return orderDate; }
    public void setOrderDate(Timestamp orderDate)          { this.orderDate = orderDate; }

    public String getCustomerName()                        { return customerName; }
    public void setCustomerName(String customerName)       { this.customerName = customerName; }

    public String getCustomerEmail()                       { return customerEmail; }
    public void setCustomerEmail(String customerEmail)     { this.customerEmail = customerEmail; }

    public List<OrderItemModel> getOrderItems()            { return orderItems; }
    public void setOrderItems(List<OrderItemModel> items)  { this.orderItems = items; }
}
