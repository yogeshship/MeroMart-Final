package com.meromart.controller.admin;

import com.meromart.model.ProductModel;
import com.meromart.service.ProductService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;

@WebServlet("/addproduct")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 20,
        maxRequestSize = 1024 * 1024 * 30
)
public class AddProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Load categories for dropdown
        request.setAttribute("categories", productService.getAllCategories());
        request.setAttribute("activePage", "add-product");

        request.getRequestDispatcher("/pages/admin/add-product.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Read form values
            String productName = trim(request.getParameter("productName"));
            String categoryValue = trim(request.getParameter("category"));
            String priceValue = trim(request.getParameter("price"));
            String stockValue = trim(request.getParameter("stockQuantity"));
            String unit = trim(request.getParameter("unit"));
            String status = trim(request.getParameter("status"));
            String description = trim(request.getParameter("description"));

            // Validate required fields before parsing
            if (productName == null || productName.isBlank()
                    || categoryValue == null || categoryValue.isBlank()
                    || priceValue == null || priceValue.isBlank()
                    || stockValue == null || stockValue.isBlank()
                    || unit == null || unit.isBlank()
                    || status == null || status.isBlank()) {

                request.setAttribute("formError", "Please fill all required fields before saving the product.");
                reloadAddProductPage(request, response);
                return;
            }

            int categoryId = Integer.parseInt(categoryValue);
            double price = Double.parseDouble(priceValue);
            int stockQuantity = Integer.parseInt(stockValue);

            ProductModel product = new ProductModel();
            product.setProductName(productName);
            product.setCategoryId(categoryId);
            product.setPrice(price);
            product.setStockQuantity(stockQuantity);
            product.setUnit(unit);
            product.setStatus(status);
            product.setDescription(description);

            // Upload image safely
            Part filePart = request.getPart("productImage");
            String imagePath = handleImageUpload(filePart);

            product.setImagePath(imagePath);

            boolean added = productService.addProduct(product);

            if (added) {
                response.sendRedirect(request.getContextPath() + "/manageproducts?msg=added");
            } else {
                request.setAttribute("formError", "Failed to add product. Please check the entered details and try again.");
                reloadAddProductPage(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("formError", "Price, stock quantity, and category must contain valid numbers.");
            reloadAddProductPage(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("formError", "Something went wrong while adding the product. Please try with a smaller image.");
            reloadAddProductPage(request, response);
        }
    }

    // Saves uploaded image and returns database image path
    private String handleImageUpload(Part filePart) throws IOException {
        if (filePart == null || filePart.getSubmittedFileName() == null || filePart.getSubmittedFileName().isBlank()) {
            return "assets/images/placeholder.png";
        }

        String originalFileName = new File(filePart.getSubmittedFileName()).getName();

        // Make filename safer for browser and server
        String safeFileName = System.currentTimeMillis() + "_" + originalFileName
                .replaceAll("[^a-zA-Z0-9._-]", "_");

        String uploadPath = getServletContext().getRealPath("/assets/images/products");

        if (uploadPath == null) {
            throw new IOException("Upload path is not available.");
        }

        File uploadDir = new File(uploadPath);

        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        File savedFile = new File(uploadDir, safeFileName);

        Files.copy(filePart.getInputStream(), savedFile.toPath(), StandardCopyOption.REPLACE_EXISTING);

        return "assets/images/products/" + safeFileName;
    }

    // Reloads page with category list and error message
    private void reloadAddProductPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("categories", productService.getAllCategories());
        request.setAttribute("activePage", "add-product");

        request.getRequestDispatcher("/pages/admin/add-product.jsp").forward(request, response);
    }

    private String trim(String value) {
        return value == null ? null : value.trim();
    }
}