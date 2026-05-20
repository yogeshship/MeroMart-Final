package com.meromart.controller.common;

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

// Handles public home page
@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<ProductModel> allProducts = productService.getAllProducts();
        List<ProductModel> featuredProducts = new ArrayList<>();

        int activeProductCount = 0;

        // Count active products and prepare featured products for home page
        for (ProductModel product : allProducts) {
            boolean active = product.getStatus() == null || product.getStatus().equalsIgnoreCase("Active");
            boolean inStock = product.getStockQuantity() > 0;

            if (active && inStock) {
                activeProductCount++;

                if (featuredProducts.size() < 4) {
                    featuredProducts.add(product);
                }
            }
        }

        // Dynamic home page values
        request.setAttribute("products", featuredProducts);
       
        request.setAttribute("activePage", "home");

        request.getRequestDispatcher("/pages/common/home.jsp").forward(request, response);
    }
}