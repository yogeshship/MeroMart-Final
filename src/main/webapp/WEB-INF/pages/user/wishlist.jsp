<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Wishlist - Mero Mart</title>

    <!-- Fonts used by public pages -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@600;700&family=Manrope:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <!-- Main user-side stylesheet -->
    <link rel="stylesheet" href="<c:url value='/assets/css/user.css'/>">

    <style>
        .wishlist-panel {
            background: rgba(255, 255, 255, 0.84);
            border: 1px solid rgba(12, 81, 63, 0.12);
            border-radius: 28px;
            padding: 62px 28px;
            text-align: center;
            box-shadow: 0 22px 60px rgba(12, 81, 63, 0.08);
        }

        .wishlist-icon {
            width: 78px;
            height: 78px;
            margin: 0 auto 22px;
            border-radius: 26px;
            background: #e6f2ee;
            color: #087557;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .wishlist-panel h2 {
            font-family: "Cormorant Garamond", serif;
            font-size: 42px;
            color: #102033;
            margin: 0 0 10px;
        }

        .wishlist-panel p {
            color: #637083;
            font-weight: 700;
            margin-bottom: 24px;
        }
    </style>
</head>

<body class="user-body">

    <!-- Common navbar -->
    <jsp:include page="/WEB-INF/pages/common/navbar.jsp" />

    <main class="u-page">
        <div class="u-container">

            <!-- Page heading -->
            <section style="margin-bottom:34px;">
                <span class="catalog-eyebrow">Wishlist</span>
                <h1>Your saved grocery picks.</h1>
                <p class="u-subtitle">
                    Keep favorite items here for faster shopping in future visits.
                </p>
            </section>

            <!-- Simple wishlist placeholder -->
            <section class="wishlist-panel">
                <div class="wishlist-icon">
                    <svg width="38" height="38" viewBox="0 0 24 24" fill="none"
                         stroke="currentColor" stroke-width="1.8"
                         stroke-linecap="round" stroke-linejoin="round">
                        <path d="M20.8 4.6c-1.5-1.4-3.9-1.4-5.4 0L12 8l-3.4-3.4c-1.5-1.4-3.9-1.4-5.4 0s-1.5 3.8 0 5.3L12 18.7l8.8-8.8c1.5-1.5 1.5-3.9 0-5.3z"></path>
                    </svg>
                </div>

                <h2>Your wishlist is empty</h2>

                <p>
                    Save products you like and return to them later.
                </p>

                <a class="u-btn u-btn--primary" href="<c:url value='/product'/>">
                    Browse Products
                </a>
            </section>

        </div>
    </main>

    <!-- Common footer -->
    <jsp:include page="/WEB-INF/pages/common/footer.jsp" />

</body>
</html>