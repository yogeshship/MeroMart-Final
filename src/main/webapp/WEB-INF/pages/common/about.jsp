<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Mero Mart</title>

    <!-- Google fonts used by the user-side layout -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@600;700&family=Manrope:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <!-- Main user-side CSS stays outside WEB-INF -->
    <link rel="stylesheet" href="<c:url value='/assets/css/user.css'/>">

    <!-- Custom CSS for About and Contact pages stays outside WEB-INF -->
    <link rel="stylesheet" href="<c:url value='/assets/css/yogesh-style.css'/>">
</head>

<body class="user-body">

    <!-- Public user-side navbar from WEB-INF -->
    <jsp:include page="/WEB-INF/pages/common/navbar.jsp" />

    <!-- About page content -->
    <main class="u-page">
        <div class="u-container">

            <!-- Page heading -->
            <section class="common-page-head">
                <span class="catalog-eyebrow">System Overview</span>

                <h1>About Mero Mart</h1>

                <p class="u-subtitle">
                    Mero Mart is a grocery management system designed to support product browsing,
                    cart handling, order processing, and customer communication.
                </p>
            </section>

            <!-- Main overview card -->
            <section class="about-hero-card">
                <span class="catalog-eyebrow">Mero Mart Grocery System</span>

                <h2>Fresh groceries, simple shopping.</h2>

                <p>
                    Mero Mart provides a simple digital platform where users can browse grocery products,
                    manage cart items, place orders, and contact the store for support. The system is
                    designed to make grocery shopping more organised, accessible, and user-friendly.
                </p>
            </section>

            <!-- Mission, vision and goal -->
            <section class="about-card-grid">

                <article class="about-info-card">
                    <h2>Our Mission</h2>
                    <p>
                        To provide a clean and reliable grocery platform that helps customers shop easily
                        and allows the store to manage products efficiently.
                    </p>
                </article>

                <article class="about-info-card">
                    <h2>Our Vision</h2>
                    <p>
                        To become a trusted online grocery system that connects customers with fresh
                        products and better shopping services.
                    </p>
                </article>

                <article class="about-info-card">
                    <h2>Our Goal</h2>
                    <p>
                        To support product browsing, cart management, order handling, and customer
                        communication through one organised system.
                    </p>
                </article>

            </section>

            <!-- Key features -->
            <section class="about-feature-card">
                <h2>Key System Features</h2>

                <div class="about-feature-grid">

                    <div class="about-feature-item">
                        <h3>Product Browsing</h3>
                        <p>Users can view grocery items and product details.</p>
                    </div>

                    <div class="about-feature-item">
                        <h3>Cart Management</h3>
                        <p>Users can add products and manage quantities before placing an order.</p>
                    </div>

                    <div class="about-feature-item">
                        <h3>Order Processing</h3>
                        <p>Users can proceed from cart to checkout and complete their order.</p>
                    </div>

                    <div class="about-feature-item">
                        <h3>Contact Support</h3>
                        <p>Users can send enquiries through the contact form.</p>
                    </div>

                </div>
            </section>

            <!-- Database foundation -->
            <section class="about-database-card">
                <span class="catalog-eyebrow">Database Foundation</span>

                <h2>Structured and reliable data storage</h2>

                <p>
                    The system is supported by a relational database that stores users, products,
                    categories, carts, orders, order items, and contact messages. This helps the system
                    manage customer activity and store operations in an organised way.
                </p>
            </section>

        </div>
    </main>

    <!-- Public user-side footer from WEB-INF -->
    <jsp:include page="/WEB-INF/pages/common/footer.jsp" />

</body>
</html>