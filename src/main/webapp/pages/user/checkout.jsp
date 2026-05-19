<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - Mero Mart</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@600;700&family=Manrope:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="<c:url value='/assets/css/user.css'/>">

    <style>
        .checkout-shell {
            display: grid;
            grid-template-columns: minmax(0, 1.4fr) minmax(320px, 0.8fr);
            gap: 28px;
            align-items: start;
        }

        .checkout-panel {
            background: rgba(255, 255, 255, 0.84);
            border: 1px solid rgba(12, 81, 63, 0.12);
            border-radius: 28px;
            padding: 30px;
            box-shadow: 0 22px 60px rgba(12, 81, 63, 0.08);
        }

        .checkout-panel h2 {
            font-family: "Cormorant Garamond", serif;
            font-size: 34px;
            margin-top: 0;
            color: #102033;
        }

        .checkout-field {
            margin-bottom: 18px;
        }

        .checkout-field label {
            display: block;
            font-weight: 800;
            color: #102033;
            margin-bottom: 8px;
        }

        .checkout-field input,
        .checkout-field textarea,
        .checkout-field select {
            width: 100%;
            border: 1px solid rgba(12, 81, 63, 0.18);
            border-radius: 16px;
            padding: 14px 16px;
            font-family: "Manrope", sans-serif;
            font-weight: 700;
            background: #ffffff;
            color: #102033;
        }

        .checkout-field textarea {
            min-height: 110px;
            resize: vertical;
        }

        .checkout-list {
            display: grid;
            gap: 14px;
            margin-bottom: 22px;
        }

        .checkout-item {
            display: flex;
            justify-content: space-between;
            gap: 14px;
            padding-bottom: 14px;
            border-bottom: 1px solid rgba(12, 81, 63, 0.10);
            color: #637083;
            font-weight: 800;
        }

        .checkout-total {
            display: flex;
            justify-content: space-between;
            font-size: 22px;
            font-weight: 900;
            color: #102033;
            margin-top: 18px;
        }

        .checkout-actions {
            display: grid;
            gap: 12px;
            margin-top: 24px;
        }

        @media (max-width: 980px) {
            .checkout-shell {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>

<body class="user-body">

    <jsp:include page="../common/navbar.jsp" />

    <main class="u-page">
        <div class="u-container">

            <section style="margin-bottom:34px;">
                <span class="catalog-eyebrow">Checkout</span>
                <h1>Confirm your delivery details.</h1>
                <p class="u-subtitle">
                    Review your cart and enter delivery information before placing the order.
                </p>
            </section>

            <c:choose>
                <c:when test="${empty cartItems}">
                    <section class="checkout-panel" style="text-align:center;">
                        <h2>Your cart is empty</h2>
                        <p class="u-subtitle">Please add products to your cart before checkout.</p>
                        <a class="u-btn u-btn--primary" href="<c:url value='/product'/>">Browse Products</a>
                    </section>
                </c:when>

                <c:otherwise>
                    <section class="checkout-shell">

                        <form class="checkout-panel" action="<c:url value='/checkout'/>" method="post">
                            <h2>Delivery Information</h2>

                            <div class="checkout-field">
                                <label>Full Name</label>
                                <input type="text" name="fullName" placeholder="Enter your full name" required>
                            </div>

                            <div class="checkout-field">
                                <label>Phone Number</label>
                                <input type="text" name="phone" placeholder="Enter phone number" required>
                            </div>

                            <div class="checkout-field">
                                <label>Delivery Address</label>
                                <textarea name="address" placeholder="Enter delivery address" required></textarea>
                            </div>

                            <div class="checkout-field">
                                <label>Payment Method</label>
                                <select name="paymentMethod" required>
                                    <option value="Cash on Delivery">Cash on Delivery</option>
                                    <option value="Online Payment">Online Payment</option>
                                </select>
                            </div>

                            <button class="u-btn u-btn--primary" type="submit">
                                Place Order
                            </button>
                        </form>

                        <aside class="checkout-panel">
                            <h2>Order Review</h2>

                            <div class="checkout-list">
                                <c:forEach var="item" items="${cartItems}">
                                    <div class="checkout-item">
                                        <span>
                                            <c:out value="${item.productName}" />
                                            ×
                                            <c:out value="${item.quantity}" />
                                        </span>
                                        <strong>Rs. <c:out value="${item.subtotal}" /></strong>
                                    </div>
                                </c:forEach>
                            </div>

                            <div class="checkout-item">
                                <span>Delivery</span>
                                <strong style="color:#087557;">Free</strong>
                            </div>

                            <div class="checkout-total">
                                <span>Total</span>
                                <span>Rs. ${total}</span>
                            </div>

                            <div class="checkout-actions">
                                <a class="u-btn" href="<c:url value='/cart'/>">Back to Cart</a>
                                <a class="u-btn" href="<c:url value='/product'/>">Continue Shopping</a>
                            </div>
                        </aside>

                    </section>
                </c:otherwise>
            </c:choose>

        </div>
    </main>

    <jsp:include page="../common/footer.jsp" />

</body>
</html>