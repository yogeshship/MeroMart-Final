<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Access Denied</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="<c:url value='/assets/css/auth.css?v=20260502-1'/>">
</head>
<body class="auth-body">
    <main class="auth-shell">
        <section class="auth-panel auth-panel--narrow">
            <span class="auth-eyebrow">Access Control</span>
            <h1>Access denied</h1>
            <p>${empty deniedMessage ? 'You do not have permission to access this area.' : deniedMessage}</p>
            <div class="auth-actions">
                <a class="auth-link-button" href="<c:url value='/product'/>">Go to Storefront</a>
                <a class="auth-link-button auth-link-button--solid" href="<c:url value='/login'/>">Admin Login</a>
            </div>
        </section>
    </main>
</body>
</html>
