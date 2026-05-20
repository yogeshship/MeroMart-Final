<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products - Mero Mart</title>

    <!-- Google fonts used by public user pages -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@600;700&family=Manrope:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <!-- Main public user CSS stays outside WEB-INF -->
    <link rel="stylesheet" href="<c:url value='/assets/css/user.css?v=20260520-2'/>">
</head>

<body class="user-body">

    <!-- Common public navbar from WEB-INF -->
    <jsp:include page="/WEB-INF/pages/common/navbar.jsp" />

    <main class="u-page">
        <div class="u-container">

            <!-- Product page hero section -->
            <section class="catalog-hero">
                <div class="catalog-copy catalog-copy--airy">
                    <div class="catalog-copy-content">
                        <span class="catalog-eyebrow">Curated grocery collection</span>

                        <h1>Products arranged with more space and less visual noise.</h1>

                        <p class="u-subtitle">
                            Browse fresh groceries from the Mero Mart catalog with a clean layout,
                            clear product details, and quick access to each item.
                        </p>

                        <div class="catalog-copy-points">
                            <span>Organized categories with cleaner scanning</span>
                            <span>Balanced product cards and reduced image dominance</span>
                            <span>Quieter premium styling for daily shopping</span>
                        </div>

                        <div class="catalog-cta">
                            <a class="u-btn u-btn--primary" href="#catalog-grid">
                                Browse Products
                            </a>

                            <a class="u-btn" href="<c:url value='/usersettings'/>">
                                Account Settings
                            </a>
                        </div>
                    </div>

                    <div class="catalog-hero-visual">
                        <img src="<c:url value='/assets/images/banners/hero-market.webp'/>"
                             alt="Organic fresh produce market">
                    </div>
                </div>

                <div class="catalog-aside">
                    <div class="catalog-aside-card">
                        <span>Shopping rhythm</span>

                        <strong>Less pressure. Better focus.</strong>

                        <p class="catalog-focus-copy">
                            Each product is displayed with clear price, unit, category, and stock information.
                        </p>

                        <p class="catalog-focus-copy">
                            The result is a catalog that feels more premium, aligned, and easier to browse.
                        </p>

                        <div class="catalog-focus-visual">
                            <img src="<c:url value='/assets/images/banners/focus-basket.webp'/>"
                                 alt="Premium grocery basket">
                        </div>
                    </div>
                </div>
            </section>

            <!-- Product filter heading -->
            <section class="catalog-toolbar">
                <div class="u-page-head">
                    <div>
                        <h2>Shop products</h2>

                        <p class="u-subtitle">
                            Browse a cleaner premium selection across fruits, vegetables, grains, and dairy.
                        </p>
                    </div>
                </div>

                <!-- Functional category filter buttons -->
                <div class="u-filters" aria-label="Product category filters">

                    <a class="filter-chip ${empty param.q ? 'is-active' : ''}"
                       href="<c:url value='/product'/>">
                        All
                    </a>

                    <a class="filter-chip ${param.q == 'Fruits' ? 'is-active' : ''}"
                       href="<c:url value='/product?q=Fruits'/>">
                        Fruits
                    </a>

                    <a class="filter-chip ${param.q == 'Vegetables' ? 'is-active' : ''}"
                       href="<c:url value='/product?q=Vegetables'/>">
                        Vegetables
                    </a>

                    <a class="filter-chip ${param.q == 'Grains' ? 'is-active' : ''}"
                       href="<c:url value='/product?q=Grains'/>">
                        Grains
                    </a>

                    <a class="filter-chip ${param.q == 'Dairy' ? 'is-active' : ''}"
                       href="<c:url value='/product?q=Dairy'/>">
                        Dairy
                    </a>

                </div>
            </section>

            <!-- Product grid loaded from database -->
            <section class="u-grid" id="catalog-grid" aria-label="Product grid">

                <c:forEach var="p" items="${products}">
                    <article class="p-card">
                        <a href="<c:url value='/productdetail?id=${p.id}'/>">

                            <!-- Product image -->
                            <div class="p-media">
                                <c:choose>
                                    <c:when test="${not empty p.imagePath}">
                                        <img src="<c:url value='/${p.imagePath}'/>"
                                             alt="${p.productName}">
                                    </c:when>

                                    <c:otherwise>
                                        <img src="<c:url value='/assets/images/placeholder.png'/>"
                                             alt="Product image">
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <!-- Product details -->
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

                                    <span>
                                        Stock: <c:out value="${p.stockQuantity}" />
                                    </span>
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

                <!-- Empty state -->
                <c:if test="${empty products}">
                    <div style="grid-column: 1 / -1; text-align: center; padding: 60px 20px; background: #ffffff; border-radius: 28px;">
                        <h2>No products found</h2>

                        <p class="u-subtitle">
                            No active products are available for this category right now.
                        </p>

                        <a class="u-btn u-btn--primary"
                           href="<c:url value='/product'/>"
                           style="margin-top: 18px;">
                            View All Products
                        </a>
                    </div>
                </c:if>

            </section>
        </div>
    </main>

    <!-- Common public footer from WEB-INF -->
    <jsp:include page="/WEB-INF/pages/common/footer.jsp" />

</body>
</html>