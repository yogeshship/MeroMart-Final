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

@WebServlet("/productdetail")
public class ProductDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final ProductService productService = new ProductService();

    // Shows single product detail from database
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idValue = request.getParameter("id");

        if (idValue == null || idValue.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/product");
            return;
        }

        try {
            int productId = Integer.parseInt(idValue);

            ProductModel product = productService.getProductById(productId);

            if (product == null) {
                response.sendRedirect(request.getContextPath() + "/product");
                return;
            }

            // Related products loaded from database
            List<ProductModel> relatedProducts = new ArrayList<>();

            for (ProductModel p : productService.getAllProducts()) {
                boolean differentProduct = p.getId() != product.getId();
                boolean active = p.getStatus() == null || p.getStatus().equalsIgnoreCase("Active");
                boolean inStock = p.getStockQuantity() > 0;

                if (differentProduct && active && inStock) {
                    relatedProducts.add(p);
                }

                if (relatedProducts.size() == 4) {
                    break;
                }
            }

            request.setAttribute("product", product);
            request.setAttribute("relatedProducts", relatedProducts);
            request.setAttribute("activePage", "products");

            request.getRequestDispatcher("/pages/user/product-details.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/product");
        }
    }

    // POST uses the same display logic
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}