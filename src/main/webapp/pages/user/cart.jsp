<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart - Mero Mart</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@600;700&family=Manrope:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="<c:url value='/assets/css/user.css'/>">

    <style>
        .cart-page-head {
            margin-bottom: 34px;
        }

        .cart-shell {
            display: grid;
            grid-template-columns: minmax(0, 1.8fr) minmax(320px, 0.8fr);
            gap: 28px;
            align-items: start;
        }

        .cart-panel {
            background: rgba(255, 255, 255, 0.82);
            border: 1px solid rgba(12, 81, 63, 0.12);
            border-radius: 28px;
            padding: 28px;
            box-shadow: 0 22px 60px rgba(12, 81, 63, 0.08);
        }

        .cart-item-card {
            display: grid;
            grid-template-columns: 110px minmax(0, 1fr) 90px 110px 48px;
            gap: 18px;
            align-items: center;
            padding: 18px 0;
            border-bottom: 1px solid rgba(12, 81, 63, 0.10);
        }

        .cart-item-card:first-child {
            padding-top: 0;
        }

        .cart-item-card:last-child {
            border-bottom: none;
            padding-bottom: 0;
        }

        .cart-item-img-wrap {
            width: 110px;
            height: 96px;
            border-radius: 20px;
            overflow: hidden;
            background: #f4efe6;
            border: 1px solid rgba(12, 81, 63, 0.10);
        }

        .cart-item-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
        }

        .cart-item-info h3 {
            margin: 0 0 8px;
            font-size: 19px;
            color: #102033;
        }

        .cart-item-price {
            color: #637083;
            font-weight: 700;
            font-size: 14px;
        }

        .cart-item-qty input {
            width: 76px;
            border: 1px solid rgba(12, 81, 63, 0.18);
            border-radius: 14px;
            padding: 12px;
            font-weight: 800;
            text-align: center;
            background: #ffffff;
        }

        .cart-item-subtotal {
            font-weight: 900;
            color: #087557;
            text-align: right;
        }

        .cart-remove-btn {
            width: 42px;
            height: 42px;
            border: 1px solid rgba(176, 0, 32, 0.16);
            color: #b00020;
            background: #fff5f5;
            border-radius: 14px;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .cart-remove-btn:hover {
            background: #fdecec;
        }

        .cart-summary {
            position: sticky;
            top: 24px;
        }

        .cart-summary h2 {
            margin-top: 0;
            font-family: "Cormorant Garamond", serif;
            font-size: 34px;
            color: #102033;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            gap: 16px;
            padding: 15px 0;
            border-bottom: 1px solid rgba(12, 81, 63, 0.10);
            color: #637083;
            font-weight: 800;
        }

        .summary-row strong {
            color: #102033;
        }

        .summary-total {
            border-bottom: none;
            font-size: 20px;
            color: #102033;
        }

        .cart-actions {
            display: grid;
            gap: 12px;
            margin-top: 22px;
        }

        .cart-empty {
            text-align: center;
            padding: 60px 28px;
        }

        .cart-empty-icon {
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

        .cart-empty h2 {
            font-family: "Cormorant Garamond", serif;
            font-size: 40px;
            color: #102033;
            margin: 0 0 10px;
        }

        .cart-empty p {
            color: #637083;
            margin-bottom: 24px;
        }

        @media (max-width: 980px) {
            .cart-shell {
                grid-template-columns: 1fr;
            }

            .cart-summary {
                position: static;
            }

            .cart-item-card {
                grid-template-columns: 90px 1fr;
            }

            .cart-item-qty,
            .cart-item-subtotal,
            .cart-item-card form:last-child {
                grid-column: 2;
            }

            .cart-item-subtotal {
                text-align: left;
            }
        }
    </style>
</head>

<body class="user-body">

    <jsp:include page="../common/navbar.jsp" />

    <main class="u-page">
        <div class="u-container">

            <section class="cart-page-head">
                <span class="catalog-eyebrow">Shopping Cart</span>
                <h1>Review your grocery basket before checkout.</h1>
                <p class="u-subtitle">
                    Check selected products, update quantities, remove unwanted items, and continue to checkout.
                </p>
            </section>

            <c:choose>
                <c:when test="${not empty cartItems}">
                    <section class="cart-shell">
                        <div class="cart-panel">
                            <c:forEach var="item" items="${cartItems}">
                                <div class="cart-item-card">

                                    <div class="cart-item-img-wrap">
                                        <c:choose>
                                            <c:when test="${not empty item.productImage}">
                                                <img src="<c:url value='/${item.productImage}'/>"
                                                     alt="${item.productName}"
                                                     class="cart-item-img">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="cart-item-img"
                                                     style="display:flex;align-items:center;justify-content:center;color:#637083;font-weight:800;">
                                                    No Image
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <div class="cart-item-info">
                                        <h3><c:out value="${item.productName}" /></h3>
                                        <div class="cart-item-price">
                                            Rs. <c:out value="${item.productPrice}" />
                                            /
                                            <c:out value="${item.productUnit}" />
                                        </div>
                                    </div>

                                    <form action="<c:url value='/cart'/>" method="post" class="cart-item-qty">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="cartItemId" value="${item.cartItemId}">
                                        <input type="number"
                                               name="quantity"
                                               value="${item.quantity}"
                                               min="1"
                                               max="${item.stockQuantity}"
                                               onchange="this.form.submit()">
                                    </form>

                                    <div class="cart-item-subtotal">
                                        Rs. <c:out value="${item.subtotal}" />
                                    </div>

                                    <form action="<c:url value='/cart'/>" method="post">
                                        <input type="hidden" name="action" value="remove">
                                        <input type="hidden" name="cartItemId" value="${item.cartItemId}">

                                        <button type="submit" class="cart-remove-btn" title="Remove item">
                                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none"
                                                 stroke="currentColor" stroke-width="2"
                                                 stroke-linecap="round" stroke-linejoin="round">
                                                <polyline points="3 6 5 6 21 6"></polyline>
                                                <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6"></path>
                                                <path d="M8 6V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                                            </svg>
                                        </button>
                                    </form>

                                </div>
                            </c:forEach>
                        </div>

                        <aside class="cart-panel cart-summary">
                            <h2>Order Summary</h2>

                            <c:set var="total" value="0" />
                            <c:forEach var="item" items="${cartItems}">
                                <c:set var="total" value="${total + item.subtotal}" />
                            </c:forEach>

                            <div class="summary-row">
                                <span>Subtotal</span>
                                <strong>Rs. ${total}</strong>
                            </div>

                            <div class="summary-row">
                                <span>Delivery</span>
                                <strong style="color:#087557;">Free</strong>
                            </div>

                            <div class="summary-row summary-total">
                                <span>Total</span>
                                <strong>Rs. ${total}</strong>
                            </div>

                            <div class="cart-actions">
                                <a class="u-btn u-btn--primary" href="<c:url value='/checkout'/>">
                                    Proceed to Checkout
                                </a>

                                <a class="u-btn" href="<c:url value='/product'/>">
                                    Continue Shopping
                                </a>
                            </div>
                        </aside>
                    </section>
                </c:when>

                <c:otherwise>
                    <section class="cart-panel cart-empty">
                        <div class="cart-empty-icon">
                            <svg width="38" height="38" viewBox="0 0 24 24" fill="none"
                                 stroke="currentColor" stroke-width="1.8"
                                 stroke-linecap="round" stroke-linejoin="round">
                                <circle cx="9" cy="21" r="1"></circle>
                                <circle cx="20" cy="21" r="1"></circle>
                                <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
                            </svg>
                        </div>

                        <h2>Your cart is empty</h2>

                        <p>
                            Start by browsing the grocery collection and add items to your cart.
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
