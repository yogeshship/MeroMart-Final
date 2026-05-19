package com.meromart.util;

import java.util.List;
import java.util.Map;

public final class AdminViewDataFactory {

    private AdminViewDataFactory() {
    }

    public static List<Map<String, Object>> dashboardStats() {
        return List.of(
            map("icon", "bag", "title", "Total Products", "value", "128", "description", "Across all organic collections", "trend", "8 new this week", "trendType", "positive", "cta", ""),
            map("icon", "tag", "title", "Categories", "value", "12", "description", "Fruits, vegetables, grains and more", "trend", "No change", "trendType", "neutral", "cta", ""),
            map("icon", "receipt", "title", "Orders Today", "value", "34", "description", "Placed in the last 24 hours", "trend", "12% vs yesterday", "trendType", "positive", "cta", ""),
            map("icon", "alert", "title", "Low Stock", "value", "09", "description", "Items needing restock soon", "trend", "", "trendType", "neutral", "cta", "View low stock")
        );
    }

    public static List<Map<String, Object>> salesOverviewCards() {
        return List.of(
            map("label", "Total Sales", "value", "Rs. 48,750", "trend", "18.6% vs last week", "featured", true),
            map("label", "Orders", "value", "156", "trend", "14.5%", "featured", false),
            map("label", "Avg. Order Value", "value", "Rs. 312", "trend", "3.2%", "featured", false)
        );
    }

    public static List<Map<String, Object>> salesChartPoints() {
        return List.of(
            map("label", "May 15", "value", 4200),
            map("label", "May 16", "value", 8800),
            map("label", "May 17", "value", 14500),
            map("label", "May 18", "value", 8600),
            map("label", "May 19", "value", 12100),
            map("label", "May 20", "value", 10900),
            map("label", "May 21", "value", 19800)
        );
    }

    public static List<Map<String, Object>> quickInsights() {
        return List.of(
            map("icon", "category", "label", "Top Selling Category", "value", "Fruits", "meta", "42% of total sales"),
            map("icon", "bag", "label", "Best Selling Product", "value", "Blueberries", "meta", "320+ units sold"),
            map("icon", "user", "label", "New Customers", "value", "24", "meta", "Joined this week"),
            map("icon", "receipt", "label", "Pending Orders", "value", "07", "meta", "Awaiting fulfillment")
        );
    }

    public static List<Map<String, Object>> stockSegments() {
        return List.of(
            map("name", "In Stock", "count", "73", "percentage", "57%", "color", "stock-green"),
            map("name", "Low Stock", "count", "30", "percentage", "23%", "color", "stock-yellow"),
            map("name", "Out of Stock", "count", "09", "percentage", "7%", "color", "stock-red"),
            map("name", "Coming Soon", "count", "16", "percentage", "13%", "color", "stock-gray")
        );
    }

    public static List<Map<String, Object>> latestActivities() {
        return List.of(
            map("icon", "bag", "title", "New product Blueberries added", "meta", "by Admin - 2 hours ago"),
            map("icon", "receipt", "title", "Order #MM1256 received", "meta", "by System - 4 hours ago"),
            map("icon", "tag", "title", "Stock updated for Tomatoes", "meta", "by Admin - 6 hours ago"),
            map("icon", "user", "title", "New user registered", "meta", "by System - 1 day ago")
        );
    }

    public static List<Map<String, Object>> recentProducts() {
        return List.of(
            map("name", "Blueberries", "category", "Fruits", "price", "Rs. 250", "stock", "40", "status", "In Stock", "statusClass", "status-success", "visual", "berries"),
            map("name", "Tomatoes", "category", "Vegetables", "price", "Rs. 150", "stock", "20", "status", "Low Stock", "statusClass", "status-warning", "visual", "tomato"),
            map("name", "Oranges", "category", "Fruits", "price", "Rs. 200", "stock", "50", "status", "In Stock", "statusClass", "status-success", "visual", "orange"),
            map("name", "Brown Rice", "category", "Grains", "price", "Rs. 600", "stock", "30", "status", "In Stock", "statusClass", "status-success", "visual", "rice")
        );
    }

