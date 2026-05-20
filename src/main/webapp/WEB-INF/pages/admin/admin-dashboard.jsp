<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Mero Mart</title>

    <!-- Google font for admin pages -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">

    <!-- Admin stylesheet stays outside WEB-INF -->
    <link rel="stylesheet" href="<c:url value='/assets/css/admin.css?v=20260520-1'/>">
</head>

<body class="admin-body">

    <div class="admin-shell">

        <!-- Admin sidebar navigation from WEB-INF -->
        <jsp:include page="/WEB-INF/pages/admin/admin-sidebar.jsp" />

        <main class="admin-main admin-main--dashboard">

            <!-- Dashboard heading -->
            <section class="page-toolbar page-toolbar--dashboard">
                <div class="page-copy">
                    <span class="eyebrow">Admin Dashboard</span>
                    <h1>Hello, Admin.</h1>
                    <p>Today at a glance.</p>
                </div>

                <div class="toolbar-actions">
                    <button class="date-pill" type="button">May 21, 2025</button>
                </div>
            </section>

            <!-- Dashboard statistics -->
            <section class="stats-grid stats-grid--dashboard">

                <c:forEach var="stat" items="${dashboardStats}">
                    <article class="stat-card">
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

                            <c:if test="${not empty stat.trend}">
                                <span class="stat-trend ${stat.trendType eq 'positive' ? 'positive' : 'neutral'}">
                                    <c:out value="${stat.trend}" />
                                </span>
                            </c:if>

                            <c:if test="${not empty stat.cta}">
                                <a class="inline-link" href="<c:url value='/manageproducts'/>">
                                    <c:out value="${stat.cta}" />
                                </a>
                            </c:if>
                        </div>
                    </article>
                </c:forEach>

            </section>

            <!-- Dashboard middle section -->
            <section class="dashboard-grid">

                <!-- Sales overview -->
                <article class="panel sales-panel">
                    <div class="panel-head">
                        <div>
                            <h2>Sales Overview</h2>
                            <p>May 15 - May 21</p>
                        </div>

                        <button class="ghost-select" type="button">This Week</button>
                    </div>

                    <div class="sales-layout">

                        <div class="sales-summary">
                            <c:forEach var="card" items="${salesOverviewCards}">
                                <div class="mini-card ${card.featured ? 'featured' : ''}">
                                    <span>
                                        <c:out value="${card.label}" />
                                    </span>

                                    <strong>
                                        <c:out value="${card.value}" />
                                    </strong>

                                    <em>
                                        <c:out value="${card.trend}" />
                                    </em>
                                </div>
                            </c:forEach>
                        </div>

                        <div class="chart-card">
                            <div class="chart-grid">
                                <span>20K</span>
                                <span>15K</span>
                                <span>10K</span>
                                <span>5K</span>
                                <span>0</span>
                            </div>

                            <svg class="sales-chart" viewBox="0 0 520 250" preserveAspectRatio="none" aria-label="Sales chart">
                                <defs>
                                    <linearGradient id="chart-fill" x1="0" x2="0" y1="0" y2="1">
                                        <stop offset="0%" stop-color="#0d8b61" stop-opacity="0.18"></stop>
                                        <stop offset="100%" stop-color="#0d8b61" stop-opacity="0"></stop>
                                    </linearGradient>
                                </defs>

                                <path d="M20 195 L100 140 L180 78 L260 145 L340 104 L420 118 L500 28 L500 220 L20 220 Z"
                                      fill="url(#chart-fill)"></path>

                                <polyline points="20,195 100,140 180,78 260,145 340,104 420,118 500,28"
                                          fill="none"
                                          stroke="#0d8b61"
                                          stroke-width="4"
                                          stroke-linecap="round"
                                          stroke-linejoin="round"></polyline>

                                <g class="chart-points">
                                    <circle cx="20" cy="195" r="6"></circle>
                                    <circle cx="100" cy="140" r="6"></circle>
                                    <circle cx="180" cy="78" r="6"></circle>
                                    <circle cx="260" cy="145" r="6"></circle>
                                    <circle cx="340" cy="104" r="6"></circle>
                                    <circle cx="420" cy="118" r="6"></circle>
                                    <circle cx="500" cy="28" r="6"></circle>
                                </g>
                            </svg>

                            <div class="chart-labels">
                                <c:forEach var="point" items="${salesChartPoints}">
                                    <span>
                                        <c:out value="${point.label}" />
                                    </span>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </article>

                <!-- Quick insights -->
                <article class="panel insight-panel">
                    <h2>Quick Insights</h2>

                    <div class="insight-list">
                        <c:forEach var="insight" items="${quickInsights}">
                            <div class="insight-item">
                                <span class="insight-icon icon-${insight.icon}"></span>

                                <div>
                                    <small>
                                        <c:out value="${insight.label}" />
                                    </small>

                                    <strong>
                                        <c:out value="${insight.value}" />
                                    </strong>
                                </div>

                                <em>
                                    <c:out value="${insight.meta}" />
                                </em>
                            </div>
                        </c:forEach>
                    </div>
                </article>

            </section>

            <!-- Dashboard bottom section -->
            <section class="dashboard-bottom">

                <!-- Stock overview -->
                <article class="panel stock-panel">
                    <h2>Stock Overview</h2>

                    <div class="stock-layout">
                        <div class="stock-ring">
                            <div class="ring-center">
                                <strong>128</strong>
                                <span>Total Items</span>
                            </div>
                        </div>

                        <div class="stock-legend">
                            <c:forEach var="segment" items="${stockSegments}">
                                <div class="legend-row">
                                    <span class="legend-dot ${segment.color}"></span>

                                    <span>
                                        <c:out value="${segment.name}" />
                                    </span>

                                    <strong>
                                        <c:out value="${segment.count}" /> 
                                        (<c:out value="${segment.percentage}" />)
                                    </strong>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <a class="panel-button" href="<c:url value='/manageproducts'/>">
                        View Stock Report
                    </a>
                </article>

                <!-- Latest activity -->
                <article class="panel activity-panel">
                    <h2>Latest Activity</h2>

                    <div class="activity-list">
                        <c:forEach var="activity" items="${latestActivities}">
                            <div class="activity-item">
                                <span class="activity-icon icon-${activity.icon}"></span>

                                <div>
                                    <strong>
                                        <c:out value="${activity.title}" />
                                    </strong>

                                    <small>
                                        <c:out value="${activity.meta}" />
                                    </small>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <a class="panel-button" href="<c:url value='/manageorder'/>">
                        View All Activity
                    </a>
                </article>

                <!-- Recent products -->
                <article class="panel product-table-panel">
                    <div class="panel-head">
                        <div>
                            <h2>Recent Products</h2>
                            <p>Latest additions</p>
                        </div>

                        <a class="solid-button small" href="<c:url value='/addproduct'/>">
                            + Add Product
                        </a>
                    </div>

                    <div class="table-wrap">
                        <table class="admin-table compact-table">
                            <thead>
                                <tr>
                                    <th>Product</th>
                                    <th>Category</th>
                                    <th>Price</th>
                                    <th>Stock</th>
                                    <th>Status</th>
                                </tr>
                            </thead>

                            <tbody>
                                <c:forEach var="product" items="${recentProducts}">
                                    <tr>
                                        <td>
                                            <div class="product-cell">
                                                <span class="product-thumb thumb-${product.visual}"></span>

                                                <strong>
                                                    <c:out value="${product.name}" />
                                                </strong>
                                            </div>
                                        </td>

                                        <td>
                                            <c:out value="${product.category}" />
                                        </td>

                                        <td>
                                            <c:out value="${product.price}" />
                                        </td>

                                        <td>
                                            <c:out value="${product.stock}" />
                                        </td>

                                        <td>
                                            <span class="status-pill ${product.statusClass}">
                                                <c:out value="${product.status}" />
                                            </span>
                                        </td>
                                    </tr>
                                </c:forEach>

                                <c:if test="${empty recentProducts}">
                                    <tr>
                                        <td colspan="5" style="text-align: center; padding: 28px; color: #687282;">
                                            No recent products found.
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>

                    <a class="panel-button" href="<c:url value='/manageproducts'/>">
                        View All Products
                    </a>
                </article>

            </section>

        </main>
    </div>

</body>
</html>