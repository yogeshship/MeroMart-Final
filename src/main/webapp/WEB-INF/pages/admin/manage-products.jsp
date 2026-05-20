<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Products - Mero Mart</title>

    <!-- Google font for admin pages -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">

    <!-- Admin stylesheet stays outside WEB-INF -->
    <link rel="stylesheet" href="<c:url value='/assets/css/admin.css?v=20260520-1'/>">
</head>

<body class="admin-body">

    <div class="admin-shell">

        <!-- Admin sidebar navigation from WEB-INF -->
        <jsp:include page="/WEB-INF/pages/admin/admin-sidebar.jsp" />

        <main class="admin-main admin-main--airy">

            <!-- Page heading -->
            <section class="page-toolbar">
                <div class="page-copy">
                    <span class="eyebrow">Catalog Workspace</span>
                    <h1>Manage Products</h1>
                    <p>Catalog, stock, and pricing.</p>
                </div>
            </section>

            <!-- Success messages -->
            <c:if test="${param.msg == 'added'}">
                <div style="color: #00674F; margin-bottom: 15px; padding: 10px; background: #E6F0ED; border-radius: 6px; font-weight: 600;">
                    Product added successfully.
                </div>
            </c:if>

            <c:if test="${param.msg == 'updated'}">
                <div style="color: #00674F; margin-bottom: 15px; padding: 10px; background: #E6F0ED; border-radius: 6px; font-weight: 600;">
                    Product updated successfully.
                </div>
            </c:if>

            <c:if test="${param.msg == 'deleted'}">
                <div style="color: #b91c1c; margin-bottom: 15px; padding: 10px; background: #fee2e2; border-radius: 6px; font-weight: 600;">
                    Product deleted successfully.
                </div>
            </c:if>

            <c:if test="${param.error != null}">
                <div style="color: #b91c1c; margin-bottom: 15px; padding: 10px; background: #fee2e2; border-radius: 6px; font-weight: 600;">
                    Unable to complete that product action.
                </div>
            </c:if>

            <!-- Search section -->
            <section class="search-strip">
                <form class="search-form" action="<c:url value='/manageproducts'/>" method="get">
                    <input type="search"
                           name="q"
                           value="<c:out value='${param.q}'/>"
                           placeholder="Search products by name, category, or keyword...">
                    <button type="submit" aria-label="Search"></button>
                </form>
            </section>

            <!-- Product cards -->
            <section class="product-grid">

                <c:forEach var="product" items="${products}">

                    <c:choose>
                        <c:when test="${not empty product.imagePath}">
                            <c:url var="productImageUrl" value="/${product.imagePath}" />
                        </c:when>
                        <c:otherwise>
                            <c:url var="productImageUrl" value="/assets/images/placeholder.png" />
                        </c:otherwise>
                    </c:choose>

                    <article class="product-card">

                        <!-- Product image -->
                        <div class="product-image"
                             style="background-image: url('${productImageUrl}'); background-size: cover; background-position: center; border: none;">

                            <span class="product-image-badge">
                                <c:choose>
                                    <c:when test="${not empty product.categoryName}">
                                        <c:out value="${product.categoryName}" />
                                    </c:when>
                                    <c:otherwise>
                                        Grocery
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </div>

                        <!-- Product details -->
                        <div class="product-content">
                            <h2>
                                <c:out value="${product.productName}" />
                            </h2>

                            <p style="text-transform: capitalize;">
                                <c:choose>
                                    <c:when test="${not empty product.categoryName}">
                                        <c:out value="${product.categoryName}" />
                                    </c:when>
                                    <c:otherwise>
                                        Grocery
                                    </c:otherwise>
                                </c:choose>
                            </p>

                            <strong>
                                Rs. <c:out value="${product.price}" />
                                <span>/ <c:out value="${product.unit}" /></span>
                            </strong>
                        </div>

                        <!-- Stock and status -->
                        <div class="product-footer">
                            <span>
                                Stock: <c:out value="${product.stockQuantity}" />
                            </span>

                            <span class="status-pill ${product.status == 'Active' ? 'status-success' : (product.status == 'Draft' ? 'status-warning' : 'status-danger')}">
                                <c:choose>
                                    <c:when test="${not empty product.status}">
                                        <c:out value="${product.status}" />
                                    </c:when>
                                    <c:otherwise>
                                        Draft
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </div>

                        <!-- Edit and delete actions -->
                        <div class="product-footer" style="justify-content: flex-end; border-top: none; padding-top: 0;">
                            <div class="action-group">

                                <a class="table-button"
                                   href="<c:url value='/editproduct?id=${product.id}'/>">
                                    Edit
                                </a>

                                <form action="<c:url value='/deleteproduct'/>"
                                      method="post"
                                      style="margin: 0; display: inline-block;">

                                    <input type="hidden" name="id" value="${product.id}">

                                    <button class="table-button danger"
                                            type="submit"
                                            onclick="return confirm('Are you sure you want to delete this product?');">
                                        Delete
                                    </button>
                                </form>

                            </div>
                        </div>

                    </article>
                </c:forEach>

                <!-- Empty state -->
                <c:if test="${empty products}">
                    <p style="grid-column: 1/-1; text-align: center; color: var(--text-muted); padding: 40px 0;">
                        No products found. Start by adding a new product.
                    </p>
                </c:if>

            </section>

        </main>
    </div>

</body>
</html>