    public static List<Map<String, Object>> productCards() {
        return List.of(
            map("name", "Organic Blueberries", "category", "Fruits", "price", "Rs. 850", "unit", "/ 125g", "stock", "48", "status", "In Stock", "statusClass", "status-success", "visual", "berries"),
            map("name", "Organic Tomatoes", "category", "Vegetables", "price", "Rs. 120", "unit", "/ 500g", "stock", "32", "status", "In Stock", "statusClass", "status-success", "visual", "tomato"),
            map("name", "Organic Oranges", "category", "Fruits", "price", "Rs. 140", "unit", "/ 1kg", "stock", "25", "status", "Low Stock", "statusClass", "status-warning", "visual", "orange"),
            map("name", "Brown Rice", "category", "Grains", "price", "Rs. 210", "unit", "/ 1kg", "stock", "18", "status", "Low Stock", "statusClass", "status-warning", "visual", "rice"),
            map("name", "Organic Spinach", "category", "Vegetables", "price", "Rs. 80", "unit", "/ 250g", "stock", "55", "status", "In Stock", "statusClass", "status-success", "visual", "spinach"),
            map("name", "Organic Milk (1L)", "category", "Dairy", "price", "Rs. 160", "unit", "/ 1L", "stock", "40", "status", "In Stock", "statusClass", "status-success", "visual", "milk"),
            map("name", "Organic Potatoes", "category", "Vegetables", "price", "Rs. 60", "unit", "/ 1kg", "stock", "30", "status", "In Stock", "statusClass", "status-success", "visual", "potato"),
            map("name", "Organic Oats", "category", "Grains", "price", "Rs. 190", "unit", "/ 1kg", "stock", "22", "status", "Low Stock", "statusClass", "status-warning", "visual", "oats")
        );
    }

    public static List<Map<String, Object>> orderStats() {
        return List.of(
            map("icon", "bag", "title", "Total Orders", "value", "128", "trend", "18.6% vs yesterday", "trendType", "positive"),
            map("icon", "clock", "title", "Pending Orders", "value", "16", "trend", "12.5% vs yesterday", "trendType", "warning"),
            map("icon", "truck", "title", "Delivered Orders", "value", "86", "trend", "21.3% vs yesterday", "trendType", "positive"),
            map("icon", "wallet", "title", "Revenue Today", "value", "Rs. 48,750", "trend", "15.4% vs yesterday", "trendType", "positive")
        );
    }

    public static List<Map<String, Object>> orders() {
        return List.of(
            map("id", "ORD-1001", "customer", "Garima Rana", "items", "5 items", "total", "Rs. 1,250", "payment", "Paid", "paymentClass", "status-success", "status", "Delivered", "statusClass", "status-success", "date", "13 Apr 2026", "secondaryAction", "Invoice"),
            map("id", "ORD-1002", "customer", "Aahana KC", "items", "3 items", "total", "Rs. 680", "payment", "Paid", "paymentClass", "status-success", "status", "Shipped", "statusClass", "status-info", "date", "13 Apr 2026", "secondaryAction", "Invoice"),
            map("id", "ORD-1003", "customer", "Dikshya Giri", "items", "7 items", "total", "Rs. 2,340", "payment", "Paid", "paymentClass", "status-success", "status", "Packed", "statusClass", "status-peach", "date", "12 Apr 2026", "secondaryAction", "Update"),
            map("id", "ORD-1004", "customer", "Manish Shrestha", "items", "2 items", "total", "Rs. 420", "payment", "COD", "paymentClass", "status-warning", "status", "Pending", "statusClass", "status-warning", "date", "12 Apr 2026", "secondaryAction", "Update"),
            map("id", "ORD-1005", "customer", "Ansh Raut", "items", "6 items", "total", "Rs. 1,890", "payment", "Paid", "paymentClass", "status-success", "status", "Delivered", "statusClass", "status-success", "date", "11 Apr 2026", "secondaryAction", "Invoice"),
            map("id", "ORD-1006", "customer", "Suman Karki", "items", "4 items", "total", "Rs. 950", "payment", "Paid", "paymentClass", "status-success", "status", "Cancelled", "statusClass", "status-danger", "date", "11 Apr 2026", "secondaryAction", "Invoice"),
            map("id", "ORD-1007", "customer", "Neha Adhikari", "items", "8 items", "total", "Rs. 2,760", "payment", "Paid", "paymentClass", "status-success", "status", "Shipped", "statusClass", "status-info", "date", "10 Apr 2026", "secondaryAction", "Update"),
            map("id", "ORD-1008", "customer", "Ritesh Lama", "items", "3 items", "total", "Rs. 540", "payment", "COD", "paymentClass", "status-warning", "status", "Pending", "statusClass", "status-warning", "date", "10 Apr 2026", "secondaryAction", "Update")
        );
    }

    public static List<Map<String, Object>> categoryStats() {
        return List.of(
            map("icon", "grid", "title", "Total Categories", "value", "7", "description", "All product categories"),
            map("icon", "check", "title", "Active Categories", "value", "6", "description", "Currently active"),
            map("icon", "leaf", "title", "Seasonal Categories", "value", "1", "description", "Seasonal items"),
            map("icon", "star", "title", "Featured Categories", "value", "4", "description", "Highlighted on store")
        );
    }

