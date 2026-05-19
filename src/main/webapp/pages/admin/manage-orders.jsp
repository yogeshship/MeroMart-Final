<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Orders - Mero Mart</title>

    <!-- Google font for admin pages -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">

    <!-- Admin stylesheet -->
    <link rel="stylesheet" href="<c:url value='/assets/css/admin.css?v=20260501-2'/>">
</head>

<body class="admin-body">

    <div class="admin-shell">

        <!-- Admin sidebar -->
        <jsp:include page="admin-sidebar.jsp" />

        <main class="admin-main admin-main--airy">

            <!-- Page heading -->
            <section class="page-toolbar">
                <div class="page-copy">
                    <span class="eyebrow">Fulfillment</span>
                    <h1>Manage Orders</h1>
                    <p>Track customer orders and update their fulfillment status.</p>
                </div>
            </section>

            <!-- Success message -->
            <c:if test="${param.msg == 'updated'}">
                <div style="color: #00674F; margin-bottom: 15px; padding: 10px; background: #E6F0ED; border-radius: 6px; font-weight: 600;">
                    Order status updated successfully.
                </div>
            </c:if>

            <!-- Error message -->
            <c:if test="${param.error == 'update'}">
                <div style="color: #b91c1c; margin-bottom: 15px; padding: 10px; background: #fee2e2; border-radius: 6px; font-weight: 600;">
                    Unable to update that order right now.
                </div>
            </c:if>

            <!-- Search bar -->
            <section class="search-strip">
                <form class="search-form" action="<c:url value='/manageorder'/>" method="get">
                    <input type="search"
                           name="q"
                           value="${searchQuery}"
                           placeholder="Search orders by customer or status...">
                    <button type="submit" aria-label="Search"></button>
                </form>
            </section>

            <!-- Orders table -->
            <section class="panel">

                <div class="table-wrap">
                    <table class="admin-table">
                        <thead>
                            <tr>
                                <th>Order ID</th>
                                <th>Customer</th>
                                <th>Email</th>
                                <th>Total</th>
                                <th>Status</th>
                                <th>Date</th>
                                <th>Delivery Address</th>
                                <th>Action</th>
                            </tr>
                        </thead>

                        <tbody>
                            <c:forEach var="order" items="${orders}">
                                <tr>
                                    <!-- Order ID -->
                                    <td>
                                        ORD-${order.orderId}
                                    </td>

                                    <!-- Customer name -->
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty order.customerName}">
                                                <c:out value="${order.customerName}" />
                                            </c:when>
                                            <c:otherwise>
                                                Customer
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <!-- Customer email -->
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty order.customerEmail}">
                                                <c:out value="${order.customerEmail}" />
                                            </c:when>
                                            <c:otherwise>
                                                Not available
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <!-- Total amount -->
                                    <td>
                                        Rs. <c:out value="${order.totalAmount}" />
                                    </td>

                                    <!-- Order status -->
                                    <td>
                                        <span class="status-pill">
                                            <c:choose>
                                                <c:when test="${not empty order.orderStatus}">
                                                    <c:out value="${order.orderStatus}" />
                                                </c:when>
                                                <c:otherwise>
                                                    pending
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                    </td>

                                    <!-- Order date -->
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty order.orderDate}">
                                                <fmt:formatDate value="${order.orderDate}" pattern="MMM dd, yyyy" />
                                            </c:when>
                                            <c:otherwise>
                                                Not available
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <!-- Delivery address -->
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty order.deliveryAddress}">
                                                <c:out value="${order.deliveryAddress}" />
                                            </c:when>
                                            <c:otherwise>
                                                No address
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <!-- Status update form -->
                                    <td>
                                        <form class="action-group"
                                              action="<c:url value='/manageorder'/>"
                                              method="post"
                                              style="align-items: center;">

                                            <input type="hidden" name="orderId" value="${order.orderId}">

                                            <select name="status" style="min-width: 120px;">
                                                <option value="pending" ${order.orderStatus == 'pending' ? 'selected' : ''}>
                                                    Pending
                                                </option>

                                                <option value="confirmed" ${order.orderStatus == 'confirmed' ? 'selected' : ''}>
                                                    Confirmed
                                                </option>

                                                <option value="delivered" ${order.orderStatus == 'delivered' ? 'selected' : ''}>
                                                    Delivered
                                                </option>

                                                <option value="completed" ${order.orderStatus == 'completed' ? 'selected' : ''}>
                                                    Completed
                                                </option>

                                                <option value="cancelled" ${order.orderStatus == 'cancelled' ? 'selected' : ''}>
                                                    Cancelled
                                                </option>
                                            </select>

                                            <button class="table-button" type="submit">
                                                Save
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>

                            <!-- Empty state -->
                            <c:if test="${empty orders}">
                                <tr>
                                    <td colspan="8" style="text-align: center; color: var(--text-muted); padding: 30px 0;">
                                        No orders found yet. This page will fill automatically when customer orders are created.
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>

                <!-- Table footer -->
                <div class="table-footer">
                    <span>Customer order records</span>
                    <div class="pagination">
                        <button class="is-current" type="button">1</button>
                    </div>
                </div>

            </section>

        </main>
    </div>

</body>
</html>