<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<footer class="store-footer">
    <div class="u-container">
        <div class="footer-grid">
            <div class="footer-brand">
                <div>
                    <strong>Mero Mart Nepal</strong>
                    <p>Fresh essentials curated with thoughtful sourcing, clean design, and premium everyday convenience.</p>
                </div>
            </div>
            <div class="footer-col">
                <h3>Shop</h3>
                <a href="<c:url value='/product'/>">All Products</a>
                <a href="<c:url value='/wishlist'/>">Wishlist</a>
                <a href="<c:url value='/cart'/>">Cart</a>
            </div>
            <div class="footer-col">
                <h3>Explore</h3>
                <a href="<c:url value='/about'/>">About Us</a>
                <a href="<c:url value='/contact'/>">Contact</a>
                <a href="<c:url value='/orderhistory'/>">Order History</a>
            </div>
            <div class="footer-col">
                <h3>Support</h3>
                <a href="tel:+9779800000000">+977 9800000000</a>
                <a href="mailto:hello@meromart.com">hello@meromart.com</a>
                <span>Kalanki, Kathmandu</span>
            </div>
        </div>
        <div class="footer-bottom">
            <span>&copy; 2026 Mero Mart Nepal</span>
        </div>
    </div>
</footer>
