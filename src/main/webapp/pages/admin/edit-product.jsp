<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Product</title>
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
                    <span class="eyebrow">Inventory Update</span>
                    <h1>Edit Product</h1>
                    <p>Update details for ${product.productName}.</p>
                </div>
            </section>

            <c:if test="${param.error != null}">
                <div style="color: red; margin-bottom: 15px; padding: 10px; background: #fee2e2; border-radius: 6px;">
                    Failed to update product. Please try again.
                </div>
            </c:if>

            <section class="panel form-panel">
                <form class="product-form" action="<c:url value='/editproduct'/>" method="post" enctype="multipart/form-data">
                    
                    <!-- Hidden ID field so the database knows which product to update -->
                    <input type="hidden" name="id" value="${product.id}">

                    <div class="upload-dropzone" style="background-image: url('<c:url value="/${product.imagePath}"/>'); background-size: contain; background-repeat: no-repeat; background-position: center; background-color: #fcfcfd;">
                        <div style="background: rgba(255,255,255,0.85); padding: 20px; border-radius: 8px;">
                            <strong>Update Product Image</strong>
                            <p>Leave empty to keep the current image.</p>
                            <!-- Note: 'required' is removed here -->
                            <input type="file" name="productImage" accept="image/jpeg, image/png, image/webp" style="margin-top: 15px; cursor: pointer;">
                        </div>
                    </div>

                    <div class="form-fields">
                        <label class="field full">
                            <span>Product Name <em>*</em></span>
                            <input type="text" name="productName" value="${product.productName}" required>
                        </label>

                        <label class="field">
                            <span>Category <em>*</em></span>
                            <select name="category" required>
                                <option value="">Select category</option>
                                <c:forEach var="category" items="${categories}">
                                <!-- Select the category if it matches the product's category -->
                                    <option value="${category.id}" ${product.categoryId == category.id ? 'selected' : ''}>${empty category.label ? category.name : category.label}</option>
                                </c:forEach>
                            </select>
                        </label>

                        <label class="field">
                            <span>Price (Rs.) <em>*</em></span>
                            <input type="number" step="0.01" name="price" value="${product.price}" required>
                        </label>

                        <label class="field">
                            <span>Stock Quantity <em>*</em></span>
                            <input type="number" name="stockQuantity" value="${product.stockQuantity}" required>
                        </label>

                        <label class="field">
                            <span>Unit <em>*</em></span>
                            <select name="unit" required>
                                <option value="kg" ${product.unit == 'kg' ? 'selected' : ''}>Kilogram (kg)</option>
                                <option value="pcs" ${product.unit == 'pcs' ? 'selected' : ''}>Pieces (pcs)</option>
                                <option value="liter" ${product.unit == 'liter' ? 'selected' : ''}>Liter (L)</option>
                                <option value="packet" ${product.unit == 'packet' ? 'selected' : ''}>Packet</option>
                                <option value="dozen" ${product.unit == 'dozen' ? 'selected' : ''}>Dozen</option>
                            </select>
                        </label>

                        <label class="field full">
                            <span>Status <em>*</em></span>
                            <select name="status" required>
                                <option value="Active" ${product.status == 'Active' ? 'selected' : ''}>Active (In Stock)</option>
                                <option value="Draft" ${product.status == 'Draft' ? 'selected' : ''}>Draft (Hidden)</option>
                                <option value="Out of Stock" ${product.status == 'Out of Stock' ? 'selected' : ''}>Out of Stock</option>
                            </select>
                        </label>

                        <label class="field full">
                            <span>Description</span>
                            <textarea name="description" rows="6">${product.description}</textarea>
                        </label>
                    </div>

                    <div class="form-actions">
                        <a href="<c:url value='/admin/manageproducts'/>" class="panel-button panel-button--muted" style="text-decoration: none; padding: 10px 20px;">Cancel</a>
                        <button class="solid-button" type="submit">Update Product</button>
                    </div>
                </form>
            </section>
        </main>
    </div>
</body>
</html>
