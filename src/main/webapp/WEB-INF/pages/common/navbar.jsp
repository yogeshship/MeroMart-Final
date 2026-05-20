<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%-- Check logged-in user from session --%>
<c:set var="loggedUser" value="${sessionScope.currentUser}" />

<c:if test="${empty loggedUser}">
    <c:set var="loggedUser" value="${sessionScope.user}" />
</c:if>

<style>
    .nav-account-wrapper {
        position: relative;
        display: inline-block;
    }

    .nav-account-button {
        border: 1px solid rgba(255, 255, 255, 0.22);
        background: rgba(255, 255, 255, 0.12);
        color: #ffffff;
        border-radius: 999px;
        padding: 13px 18px;
        font-weight: 800;
        font-family: inherit;
        font-size: 14px;
        cursor: pointer;
        line-height: 1;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 6px;
        list-style: none;
    }

    .nav-account-button::-webkit-details-marker {
        display: none;
    }

    .nav-account-button:hover {
        background: rgba(255, 255, 255, 0.20);
    }

    .nav-account-menu {
        position: absolute;
        top: 48px;
        right: 0;
        width: 180px;
        background: #ffffff;
        border: 1px solid rgba(12, 81, 63, 0.14);
        border-radius: 16px;
        box-shadow: 0 18px 45px rgba(12, 81, 63, 0.16);
        padding: 8px;
        z-index: 9999;
    }

    .nav-account-menu a {
        display: block;
        padding: 11px 12px;
        border-radius: 10px;
        color: #102033;
        text-decoration: none;
        font-size: 14px;
        font-weight: 800;
    }

    .nav-account-menu a:hover {
        background: #e6f2ee;
        color: #087557;
    }
</style>

<header class="store-header">

    <!-- Top store information strip -->
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

            <!-- Public navigation links -->
            <nav class="store-menu" aria-label="Main">
                <a class="store-link ${activePage eq 'home' ? 'is-active' : ''}"
                   href="<c:url value='/home'/>">
                    Home
                </a>

                <a class="store-link ${activePage eq 'products' ? 'is-active' : ''}"
                   href="<c:url value='/product'/>">
                    Products
                </a>

                <a class="store-link ${activePage eq 'about' ? 'is-active' : ''}"
                   href="<c:url value='/about'/>">
                    About
                </a>

                <a class="store-link ${activePage eq 'contact' ? 'is-active' : ''}"
                   href="<c:url value='/contact'/>">
                    Contact
                </a>
            </nav>

            <!-- Right side navbar tools -->
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
                           value="<c:out value='${param.q}'/>">
                </form>

                <!-- Cart button -->
                <a class="store-action store-action--strong" href="<c:url value='/cart'/>">
                    Cart
                </a>

                <%-- Login/account display logic --%>
                <c:choose>

                    <%-- Account dropdown for logged-in user --%>
                    <c:when test="${not empty loggedUser}">
                        <details class="nav-account-wrapper">

                            <!-- User account button -->
                            <summary class="nav-account-button">
                                <c:choose>
                                    <c:when test="${not empty loggedUser.fullName}">
                                        <c:out value="${loggedUser.fullName}" />
                                    </c:when>

                                    <c:otherwise>
                                        Account
                                    </c:otherwise>
                                </c:choose>
                                ▾
                            </summary>

                            <!-- Account dropdown menu -->
                            <div class="nav-account-menu">
                                <a href="<c:url value='/usersettings'/>">
                                    Settings
                                </a>

                                <a href="<c:url value='/order-history'/>">
                                    Order History
                                </a>

                                <a href="<c:url value='/logout'/>">
                                    Logout
                                </a>
                            </div>

                        </details>
                    </c:when>

                    <%-- Login button for guest user --%>
                    <c:otherwise>
                        <a class="store-action" href="<c:url value='/login'/>">
                            Login
                        </a>
                    </c:otherwise>

                </c:choose>

            </div>

        </div>
    </div>

</header>