<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Messages - Mero Mart</title>

    <!-- Google font for admin pages -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">

    <!-- Admin stylesheet stays outside WEB-INF -->
    <link rel="stylesheet" href="<c:url value='/assets/css/admin.css?v=20260520-contacts'/>">
</head>

<body class="admin-body">

    <div class="admin-shell">

        <!-- Admin sidebar navigation from WEB-INF -->
        <jsp:include page="/WEB-INF/pages/admin/admin-sidebar.jsp" />

        <main class="admin-main admin-main--airy">

            <!-- Page heading -->
            <section class="page-toolbar">
                <div class="page-copy">
                    <span class="eyebrow">Customer Support</span>
                    <h1>Contact Messages</h1>
                    <p>View customer messages submitted from the contact page.</p>
                </div>
            </section>

            <!-- Contact messages table -->
            <section class="panel">
                <div class="table-wrap">
                    <table class="admin-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Customer</th>
                                <th>Email</th>
                                <th>Subject</th>
                                <th>Message</th>
                                <th>Date</th>
                            </tr>
                        </thead>

                        <tbody>
                            <c:forEach var="contact" items="${contacts}">
                                <tr>
                                    <td>
                                        #<c:out value="${contact.id}" />
                                    </td>

                                    <td>
                                        <c:out value="${contact.name}" />
                                    </td>

                                    <td>
                                        <c:out value="${contact.email}" />
                                    </td>

                                    <td>
                                        <c:out value="${contact.subject}" />
                                    </td>

                                    <td style="max-width: 360px; white-space: normal; line-height: 1.6;">
                                        <c:out value="${contact.message}" />
                                    </td>

                                    <td>
                                        <c:out value="${contact.createdAt}" />
                                    </td>
                                </tr>
                            </c:forEach>

                            <c:if test="${empty contacts}">
                                <tr>
                                    <td colspan="6" style="text-align:center; padding:30px 0; color:var(--text-muted);">
                                        No contact messages found yet.
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>

                <div class="table-footer">
                    <span>Customer contact records</span>

                    <div class="pagination">
                        <button class="is-current" type="button">1</button>
                    </div>
                </div>
            </section>

        </main>
    </div>

</body>
</html>