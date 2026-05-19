package com.meromart.controller.user;

import com.meromart.model.ProductModel;
import com.meromart.service.ProductService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/product")
public class ProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final ProductService productService = new ProductService();

    // Shows customer-side product listing from database
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String query = trim(request.getParameter("q"));

        // Get products from database
        List<ProductModel> allProducts = productService.getAllProducts();

        // Only show active products with stock available
        List<ProductModel> visibleProducts = new ArrayList<>();

        for (ProductModel product : allProducts) {
            boolean active = product.getStatus() == null || product.getStatus().equalsIgnoreCase("Active");
            boolean inStock = product.getStockQuantity() > 0;

            if (active && inStock) {
                if (query == null || query.isBlank()) {
                    visibleProducts.add(product);
                } else {
                    String searchText = query.toLowerCase();

                    boolean matchesName = product.getProductName() != null
                            && product.getProductName().toLowerCase().contains(searchText);

                    boolean matchesCategory = product.getCategoryName() != null
                            && product.getCategoryName().toLowerCase().contains(searchText);

                    if (matchesName || matchesCategory) {
                        visibleProducts.add(product);
                    }
                }
            }
        }

        request.setAttribute("products", visibleProducts);
        request.setAttribute("searchQuery", query == null ? "" : query);
        request.setAttribute("activePage", "products");

        request.getRequestDispatcher("/pages/user/products.jsp").forward(request, response);
    }

    // Product page search also uses GET logic
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    private String trim(String value) {
        return value == null ? null : value.trim();
    }
}