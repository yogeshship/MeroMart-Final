<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order History - Mero Mart</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@600;700&family=Manrope:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="<c:url value='/assets/css/user.css'/>">

    <style>
        .orders-page-head {
            margin-bottom: 34px;
        }

        .orders-panel {
            background: rgba(255, 255, 255, 0.84);
            border: 1px solid rgba(12, 81, 63, 0.12);
            border-radius: 28px;
            padding: 30px;
            box-shadow: 0 22px 60px rgba(12, 81, 63, 0.08);
        }

        .orders-list {
            display: grid;
            gap: 18px;
        }

        .order-card {
            border: 1px solid rgba(12, 81, 63, 0.12);
            background: #ffffff;
            border-radius: 22px;
            padding: 22px;
        }

        .order-header {
            display: flex;
            justify-content: space-between;
            gap: 18px;
            align-items: flex-start;
            padding-bottom: 16px;
            border-bottom: 1px solid rgba(12, 81, 63, 0.10);
            margin-bottom: 16px;
        }

        .order-id {
            display: block;
            font-weight: 900;
            color: #102033;
            font-size: 18px;
        }

        .order-date {
            display: block;
            color: #637083;
            font-size: 14px;
            font-weight: 700;
            margin-top: 4px;
        }

        .order-status {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 9px 14px;
            border-radius: 999px;
            background: #e6f2ee;
            color: #087557;
            font-size: 12px;
            font-weight: 900;
            letter-spacing: 0.08em;
            text-transform: uppercase;
        }

        .order-body {
            display: grid;
            grid-template-columns: minmax(0, 1fr) auto;
            gap: 18px;
            align-items: center;
        }

        .order-body p {
            margin: 0;
            color: #637083;
            font-weight: 700;
            line-height: 1.6;
        }

        .order-total {
            font-size: 22px;
            font-weight: 900;
            color: #087557;
            white-space: nowrap;
        }

        .orders-empty {
            text-align: center;
            padding: 62px 28px;
        }

        .orders-empty-icon {
            width: 78px;
            height: 78px;
            margin: 0 auto 22px;
            border-radius: 26px;
            background: #e6f2ee;
            color: #087557;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .orders-empty h2 {
            font-family: "Cormorant Garamond", serif;
            font-size: 42px;
            color: #102033;
            margin: 0 0 10px;
        }

        .orders-empty p {
            color: #637083;
            margin-bottom: 24px;
            font-weight: 700;
        }

        .order-alert {
            background: #e6f2ee;
            color: #087557;
            border: 1px solid rgba(8, 117, 87, 0.18);
            border-radius: 18px;
            padding: 15px 18px;
            font-weight: 800;
            margin-bottom: 22px;
        }

        @media (max-width: 760px) {
            .order-header,
            .order-body {
                grid-template-columns: 1fr;
                display: grid;
            }

            .order-total {
                white-space: normal;
            }
        }
    </style>
</head>

<body class="user-body">

    <jsp:include page="../common/navbar.jsp" />

    <main class="u-page">
        <div class="u-container">

            <section class="orders-page-head">
                <span class="catalog-eyebrow">Order History</span>
                <h1>Track your previous grocery orders.</h1>
                <p class="u-subtitle">
                    View your placed orders, delivery address, order status, and total order amount.
                </p>
            </section>

            <c:if test="${not empty successMessage}">
                <div class="order-alert">
                    <c:out value="${successMessage}" />
                </div>
            </c:if>

            <c:choose>
                <c:when test="${not empty orders}">
                    <section class="orders-panel">
                        <div class="orders-list">
                            <c:forEach var="order" items="${orders}">
                                <article class="order-card">
                                    <div class="order-header">
                                        <div>
                                            <span class="order-id">Order #${order.orderId}</span>
                                            <span class="order-date">
                                                <fmt:formatDate value="${order.orderDate}" pattern="MMM dd, yyyy" />
                                            </span>
                                        </div>

                                        <span class="order-status">
                                            <c:out value="${order.orderStatus}" />
                                        </span>
                                    </div>

                                    <div class="order-body">
                                        <p>
                                            <strong>Delivery Address:</strong><br>
                                            <c:out value="${order.deliveryAddress}" />
                                        </p>

                                        <div class="order-total">
                                            Rs. <c:out value="${order.totalAmount}" />
                                        </div>
                                    </div>
                                </article>
                            </c:forEach>
                        </div>
                    </section>
                </c:when>

                <c:otherwise>
                    <section class="orders-panel orders-empty">
                        <div class="orders-empty-icon">
                            <svg width="38" height="38" viewBox="0 0 24 24" fill="none"
                                 stroke="currentColor" stroke-width="1.8"
                                 stroke-linecap="round" stroke-linejoin="round">
                                <path d="M6 2h9l5 5v15H6z"></path>
                                <path d="M14 2v6h6"></path>
                                <path d="M9 13h7"></path>
                                <path d="M9 17h5"></path>
                            </svg>
                        </div>

                        <h2>No orders yet</h2>

                        <p>
                            You have not placed any saved orders yet. Start shopping and complete checkout.
                        </p>

                        <a class="u-btn u-btn--primary" href="<c:url value='/product'/>">
                            Browse Products
                        </a>
                    </section>
                </c:otherwise>
            </c:choose>

        </div>
    </main>

    <jsp:include page="../common/footer.jsp" />

</body>
</html>