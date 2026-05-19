<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users</title>
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
                    <span class="eyebrow">Team Access</span>
                    <h1>Manage Users</h1>
                    <p>Review access and permissions.</p>
                </div>
            </section>

            <c:if test="${param.msg == 'added'}">
                <div style="color: #00674F; margin-bottom: 15px; padding: 10px; background: #E6F0ED; border-radius: 6px;">
                    User added successfully.
                </div>
            </c:if>
            <c:if test="${param.msg == 'updated'}">
                <div style="color: #00674F; margin-bottom: 15px; padding: 10px; background: #E6F0ED; border-radius: 6px;">
                    User updated successfully.
                </div>
            </c:if>
            <c:if test="${param.msg == 'deleted'}">
                <div style="color: #b91c1c; margin-bottom: 15px; padding: 10px; background: #fee2e2; border-radius: 6px;">
                    User deleted successfully.
                </div>
            </c:if>
            <c:if test="${param.error == 'missing' || param.error == 'delete'}">
                <div style="color: #b91c1c; margin-bottom: 15px; padding: 10px; background: #fee2e2; border-radius: 6px;">
                    Unable to complete that user action.
                </div>
            </c:if>
            <c:if test="${not empty formError}">
                <div style="color: #b91c1c; margin-bottom: 15px; padding: 10px; background: #fee2e2; border-radius: 6px;">
                    ${formError}
                </div>
            </c:if>

            <section class="search-strip">
                <form class="search-form" action="<c:url value='/manageuser'/>" method="get">
                    <input type="search" name="q" value="${searchQuery}" placeholder="Search users...">
                    <button type="submit" aria-label="Search"></button>
                </form>
            </section>

            <section class="panel" style="margin-bottom: 20px;">
                <div class="panel-head">
                    <div>
                        <h2>${empty editUser.id ? 'Add User' : 'Edit User'}</h2>
                        <p class="stat-description">${empty editUser.id ? 'Create a new admin or customer account.' : 'Update account access and contact information.'}</p>
                    </div>
                </div>
                <form action="<c:url value='/manageuser'/>" method="post">
                    <input type="hidden" name="action" value="save">
                    <input type="hidden" name="userId" value="${editUser.id}">

                    <div class="form-fields">
                        <label class="field">
                            <span>Full Name <em>*</em></span>
                            <input type="text" name="fullName" value="${editUser.fullName}" placeholder="Enter full name" required>
                        </label>

                        <label class="field">
                            <span>Email <em>*</em></span>
                            <input type="email" name="email" value="${editUser.email}" placeholder="Enter email address" required>
                        </label>

                        <label class="field">
                            <span>Phone</span>
                            <input type="text" name="phone" value="${editUser.phone}" placeholder="Enter phone number">
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
                            <span>Password <c:if test="${empty editUser.id}"><em>*</em></c:if></span>
                            <input type="password" name="password" placeholder="${empty editUser.id ? 'Create a password' : 'Leave blank to keep current password'}">
                        </label>

                        <label class="field full">
                            <span>Address</span>
                            <textarea name="address" rows="4" placeholder="Add address or internal notes...">${editUser.address}</textarea>
                        </label>
                    </div>

                    <div class="form-actions">
                        <a class="panel-button panel-button--muted" href="<c:url value='/manageuser'/>">Clear</a>
                        <button class="solid-button" type="submit">${empty editUser.id ? 'Save User' : 'Update User'}</button>
                    </div>
                </form>
            </section>

            <section class="panel user-panel">
                <div class="stats-grid stats-grid--compact">
                    <c:forEach var="stat" items="${userStats}">
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
                                            <span class="avatar-pill">${user.initials}</span>
                                            <strong>${user.fullName}</strong>
                                        </div>
                                    </td>
                                    <td>${user.email}</td>
                                    <td><span class="status-pill ${user.accessClass}">${user.displayRole}</span></td>
                                    <td>${user.createdAt}</td>
                                    <td>${user.lastLogin}</td>
                                    <td>
                                        <div class="action-group">
                                            <a class="table-button" href="<c:url value='/manageuser?editId=${user.id}'/>">Edit</a>
                                            <form action="<c:url value='/manageuser'/>" method="post" style="margin: 0; display: inline-block;">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="id" value="${user.id}">
                                                <button class="table-button danger" type="submit" onclick="return confirm('Delete this user?');">Delete</button>
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

                <div class="table-footer">
                    <span>Showing ${userCount} users</span>
                    <div class="pagination">
                        <button class="is-current" type="button">1</button>
                    </div>
                </div>
            </section>
        </main>
    </div>
</body>
</html>
