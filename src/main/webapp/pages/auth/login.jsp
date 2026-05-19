<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login - Mero Mart</title>

<!-- Google font for authentication pages -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">

<!-- Authentication page CSS -->
<link rel="stylesheet" href="<c:url value='/assets/css/auth.css?v=20260502-1'/>">
</head>

<body class="auth-body">

    <!-- Main authentication layout -->
    <main class="auth-shell">

        <!-- Login card -->
        <section class="auth-panel">

            <!-- Back to home link -->
            <a class="auth-back-home" href="<c:url value='/home'/>">Back to Home</a>

            <!-- Login heading -->
            <div class="auth-brand">
                <div>
                    <span class="auth-eyebrow">Account Access</span>
                    <h1>Welcome back</h1>
                    <p>Sign in to continue using the Mero Mart system.</p>
                </div>
            </div>

            <!-- Logout success message -->
            <c:if test="${param.logout == '1'}">
                <div class="auth-alert auth-alert--success">
                    You have been logged out successfully.
                </div>
            </c:if>

            <!-- First admin account notice -->
            <c:if test="${bootstrapMode}">
                <div class="auth-alert auth-alert--info">
                    No admin account exists yet. You can create the first one from
                    <a href="<c:url value='/manageuser'/>">Manage Users</a>.
                </div>
            </c:if>

            <!-- Login error message -->
            <c:if test="${not empty loginError}">
                <div class="auth-alert auth-alert--error">
                    ${loginError}
                </div>
            </c:if>

            <!-- Login form -->
            <form class="auth-form" action="<c:url value='/login'/>" method="post">

                <!-- Email input -->
                <label class="auth-field">
                    <span>Email</span>
                    <input type="email"
                           name="email"
                           value="${not empty submittedEmail ? submittedEmail : rememberedEmail}"
                           placeholder="Enter your email"
                           required>
                </label>

                <!-- Password input -->
                <label class="auth-field">
                    <span>Password</span>
                    <input type="password"
                           name="password"
                           placeholder="Enter your password"
                           required>
                </label>

                <!-- Submit button -->
                <button class="auth-button" type="submit">Sign In</button>

                <!-- Register link -->
                <p class="auth-switch">
                    Don't have an account?
                    <a href="<c:url value='/register'/>">Create Account</a>
                </p>
            </form>

            <!-- Extra information -->
            <div class="auth-meta">
                <span>Secure login with session-based access control.</span>
            </div>

        </section>
    </main>

</body>
</html>