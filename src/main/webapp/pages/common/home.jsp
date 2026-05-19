<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mero Mart Nepal</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@600;700&family=Manrope:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value='/assets/css/user.css'/>">
</head>
<body class="user-body">
    <jsp:include page="navbar.jsp" />

    <main class="u-page">
        <div class="u-container">
            <section class="home-hero">
                <div class="home-hero-copy">
                    <span class="catalog-eyebrow">Mero Mart Nepal</span>
                    <h1>Classic everyday grocery shopping, made warm, calm, and beautifully simple.</h1>
                    <p class="u-subtitle">Fresh produce, pantry essentials, and household staples delivered with a more refined, timeless storefront experience.</p>
                    <div class="home-hero-points">
                        <span>Fresh market quality with daily-ready picks</span>
                        <span>Trusted local delivery across Kathmandu Valley</span>
                        <span>Thoughtful packaging for a premium feel at home</span>
                    </div>
                    <div class="catalog-cta">
                        <a class="u-btn u-btn--primary" href="<c:url value='/product'/>">Shop Collection</a>
                        <a class="u-btn" href="<c:url value='/about'/>">Our Story</a>
                    </div>
                </div>

                <div class="home-hero-visual">
                    <img src="<c:url value='/assets/images/banners/hero-market.webp'/>" alt="Fresh groceries arranged in a real market setting">
                    <div class="home-hero-note">
                        <span>Open daily</span>
                        <strong>Fresh produce, pantry staples, and dairy prepared for the modern Nepali home.</strong>
                    </div>
                </div>
            </section>

            <section class="home-metrics">
                <div class="home-metric-card">
                    <strong>300+</strong>
                    <span>Curated products</span>
                </div>
                <div class="home-metric-card">
                    <strong>4.8</strong>
                    <span>Customer rating</span>
                </div>
                <div class="home-metric-card">
                    <strong>24h</strong>
                    <span>Fast valley dispatch</span>
                </div>
            </section>

            <section class="home-story">
                <div class="home-story-intro">
                    <span class="catalog-eyebrow">Why Mero Mart</span>
                    <h2>A timeless market feel with cleaner digital shopping.</h2>
                    <p class="u-subtitle">We combined a classic cream-and-green palette, natural food imagery, and compact layouts to make the store feel both pleasant and practical.</p>
                </div>
                <div class="home-story-grid">
                    <article class="home-story-card">
                        <h3>Fresh First</h3>
                        <p>Produce and staples are presented with visual clarity so customers can browse faster and trust what they see.</p>
                    </article>
                    <article class="home-story-card">
                        <h3>Calm Layout</h3>
                        <p>Clear spacing, softer surfaces, and classic typography create a shopping flow that feels less noisy and more premium.</p>
                    </article>
                    <article class="home-story-card">
                        <h3>Local Convenience</h3>
                        <p>Built around daily needs in Kathmandu Valley, from quick restocks to carefully chosen essentials for the week.</p>
                    </article>
                </div>
            </section>

            <section class="home-categories">
                <div class="u-page-head">
                    <div>
                        <h2>Shop By Everyday Favorites</h2>
                        <p class="u-subtitle">A clean starting point for the categories people come back to most.</p>
                    </div>
                </div>
                <div class="home-category-grid">
                    <a class="home-category-card" href="<c:url value='/product?q=Fruits'/>">
                        <img src="<c:url value='/assets/images/products/oranges.jpg'/>" alt="Fresh fruits">
                        <div>
                            <strong>Fruits</strong>
                            <span>Bright, seasonal, naturally fresh</span>
                        </div>
                    </a>
                    <a class="home-category-card" href="<c:url value='/product?q=Vegetables'/>">
                        <img src="<c:url value='/assets/images/products/tomatoes.jpg'/>" alt="Fresh vegetables">
                        <div>
                            <strong>Vegetables</strong>
                            <span>Kitchen staples for everyday meals</span>
                        </div>
                    </a>
                    <a class="home-category-card" href="<c:url value='/product?q=Grains'/>">
                        <img src="<c:url value='/assets/images/products/brown-rice.jpg'/>" alt="Grains and pantry essentials">
                        <div>
                            <strong>Grains</strong>
                            <span>Comforting bases for home cooking</span>
                        </div>
                    </a>
                    <a class="home-category-card" href="<c:url value='/product?q=Dairy'/>">
                        <img src="<c:url value='/assets/images/products/milk.jpg'/>" alt="Dairy essentials">
                        <div>
                            <strong>Dairy</strong>
                            <span>Daily freshness for tea, breakfast, and more</span>
                        </div>
                    </a>
                </div>
            </section>

            <section class="home-showcase">
                <div class="home-showcase-image">
                    <img src="<c:url value='/assets/images/banners/focus-basket.webp'/>" alt="Curated basket of fresh groceries">
                </div>
                <div class="home-showcase-copy">
                    <span class="catalog-eyebrow">Handpicked Daily</span>
                    <h2>Small details make the storefront feel more human.</h2>
                    <p class="u-subtitle">Real-life grocery imagery, compact cards, and steady typography help the store feel grounded, useful, and trustworthy.</p>
                    <div class="home-showcase-list">
                        <div><strong>Classic palette</strong><span>Cream backgrounds, warm white cards, and deep green accents.</span></div>
                        <div><strong>Compact composition</strong><span>Balanced spacing that keeps more content visible without feeling crowded.</span></div>
                        <div><strong>Timeless shopping flow</strong><span>Familiar structure with a more polished presentation from hero to footer.</span></div>
                    </div>
                    <a class="u-btn u-btn--primary" href="<c:url value='/product'/>">Explore Products</a>
                </div>
            </section>
        </div>
    </main>

    <jsp:include page="footer.jsp" />
</body>
</html>
