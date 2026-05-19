<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<header class="store-header">

    <!-- Top information strip -->
    <div class="store-info-strip">
        <div class="u-container">
            <div class="store-topline">
                <div class="store-topline-meta">
                    <span>Open daily</span>
                    <span>|</span>
                    <span>Kathmandu Valley delivery</span>
                </div>
            </div>
        </div>
    </div>

    <!-- Main navbar -->
    <div class="u-container">
        <div class="store-nav">

            <!-- Logo -->
            <a class="store-brand" href="<c:url value='/home'/>">
                <img src="<c:url value='/assets/images/logo/logo.png?v=20260501-3'/>" alt="Mero Mart">
            </a>

            <!-- Main navigation links -->
            <nav class="store-menu" aria-label="Main">
                <a class="store-link ${activePage eq 'home' ? 'is-active' : ''}"
                   href="<c:url value='/home'/>">Home</a>

                <a class="store-link ${activePage eq 'products' ? 'is-active' : ''}"
                   href="<c:url value='/product'/>">Products</a>

                <a class="store-link ${activePage eq 'about' ? 'is-active' : ''}"
                   href="<c:url value='/about'/>">About</a>

                <a class="store-link ${activePage eq 'contact' ? 'is-active' : ''}"
                   href="<c:url value='/contact'/>">Contact</a>
            </nav>

            <!-- Search and action buttons -->
            <div class="store-tools">

                <!-- Product search form -->
                <form class="store-search" action="<c:url value='/product'/>" method="get">
                    <svg viewBox="0 0 20 20" aria-hidden="true">
                        <circle cx="9" cy="9" r="5.5"></circle>
                        <path d="M13.5 13.5 17 17"></path>
                    </svg>

                    <input name="q"
                           type="search"
                           placeholder="Search by product or category"
                           value="${param.q}">
                </form>

                <!-- Show Login when user is not logged in -->
                <a class="store-action" href="<c:url value='/login'/>">Login</a>

                <!-- Protected user actions -->
                <a class="store-action" href="<c:url value='/wishlist'/>">Wishlist</a>
                <a class="store-action store-action--strong" href="<c:url value='/cart'/>">Cart</a>

            </div>

        </div>
    </div>

</header>