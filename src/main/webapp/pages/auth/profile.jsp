<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Settings</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="<c:url value='/assets/css/admin.css?v=20260501-2'/>">
</head>
<body class="admin-body">
    <div class="admin-shell">
        <jsp:include page="/pages/admin/admin-sidebar.jsp" />
        <main class="admin-main admin-main--airy">
            <section class="page-toolbar">
                <div class="page-copy">
                    <span class="eyebrow">Account Settings</span>
                    <h1>Profile</h1>
                    <p>Review the active session and account details.</p>
                </div>
            </section>

            <section class="panel" style="max-width: 760px;">
                <div class="panel-head">
                    <div>
                        <h2>Signed-in account</h2>
                        <p class="stat-description">This page confirms the authenticated admin session.</p>
                    </div>
                </div>
                <div class="form-fields">
                    <div class="field">
                        <span>Full Name</span>
                        <input type="text" value="${profileUser.fullName}" readonly>
                    </div>
                    <div class="field">
                        <span>Email</span>
                        <input type="text" value="${profileUser.email}" readonly>
                    </div>
                    <div class="field">
                        <span>Access Level</span>
                        <input type="text" value="${profileUser.displayRole}" readonly>
                    </div>
                    <div class="field">
                        <span>Phone</span>
                        <input type="text" value="${empty profileUser.phone ? '-' : profileUser.phone}" readonly>
                    </div>
                    <div class="field full">
                        <span>Address</span>
                        <textarea rows="4" readonly>${empty profileUser.address ? '-' : profileUser.address}</textarea>
                    </div>
                </div>
                <div class="form-actions">
                    <a class="panel-button panel-button--muted" href="<c:url value='/admindashboard'/>">Back to Dashboard</a>
                    <a class="solid-button" href="<c:url value='/logout'/>">Log Out</a>
                </div>
            </section>
        </main>
    </div>
</body>
</html>
