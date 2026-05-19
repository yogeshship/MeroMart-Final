<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${product.name} - Mero Mart</title>

    <!-- Google fonts used by public user pages -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@600;700&family=Manrope:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <!-- Main public user CSS -->
    <link rel="stylesheet" href="<c:url value='/assets/css/user.css'/>">
</head>

<body class="user-body">

    <!-- Use the same public navbar as Home, About, Contact and Product pages -->
    <jsp:include page="../common/navbar.jsp" />

    <main class="u-page">
        <div class="u-container">

            <!-- Breadcrumb navigation -->
            <nav class="u-breadcrumbs" aria-label="Breadcrumb">
                <a href="<c:url value='/home'/>">Home</a>
                <span>/</span>
                <a href="<c:url value='/product'/>">Products</a>
                <span>/</span>
                <span>${product.category}</span>
                <span>/</span>
                <span>${product.name}</span>
            </nav>

            <!-- Product detail section -->
            <section class="pd-shell">

                <!-- Product image area -->
                <div class="pd-panel pd-gallery">
                    <div class="pd-hero">
                        <img src="<c:url value='${product.image}'/>" alt="${product.name}">
                    </div>

                    <div class="pd-gallery-note">
                        <span>
                            <c:out value="${empty product.badge ? 'Fresh Pick' : product.badge}"/>
                        </span>

                        <strong>
                            Selected for a calmer product view with cleaner spacing,
                            softer framing, and quick confidence.
                        </strong>
                    </div>
                </div>

                <!-- Product information area -->
                <div class="pd-panel pd-info">
                    <span class="catalog-eyebrow">Product details</span>

                    <h1 class="pd-title">${product.name}</h1>

                    <p class="pd-kicker">
                        ${product.category} &#8226; ${product.unit} &#8226; ${product.rating}&#9733; rating
                    </p>

                    <div class="pd-row">
                        <div class="pd-price">Rs. ${product.price}</div>
                        <div class="pd-chip">${product.stockLabel}</div>
                    </div>

                    <p class="pd-desc">${product.description}</p>

                  <!-- Product action buttons -->

				  <div class="pd-actions">

    				<form action="<c:url value='/cart'/>" method="post" style="display:inline;">

        			<input type="hidden" name="action" value="add">

        			<input type="hidden" name="productId" value="${product.id}">

        			<input type="hidden" name="quantity" value="1">

        			<button class="u-btn u-btn--primary" type="submit">

            			Add to Cart

        			</button>

    				</form>

    				<a class="u-btn" href="<c:url value='/wishlist'/>">

        			Save to Wishlist

   		 			</a>

				</div>

                    <!-- Product highlights -->
                    <div class="u-section pd-section">
                        <h2>Highlights</h2>

                        <div class="pd-highlights">
                            <div class="pd-feature">
                                <span>01</span>
                                <strong>${product.highlightOne}</strong>
                            </div>

                            <div class="pd-feature">
                                <span>02</span>
                                <strong>${product.highlightTwo}</strong>
                            </div>

                            <div class="pd-feature">
                                <span>03</span>
                                <strong>Same-day delivery in valley</strong>
                            </div>
                        </div>
                    </div>

                    <!-- Quick product information -->
                    <div class="u-section pd-section">
                        <h2>Quick info</h2>

                        <div class="pd-quick-grid">
                            <div class="pd-quick-card">
                                <span>Best for</span>
                                <strong>Daily kitchen use</strong>
                            </div>

                            <div class="pd-quick-card">
                                <span>Delivery</span>
                                <strong>Fast valley dispatch</strong>
                            </div>

                            <div class="pd-quick-card">
                                <span>Packing</span>
                                <strong>Carefully handled</strong>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Related products section -->
            <section class="u-section">
                <h2>Similar picks</h2>

                <div class="u-grid" aria-label="Related products">
                    <c:forEach var="p" items="${relatedProducts}">
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
                </div>
            </section>

            <!-- Product notes section -->
            <section class="pd-notes">
                <h2>Product notes</h2>

                <p class="u-subtitle">
                    A quieter details section for delivery, freshness, and storage information.
                </p>

                <div class="pd-notes-panel">
                    <div class="pd-notes-row">
                        <span>Freshness note</span>
                        <strong>Best enjoyed within 2 to 3 days of delivery for peak taste and texture.</strong>
                    </div>

                    <div class="pd-notes-row">
                        <span>Storage</span>
                        <strong>Keep refrigerated or in a cool dry place depending on the item category.</strong>
                    </div>

                    <div class="pd-notes-row">
                        <span>Delivery</span>
                        <strong>Handled with careful packing to preserve shape, color, and quality on arrival.</strong>
                    </div>
                </div>
            </section>

        </div>
    </main>

    <!-- Use the same public footer as Home, About, Contact and Product pages -->
    <jsp:include page="../common/footer.jsp" />

</body>
</html>