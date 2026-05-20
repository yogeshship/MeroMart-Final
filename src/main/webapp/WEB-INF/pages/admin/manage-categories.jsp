<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Categories - Mero Mart</title>

    <!-- Google font for admin pages -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">

    <!-- Admin stylesheet stays outside WEB-INF -->
    <link rel="stylesheet" href="<c:url value='/assets/css/admin.css?v=20260520-1'/>">

    <!-- Small page-level fix for equal form buttons -->
    <style>
        .form-actions {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 12px;
        }

        .form-actions .panel-button,
        .form-actions .solid-button {
            min-width: 130px;
            height: 48px;
            padding: 0 20px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            line-height: 1;
            text-decoration: none;
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
                    <span class="eyebrow">Store Structure</span>
                    <h1>Manage Categories</h1>
                    <p>Organize the storefront taxonomy.</p>
                </div>
            </section>

            <!-- Success and error messages -->
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
                    <c:out value="${formError}" />
                </div>
            </c:if>

            <!-- Search category -->
            <section class="search-strip">
                <form class="search-form" action="<c:url value='/managecategory'/>" method="get">
                    <input type="search"
                           name="q"
                           value="<c:out value='${searchQuery}'/>"
                           placeholder="Search categories...">
                    <button type="submit" aria-label="Search"></button>
                </form>
            </section>

            <!-- Add/Edit category form -->
            <section class="panel" style="margin-bottom: 20px;">
                <div class="panel-head">
                    <div>
                        <h2>
                            <c:choose>
                                <c:when test="${empty editCategory}">
                                    Add Category
                                </c:when>
                                <c:otherwise>
                                    Edit Category
                                </c:otherwise>
                            </c:choose>
                        </h2>

                        <p class="stat-description">
                            <c:choose>
                                <c:when test="${empty editCategory}">
                                    Create a new category for the store catalog.
                                </c:when>
                                <c:otherwise>
                                    Update the selected category details.
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                </div>

                <form action="<c:url value='/managecategory'/>" method="post">
                    <input type="hidden" name="action" value="save">
                    <input type="hidden" name="categoryId" value="${editCategory.id}">

                    <div class="form-fields">

                        <label class="field">
                            <span>Category Name <em>*</em></span>
                            <input type="text"
                                   name="categoryName"
                                   value="<c:out value='${editCategory.name}'/>"
                                   placeholder="Enter category name"
                                   required>
                        </label>

                        <label class="field full">
                            <span>Description</span>
                            <textarea name="description"
                                      rows="4"
                                      placeholder="Add a short description for this category..."><c:out value="${editCategory.description}" /></textarea>
                        </label>

                    </div>

                    <div class="form-actions">
                        <a class="panel-button panel-button--muted"
                           href="<c:url value='/managecategory'/>">
                            Clear
                        </a>

                        <button class="solid-button" type="submit">
                            <c:choose>
                                <c:when test="${empty editCategory}">
                                    Save Category
                                </c:when>
                                <c:otherwise>
                                    Update Category
                                </c:otherwise>
                            </c:choose>
                        </button>
                    </div>
                </form>
            </section>

            <!-- Category list -->
            <section class="panel">

                <!-- Category stats -->
                <div class="stats-grid stats-grid--compact">
                    <c:forEach var="stat" items="${categoryStats}">
                        <article class="stat-card stat-card--compact">
                            <div class="stat-icon icon-${stat.icon}"></div>

                            <div class="stat-copy">
                                <span class="stat-title">
                                    <c:out value="${stat.title}" />
                                </span>

                                <strong class="stat-value">
                                    <c:out value="${stat.value}" />
                                </strong>

                                <p class="stat-description">
                                    <c:out value="${stat.description}" />
                                </p>
                            </div>
                        </article>
                    </c:forEach>
                </div>

                <!-- Categories table -->
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
                                            <span class="category-badge">
                                                <c:out value="${category.icon}" />
                                            </span>

                                            <strong>
                                                <c:out value="${category.name}" />
                                            </strong>
                                        </div>
                                    </td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${empty category.description}">
                                                No description added yet.
                                            </c:when>
                                            <c:otherwise>
                                                <c:out value="${category.description}" />
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td>
                                        <c:out value="${category.productCount}" />
                                    </td>

                                    <td>
                                        <span class="status-pill ${category.statusClass}">
                                            <c:out value="${category.status}" />
                                        </span>
                                    </td>

                                    <td>
                                        <div class="action-group">
                                            <a class="table-button"
                                               href="<c:url value='/managecategory?editId=${category.id}'/>">
                                                Edit
                                            </a>

                                            <form action="<c:url value='/managecategory'/>"
                                                  method="post"
                                                  style="margin: 0; display: inline-block;">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="id" value="${category.id}">

                                                <button class="table-button danger"
                                                        type="submit"
                                                        onclick="return confirm('Delete this category?');">
                                                    Delete
                                                </button>
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

                <!-- Table footer -->
                <div class="table-footer">
                    <span>
                        Showing <c:out value="${categoryCount}" /> categories
                    </span>

                    <div class="pagination">
                        <button class="is-current" type="button">1</button>
                    </div>
                </div>

            </section>

        </main>
    </div>

</body>
</html>