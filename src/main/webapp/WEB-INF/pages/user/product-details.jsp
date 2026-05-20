<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:out value="${product.productName}" /> - Mero Mart</title>

    <!-- Google fonts used by public user pages -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@600;700&family=Manrope:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <!-- Main public user CSS stays outside WEB-INF -->
    <link rel="stylesheet" href="<c:url value='/assets/css/user.css'/>">
</head>

<body class="user-body">

    <!-- Common public navbar from WEB-INF -->
    <jsp:include page="/WEB-INF/pages/common/navbar.jsp" />

    <main class="u-page">
        <div class="u-container">

            <!-- Breadcrumb navigation -->
            <nav class="u-breadcrumbs" aria-label="Breadcrumb">
                <a href="<c:url value='/home'/>">Home</a>
                <span>/</span>
                <a href="<c:url value='/product'/>">Products</a>
                <span>/</span>

                <span>
                    <c:choose>
                        <c:when test="${not empty product.categoryName}">
                            <c:out value="${product.categoryName}" />
                        </c:when>
                        <c:otherwise>
                            Grocery
                        </c:otherwise>
                    </c:choose>
                </span>

                <span>/</span>

                <span>
                    <c:out value="${product.productName}" />
                </span>
            </nav>

            <!-- Product detail section -->
            <section class="pd-shell">

                <!-- Product image area -->
                <div class="pd-panel pd-gallery">
                    <div class="pd-hero">
                        <c:choose>
                            <c:when test="${not empty product.imagePath}">
                                <img src="<c:url value='/${product.imagePath}'/>" alt="${product.productName}">
                            </c:when>

                            <c:otherwise>
                                <img src="<c:url value='/assets/images/placeholder.png'/>" alt="Product image">
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="pd-gallery-note">
                        <span>Fresh Pick</span>

                        <strong>
                            Selected for a calmer product view with cleaner spacing,
                            softer framing, and quick confidence.
                        </strong>
                    </div>
                </div>

                <!-- Product information area -->
                <div class="pd-panel pd-info">
                    <span class="catalog-eyebrow">Product details</span>

                    <h1 class="pd-title">
                        <c:out value="${product.productName}" />
                    </h1>

                    <p class="pd-kicker">
                        <c:choose>
                            <c:when test="${not empty product.categoryName}">
                                <c:out value="${product.categoryName}" />
                            </c:when>
                            <c:otherwise>
                                Grocery
                            </c:otherwise>
                        </c:choose>
                        &#8226;
                        <c:out value="${product.unit}" />
                        &#8226;
                        Stock: <c:out value="${product.stockQuantity}" />
                    </p>

                    <div class="pd-row">
                        <div class="pd-price">
                            Rs. <c:out value="${product.price}" />
                        </div>

                        <div class="pd-chip">
                            <c:choose>
                                <c:when test="${product.stockQuantity > 0}">
                                    In Stock
                                </c:when>
                                <c:otherwise>
                                    Out of Stock
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <p class="pd-desc">
                        <c:choose>
                            <c:when test="${not empty product.description}">
                                <c:out value="${product.description}" />
                            </c:when>
                            <c:otherwise>
                                Fresh grocery item selected for everyday shopping and careful delivery.
                            </c:otherwise>
                        </c:choose>
                    </p>

                    <!-- Product action button -->
                    <div class="pd-actions">
                        <form action="<c:url value='/cart'/>" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="productId" value="${product.id}">
                            <input type="hidden" name="quantity" value="1">

                            <button class="u-btn u-btn--primary" type="submit">
                                Add to Cart
                            </button>
                        </form>
                    </div>

                    <!-- Product highlights -->
                    <div class="u-section pd-section">
                        <h2>Highlights</h2>

                        <div class="pd-highlights">
                            <div class="pd-feature">
                                <span>01</span>
                                <strong>Fresh grocery product available for daily shopping</strong>
                            </div>

                            <div class="pd-feature">
                                <span>02</span>
                                <strong>Carefully handled and packed for delivery</strong>
                            </div>

                            <div class="pd-feature">
                                <span>03</span>
                                <strong>Same-day delivery in Kathmandu Valley</strong>
                            </div>
                        </div>
                    </div>

                    <!-- Quick product information -->
                    <div class="u-section pd-section">
                        <h2>Quick info</h2>

                        <div class="pd-quick-grid">
                            <div class="pd-quick-card">
                                <span>Best for</span>
                                <strong>Daily kitchen use</strong>
                            </div>

                            <div class="pd-quick-card">
                                <span>Unit</span>
                                <strong><c:out value="${product.unit}" /></strong>
                            </div>

                            <div class="pd-quick-card">
                                <span>Status</span>
                                <strong>
                                    <c:choose>
                                        <c:when test="${not empty product.status}">
                                            <c:out value="${product.status}" />
                                        </c:when>
                                        <c:otherwise>
                                            Active
                                        </c:otherwise>
                                    </c:choose>
                                </strong>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Related products section -->
            <section class="u-section">
                <h2>Similar picks</h2>

                <div class="u-grid" aria-label="Related products">
                    <c:forEach var="p" items="${relatedProducts}">
                        <article class="p-card">
                            <a href="<c:url value='/productdetail?id=${p.id}'/>">

                                <!-- Related product image -->
                                <div class="p-media">
                                    <c:choose>
                                        <c:when test="${not empty p.imagePath}">
                                            <img src="<c:url value='/${p.imagePath}'/>" alt="${p.productName}">
                                        </c:when>

                                        <c:otherwise>
                                            <img src="<c:url value='/assets/images/placeholder.png'/>" alt="Product image">
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <!-- Related product details -->
                                <div class="p-body">
                                    <h3 class="p-title">
                                        <c:out value="${p.productName}" />
                                    </h3>

                                    <div class="p-meta">
                                        <span>
                                            <c:choose>
                                                <c:when test="${not empty p.categoryName}">
                                                    <c:out value="${p.categoryName}" />
                                                </c:when>
                                                <c:otherwise>
                                                    Grocery
                                                </c:otherwise>
                                            </c:choose>
                                        </span>

                                        <span>Stock: <c:out value="${p.stockQuantity}" /></span>
                                    </div>

                                    <p class="p-description">
                                        <c:choose>
                                            <c:when test="${not empty p.description}">
                                                <c:out value="${p.description}" />
                                            </c:when>
                                            <c:otherwise>
                                                Fresh grocery item selected for everyday shopping.
                                            </c:otherwise>
                                        </c:choose>
                                    </p>

                                    <div class="p-price">
                                        <strong>Rs. <c:out value="${p.price}" /></strong>
                                        <span class="p-unit">/ <c:out value="${p.unit}" /></span>
                                    </div>

                                    <div class="p-footer">
                                        <span class="p-stock">
                                            <c:choose>
                                                <c:when test="${p.stockQuantity > 0}">
                                                    In Stock
                                                </c:when>
                                                <c:otherwise>
                                                    Out of Stock
                                                </c:otherwise>
                                            </c:choose>
                                        </span>

                                        <span class="p-link">View details</span>
                                    </div>
                                </div>
                            </a>
                        </article>
                    </c:forEach>
                </div>
            </section>

            <!-- Product notes section -->
            <section class="pd-notes">
                <h2>Product notes</h2>

                <p class="u-subtitle">
                    A quieter details section for delivery, freshness, and storage information.
                </p>

                <div class="pd-notes-panel">
                    <div class="pd-notes-row">
                        <span>Freshness note</span>
                        <strong>Best enjoyed soon after delivery for better taste and quality.</strong>
                    </div>

                    <div class="pd-notes-row">
                        <span>Storage</span>
                        <strong>Keep refrigerated or in a cool dry place depending on the item category.</strong>
                    </div>

                    <div class="pd-notes-row">
                        <span>Delivery</span>
                        <strong>Handled with careful packing to preserve shape, color, and quality on arrival.</strong>
                    </div>
                </div>
            </section>

        </div>
    </main>

    <!-- Common public footer from WEB-INF -->
    <jsp:include page="/WEB-INF/pages/common/footer.jsp" />

</body>
</html>