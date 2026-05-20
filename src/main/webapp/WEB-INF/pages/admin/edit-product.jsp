<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:url var="currentImage" value="/${product.imagePath}" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Product - Mero Mart</title>

    <!-- Google font for admin pages -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">

    <!-- Admin stylesheet stays outside WEB-INF -->
    <link rel="stylesheet" href="<c:url value='/assets/css/admin.css?v=20260520-1'/>">

    <!-- Small page-level fix for equal button sizes -->
    <style>
        .form-actions {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 12px;
        }

        .form-actions .panel-button,
        .form-actions .solid-button {
            min-width: 140px;
            height: 48px;
            padding: 0 20px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            line-height: 1;
            text-decoration: none;
        }

        .current-image-box {
            background-size: contain;
            background-repeat: no-repeat;
            background-position: center;
            background-color: #fcfcfd;
        }

        .current-image-overlay {
            background: rgba(255, 255, 255, 0.88);
            padding: 20px;
            border-radius: 10px;
        }
    </style>
</head>

<body class="admin-body">

    <div class="admin-shell">

        <!-- Admin sidebar navigation from WEB-INF -->
        <jsp:include page="/WEB-INF/pages/admin/admin-sidebar.jsp" />

        <main class="admin-main admin-main--airy">

            <!-- Page heading -->
            <section class="page-toolbar">
                <div class="page-copy">
                    <span class="eyebrow">Inventory Update</span>
                    <h1>Edit Product</h1>
                    <p>
                        Update details for
                        <c:out value="${product.productName}" />.
                    </p>
                </div>
            </section>

            <!-- Error message from redirect parameter -->
            <c:if test="${param.error != null}">
                <div style="color: #991b1b; margin-bottom: 15px; padding: 12px 14px; background: #fee2e2; border: 1px solid #fecaca; border-radius: 8px; font-weight: 600;">
                    Failed to update product. Please try again.
                </div>
            </c:if>

            <!-- Product edit form -->
            <section class="panel form-panel">

                <form class="product-form"
                      action="<c:url value='/editproduct'/>"
                      method="post"
                      enctype="multipart/form-data">

                    <!-- Hidden product ID tells servlet which product to update -->
                    <input type="hidden" name="id" value="${product.id}">

                    <!-- Product image update section -->
                    <div class="upload-dropzone current-image-box"
                         style="background-image: url('${currentImage}');">

                        <div class="current-image-overlay">
                            <strong>Update Product Image</strong>

                            <p>
                                Leave this empty if you want to keep the current image.
                            </p>

                            <span>Max file size: 5MB (JPG, PNG, WebP)</span>

                            <input type="file"
                                   name="productImage"
                                   accept="image/jpeg, image/png, image/webp"
                                   style="margin-top: 15px; cursor: pointer;">
                        </div>
                    </div>

                    <!-- Product input fields -->
                    <div class="form-fields">

                        <!-- Product name -->
                        <label class="field full">
                            <span>Product Name <em>*</em></span>
                            <input type="text"
                                   name="productName"
                                   value="<c:out value='${product.productName}'/>"
                                   required>
                        </label>

                        <!-- Category -->
                        <label class="field">
                            <span>Category <em>*</em></span>

                            <select name="category" required>
                                <option value="">Select category</option>

                                <c:forEach var="category" items="${categories}">
                                    <option value="${category.id}" ${product.categoryId == category.id ? 'selected' : ''}>
                                        <c:choose>
                                            <c:when test="${not empty category.label}">
                                                <c:out value="${category.label}" />
                                            </c:when>
                                            <c:otherwise>
                                                <c:out value="${category.name}" />
                                            </c:otherwise>
                                        </c:choose>
                                    </option>
                                </c:forEach>
                            </select>
                        </label>

                        <!-- Price -->
                        <label class="field">
                            <span>Price (Rs.) <em>*</em></span>
                            <input type="number"
                                   step="0.01"
                                   min="0"
                                   name="price"
                                   value="${product.price}"
                                   required>
                        </label>

                        <!-- Stock quantity -->
                        <label class="field">
                            <span>Stock Quantity <em>*</em></span>
                            <input type="number"
                                   min="0"
                                   name="stockQuantity"
                                   value="${product.stockQuantity}"
                                   required>
                        </label>

                        <!-- Unit -->
                        <label class="field">
                            <span>Unit <em>*</em></span>

                            <select name="unit" required>
                                <option value="kg" ${product.unit == 'kg' ? 'selected' : ''}>Kilogram (kg)</option>
                                <option value="g" ${product.unit == 'g' ? 'selected' : ''}>Gram (g)</option>
                                <option value="pcs" ${product.unit == 'pcs' ? 'selected' : ''}>Pieces (pcs)</option>
                                <option value="liter" ${product.unit == 'liter' ? 'selected' : ''}>Liter (L)</option>
                                <option value="packet" ${product.unit == 'packet' ? 'selected' : ''}>Packet</option>
                                <option value="dozen" ${product.unit == 'dozen' ? 'selected' : ''}>Dozen</option>
                            </select>
                        </label>

                        <!-- Status -->
                        <label class="field full">
                            <span>Status <em>*</em></span>

                            <select name="status" required>
                                <option value="Active" ${product.status == 'Active' ? 'selected' : ''}>Active (In Stock)</option>
                                <option value="Draft" ${product.status == 'Draft' ? 'selected' : ''}>Draft (Hidden)</option>
                                <option value="Out of Stock" ${product.status == 'Out of Stock' ? 'selected' : ''}>Out of Stock</option>
                            </select>
                        </label>

                        <!-- Description -->
                        <label class="field full">
                            <span>Description</span>
                            <textarea name="description"
                                      rows="6"><c:out value="${product.description}" /></textarea>
                        </label>

                    </div>

                    <!-- Form buttons -->
                    <div class="form-actions">
                        <a href="<c:url value='/manageproducts'/>"
                           class="panel-button panel-button--muted">
                            Cancel
                        </a>

                        <button class="solid-button" type="submit">
                            Update Product
                        </button>
                    </div>

                </form>
            </section>

        </main>
    </div>

</body>
</html>