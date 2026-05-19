<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<header class="store-header">
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
    <div class="u-container">
        <div class="store-nav">
            <a class="store-brand" href="<c:url value='/'/>">
                <img src="<c:url value='/assets/images/logo/logo.png?v=20260501-3'/>" alt="Mero Mart">
            </a>

            <nav class="store-menu" aria-label="Main">
                <a class="store-link ${activePage eq 'home' ? 'is-active' : ''}" href="<c:url value='/'/>">Home</a>
                <a class="store-link ${activePage eq 'products' ? 'is-active' : ''}" href="<c:url value='/product'/>">Products</a>
                <a class="store-link ${activePage eq 'about' ? 'is-active' : ''}" href="<c:url value='/about'/>">About</a>
                <a class="store-link ${activePage eq 'contact' ? 'is-active' : ''}" href="<c:url value='/contact'/>">Contact</a>
            </nav>

            <div class="store-tools">
                <form class="store-search" action="<c:url value='/product'/>" method="get">
                    <svg viewBox="0 0 20 20" aria-hidden="true">
                        <circle cx="9" cy="9" r="5.5"></circle>
                        <path d="M13.5 13.5 17 17"></path>
                    </svg>
                    <input name="q" type="search" placeholder="Search by product or category" value="${param.q}">
                </form>
                <div class="store-quick-actions">
                    <a class="store-action" href="<c:url value='/wishlist'/>">Wishlist</a>
                    <a class="store-action store-action--strong" href="<c:url value='/cart'/>">Cart</a>
                    <details class="store-user-menu">
                        <summary class="store-user-toggle">
                            <span class="store-user-avatar">
                                ${empty sessionScope.user.initials ? 'U' : sessionScope.user.initials}
                            </span>
                            <span class="store-user-toggle-copy">
                                <small>Account</small>
                                <strong>${empty sessionScope.user.fullName ? 'User' : sessionScope.user.fullName}</strong>
                            </span>
                            <svg viewBox="0 0 20 20" aria-hidden="true">
                                <path d="M5 7.5 10 12.5 15 7.5"></path>
                            </svg>
                        </summary>
                        <div class="store-user-dropdown">
                            <div class="store-user-summary">
                                <span class="store-user-avatar store-user-avatar--large">
                                    ${empty sessionScope.user.initials ? 'U' : sessionScope.user.initials}
                                </span>
                                <div>
                                    <strong>${empty sessionScope.user.fullName ? 'User Account' : sessionScope.user.fullName}</strong>
                                    <span>${empty sessionScope.user.email ? 'Signed in shopper' : sessionScope.user.email}</span>
                                </div>
                            </div>
                            <a class="store-user-item" href="<c:url value='/usersettings'/>">Settings</a>
                            <a class="store-user-item store-user-item--danger" href="<c:url value='/logout'/>">Logout</a>
                        </div>
                    </details>
                </div>
            </div>
        </div>
    </div>
</header>
