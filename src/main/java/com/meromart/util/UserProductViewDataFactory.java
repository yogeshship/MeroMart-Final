package com.meromart.util;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

public final class UserProductViewDataFactory {

    private UserProductViewDataFactory() {
    }

    public static List<Map<String, Object>> products(String query) {
        List<Map<String, Object>> items = allProducts();
        if (query == null || query.isBlank()) {
            return items;
        }

        String normalized = query.toLowerCase(Locale.ROOT);
        List<Map<String, Object>> filtered = new ArrayList<>();
        for (Map<String, Object> item : items) {
            String haystack = (item.get("name") + " " + item.get("category") + " " + item.get("description"))
                .toString()
                .toLowerCase(Locale.ROOT);
            if (haystack.contains(normalized)) {
                filtered.add(item);
            }
        }
        return filtered;
    }

    public static Map<String, Object> findById(String id) {
        String resolvedId = (id == null || id.isBlank()) ? "P-1001" : id;
        for (Map<String, Object> item : allProducts()) {
            if (resolvedId.equals(item.get("id"))) {
                return item;
            }
        }
        return allProducts().get(0);
    }

    public static List<Map<String, Object>> relatedProducts(String id) {
        String category = findById(id).get("category").toString();
        List<Map<String, Object>> related = new ArrayList<>();
        for (Map<String, Object> item : allProducts()) {
            if (!item.get("id").equals(id) && item.get("category").equals(category) && related.size() < 4) {
                related.add(item);
            }
        }
        for (Map<String, Object> item : allProducts()) {
            if (!item.get("id").equals(id) && !related.contains(item) && related.size() < 4) {
                related.add(item);
            }
        }
        return related;
    }

    private static List<Map<String, Object>> allProducts() {
        return List.of(
            product("P-1001", "Organic Blueberries", "Fruits", "850", "125g", "4.8", "Just In", "In Stock", "/assets/images/products/blueberries.jpg",
                "Sweet, dense berries picked for a bright finish and clean texture. A beautiful topper for breakfast bowls, desserts, and smoothies.",
                "Small-batch packed", "Naturally antioxidant-rich"),
            product("P-1002", "Organic Tomatoes", "Vegetables", "120", "500g", "4.6", "Kitchen Staple", "Fresh Daily", "/assets/images/products/tomatoes.jpg",
                "Balanced acidity with a juicy center, ideal for curries, salads, and slow-cooked sauces that need real depth.",
                "Farm-picked", "Best for everyday cooking"),
            product("P-1003", "Organic Oranges", "Fruits", "140", "1kg", "4.7", "Citrus Favorite", "In Stock", "/assets/images/products/oranges.jpg",
                "Vibrant, fragrant oranges with a refreshing sweetness. Great for juicing, snacking, or a clean mid-day reset.",
                "High in vitamin C", "Juicy and easy to peel"),
            product("P-1004", "Brown Rice", "Grains", "210", "1kg", "4.5", "Pantry Essential", "In Stock", "/assets/images/products/brown-rice.jpg",
                "Nutty whole-grain rice with a pleasantly firm bite. A versatile base for bowls, lunches, and hearty home dinners.",
                "Whole grain", "Longer-lasting fullness"),
            product("P-1005", "Organic Spinach", "Vegetables", "80", "250g", "4.4", "Leafy Green", "Harvested Today", "/assets/images/products/spinach.jpg",
                "Tender spinach leaves with a fresh earthy flavor. Excellent for sauteing, blending, or folding into warm meals.",
                "Tender leaves", "Quick-cook friendly"),
            product("P-1006", "Organic Milk", "Dairy", "160", "1L", "4.6", "Fresh Pour", "Chilled", "/assets/images/products/milk.jpg",
                "Smooth full-bodied milk sourced for daily freshness. Designed for tea, coffee, breakfast, and simple wholesome cooking.",
                "Morning fresh", "Rich and smooth"),
            product("P-1007", "Organic Potatoes", "Vegetables", "60", "1kg", "4.3", "Daily Value", "In Stock", "/assets/images/products/potatoes.jpg",
                "Reliable all-round potatoes with a soft fluffy interior. Great for roasting, frying, mashing, or weeknight comfort meals.",
                "Versatile texture", "Excellent for roasting"),
            product("P-1008", "Organic Oats", "Grains", "190", "1kg", "4.6", "Breakfast Pick", "In Stock", "/assets/images/products/oats.jpg",
                "Hearty oats with a naturally creamy finish when cooked. A dependable staple for porridge, granola, and baking.",
                "Fiber-rich", "Breakfast-ready")
        );
    }

    private static Map<String, Object> product(
        String id,
        String name,
        String category,
        String price,
        String unit,
        String rating,
        String badge,
        String stockLabel,
        String image,
        String description,
        String highlightOne,
        String highlightTwo
    ) {
        Map<String, Object> item = new LinkedHashMap<>();
        item.put("id", id);
        item.put("name", name);
        item.put("category", category);
        item.put("price", price);
        item.put("unit", unit);
        item.put("rating", rating);
        item.put("badge", badge);
        item.put("stockLabel", stockLabel);
        item.put("image", image);
        item.put("description", description);
        item.put("highlightOne", highlightOne);
        item.put("highlightTwo", highlightTwo);
        return item;
    }
}
