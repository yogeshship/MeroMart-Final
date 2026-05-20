<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mero Mart Nepal</title>

    <!-- Google fonts used by public user pages -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@600;700&family=Manrope:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <!-- Your existing user CSS -->
    <link rel="stylesheet" href="<c:url value='/assets/css/user.css?v=20260520-home-final'/>">
</head>

<body class="user-body">

    <!-- Keep your own navbar -->
    <jsp:include page="navbar.jsp" />

    <main class="home-page">

        <!-- Home hero section -->
        <section class="home-simple-hero">

            <!-- Left text card -->
            <div class="home-simple-text">
                <span class="home-simple-label">Fresh Grocery Store</span>

                <h1>Fresh groceries for your everyday needs.</h1>

                <p>
                    Shop fruits, vegetables, dairy, grains and daily essentials from
                    Mero Mart Nepal with a clean and simple shopping experience.
                </p>

                <div class="home-simple-actions">
                    <a href="<c:url value='/product'/>" class="home-simple-btn primary">Shop Now</a>
                    <a href="#featured" class="home-simple-btn secondary">View Products</a>
                </div>
            </div>

            <!-- Middle image card -->
            <div class="home-simple-image">
                <img src="<c:url value='/assets/images/banners/hero-market.webp'/>" alt="Fresh groceries">
            </div>

            <!-- Right green card -->
            <div class="home-simple-side-card">
                <h2>Focused freshness, modern comfort.</h2>

                <p>
                    A quiet highlight panel for fresh seasonal picks,
                    daily essentials, and quick visual trust.
                </p>

                <img src="<c:url value='/assets/images/banners/focus-basket.webp'/>" alt="Shopping basket">
            </div>

        </section>

        <!-- Category section -->
        <section class="home-simple-categories">
            <div class="home-simple-section-title">
                <h2>Shop by Category</h2>
                <p>Choose your daily grocery essentials easily.</p>
            </div>

            <div class="home-simple-category-grid">

                <a class="home-simple-category-card" href="<c:url value='/product?q=Fruits'/>">
                    <img src="<c:url value='/assets/images/products/oranges.jpg'/>" alt="Fruits">
                    <span>Fruits</span>
                </a>

                <a class="home-simple-category-card" href="<c:url value='/product?q=Vegetables'/>">
                    <img src="<c:url value='/assets/images/products/tomatoes.jpg'/>" alt="Vegetables">
                    <span>Vegetables</span>
                </a>

                <a class="home-simple-category-card" href="<c:url value='/product?q=Dairy'/>">
                    <img src="<c:url value='/assets/images/products/milk.jpg'/>" alt="Dairy">
                    <span>Dairy</span>
                </a>

                <a class="home-simple-category-card" href="<c:url value='/product?q=Grains'/>">
                    <img src="<c:url value='/assets/images/products/brown-rice.jpg'/>" alt="Grains">
                    <span>Grains</span>
                </a>

            </div>
        </section>

        <!-- Offer section -->
        <section class="home-simple-offer">
            <div>
                <span>Today’s Offer</span>
                <h2>Fresh products at better prices</h2>
                <p>Get quality grocery items with fast Kathmandu Valley delivery.</p>
            </div>

            <a href="<c:url value='/product'/>">Browse Offers</a>
        </section>

        <!-- Featured products section -->
        <section class="home-simple-products" id="featured">
            <div class="home-simple-section-title">
                <h2>Featured Products</h2>
                <p>Popular grocery items selected for you.</p>
            </div>

            <div class="u-grid">

                <c:forEach var="p" items="${products}" end="3">
                    <article class="p-card">
                        <a href="<c:url value='/productdetail?id=${p.id}'/>">

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

                                    <span class="p-link">View</span>
                                </div>
                            </div>

                        </a>
                    </article>
                </c:forEach>

            </div>
        </section>

    </main>

    <!-- Keep your own footer -->
    <jsp:include page="footer.jsp" />

</body>
</html>