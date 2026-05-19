<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Product - Mero Mart</title>

    <!-- Google font for admin pages -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">

    <!-- Admin stylesheet -->
    <link rel="stylesheet" href="<c:url value='/assets/css/admin.css?v=20260501-2'/>">
</head>

<body class="admin-body">

    <div class="admin-shell">

        <!-- Admin sidebar navigation -->
        <jsp:include page="admin-sidebar.jsp" />

        <main class="admin-main admin-main--airy">

            <!-- Page heading -->
            <section class="page-toolbar">
                <div class="page-copy">
                    <span class="eyebrow">Inventory Entry</span>
                    <h1>Add Product</h1>
                    <p>Create a new product item for the Mero Mart catalog.</p>
                </div>
            </section>

            <!-- Error message shown from AddProductServlet -->
            <c:if test="${not empty formError}">
                <div style="color: #991b1b; margin-bottom: 15px; padding: 12px 14px; background: #fee2e2; border: 1px solid #fecaca; border-radius: 8px; font-weight: 600;">
                    <c:out value="${formError}" />
                </div>
            </c:if>

            <!-- Product add form -->
            <section class="panel form-panel">

                <!-- enctype is required for product image upload -->
                <form class="product-form"
                      action="<c:url value='/addproduct'/>"
                      method="post"
                      enctype="multipart/form-data">

                    <!-- Product image upload section -->
                    <div class="upload-dropzone">
                        <div class="upload-icon"></div>

                        <strong>Upload Product Image</strong>

                        <p>
                            Drag and drop an image here,<br>
                            or click to browse
                        </p>

                        <span>Recommended size: 800x800px</span>
                        <span>Max file size: 5MB (JPG, PNG, WebP)</span>

                        <input type="file"
                               name="productImage"
                               accept="image/jpeg, image/png, image/webp"
                              
                               style="margin-top: 15px; cursor: pointer;">
                    </div>

                    <!-- Product input fields -->
                    <div class="form-fields">

                        <!-- Product name -->
                        <label class="field full">
                            <span>Product Name <em>*</em></span>
                            <input type="text"
                                   name="productName"
                                   placeholder="Enter product name"
                                   required>
                        </label>

                        <!-- Category dropdown -->
                        <label class="field">
                            <span>Category <em>*</em></span>

                            <select name="category" required>
                                <option value="">Select category</option>

                                <c:forEach var="category" items="${categories}">
                                    <option value="${category.id}">
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
                                   placeholder="Enter price"
                                   required>
                        </label>

                        <!-- Stock quantity -->
                        <label class="field">
                            <span>Stock Quantity <em>*</em></span>
                            <input type="number"
                                   min="0"
                                   name="stockQuantity"
                                   placeholder="Enter stock quantity"
                                   required>
                        </label>

                        <!-- Unit -->
                        <label class="field">
                            <span>Unit <em>*</em></span>

                            <select name="unit" required>
                                <option value="">Select unit</option>
                                <option value="kg">Kilogram (kg)</option>
                                <option value="g">Gram (g)</option>
                                <option value="pcs">Pieces (pcs)</option>
                                <option value="liter">Liter (L)</option>
                                <option value="packet">Packet</option>
                                <option value="dozen">Dozen</option>
                            </select>
                        </label>

                        <!-- Status -->
                        <label class="field full">
                            <span>Status <em>*</em></span>

                            <select name="status" required>
                                <option value="">Select status</option>
                                <option value="Active">Active (In Stock)</option>
                                <option value="Draft">Draft (Hidden)</option>
                                <option value="Out of Stock">Out of Stock</option>
                            </select>
                        </label>

                        <!-- Description -->
                        <label class="field full">
                            <span>Description</span>
                            <textarea name="description"
                                      rows="6"
                                      placeholder="Enter product description..."></textarea>
                        </label>

                    </div>

                    <!-- Form buttons -->
                    <div class="form-actions">
                        <button class="panel-button panel-button--muted" type="reset">
                            Reset
                        </button>

                        <button class="solid-button" type="submit">
                            Save Product
                        </button>
                    </div>

                </form>
            </section>

        </main>
    </div>

</body>
</html>