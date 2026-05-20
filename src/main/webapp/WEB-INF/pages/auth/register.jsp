<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Mero Mart</title>

    <!-- Google font for authentication pages -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">

    <!-- Authentication page CSS stays outside WEB-INF -->
    <link rel="stylesheet" href="<c:url value='/assets/css/auth.css?v=20260520-1'/>">
</head>

<body class="auth-body">

    <!-- Main authentication layout -->
    <main class="auth-shell">

        <!-- Register information card -->
        <section class="auth-panel auth-panel--narrow">

            <!-- Page heading -->
            <span class="auth-eyebrow">Account Setup</span>

            <h1>Registration is managed by admin</h1>

            <p>
                For this coursework build, new accounts should be created from the admin
                Manage Users page.
            </p>

            <!-- Navigation buttons use servlet URLs -->
            <div class="auth-action-row">
                <a class="auth-link-button" href="<c:url value='/login'/>">
                    Back to Login
                </a>

                <a class="auth-link-button" href="<c:url value='/home'/>">
                    Back to Home
                </a>
            </div>

        </section>
    </main>

</body>
</html>