    public static List<Map<String, Object>> categories() {
        return List.of(
            map("icon", "FR", "name", "Fruits", "description", "Fresh seasonal and exotic fruits", "products", "24", "status", "Active", "statusClass", "status-success"),
            map("icon", "VG", "name", "Vegetables", "description", "Fresh farm vegetables and greens", "products", "31", "status", "Active", "statusClass", "status-success"),
            map("icon", "GR", "name", "Grains", "description", "Rice, wheat, pulses and millets", "products", "12", "status", "Active", "statusClass", "status-success"),
            map("icon", "DY", "name", "Dairy", "description", "Milk, cheese, yogurt and more", "products", "18", "status", "Active", "statusClass", "status-success"),
            map("icon", "SN", "name", "Organic Snacks", "description", "Healthy organic snacks and nuts", "products", "15", "status", "Seasonal", "statusClass", "status-soft-warning"),
            map("icon", "BV", "name", "Beverages", "description", "Juices, drinks and other beverages", "products", "20", "status", "Active", "statusClass", "status-success"),
            map("icon", "HN", "name", "Honey & Spreads", "description", "Honey, jams, peanut butter & more", "products", "9", "status", "Active", "statusClass", "status-success")
        );
    }

    public static List<Map<String, Object>> users() {
        return List.of(
            map("initials", "GR", "name", "Garima Rana", "email", "garima.rana@meromart.com", "accessLevel", "Admin", "accessClass", "status-success", "dateAdded", "12 Jan 2026", "lastLogin", "Today 9:12 AM"),
            map("initials", "AK", "name", "Aahana KC", "email", "aahana.kc@meromart.com", "accessLevel", "Admin", "accessClass", "status-success", "dateAdded", "15 Jan 2026", "lastLogin", "Today 8:45 AM"),
            map("initials", "DG", "name", "Dikshya Giri", "email", "dikshya.giri@meromart.com", "accessLevel", "Admin", "accessClass", "status-success", "dateAdded", "18 Jan 2026", "lastLogin", "Yesterday 6:20 PM"),
            map("initials", "MS", "name", "Manish Shrestha", "email", "manish.shrestha@gmail.com", "accessLevel", "User", "accessClass", "status-plain", "dateAdded", "20 Jan 2026", "lastLogin", "Today 10:05 AM"),
            map("initials", "AR", "name", "Ansh Raut", "email", "ansh.raut@gmail.com", "accessLevel", "User", "accessClass", "status-plain", "dateAdded", "22 Jan 2026", "lastLogin", "Yesterday 3:10 PM"),
            map("initials", "SK", "name", "Suman Karki", "email", "suman.karki@meromart.com", "accessLevel", "User", "accessClass", "status-plain", "dateAdded", "24 Jan 2026", "lastLogin", "Today 11:30 AM"),
            map("initials", "NA", "name", "Neha Adhikari", "email", "neha.adhikari@meromart.com", "accessLevel", "Admin", "accessClass", "status-success", "dateAdded", "26 Jan 2026", "lastLogin", "Yesterday 9:15 PM"),
            map("initials", "RL", "name", "Ritesh Lama", "email", "ritesh.lama@gmail.com", "accessLevel", "User", "accessClass", "status-plain", "dateAdded", "28 Jan 2026", "lastLogin", "Today 7:20 AM")
        );
    }

    public static List<Map<String, Object>> addProductCategories() {
        return List.of(
            map("value", "Fruits", "label", "Fruits"),
            map("value", "Vegetables", "label", "Vegetables"),
            map("value", "Grains", "label", "Grains"),
            map("value", "Dairy", "label", "Dairy")
        );
    }

    public static List<Map<String, Object>> units() {
        return List.of(
            map("value", "kg", "label", "Kilogram (kg)"),
            map("value", "g", "label", "Gram (g)"),
            map("value", "l", "label", "Liter (L)"),
            map("value", "pcs", "label", "Pieces")
        );
    }

    public static List<Map<String, Object>> statuses() {
        return List.of(
            map("value", "in-stock", "label", "In Stock"),
            map("value", "low-stock", "label", "Low Stock"),
            map("value", "coming-soon", "label", "Coming Soon")
        );
    }

    private static Map<String, Object> map(Object... keyValuePairs) {
        java.util.LinkedHashMap<String, Object> map = new java.util.LinkedHashMap<>();
        for (int index = 0; index < keyValuePairs.length; index += 2) {
            map.put(String.valueOf(keyValuePairs[index]), keyValuePairs[index + 1]);
        }
        return map;
    }
}
