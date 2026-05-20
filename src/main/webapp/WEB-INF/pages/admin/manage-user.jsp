<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users - Mero Mart</title>

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
            min-width: 120px;
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
                    <span class="eyebrow">Team Access</span>
                    <h1>Manage Users</h1>
                    <p>Review access and permissions.</p>
                </div>
            </section>

            <!-- Success and error messages -->
            <c:if test="${param.msg == 'added'}">
                <div style="color: #00674F; margin-bottom: 15px; padding: 10px; background: #E6F0ED; border-radius: 6px; font-weight: 600;">
                    User added successfully.
                </div>
            </c:if>

            <c:if test="${param.msg == 'updated'}">
                <div style="color: #00674F; margin-bottom: 15px; padding: 10px; background: #E6F0ED; border-radius: 6px; font-weight: 600;">
                    User updated successfully.
                </div>
            </c:if>

            <c:if test="${param.msg == 'deleted'}">
                <div style="color: #b91c1c; margin-bottom: 15px; padding: 10px; background: #fee2e2; border-radius: 6px; font-weight: 600;">
                    User deleted successfully.
                </div>
            </c:if>

            <c:if test="${param.error == 'missing' || param.error == 'delete'}">
                <div style="color: #b91c1c; margin-bottom: 15px; padding: 10px; background: #fee2e2; border-radius: 6px; font-weight: 600;">
                    Unable to complete that user action.
                </div>
            </c:if>

            <c:if test="${not empty formError}">
                <div style="color: #b91c1c; margin-bottom: 15px; padding: 10px; background: #fee2e2; border-radius: 6px; font-weight: 600;">
                    <c:out value="${formError}" />
                </div>
            </c:if>

            <!-- Search user -->
            <section class="search-strip">
                <form class="search-form" action="<c:url value='/manageuser'/>" method="get">
                    <input type="search"
                           name="q"
                           value="<c:out value='${searchQuery}'/>"
                           placeholder="Search users...">
                    <button type="submit" aria-label="Search"></button>
                </form>
            </section>

            <!-- Add/Edit user form -->
            <section class="panel" style="margin-bottom: 20px;">
                <div class="panel-head">
                    <div>
                        <h2>
                            <c:choose>
                                <c:when test="${empty editUser.id}">
                                    Add User
                                </c:when>
                                <c:otherwise>
                                    Edit User
                                </c:otherwise>
                            </c:choose>
                        </h2>

                        <p class="stat-description">
                            <c:choose>
                                <c:when test="${empty editUser.id}">
                                    Create a new admin or customer account.
                                </c:when>
                                <c:otherwise>
                                    Update account access and contact information.
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                </div>

                <form action="<c:url value='/manageuser'/>" method="post">
                    <input type="hidden" name="action" value="save">
                    <input type="hidden" name="userId" value="${editUser.id}">

                    <div class="form-fields">

                        <label class="field">
                            <span>Full Name <em>*</em></span>
                            <input type="text"
                                   name="fullName"
                                   value="<c:out value='${editUser.fullName}'/>"
                                   placeholder="Enter full name"
                                   required>
                        </label>

                        <label class="field">
                            <span>Email <em>*</em></span>
                            <input type="email"
                                   name="email"
                                   value="<c:out value='${editUser.email}'/>"
                                   placeholder="Enter email address"
                                   required>
                        </label>

                        <label class="field">
                            <span>Phone</span>
                            <input type="text"
                                   name="phone"
                                   value="<c:out value='${editUser.phone}'/>"
                                   placeholder="Enter phone number">
                        </label>

                        <label class="field">
                            <span>Access Level <em>*</em></span>

                            <select name="role" required>
                                <option value="">Select access level</option>
                                <option value="admin" ${editUser.role == 'admin' ? 'selected' : ''}>Admin</option>
                                <option value="customer" ${editUser.role == 'customer' ? 'selected' : ''}>Customer</option>
                            </select>
                        </label>

                        <label class="field full">
                            <span>
                                Password
                                <c:if test="${empty editUser.id}">
                                    <em>*</em>
                                </c:if>
                            </span>

                            <input type="password"
                                   name="password"
                                   placeholder="${empty editUser.id ? 'Create a password' : 'Leave blank to keep current password'}">
                        </label>

                        <label class="field full">
                            <span>Address</span>
                            <textarea name="address"
                                      rows="4"
                                      placeholder="Add address or internal notes..."><c:out value="${editUser.address}" /></textarea>
                        </label>

                    </div>

                    <div class="form-actions">
                        <a class="panel-button panel-button--muted"
                           href="<c:url value='/manageuser'/>">
                            Clear
                        </a>

                        <button class="solid-button" type="submit">
                            <c:choose>
                                <c:when test="${empty editUser.id}">
                                    Save User
                                </c:when>
                                <c:otherwise>
                                    Update User
                                </c:otherwise>
                            </c:choose>
                        </button>
                    </div>
                </form>
            </section>

            <!-- User list -->
            <section class="panel user-panel">

                <!-- User stats -->
                <div class="stats-grid stats-grid--compact">
                    <c:forEach var="stat" items="${userStats}">
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

                <!-- Users table -->
                <div class="table-wrap">
                    <table class="admin-table users-table">
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Access Level</th>
                                <th>Date Added</th>
                                <th>Last Login</th>
                                <th>Action</th>
                            </tr>
                        </thead>

                        <tbody>
                            <c:forEach var="user" items="${users}">
                                <tr>
                                    <td>
                                        <div class="user-cell">
                                            <span class="avatar-pill">
                                                <c:out value="${empty user.initials ? 'U' : user.initials}" />
                                            </span>

                                            <strong>
                                                <c:out value="${user.fullName}" />
                                            </strong>
                                        </div>
                                    </td>

                                    <td>
                                        <c:out value="${user.email}" />
                                    </td>

                                    <td>
                                        <span class="status-pill ${user.accessClass}">
                                            <c:out value="${user.displayRole}" />
                                        </span>
                                    </td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty user.createdAt}">
                                                <c:out value="${user.createdAt}" />
                                            </c:when>
                                            <c:otherwise>
                                                Not available
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty user.lastLogin}">
                                                <c:out value="${user.lastLogin}" />
                                            </c:when>
                                            <c:otherwise>
                                                Never
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td>
                                        <div class="action-group">
                                            <a class="table-button"
                                               href="<c:url value='/manageuser?editId=${user.id}'/>">
                                                Edit
                                            </a>

                                            <form action="<c:url value='/manageuser'/>"
                                                  method="post"
                                                  style="margin: 0; display: inline-block;">

                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="id" value="${user.id}">

                                                <button class="table-button danger"
                                                        type="submit"
                                                        onclick="return confirm('Delete this user?');">
                                                    Delete
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>

                            <c:if test="${empty users}">
                                <tr>
                                    <td colspan="6" style="text-align: center; color: var(--text-muted); padding: 30px 0;">
                                        No users found yet. Add the first account from the form above.
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>

                <!-- Table footer -->
                <div class="table-footer">
                    <span>
                        Showing <c:out value="${userCount}" /> users
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