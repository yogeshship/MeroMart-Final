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

@WebServlet("/addproduct")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 10)
public class AddProductServlet extends HttpServlet {
    private ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("categories", productService.getAllCategories());
        request.setAttribute("activePage", "add-product");
        request.getRequestDispatcher("/pages/admin/add-product.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductModel product = new ProductModel();
        product.setProductName(request.getParameter("productName"));
        product.setCategoryId(Integer.parseInt(request.getParameter("category")));
        product.setPrice(Double.parseDouble(request.getParameter("price")));
        product.setStockQuantity(Integer.parseInt(request.getParameter("stockQuantity")));
        product.setUnit(request.getParameter("unit"));
        product.setStatus(request.getParameter("status"));
        product.setDescription(request.getParameter("description"));

        Part filePart = request.getPart("productImage");
        String fileName = filePart.getSubmittedFileName();
        if (fileName != null && !fileName.isEmpty()) {
            String uploadPath = getServletContext().getRealPath("") + File.separator + "assets" + File.separator + "images" + File.separator + "products";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();
            filePart.write(uploadPath + File.separator + fileName);
            product.setImagePath("assets/images/products/" + fileName);
        } else {
            product.setImagePath(""); // default or empty
        }

        if (productService.addProduct(product)) {
            response.sendRedirect(request.getContextPath() + "/manageproducts?msg=added");
        } else {
            response.sendRedirect(request.getContextPath() + "/addproduct?error=1");
        }
    }
}