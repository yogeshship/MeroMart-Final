<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Mero Mart</title>

    <!-- Google fonts used by the user-side layout -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@600;700&family=Manrope:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <!-- Main user-side CSS stays outside WEB-INF -->
    <link rel="stylesheet" href="<c:url value='/assets/css/user.css'/>">

    <!-- Custom CSS for About and Contact pages stays outside WEB-INF -->
    <link rel="stylesheet" href="<c:url value='/assets/css/yogesh-style.css'/>">
</head>

<body class="user-body">

    <!-- Public user-side navbar from WEB-INF -->
    <jsp:include page="/WEB-INF/pages/common/navbar.jsp" />

    <!-- Contact page content -->
    <main class="u-page">
        <div class="u-container">

            <!-- Page heading -->
            <section class="common-page-head">
                <span class="catalog-eyebrow">Customer Support</span>

                <h1>Contact Mero Mart</h1>

                <p class="u-subtitle">
                    Send us your product enquiries, delivery questions, and support messages.
                </p>
            </section>

            <!-- Main contact layout -->
            <section class="contact-public-grid">

                <!-- Contact form card -->
                <div class="contact-public-card">
                    <h2>Send us a message</h2>

                    <p>
                        Fill in the form below and the Mero Mart support team will review your message.
                    </p>

                    <!-- Error message from ContactServlet -->
                    <c:if test="${not empty errorMessage}">
                        <div class="error-message">
                            <c:out value="${errorMessage}" />
                        </div>
                    </c:if>

                    <!-- Contact form submits to ContactServlet -->
                    <form action="<c:url value='/contact'/>" method="post" class="contact-form">

                        <label>Full Name *</label>
                        <input type="text"
                               name="name"
                               placeholder="Enter full name"
                               required>

                        <label>Email *</label>
                        <input type="email"
                               name="email"
                               placeholder="Enter email address"
                               required>

                        <label>Subject *</label>
                        <input type="text"
                               name="subject"
                               placeholder="Enter message subject"
                               required>

                        <label>Message *</label>
                        <textarea name="message"
                                  placeholder="Enter your message..."
                                  required></textarea>

                        <div class="button-row">
                            <button type="submit" class="u-btn u-btn--primary">
                                Send Message
                            </button>

                            <!-- Success message from ContactServlet -->
                            <c:if test="${not empty successMessage}">
                                <span class="inline-success">
                                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                                        <path d="M20 6L9 17l-5-5"></path>
                                    </svg>

                                    <c:out value="${successMessage}" />
                                </span>
                            </c:if>
                        </div>
                    </form>
                </div>

                <!-- Right side cards -->
                <aside class="contact-side-panel">

                    <!-- Contact information card -->
                    <div class="contact-info-card">
                        <h2>Contact Information</h2>

                        <div class="contact-info-item">
                            <strong>Location</strong>
                            <span>Kathmandu, Nepal</span>
                        </div>

                        <div class="contact-info-item">
                            <strong>Email</strong>
                            <span>support@meromart.com</span>
                        </div>

                        <div class="contact-info-item">
                            <strong>Phone</strong>
                            <span>+977 9800000000</span>
                        </div>
                    </div>

                    <!-- Support notice card -->
                    <div class="contact-info-card">
                        <h2>Support Notice</h2>

                        <p>
                            Customer messages are stored securely in the contact_messages table
                            for future review and response.
                        </p>

                        <span class="public-badge">Stored in Database</span>
                    </div>

                </aside>
            </section>

            <!-- Support categories -->
            <section class="support-public-card">
                <h2>Support Categories</h2>

                <div class="support-public-grid">
                    <div class="support-public-item">Order Help</div>
                    <div class="support-public-item">Product Enquiry</div>
                    <div class="support-public-item">Delivery Support</div>
                </div>
            </section>

        </div>
    </main>

    <!-- Public user-side footer from WEB-INF -->
    <jsp:include page="/WEB-INF/pages/common/footer.jsp" />

</body>
</html>