<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Settings</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@600;700&family=Manrope:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value='/assets/css/user.css'/>">
</head>
<body class="user-body">
    <jsp:include page="user-navbar.jsp" />

    <main class="u-page">
        <div class="u-container">
            <section class="settings-hero">
                <div class="settings-hero-copy">
                    <span class="catalog-eyebrow">User settings</span>
                    <h1>Personal details and storefront preferences in one calm space.</h1>
                    <p class="u-subtitle">Review your login information, see your account details, and manage the small personalization touches that shape your shopping experience.</p>
                </div>
                <div class="settings-hero-card">
                    <span class="store-user-avatar store-user-avatar--hero">
                        ${empty profileUser.initials ? 'U' : profileUser.initials}
                    </span>
                    <strong>${empty profileUser.fullName ? 'User Account' : profileUser.fullName}</strong>
                    <span>${empty profileUser.email ? 'Signed in shopper' : profileUser.email}</span>
                </div>
            </section>

            <section class="settings-grid">
                <article class="settings-panel">
                    <div class="settings-panel-head">
                        <div>
                            <span class="catalog-eyebrow">Login info</span>
                            <h2>Account details</h2>
                        </div>
                    </div>
                    <div class="settings-info-grid">
                        <div class="settings-info-card">
                            <span>Full name</span>
                            <strong>${empty profileUser.fullName ? 'Not available' : profileUser.fullName}</strong>
                        </div>
                        <div class="settings-info-card">
                            <span>Email</span>
                            <strong>${empty profileUser.email ? 'Not available' : profileUser.email}</strong>
                        </div>
                        <div class="settings-info-card">
                            <span>Phone</span>
                            <strong>${empty profileUser.phone ? 'Not added yet' : profileUser.phone}</strong>
                        </div>
                        <div class="settings-info-card">
                            <span>Role</span>
                            <strong>${empty profileUser.displayRole ? 'User' : profileUser.displayRole}</strong>
                        </div>
                        <div class="settings-info-card settings-info-card--wide">
                            <span>Address</span>
                            <strong>${empty profileUser.address ? 'No address saved yet' : profileUser.address}</strong>
                        </div>
                    </div>
                </article>

                <article class="settings-panel">
                    <div class="settings-panel-head">
                        <div>
                            <span class="catalog-eyebrow">Customization</span>
                            <h2>Experience preferences</h2>
                        </div>
                    </div>
                    <div class="settings-choice-list">
                        <div class="settings-choice-card">
                            <span>Storefront mood</span>
                            <strong>Clean and spacious</strong>
                            <p class="u-subtitle">The current user layout favors more white space, smaller visuals, and a calmer browsing flow.</p>
                        </div>
                        <div class="settings-choice-card">
                            <span>Shopping shortcuts</span>
                            <strong>Quick access enabled</strong>
                            <p class="u-subtitle">Wishlist, cart, and your account menu stay visible from the header for faster movement across the site.</p>
                        </div>
                        <div class="settings-choice-card">
                            <span>Delivery focus</span>
                            <strong>Kathmandu Valley</strong>
                            <p class="u-subtitle">Current user messaging is tuned to local delivery convenience and everyday essentials.</p>
                        </div>
                    </div>
                </article>
            </section>

            <section class="settings-logout-panel">
                <div>
                    <span class="catalog-eyebrow">Session</span>
                    <h2>Ready to leave?</h2>
                    <p class="u-subtitle">You can log out here or from the account dropdown in the navigation.</p>
                </div>
                <a class="u-btn u-btn--primary" href="<c:url value='/logout'/>">Logout</a>
            </section>
        </div>
    </main>

    <jsp:include page="user-footer.jsp" />
</body>
</html>
