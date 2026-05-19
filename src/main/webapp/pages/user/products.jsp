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

    <!-- Main public user CSS -->
    <link rel="stylesheet" href="<c:url value='/assets/css/user.css'/>">
</head>

<body class="user-body">

    <!-- Use the same public navbar as Home, About and Contact pages -->
    <jsp:include page="../common/navbar.jsp" />

    <main class="u-page">
        <div class="u-container">

            <!-- Product page hero section -->
            <section class="catalog-hero">
                <div class="catalog-copy catalog-copy--airy">
                    <div class="catalog-copy-conxtent">
                        <span class="catalog-eyebrow">Curated grocery collection</span>

                        <h1>Products arranged with more space and less visual noise.</h1>

                        <p class="u-subtitle">
                            This remake gives the catalog a calmer structure, softer card rhythm,
                            and images that support the content instead of taking over the page.
                        </p>

                        <div class="catalog-copy-points">
                            <span>Organized categories with cleaner scanning</span>
                            <span>Balanced product cards and reduced image dominance</span>
                            <span>Quieter premium styling for daily shopping</span>
                        </div>

                        <div class="catalog-cta">
                            <a class="u-btn u-btn--primary" href="#catalog-grid">Browse Products</a>
                            <a class="u-btn" href="<c:url value='/usersettings'/>">Account Settings</a>
                        </div>
                    </div>

                    <div class="catalog-hero-visual">
                        <img src="<c:url value='/assets/images/banners/hero-market.webp'/>" alt="Organic fresh produce market">
                    </div>
                </div>

                <div class="catalog-aside">
                    <div class="catalog-aside-card">
                        <span>Shopping rhythm</span>
                        <strong>Less pressure. Better focus.</strong>

                        <p class="catalog-focus-copy">
                            We trimmed the visual weight of the page and gave each block enough
                            breathing room to feel composed.
                        </p>

                        <p class="catalog-focus-copy">
                            The result is a catalog that feels more premium, aligned, and easier to browse.
                        </p>

                        <div class="catalog-focus-visual">
                            <img src="<c:url value='/assets/images/banners/focus-basket.webp'/>" alt="Premium grocery basket">
                        </div>
                    </div>
                </div>
            </section>

            <!-- Store highlights -->
            <section class="catalog-stats" aria-label="Store highlights">
                <div class="catalog-stat-card">
                    <span class="catalog-stat-icon"></span>
                    <div>
                        <strong>300+</strong>
                        <small>Products</small>
                    </div>
                </div>

                <div class="catalog-stat-card">
                    <span class="catalog-stat-icon"></span>
                    <div>
                        <strong>4.8</strong>
                        <small>Rating</small>
                    </div>
                </div>

                <div class="catalog-stat-card">
                    <span class="catalog-stat-icon"></span>
                    <div>
                        <strong>08</strong>
                        <small>Featured</small>
                    </div>
                </div>

                <div class="catalog-stat-card">
                    <span class="catalog-stat-icon"></span>
                    <div>
                        <strong>24h</strong>
                        <small>Dispatch</small>
                    </div>
                </div>

                <div class="catalog-stat-card">
                    <span class="catalog-stat-icon"></span>
                    <div>
                        <strong>Easy</strong>
                        <small>Browsing flow</small>
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

                <div class="u-filters" aria-label="Filters">
                    <span class="filter-chip">Fruits</span>
                    <span class="filter-chip">Vegetables</span>
                    <span class="filter-chip">Grains</span>
                    <span class="filter-chip">Dairy</span>
                </div>
            </section>

            <!-- Product grid -->
            <section class="u-grid" id="catalog-grid" aria-label="Product grid">

                <c:forEach var="p" items="${products}">
                    <article class="p-card">
                        <a href="<c:url value='/productdetail?id=${p.id}'/>">

                            <div class="p-media">
                                <c:if test="${not empty p.badge}">
                                    <span class="p-badge">${p.badge}</span>
                                </c:if>

                                <img src="<c:url value='${p.image}'/>" alt="${p.name}">
                            </div>

                            <div class="p-body">
                                <h3 class="p-title">${p.name}</h3>

                                <div class="p-meta">
                                    <span>${p.category}</span>
                                    <span>${p.rating}&#9733;</span>
                                </div>

                                <p class="p-description">${p.description}</p>

                                <div class="p-price">
                                    <strong>Rs. ${p.price}</strong>
                                    <span class="p-unit">${p.unit}</span>
                                </div>

                                <div class="p-footer">
                                    <span class="p-stock">${p.stockLabel}</span>
                                    <span class="p-link">View details</span>
                                </div>
                            </div>
                        </a>
                    </article>
                </c:forEach>

            </section>
        </div>
    </main>

    <!-- Use the same public footer as Home, About and Contact pages -->
    <jsp:include page="../common/footer.jsp" />

</body>
</html>