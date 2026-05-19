<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Categories</title>
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
                    <span class="eyebrow">Store Structure</span>
                    <h1>Manage Categories</h1>
                    <p>Organize the storefront taxonomy.</p>
                </div>
            </section>

            <c:if test="${param.msg == 'added'}">
                <div style="color: #00674F; margin-bottom: 15px; padding: 10px; background: #E6F0ED; border-radius: 6px;">
                    Category added successfully.
                </div>
            </c:if>
            <c:if test="${param.msg == 'updated'}">
                <div style="color: #00674F; margin-bottom: 15px; padding: 10px; background: #E6F0ED; border-radius: 6px;">
                    Category updated successfully.
                </div>
            </c:if>
            <c:if test="${param.msg == 'deleted'}">
                <div style="color: #b91c1c; margin-bottom: 15px; padding: 10px; background: #fee2e2; border-radius: 6px;">
                    Category deleted successfully.
                </div>
            </c:if>
            <c:if test="${param.error == 'linked'}">
                <div style="color: #b45309; margin-bottom: 15px; padding: 10px; background: #fef3c7; border-radius: 6px;">
                    This category cannot be deleted because products are still linked to it.
                </div>
            </c:if>
            <c:if test="${param.error == 'delete' || param.error == 'missing'}">
                <div style="color: #b91c1c; margin-bottom: 15px; padding: 10px; background: #fee2e2; border-radius: 6px;">
                    Unable to complete that category action.
                </div>
            </c:if>
            <c:if test="${not empty formError}">
                <div style="color: #b91c1c; margin-bottom: 15px; padding: 10px; background: #fee2e2; border-radius: 6px;">
                    ${formError}
                </div>
            </c:if>

            <section class="search-strip">
                <form class="search-form" action="<c:url value='/managecategory'/>" method="get">
                    <input type="search" name="q" value="${searchQuery}" placeholder="Search categories...">
                    <button type="submit" aria-label="Search"></button>
                </form>
            </section>

            <section class="panel" style="margin-bottom: 20px;">
                <div class="panel-head">
                    <div>
                        <h2>${empty editCategory ? 'Add Category' : 'Edit Category'}</h2>
                        <p class="stat-description">${empty editCategory ? 'Create a new category for the store catalog.' : 'Update the selected category details.'}</p>
                    </div>
                </div>
                <form action="<c:url value='/managecategory'/>" method="post">
                    <input type="hidden" name="action" value="save">
                    <input type="hidden" name="categoryId" value="${editCategory.id}">

                    <div class="form-fields">
                        <label class="field">
                            <span>Category Name <em>*</em></span>
                            <input type="text" name="categoryName" value="${editCategory.name}" placeholder="Enter category name" required>
                        </label>

                        <label class="field full">
                            <span>Description</span>
                            <textarea name="description" rows="4" placeholder="Add a short description for this category...">${editCategory.description}</textarea>
                        </label>
                    </div>

                    <div class="form-actions">
                        <a class="panel-button panel-button--muted" href="<c:url value='/managecategory'/>">Clear</a>
                        <button class="solid-button" type="submit">${empty editCategory ? 'Save Category' : 'Update Category'}</button>
                    </div>
                </form>
            </section>

            <section class="panel">
                <div class="stats-grid stats-grid--compact">
                    <c:forEach var="stat" items="${categoryStats}">
                        <article class="stat-card stat-card--compact">
                            <div class="stat-icon icon-${stat.icon}"></div>
                            <div class="stat-copy">
                                <span class="stat-title">${stat.title}</span>
                                <strong class="stat-value">${stat.value}</strong>
                                <p class="stat-description">${stat.description}</p>
                            </div>
                        </article>
                    </c:forEach>
                </div>

                <div class="table-wrap">
                    <table class="admin-table">
                        <thead>
                            <tr>
                                <th>Category Name</th>
                                <th>Description</th>
                                <th>Products</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="category" items="${categories}">
                                <tr>
                                    <td>
                                        <div class="category-cell">
                                            <span class="category-badge">${category.icon}</span>
                                            <strong>${category.name}</strong>
                                        </div>
                                    </td>
                                    <td>${empty category.description ? 'No description added yet.' : category.description}</td>
                                    <td>${category.productCount}</td>
                                    <td><span class="status-pill ${category.statusClass}">${category.status}</span></td>
                                    <td>
                                        <div class="action-group">
                                            <a class="table-button" href="<c:url value='/managecategory?editId=${category.id}'/>">Edit</a>
                                            <form action="<c:url value='/managecategory'/>" method="post" style="margin: 0; display: inline-block;">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="id" value="${category.id}">
                                                <button class="table-button danger" type="submit" onclick="return confirm('Delete this category?');">Delete</button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>

                            <c:if test="${empty categories}">
                                <tr>
                                    <td colspan="5" style="text-align: center; color: var(--text-muted); padding: 30px 0;">
                                        No categories matched your search yet.
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>

                <div class="table-footer">
                    <span>Showing ${categoryCount} categories</span>
                    <div class="pagination">
                        <button class="is-current" type="button">1</button>
                    </div>
                </div>
            </section>
        </main>
    </div>
</body>
</html>
