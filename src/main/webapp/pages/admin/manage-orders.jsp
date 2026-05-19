<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Orders</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value='/assets/css/admin.css?v=20260501-2'/>">
</head>
<body class="admin-body">
    <div class="admin-shell">
        <jsp:include page="admin-sidebar.jsp" />
        <main class="admin-main admin-main--airy">
            <section class="page-toolbar">
                <div class="page-copy">
                    <span class="eyebrow">Fulfillment</span>
                    <h1>Manage Orders</h1>
                    <p>Track and fulfill customer orders.</p>
                </div>
            </section>

            <c:if test="${param.msg == 'updated'}">
                <div style="color: #00674F; margin-bottom: 15px; padding: 10px; background: #E6F0ED; border-radius: 6px;">
                    Order status updated successfully.
                </div>
            </c:if>
            <c:if test="${param.error == 'update'}">
                <div style="color: #b91c1c; margin-bottom: 15px; padding: 10px; background: #fee2e2; border-radius: 6px;">
                    Unable to update that order right now.
                </div>
            </c:if>

            <section class="search-strip">
                <form class="search-form" action="<c:url value='/manageorder'/>" method="get">
                    <input type="search" name="q" value="${searchQuery}" placeholder="Search orders by ID, customer, or status...">
                    <button type="submit" aria-label="Search"></button>
                </form>
            </section>

            <section class="panel">
                <div class="stats-grid stats-grid--compact">
                    <c:forEach var="stat" items="${orderStats}">
                        <article class="stat-card stat-card--compact">
                            <div class="stat-icon icon-${stat.icon}"></div>
                            <div class="stat-copy">
                                <span class="stat-title">${stat.title}</span>
                                <strong class="stat-value">${stat.value}</strong>
                                <p class="stat-description">${stat.description}</p>
                                <span class="stat-trend ${stat.trendType eq 'positive' ? 'positive' : 'warning'}">${stat.trend}</span>
                            </div>
                        </article>
                    </c:forEach>
                </div>

                <div class="table-wrap">
                    <table class="admin-table">
                        <thead>
                            <tr>
                                <th>Order ID</th>
                                <th>Customer</th>
                                <th>Items</th>
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
                                    <td>ORD-${order.id}</td>
                                    <td>${order.customerName}</td>
                                    <td>${order.displayItems}</td>
                                    <td>${order.displayTotal}</td>
                                    <td><span class="status-pill ${order.statusClass}">${order.status}</span></td>
                                    <td>${order.orderDate}</td>
                                    <td>${order.deliveryAddress}</td>
                                    <td>
                                        <form class="action-group" action="<c:url value='/manageorder'/>" method="post" style="align-items: center;">
                                            <input type="hidden" name="id" value="${order.id}">
                                            <select name="status" style="min-width: 120px;">
                                                <option value="pending" ${order.status == 'pending' ? 'selected' : ''}>Pending</option>
                                                <option value="confirmed" ${order.status == 'confirmed' ? 'selected' : ''}>Confirmed</option>
                                                <option value="delivered" ${order.status == 'delivered' ? 'selected' : ''}>Delivered</option>
                                                <option value="cancelled" ${order.status == 'cancelled' ? 'selected' : ''}>Cancelled</option>
                                            </select>
                                            <button class="table-button" type="submit">Save</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
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

                <div class="table-footer">
                    <span>Showing ${orderCount} orders</span>
                    <div class="pagination">
                        <button class="is-current" type="button">1</button>
                    </div>
                </div>
            </section>
        </main>
    </div>
</body>
</html>
