<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Products</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value='/assets/css/admin.css?v=20260501-2'/>">
</head>
<body class="admin-body">
    <div class="admin-shell">
        <jsp:include page="admin-sidebar.jsp" />
        <main class="admin-main admin-main--airy">
            <section class="page-toolbar">
                <div class="page-copy">
                    <span class="eyebrow">Catalog Workspace</span>
                    <h1>Manage Products</h1>
                    <p>Catalog, stock, and pricing.</p>
                </div>
            </section>

            <!-- Success/Error Messages -->
            <c:if test="${param.msg == 'added'}">
                <div style="color: #00674F; margin-bottom: 15px; padding: 10px; background: #E6F0ED; border-radius: 6px;">Product added successfully!</div>
            </c:if>
            <c:if test="${param.msg == 'updated'}">
                <div style="color: #00674F; margin-bottom: 15px; padding: 10px; background: #E6F0ED; border-radius: 6px;">Product updated successfully!</div>
            </c:if>
            <c:if test="${param.msg == 'deleted'}">
                <div style="color: #b91c1c; margin-bottom: 15px; padding: 10px; background: #fee2e2; border-radius: 6px;">Product deleted successfully!</div>
            </c:if>

            <section class="search-strip">
                <form class="search-form" action="#" method="get">
                    <input type="search" placeholder="Search products by name, category, or keyword...">
                    <button type="submit" aria-label="Search"></button>
                </form>
            </section>

            <section class="product-grid">
                <!-- Looping over actual DB products -->
                <c:forEach var="product" items="${products}">
                    <article class="product-card">
                        
                        <!-- Displaying actual uploaded image -->
                        <div class="product-image" style="background-image: url('<c:url value="/${not empty product.imagePath ? product.imagePath : 'assets/images/placeholder.png'}"/>'); background-size: cover; background-position: center; border:none;">
                            <span class="product-image-badge">${product.categoryName}</span>
                        </div>
                        
                        <div class="product-content">
                            <!-- Binding model properties -->
                            <h2>${product.productName}</h2>
                            <p style="text-transform: capitalize;">${product.categoryName}</p>
                            <strong>Rs. ${product.price} <span>/ ${product.unit}</span></strong>
                        </div>
                        
                        <div class="product-footer">
                            <span>Stock: ${product.stockQuantity}</span>
                            
                            <!-- Dynamic Status Coloring -->
                            <span class="status-pill ${product.status == 'Active' ? 'status-success' : (product.status == 'Draft' ? 'status-warning' : 'status-danger')}">
                                ${product.status}
                            </span>
                        </div>

                        <!-- NEW: Edit and Delete Actions -->
                        <div class="product-footer" style="justify-content: flex-end; border-top: none; padding-top: 0;">
                            <div class="action-group">
                                <a class="table-button" href="<c:url value='/editproduct?id=${product.id}'/>">Edit</a>
                                
                                <form action="<c:url value='/deleteproduct'/>" method="post" style="margin: 0; display: inline-block;">
                                    <input type="hidden" name="id" value="${product.id}">
                                    <button class="table-button danger" type="submit" onclick="return confirm('Are you sure you want to delete this product?');">Delete</button>
                                </form>
                            </div>
                        </div>

                    </article>
                </c:forEach>
                
                <!-- Fallback if no products exist -->
                <c:if test="${empty products}">
                    <p style="grid-column: 1/-1; text-align: center; color: var(--text-muted); padding: 40px 0;">No products found. Start by adding a new product!</p>
                </c:if>
            </section>
        </main>
    </div>
</body>
</html>
