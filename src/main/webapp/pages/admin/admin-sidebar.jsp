<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<aside class="admin-sidebar">
    <a class="brand" href="<c:url value='/admindashboard'/>">
        <img class="brand-logo" src="<c:url value='/assets/images/logo/logo.png?v=20260501-3'/>" alt="Mero Mart Nepal">
    </a>

    <div class="sidebar-title">Admin Panel</div>

    <nav class="sidebar-nav">
        <a class="nav-link ${activePage eq 'dashboard' ? 'is-active' : ''}" href="<c:url value='/admindashboard'/>">
            <span class="nav-icon" aria-hidden="true">
                <svg viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                    <rect x="3" y="3" width="5" height="5" rx="1.2"></rect>
                    <rect x="12" y="3" width="5" height="5" rx="1.2"></rect>
                    <rect x="3" y="12" width="5" height="5" rx="1.2"></rect>
                    <rect x="12" y="12" width="5" height="5" rx="1.2"></rect>
                </svg>
            </span>
            <span class="nav-label">Dashboard</span>
        </a>
        <a class="nav-link ${activePage eq 'products' ? 'is-active' : ''}" href="<c:url value='/manageproducts'/>">
            <span class="nav-icon" aria-hidden="true">
                <svg viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M6 6h8l1 2v7a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V8l1-2Z"></path>
                    <path d="M8 6a2 2 0 1 1 4 0"></path>
                </svg>
            </span>
            <span class="nav-label">Manage Products</span>
        </a>
        <a class="nav-link ${activePage eq 'add-product' ? 'is-active' : ''}" href="<c:url value='/addproduct'/>">
            <span class="nav-icon" aria-hidden="true">
                <svg viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round">
                    <path d="M10 4v12"></path>
                    <path d="M4 10h12"></path>
                </svg>
            </span>
            <span class="nav-label">Add Product</span>
        </a>
        <a class="nav-link ${activePage eq 'users' ? 'is-active' : ''}" href="<c:url value='/manageuser'/>">
            <span class="nav-icon" aria-hidden="true">
                <svg viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                    <circle cx="10" cy="6.5" r="3"></circle>
                    <path d="M4.5 16a5.5 5.5 0 0 1 11 0"></path>
                </svg>
            </span>
            <span class="nav-label">Manage Users</span>
        </a>
        <a class="nav-link ${activePage eq 'categories' ? 'is-active' : ''}" href="<c:url value='/managecategory'/>">
            <span class="nav-icon" aria-hidden="true">
                <svg viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M4 5h12"></path>
                    <path d="M4 10h12"></path>
                    <path d="M4 15h8"></path>
                </svg>
            </span>
            <span class="nav-label">Categories</span>
        </a>
        <a class="nav-link ${activePage eq 'orders' ? 'is-active' : ''}" href="<c:url value='/manageorder'/>">
            <span class="nav-icon" aria-hidden="true">
                <svg viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                    <rect x="3" y="4" width="14" height="12" rx="2"></rect>
                    <path d="M6 8h8"></path>
                    <path d="M6 12h5"></path>
                </svg>
            </span>
            <span class="nav-label">Orders</span>
        </a>
    </nav>

    <div class="sidebar-bottom">
        <div class="sidebar-divider" aria-hidden="true"></div>
        <nav class="sidebar-nav sidebar-nav--bottom" aria-label="Account">
            <a class="nav-link ${activePage eq 'settings' ? 'is-active' : ''}" href="<c:url value='/profile'/>">
                <span class="nav-icon" aria-hidden="true">
                    <svg viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                        <circle cx="10" cy="10" r="2.5"></circle>
                        <path d="M10 3.5v1.5"></path>
                        <path d="M10 15v1.5"></path>
                        <path d="M15 10h1.5"></path>
                        <path d="M3.5 10H5"></path>
                        <path d="m14.6 5.4-1.1 1.1"></path>
                        <path d="m6.5 13.5-1.1 1.1"></path>
                        <path d="m14.6 14.6-1.1-1.1"></path>
                        <path d="m6.5 6.5-1.1-1.1"></path>
                    </svg>
                </span>
                <span class="nav-label">Settings</span>
            </a>
            <a class="nav-link nav-link--danger" href="<c:url value='/logout'/>">
                <span class="nav-icon" aria-hidden="true">
                    <svg viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M8 4H5.8A1.8 1.8 0 0 0 4 5.8v8.4A1.8 1.8 0 0 0 5.8 16H8"></path>
                        <path d="M12 13.5 16 10l-4-3.5"></path>
                        <path d="M16 10H8"></path>
                    </svg>
                </span>
                <span class="nav-label">Log Out</span>
            </a>
        </nav>
    </div>
</aside>
